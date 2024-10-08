import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  const CustomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text("Grid"),
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          centerTitle: true,
          actions: const [
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.refresh)),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(6, (index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/app_store.png',width: 40,height: 40),
                          const SizedBox(height: 10),
                          Text("Grid $index",
                              style:  const TextStyle(
                                  color: Colors.black,
                                fontWeight: FontWeight.w600 ,
                                fontSize: 22,))
                        ],
                      ),
                    ),
                  );
                }))));
  }
}
