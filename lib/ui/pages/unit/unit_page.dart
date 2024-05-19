import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tai_learner/bloc/pager/pager_bloc.dart';
import 'package:tai_learner/repository/unit/unit_repository.dart';

import '../../../bloc/unit/unit_bloc.dart';
import '../../../data/model/Unit.dart';
import 'package:tai_learner/injection_container.dart' as di;

class UnitPage extends StatefulWidget {
  const UnitPage({super.key});

  @override
  State<StatefulWidget> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  var controller = PageController();
  var unitBloc;
  var pagerBloc;

  @override
  void initState() {
    super.initState();
    unitBloc = di.sl<UnitBloc>();
    pagerBloc = di.sl<PagerBloc>();
    getUnit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Unit 1"),
        ),
        body: BlocBuilder<UnitBloc, UnitState>(
          bloc: unitBloc,
          builder: (context, state) {
            if (state is Success) {
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
                          return Center(
                            child: UnitWidget(state.result[index]),
                          );
                        },
                        itemCount: state.result.length,
                      ),
                    ),
                    buildButton(state.result.length),
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

  void getUnit() {
    unitBloc.add(GetAllUnit());
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
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWidget(
                  onPressed: () {
                    pagerBloc.add(Previous());
                  },
                  text: "Previous"),
              ButtonWidget(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: "Finish"),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWidget(
                  onPressed: () {
                    pagerBloc.add(Previous());
                  },
                  text: "Previous"),
              ButtonWidget(
                  onPressed: () {
                    pagerBloc.add(Next(listLength));
                  },
                  text: "Next")
            ],
          );
        }
      },
    );
  }

  Widget ButtonWidget({VoidCallback? onPressed, required String text}) {
    return Container(
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

class UnitWidget extends StatelessWidget {
  Unit unit;

  UnitWidget(this.unit, {super.key});

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
        SizedBox(width: 300, height: 300, child: Image.asset(unit.imageUrl)),
      ],
    );
  }
}
