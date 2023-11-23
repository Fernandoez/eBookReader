import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'books.dart';
import 'utils.dart';
import 'readpage.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const NavigationMain(),
    );
  }
}

class NavigationMain extends StatefulWidget {
  const NavigationMain({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<StatefulWidget> {
  late Future<List<Book>> futureBooks;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    futureBooks = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Reader'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book),
            label: 'Livros',
          ),
          NavigationDestination(
            icon: Icon(Icons.download_done),
            label: 'Baixados',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        FutureBuilder<List<Book>>(
          future: futureBooks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return BookCard(book: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),

        /// Downloaded page
        const ReadPage(),
      ][currentPageIndex],
    );
  }
}

class BookCard extends StatefulWidget {
  final Book book;

  const BookCard({required this.book, super.key});

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isBookDownloaded = false;

  @override
  void initState() {
    super.initState();
    loadBookDownloadState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(60),
        onTap: () {
          isBookDownloaded
              ? showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Download'),
                        content: Text(
                            'O livro: ${widget.book.title} já foi baixado'),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () => Navigator.pop(context, 'Ok'),
                              child: const Text('Ok'))
                        ],
                      ))
              : showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Download!'),
                    content: Text(
                        'Deseja fazer o download do livro: ${widget.book.title}?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Não'),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context, 'Sim'),
                          Utils().bookDownload(widget.book).then((bool result) {
                            if (result) {
                              // Se o download for bem-sucedido
                              saveBookDownloadState();
                              setState(() {
                                isBookDownloaded = true;
                              });
                            } else {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Download'),
                                        content: Text(
                                            'O livro: ${widget.book.title} já foi baixado'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'Ok'),
                                              child: const Text('Ok'))
                                        ],
                                      ));
                            }
                          })
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                );
        },
        child: Column(
          children: [
            Image.network(
              widget.book.coverUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.book.author,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isBookDownloaded
                      ? const Icon(
                          Icons.download_done,
                          color: Colors.red,
                          size: 30,
                        )
                      : const Icon(
                          Icons.download,
                          color: Colors.green,
                          size: 30,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadBookDownloadState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool downloaded = prefs.getBool(widget.book.title) ?? false;

    setState(() {
      isBookDownloaded = downloaded;
    });
  }

  Future<void> saveBookDownloadState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.book.title, isBookDownloaded);
  }
}
