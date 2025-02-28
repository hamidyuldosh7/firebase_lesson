import 'dart:io';

import 'package:firebase_lesson/service/RTDB_database.dart';
import 'package:firebase_lesson/service/storage_sirvise.dart';
import 'package:flutter/material.dart';
import 'package:img_picker/img_picker.dart';

import 'home_page.dart';
import 'models/post_models.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isLoading = false;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
  final TextEditingController _aboutcontroller = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No selected Image");
      }
    });
  }

  _createPost() {
    String name = _namecontroller.text.trim().toString();
    String lastname = _lastnamecontroller.text.trim().toString();
    String about = _aboutcontroller.text.trim().toString();

    if (name.isEmpty || lastname.isEmpty || about.isEmpty) return;

    _apiUploadImage(name, lastname, about);
  }

  _apiUploadImage(String name, String lastName, String about) {
    setState(() {
      isLoading = true;
    });
    StorageService.uploadImage(_image!).then((img_url) => {
          _apiCreatePost(name, lastName, about, img_url),
        });
  }

  _apiCreatePost(String name, String lastname, String about, String img_url) {
    setState(() {
      isLoading = true;
    });
    Post post = Post(
        firstName: name, lastName: lastname, about: about, image_url: img_url);

    RTDBService.addPost(post).then((value) => {
          setState(() {
            isLoading = false;
          }),
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return const HomePage();
          })),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Details Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const Text(
            "Create Post",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              _getImage();
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              height: 120,
              width: 120,
              child: _image == null
                  ? Image.asset(
                      "assets/img.png",
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.all(12),
            height: 55,
            color: Colors.grey.shade300,
            child: Center(
              child: TextField(
                controller: _namecontroller,
                decoration: const InputDecoration(
                  hintText: "FirstName",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.all(12),
            height: 55,
            color: Colors.grey.shade300,
            child: Center(
              child: TextField(
                controller: _lastnamecontroller,
                decoration: const InputDecoration(
                  hintText: "LastName",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.all(12),
            height: 55,
            color: Colors.grey.shade300,
            child: Center(
              child: TextField(
                controller: _aboutcontroller,
                decoration: const InputDecoration(
                  hintText: "About",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          isLoading
              ? const SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : InkWell(
                  onTap: () {
                    _createPost();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
