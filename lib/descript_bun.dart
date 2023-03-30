import 'package:flutter/material.dart';

class DescriptBun extends StatefulWidget {
  const DescriptBun({Key? key}) : super(key: key);

  @override
  State<DescriptBun> createState() => _DescriptBunState();
}

class _DescriptBunState extends State<DescriptBun>
    with SingleTickerProviderStateMixin {
  List<String> list = <String>[
    '- is made of dough',
    '- has a round shape',
    '- talks and sings',
    '- can run away quickly',
    '- is fall for flattery',
  ];

  bool _isExpanded = false;

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _showAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0, end: 180 / 360).animate(
      //_controller
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );
    _showAnimation = Tween<double>(begin: 0, end: 1).animate(
      //_controller
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
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
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                  if (_isExpanded) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                });
              },
              child: Container(
                height: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 239, 249, 253),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Some facts about the Little bun',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      child: const Icon(Icons.arrow_downward),
                      builder: (context, child) {
                        return RotationTransition(
                          turns: _animation,
                          child: child,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizeTransition(
              sizeFactor: _showAnimation,
              axis: Axis.vertical,
              axisAlignment: -1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 239, 249, 253),
                ),
                child: SizedBox(
                  height: 125,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        list[index],
                        style: const TextStyle(fontSize: 17),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
