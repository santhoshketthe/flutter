import 'package:flutter/material.dart';

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  SideMenu createState() => SideMenu();
}

class SideMenu extends State<SideMenuPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SideMenu"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body:  Center(
        child: Text(selectedIndex.toString(),style: TextStyle(fontSize: 30),),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "person"),
      ],
      currentIndex: selectedIndex ,
      onTap: (index){
        setState(() {
          selectedIndex = index;
        });
      },
      selectedItemColor: Colors.blue,),
    );
  }
}
