import 'package:flutter/material.dart';

class Layouts extends StatelessWidget{
  const Layouts({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Layouts")),
       body: ExpandedLayouts(),
    );
  }
}

Widget ExpandedLayouts() {
  return
  Column(
    children: [
      Container(
        height: 100,
        color: Colors.red,
        child: const Center(
            child: Text('Fixed Height', style: TextStyle(color: Colors.white))),
      ),
      Expanded(
        child: Container(
          color: Colors.green,
          child: const Center(child: Text(
              'Expanded Space', style: TextStyle(color: Colors.white))),
        ),
      ),
      Container(
        height: 50,
        color: Colors.blue,
        child: const Center(
            child: Text('Fixed Height', style: TextStyle(color: Colors.white))),
      ),
    ],
  );
}

Widget combinedLayout(){
  return
  Column(
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text('container'),
      ),
      const Expanded(
        child:
        Row(
          children: [
            Text("Text from row"),
            Text("second Text")
          ],
        ),
      ),Expanded(child:
      ListView(
        children: const [
          ListTile(title: Text('Item 1')),
          ListTile(title: Text('Item 2')),
          ListTile(title: Text('Item 3')),
        ],
      )
      )
    ],
  );
}

Widget gridLayout(){
  return GridView.count(crossAxisCount: 2,
  children: List.generate(6, (index){
    return Container(
      color: Colors.deepPurple,
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Text("grid $index",
        style: const TextStyle(color: Colors.amberAccent,fontSize: 22)),
      ),
    );
  })
  );
}

Widget totalColumn(){
  return Container(
    color: Colors.blue,
      child: const Column(
    children: [
      Text("Column"),
      Text("column2"),
      Row(
        children: [
          Text("text"),
          Text("text2")
        ],
      )
    ],
  )
  );
}