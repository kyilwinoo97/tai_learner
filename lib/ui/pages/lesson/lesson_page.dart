import 'package:flutter/material.dart';

class LessonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  //get lesson list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson"),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.width + 100,
                child: PageView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const Center(
                      child: LessonWidget(),
                    );
                  },
                  itemCount: 5,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
              left: 10,
              right: 10,
              child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton(onPressed: () {}, child: const Text("Next")),
          ))
        ],
      ),
    );
  }
}

//lesson type 1
class LessonWidget extends StatelessWidget {
  const LessonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.volume_up,
              size: 35,
              color: Colors.green,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Click to Repeat",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.85,
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 4)),
                  child: Image.asset(
                    "assets/temp/crying.png",
                    width: 50,
                    height: 50,
                  ));
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 8.0, crossAxisSpacing: 8.0),
          ),
        )
      ],
    );
  }
}
