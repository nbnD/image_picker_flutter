import 'dart:io';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();
 File? file;
  XFile? pickedImage;
  bool isLoading = false;
  List<File?> fileList = [];


  Future pickImageFromGallery() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedImage!.path);
      fileList.add(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Upload"), actions: [
        IconButton(
            onPressed: () {
              pickImageFromGallery();
            },
            icon: const Icon(Icons.add))
      ]),
      body: GridView.builder(
        itemCount: fileList.length,
        // A delegate that controls the layout of the children within the GridView.
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int i) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.file(File(fileList[i]!.path),fit: BoxFit.cover,),
                ),
                Positioned(
                    right: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          dltImages(fileList[i]);
                        });
                      },
                      child: const Icon(Icons.cancel, color: Colors.red),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  void dltImages(data) {
    fileList.remove(data);
  }
}
