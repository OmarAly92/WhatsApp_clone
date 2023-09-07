import 'package:flutter/material.dart';



class ScrollSettingTest extends StatefulWidget {
  const ScrollSettingTest({super.key});

  @override
  State<ScrollSettingTest> createState() => _ScrollSettingTestState();
}

class _ScrollSettingTestState extends State<ScrollSettingTest> {
  ScrollController? con;

  @override
  void initState() {
    // TODO: implement initState
    con = ScrollController();
    con?.addListener(() {
      print(con!.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: con,
        children: [
          ElevatedButton(
            onPressed: () {
              con!.animateTo(
                con!.position.maxScrollExtent,
                duration: const Duration(seconds: 2),
                curve: Curves.easeIn,
              );
            },
            child: const Text("dowm"),
          ),
          ...List.generate(
            5,
            (index) {
              return Container(
                color: Colors.amber,
                width: 200,
                height: 200,
                margin: const EdgeInsets.all(10),
              );
            },
          ),
        ],
      ),
    );
  }
}
