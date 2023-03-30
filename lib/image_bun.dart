import 'package:flutter/material.dart';

class ImageBun extends StatefulWidget {
  const ImageBun({Key? key}) : super(key: key);

  @override
  State<ImageBun> createState() => _ImageBunState();
}

class _ImageBunState extends State<ImageBun>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller
        //CurvedAnimation(parent: _controller, curve: Curves.easeIn),
        );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Image.asset(
        'assets/images/bun.png',
        height: 120,
      ),
    );
  }
}
