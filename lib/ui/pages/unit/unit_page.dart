import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tai_learner/repository/unit/unit_repository.dart';
import 'package:tai_learner/ui/pages/unit/bloc/unit_bloc.dart';

import '../../../data/model/Unit.dart';

class UnitPage extends StatefulWidget {
  const UnitPage({super.key});

  @override
  State<StatefulWidget> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  List<Unit> lstUnit = [];
  var controller = PageController();

  @override
  void initState() {
    super.initState();
    getUnit();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit 1"),
      ),
      body: BlocBuilder<UnitBloc, UnitState>(builder: (context, state) {
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
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if(++ currentIndex < state.result.length){
                          controller.jumpToPage(++ currentIndex);
                        }
                      },
                      child:  const Text("Next")),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Finish")
                ))
              ]);
        }else if (state is Failure){
          return  Center(
            child: Text(state.message),
          );
        }else{
          return const CircularProgressIndicator(color: Colors.green,);

        }
      }),

    );
  }

  void loadData() async {
    var repository = UnitRepository();
    var lst = await repository.getUnit();
    setState(() {
      lstUnit.addAll(lst);
    });
  }

  void getUnit() {
    BlocProvider.of<UnitBloc>(context).add(GetAllUnit());
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
