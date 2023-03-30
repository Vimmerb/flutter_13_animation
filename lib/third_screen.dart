import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({
    super.key,
    required this.galleryBun,
    required this.index,
  });
  final AssetImage galleryBun;
  final int index;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Who did the Little bun meet?'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Hero(
              tag: 'caracteres${widget.index}',
              child: Image(image: widget.galleryBun)),
        ),
      ),
    );
  }
}
