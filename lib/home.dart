import 'dart:convert';

import 'package:api_testing/Models/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  List<postmodel> Postlist = [];
  Future<List<postmodel>> getPostApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Postlist.clear();
      for (Map<String, dynamic> i in data) {
        Postlist.add(postmodel.fromJson(i));
      }
      return Postlist;
    } else {
      return Postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Course'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle error if occurred during API call
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: Postlist.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(Postlist[index].title.toString()),
                        SizedBox(height: 15),
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(Postlist[index].body.toString()),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
