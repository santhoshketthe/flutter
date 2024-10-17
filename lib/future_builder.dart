import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/posts.dart';
import 'package:http/http.dart' as http;

class FutureBuilderPage extends StatefulWidget{
  const FutureBuilderPage({super.key});

  @override
  State<StatefulWidget> createState() => FutureBuilderCall();
}

class FutureBuilderCall extends State<FutureBuilderPage>{

  Future<List<Post>> fetchPost() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map( (post) => Post.fromJson(post)).toList();
    }else{
      throw Exception('failed to load');
    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: const Text("future Builder")),
     body: FutureBuilder(
         future: fetchPost(),
         builder: (context,snapshot){
           if(snapshot.connectionState == ConnectionState.waiting){
             return const Center( child: CircularProgressIndicator(),);
           }else if(snapshot.hasError){
             return Center(child: Text('${snapshot.error}'),);
           }else{
             final posts = snapshot.data!;
             return ListView.builder(
                 itemCount: posts.length,
                 itemBuilder: (context,index){
                   return ListTile(
                     title: Text(posts[index].title),
                   );
                 });
           }
         }),
   );
  }

}