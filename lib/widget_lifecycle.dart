import 'package:flutter/material.dart';

class WidgetLifeCycle extends StatefulWidget {
  @override
  WidgetLifeCycleState createState() {
    print('create state called');
    return WidgetLifeCycleState();
  }
}

class WidgetLifeCycleState extends State<WidgetLifeCycle> {

  @override
  void initState() {
    super.initState();
    print('init called');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies Called');
  }

  Widget build(BuildContext context) {
    print('build called');
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Lifecycle Example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          // Added SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Centering column items
            children: [
              Text('Stateful Widget!'),
              GestureDetector(
                onDoubleTap: () {
                  print('double tap');
                },
                onLongPress: () {
                  print('long press');
                },
                onTap: () {
                  print('onTap');
                },
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  // Added padding for better touch response
                  color: Colors.blue,
                  // Added color to visualize the area
                  child: Text('Gesture!'),
                ),
              ),
              InkWell(
                onTap: (){
                  print('ink well tapped');
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  color: Colors.transparent,
                  child: Text('intkwell tapped',textAlign: TextAlign.center,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant WidgetLifeCycle oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didupdatewidget called');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate called');
  }

  @override
  void dispose() {
    print('dispose called');
    super.dispose();
  }
}
