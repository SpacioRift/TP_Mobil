import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;
  final List<dynamic> searchResults;

  const DetailPage({Key? key, required this.movie, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(movie['Title'] ?? 'Détails du film'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(movie['Poster'] ?? ''),
              SizedBox(height: 16),
              Text(
                'Year: ${movie['Year']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
              ),
              SizedBox(height: 8),
              Text(
                'Plot: ${movie['Plot']}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'Actors: ${movie['Actors']}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}