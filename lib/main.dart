import 'package:flutter/material.dart';
import 'package:flutter_tp/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter TP API FILM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool dataOK = false;
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResult = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              filmRecherche(searchController.text);
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un film',
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: dataOK
          ? affichage()
          : (searchResult.isNotEmpty ? affichage() : attente()),
      backgroundColor: Colors.blueGrey[900],
    );
  }

  Widget attente() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'En attente des données',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          CircularProgressIndicator(
            color: Colors.deepOrange,
            strokeCap: StrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget affichage() {
  return ListView.builder(
    itemCount: searchResult.length,
    itemBuilder: (context, index) {
      var movie = searchResult[index];
      return ListTile(
        title: Text(movie['Title'] ?? '', style: TextStyle(color: Colors.amberAccent)),
        subtitle: Text(movie['Year'] ?? '', style: TextStyle(color: Colors.white)),
        leading: Image.network(movie['Poster'] ?? ''),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(movie: movie, searchResults: searchResult),
            ),
          );
        },
      );
    },
  );
}


Future<void> filmRecherche(String query) async {
  Uri uri = Uri.http('www.omdbapi.com', '', {'s': query, 'apikey': '659cd7e0'});
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    Map<String, dynamic> result = convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<dynamic> searchResults = result['Search'] ?? [];
    setState(() {
      searchResult = searchResults;
      dataOK = true;
    });
  } else {
    setState(() {
      searchResult = [];
      dataOK = false;
    });
  }
}
}