import 'dart:convert';

import 'package:api_testing/Models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home3 extends StatefulWidget {
  const home3({super.key});

  @override
  State<home3> createState() => _home2State();
}

class _home2State extends State<home3> {
  @override
  List<usermodel> uselist = [];
  Future<List<usermodel>> getuse() async {
    final response = await http.get(
        Uri.parse("https://webhook.site/99b7c824-012f-42ac-a506-1fcac86a7c22"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        uselist.add(usermodel.fromJson(i));
      }
      return uselist;
    } else {
      return uselist;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Course'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getuse(),
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
                          itemCount: uselist.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    reuserow(
                                      title: "Name",
                                      value: uselist[index].name.toString(),
                                    ),
                                    reuserow(
                                      title: "Email",
                                      value: uselist[index].email.toString(),
                                    ),
                                    reuserow(
                                      title: "Phone",
                                      value: uselist[index].phone.toString(),
                                    ),
                                    reuserow(
                                      title: "City",
                                      value: uselist[index]
                                          .address!
                                          .city!
                                          .toString(),
                                    ),
                                    reuserow(
                                      title: "Website",
                                      value: uselist[index].website.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

class reuserow extends StatelessWidget {
  String title, value;
  reuserow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
