import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const[
            Text('Hello World'),
        ],
        ),
          ),
        ),
      ),
    );
  }
}
