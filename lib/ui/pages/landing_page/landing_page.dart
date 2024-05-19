import 'package:flutter/material.dart';
import 'package:tai_learner/ui/pages/Unit/unit_page.dart';
import 'package:tai_learner/ui/pages/lesson/lesson_page.dart';

class LandingPage extends StatelessWidget{
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Landing Page"),),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context,index){
            return  const UnitTitle();
      }),
    );
  }
}

class UnitTitle extends StatelessWidget{
  const UnitTitle({super.key});
  final int contentCount = 5;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UnitPage()));

          },
          child: const Card(
            elevation: 1.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0,horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Learning Unit 1",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black
                  ),),
                  Icon(Icons.ac_unit,size: 30,color: Colors.green,)
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: contentCount * 105,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contentCount,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context,index){
                return   index % 2 == 0 ? const UnitLeftContent(): const UnitRightContent();
              }),
        ),
      ],
    );
  }
}
class UnitCenterContent extends StatelessWidget{
  const UnitCenterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey)
      ),
      child: const Center(
        child:  CircularWidget(),
        ),
    );
  }

}

class UnitLeftContent extends StatelessWidget{
  const UnitLeftContent({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  LessonPage()));

      },
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children :[
           CircularWidget(),
            SizedBox(width: 100,height: 100,)
          ]
      ),
    );
  }

}
class UnitRightContent extends StatelessWidget{
  const UnitRightContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children :[
          SizedBox(width: 100,height: 100,),
          CircularWidget()

        ]
    );
  }

}
class CircularWidget extends StatelessWidget{
  const CircularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6), // Border width
      decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(40), // Image radius
          child: Image.asset("assets/temp/gamer.png", fit: BoxFit.cover),
        ),
      ),
    );
  }

}

