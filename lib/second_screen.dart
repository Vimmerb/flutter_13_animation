import 'package:flutter/material.dart';
import 'package:flutter_13_animation/image_bun.dart';
import 'package:flutter_13_animation/gallery_bun.dart';
import 'package:flutter_13_animation/descript_bun.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('All about the Little bun'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          //alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: const [
                ImageBun(),
                SizedBox(
                  height: 30,
                ),
                DescriptBun(),
                SizedBox(
                  height: 50,
                ),
                GalleryBun(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
