import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home1 extends StatefulWidget {
  const home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  List<photosmodel> photolist =[];
  Future<List<photosmodel>> getphoto() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        photosmodel Photo = photosmodel(title: i["title"], url: i["url"] ,id: i["id"]);
        photolist.add(Photo);
      }
      return photolist;
    }
    else{
      return photolist;
    }
  }
  @override
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
              future: getphoto(), 
              builder: (context ,AsyncSnapshot<List<photosmodel>> snapshot){
              //   if (snapshot.connectionState == ConnectionState.waiting) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //  }
              //  else{
                return ListView.builder(
                  itemCount: photolist.length,
                  itemBuilder: (context,index)
                  {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                    ),
                    subtitle:Text( snapshot.data![index].title.toString()), 
                    title: Text('Item Count'+ snapshot.data![index].id.toString()),
                  );
                  }
                  );
              
              }
              )
          ),
        ],
      ),
    );
    
  }
}
class photosmodel{
  String url,title;
  int id;
  photosmodel({required this.title,required this.url,required this.id});
}