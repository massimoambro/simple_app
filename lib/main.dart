import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Welcome to Max Flutter Sample App - Name Generator',
      home: RandomWords(),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
          actions: [
            IconButton(
              onPressed: _pushSaved,
              icon: const Icon(Icons.list),
              tooltip: 'Saved Suggestions',
            ),
          ],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: /*1*/ (context, i) {
              //called once per row
              if (i.isOdd) return const Divider();
              /*2*/

              final index = i ~/ 2; /*3*/ //exclude the indexes of the dividers
              if (index >= _suggestions.length) {
                _suggestions
                    .addAll(generateWordPairs().take(10)); /*4*/ //end reached
              }
              final alreadySaved = _saved.contains(_suggestions[index]);
              return ListTile(
                title: Text(
                  _suggestions[index].asPascalCase,
                  style: _biggerFont,
                ),
                trailing: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
                ),
                onTap: () {
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(_suggestions[index]);
                    } else {
                      _saved.add(_suggestions[index]);
                    }
                  });
                },
              );
              /*oldReturn of ListView*/ //return Text(_suggestions[index].asPascalCase);
            }));
    /*oldReturn - */ // return Text(wordPair.asPascalCase);
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        final tiles = _saved.map(
            (pair) {
              return ListTile(
              title: Text( pair.asPascalCase, style: _biggerFont,),
              );
            }
        );
        final divided = tiles.isNotEmpty ? ListTile.divideTiles(tiles: tiles, context: context,).toList() : <Widget>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );
      })
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}
