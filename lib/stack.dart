import 'package:flutter/material.dart';

class StackLayer extends StatefulWidget{
  const StackLayer({super.key});

  @override
  StackLayout createState() => StackLayout();

}
class StackLayout extends State<StackLayer>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("future Builder")),
    body: Stack(
      children:[
        Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
        Positioned(
          top: 50,
          left: 50,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
        const Positioned(
          top: 80,
          left: 65,
          child: Text(
            'Stack!',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ));
  }
}