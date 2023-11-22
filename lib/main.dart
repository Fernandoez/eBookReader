import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
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

        ListView.builder(
          itemCount: 9, // 3 linhas, cada uma com 3 elementos
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: BookCard(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: BookCard(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: BookCard(),
                ),
              ],
            );
          },
        ),

        /// Downloaded page

        ListView.builder(
          itemCount: 9, // 3 linhas, cada uma com 3 elementos
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: BookCard(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: BookCard(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: BookCard(),
                ),
              ],
            );
          },
        ),

        /// Bookmark page
        ListView.builder(
          itemCount: 9, // 3 linhas, cada uma com 3 elementos
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: BookCard(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: BookCard(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: BookCard(),
                ),
              ],
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.asset(
            'assets/images/book_cover.jpg',
            // Substitua pelo caminho correto da imagem da capa do livro
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Título do Livro',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Nome do Autor',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
