import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
    final ThemeData theme = Theme.of(context);
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
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'Favoritos',
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

        /// Bookmark page
      ][currentPageIndex],
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: Column(
            children: [
              Image.network(
                book.coverUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Future<List<Book>> fetchBooks() async {
  final response = await http.get(Uri.parse('https://escribo.com/books.json'));

  if (response.statusCode == 200) {
    // If the server returned a 200 OK response,
    // then parse the JSON and return a list of books.
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Book.fromJson(item)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load books');
  }
}

class Book {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      coverUrl: json['cover_url'] as String,
      downloadUrl: json['download_url'] as String,
    );
  }
}
