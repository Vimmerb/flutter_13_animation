import 'package:flutter/material.dart';
import 'package:flutter_13_animation/third_screen.dart';

class GalleryBun extends StatefulWidget {
  const GalleryBun({Key? key}) : super(key: key);

  @override
  State<GalleryBun> createState() => _GalleryBunState();
}

class _GalleryBunState extends State<GalleryBun>
    with SingleTickerProviderStateMixin {
  List<AssetImage> galleryBun = [
    const AssetImage('assets/images/bun1.jpeg'),
    const AssetImage('assets/images/grandma.jpeg'),
    const AssetImage('assets/images/grandpa.jpeg'),
    const AssetImage('assets/images/hare.jpg'),
    const AssetImage('assets/images/wolf.jpg'),
    const AssetImage('assets/images/bear.jpg'),
    const AssetImage('assets/images/fox.jpg'),
  ];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
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
        buildGallery(),
      ],
    );
  }

  Widget buildGallery() {
    return Container(
      height: 220,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 239, 249, 253),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Who did The Little bun meet?',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              itemCount: galleryBun.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 40),
                  width: 170,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createRoute(index));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ThirdScreen(
                      //       galleryBun: galleryBun[index],
                      //       index: index,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Hero(
                      tag: 'caracteres$index',
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Image(
                          image: galleryBun[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ThirdScreen(
        galleryBun: galleryBun[index],
        index: index,
      ),
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
