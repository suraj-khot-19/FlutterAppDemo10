import 'dart:convert';
import 'package:app/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: const Text("Api Intgration 3")),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: const Color.fromARGB(255, 173, 212, 244),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReusableRow(
                                title: 'name',
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReusableRow(
                                title: 'user name',
                                value:
                                    snapshot.data![index].username.toString(),
                              ),
                              ReusableRow(
                                title: 'email',
                                value: snapshot.data![index].email.toString(),
                              ),
                              ReusableRow(
                                title: 'city',
                                value: snapshot.data![index].address!.city
                                    .toString(),
                              ),
                              ReusableRow(
                                title: 'latitude',
                                value: snapshot.data![index].address!.geo!.lat
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
