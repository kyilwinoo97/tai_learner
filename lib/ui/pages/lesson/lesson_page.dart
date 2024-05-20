import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tai_learner/bloc/lesson/lesson_bloc.dart';
import 'package:tai_learner/injection_container.dart' as di;

import '../../../bloc/pager/pager_bloc.dart';
import '../../../data/model/Lesson.dart';

class LessonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  var controller = PageController();
  var lessonBloc;
  var pagerBloc;
  @override
  void initState() {
    super.initState();
    lessonBloc = di.sl<LessonBloc>();
    pagerBloc = di.sl<PagerBloc>();
    getLesson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson"),
      ),
      body: BlocBuilder<LessonBloc, LessonState>(
        bloc: lessonBloc,
        builder: (context, state) {
          if (state is Success) {
            List<Lesson> lst = state.lst;
            lst.shuffle();
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    height: 500,
                    child: PageView.builder(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        playSound(lst[index].soundUrl);
                        return  Center(
                          child: LessonWidget(
                            questions: lst[index].question,
                            soundUrl: lst[index].soundUrl,
                          ),
                        );
                      },
                      itemCount: lst.length,
                    ),
                  ),
                  buildButton(lst.length),
                ]);
          } else if (state is Failure) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const CircularProgressIndicator(
              color: Colors.green,
            );
          }
        },
      ));
  }

  void getLesson() {
    lessonBloc.add(const GetLesson());
  }
  Widget buildButton(int listLength) {
    return BlocConsumer<PagerBloc, PagerState>(
      bloc: pagerBloc,
      listener: (context, state) {
        if (state is PagerSuccess) {
          controller.jumpToPage(state.pageCount);
        }
      },
      builder: (context, state) {
        if (state is PagerFinish) {
          return ButtonWidget(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: "Finish");
        } else {
          return ButtonWidget(
              onPressed: () {
                pagerBloc.add(Next(listLength));
              },
              text: "Next");
        }
      },
    );
  }

  Widget ButtonWidget({VoidCallback? onPressed, required String text}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
            onPressed: onPressed,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            )));
  }
}
void playSound(String soundUrl) async{
  AudioPlayer player = AudioPlayer();
  await player.play(AssetSource(soundUrl));
}


//lesson type 1
class LessonWidget extends StatelessWidget {
  List<Question> questions;
  String soundUrl;
  LessonWidget({required this.questions,required this.soundUrl,super.key});

  @override
  Widget build(BuildContext context) {
    questions.shuffle();
    return Column(
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                playSound(soundUrl);
              },
              child: const Icon(
                Icons.volume_up,
                size: 35,
                color: Colors.green,
              ),
            ),
            const Padding(
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
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  playSound(questions[index].soundUrl);
                },
                child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 4)),
                    child: Image.asset(
                      questions[index].url,
                      width: 50,
                      height: 50,
                    )),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 8.0, crossAxisSpacing: 8.0),
          ),
        )
      ],
    );
  }
}
