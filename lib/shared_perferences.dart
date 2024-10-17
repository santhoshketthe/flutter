import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesPage extends StatefulWidget{
  const SharedPreferencesPage({super.key});


  @override
  SharedPreferenceKey createState() => SharedPreferenceKey();
}

class SharedPreferenceKey extends State<SharedPreferencesPage>{

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text("Shared Preferences",style: Theme.of(context).textTheme.titleMedium,),),
     body: Column(
       children: [
         TextField(
           controller: _controller,
           decoration: const InputDecoration(
             label: Text("Enter anything")
           ),
         ),
         TextButton(onPressed: (){
           saveData("store", _controller.text);
           _controller.clear();
           setState(() {

           });
         }, child: const Text("Save")),
         TextButton(onPressed: (){
           removeData("store");
           setState(() {

           });
         }, child: const Text("Delete")),
         const Text("Value From Shared Preferences"),
          FutureBuilder(future: getData("store"), builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading indicator while waiting
            } else if (snapshot.hasError) {
              return const Text('Error retrieving data');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text('No value saved');
            } else {
              return Text(snapshot.data!); // Display the saved value
            }
          })
       ],
     ),
   );
  }}
Future<void> saveData(String key,String value) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString(key, value);
}


Future<void> removeData(String key) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.remove(key);
}

Future<String?> getData(String key) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(key);
}