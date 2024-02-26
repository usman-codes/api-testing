import 'dart:convert';

import 'package:api_testing/Models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home2 extends StatefulWidget {
  const home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  @override
  List<usermodel> userlist = [];
  Future<List<usermodel>> getuser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userlist.add(usermodel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
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
                  future: getuser(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: userlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  reuserow(
                                    title: "Name",
                                    value: userlist[index].name.toString(),
                                  ),
                                  reuserow(
                                    title: "Email",
                                    value: userlist[index].email.toString(),
                                  ),
                                  reuserow(
                                    title: "Phone",
                                    value: userlist[index].phone.toString(),
                                  ),
                                  reuserow(
                                    title: "City",
                                    value: userlist[index]
                                        .address!
                                        .city!
                                        .toString(),
                                  ),
                                  reuserow(
                                    title: "Geo",
                                    value: userlist[index]
                                        .address!
                                        .geo!
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
