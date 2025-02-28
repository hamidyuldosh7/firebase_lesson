import 'package:firebase_lesson/service/RTDB_database.dart';

import 'package:flutter/material.dart';

import 'food_details_page.dart';
import '../models/post_models.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Post> items = [];

  _apiPostList() async {
    var list = await RTDBService.getPost();
    setState(() {
      items = list;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }

  void deleteTaom(String id) {
    RTDBService.deleteTaomlar(id).then((value) => {_apiPostList()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FoodDetailPage(
                  name: items[index].firstName!,
                  image: items[index].image_url!,
                  price: items[index].lastName!,
                  about: items[index].about!,
                );
              }));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height / 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                              items[index].image_url ?? "",
                            ),
                            fit: BoxFit.cover)),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          items[index].firstName!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${items[index].lastName!} so'm",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      deleteTaom(items[index].id ?? "");
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(6),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.cyan,
                                ),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.cyan,
                                    ),
                                    Text(
                                      "Zakaz Berish",
                                      style: TextStyle(
                                        color: Colors.cyan,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
