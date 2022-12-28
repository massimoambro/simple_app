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
    return MaterialApp(
      title: 'Welcome to Max Flutter Sample App - Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sample App - Name Generator'),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
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
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder:/*1*/ (context, i ){ //called once per row
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/2; /*3*/ //exclude the indexes of the dividers
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/ //end reached
        }
        final alreadySaved = _saved.contains(_suggestions[index]);
        return ListTile(

            title: Text (
                _suggestions[index].asPascalCase,
                style: _biggerFont,
            ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          ),
        );
        /*oldReturn of ListView*/ //return Text(_suggestions[index].asPascalCase);
      }
    );
              /*oldReturn - */ // return Text(wordPair.asPascalCase);
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

