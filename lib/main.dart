import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grade_x/model/Album.dart';
import 'package:grade_x/model/Computer.dart';
import 'package:grade_x/variables.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppBody()
    );
  }
}

class MyAppBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppBodyState();
}

class _MyAppBodyState extends State {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  String output = '';

  List<Album> users = [];

  List<Map<String, String>> itemmap = [
    {
      "brand" : "Toyota",
      "model" : "Vios"
    },
    {
      "brand" : "Toyota",
      "model" : "Hilux"
    },
    {
      "brand" : "Toyota",
      "model" : "Fortuner"
    },
    {
      "brand" : "Ford",
      "model" : "Raptor"
    },
    {
      "brand" : "Honda",
      "model" : "Civic"
    },
    {
      "brand" : "Chevrolet",
      "model" : "Spark"
    },
  ];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Student'),
      ), body:
        FutureBuilder<List<Computer>>(
          future: fetchComputers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Computer> computers = snapshot.data!;
              return ListView.builder(
                itemCount: computers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(computers[index].brand),
                    subtitle: Text(computers[index].model),
                  );
                },
              );
            } else {
              return Text('No users found');
            }
          },
        ),
    );
  }

  Future<List<Computer>> fetchComputers() async {
    try {

      final response = await http.get(Uri.parse('$serverUrl/computer'));

      print(response.statusCode);

      if(response.statusCode == 200) {

        List<dynamic> computerList = jsonDecode(response.body);

        List<Computer> computers = computerList.map((computer) => Computer.fromJson(computer)).toList();
        return computers;

      } else {
        throw Exception('Failed to load users');
      }

    } catch(e){
      throw Exception('$e');
    }
  }

  void _showDialog(BuildContext context, int index){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            icon: Icon(Icons.info),
            title: Text("Info"),
            content: Text(itemmap[index]['brand'].toString()),
            actions: [
              TextButton(
                  onPressed: ()=> { Navigator.pop(context)},
                  child: Text('OK')
              )
            ],
          );
        }
    );
  }

  /*
  GridView.count(
          padding: EdgeInsets.all(20.0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: const Text("He'd have you all unravel at the"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[200],
                child: const Text('Heed not the rabble'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[300],
                child: const Text('Sound of screams but the'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[400],
                child: const Text('Who scream'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[500],
                child: const Text('Revolution is coming...'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[600],
                child: const Text('Revolution, they...'),
              ),
            ],
        )
   */
  /*

   */

  void _showAlertDialog(BuildContext context){
        showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Message'),
                  content: Text('Questions'),
                  actions: [
                    TextButton(onPressed: (){ Navigator.pop(context); }, child: Text('OK'))
                  ],
                );
            }
        );
  }

  Widget myTextField(String label, String hintext, TextEditingController controller){
    return  TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintext,
      ),
    );
  }


}

