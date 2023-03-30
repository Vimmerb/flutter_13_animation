import 'package:flutter/material.dart';
import 'package:flutter_13_animation/second_screen.dart';
import 'dart:math' as math;

class FirstScreen extends StatefulWidget {
  const FirstScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  late AnimationController _controller;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _rotateAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      _controller,
      //CurvedAnimation(parent: _controller, curve: Curves.ease),
    );

    _isPressed = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildImage(),
        const SizedBox(
          height: 125,
        ),
        buildText(),
      ],
    );
  }

  // Widget buildImage() {
  //   return TweenAnimationBuilder(
  //     tween: Tween<double>(begin: 0, end: 2 * math.pi),
  //     duration: const Duration(seconds: 5),
  //     builder: (_, double angle, __) {
  //       return Transform.rotate(
  //         angle: angle,
  //         child: Image.asset(
  //           'assets/images/bun.jpg',
  //           width: 300,
  //           height: 300,
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget buildImage() {
    return AnimatedBuilder(
      animation: _rotateAnimation,
      child: Image.asset(
        'assets/images/bun.png',
        width: 300,
        height: 300,
      ),
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotateAnimation.value,
          child: child,
        );
      },
    );
  }

  Widget buildText() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPressed = true;
        });
        Navigator.of(context).push(_createRoute());
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) {
        //     return const SecondScreen();
        //   }),
        // );
      },
      child: Center(
        child: Text(
          'Click to know more',
          style: TextStyle(
            fontSize: 24,
            //fontStyle: ,
            color: _isPressed ? Colors.blueGrey : Colors.black,
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SecondScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
