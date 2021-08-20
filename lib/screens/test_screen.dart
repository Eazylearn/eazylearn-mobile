import 'dart:ui';

import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/models/test.dart';
import 'package:final_cs426/utility/answer_chooser.dart';
import 'package:final_cs426/utility/current_question_tracker.dart';
import 'package:final_cs426/utility/question_wheel.dart';
import 'package:flutter/material.dart';
import 'package:final_cs426/models/answer.dart';
import 'package:final_cs426/constants/color.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool init = true;
  bool locked = false;
  PageController pageController = PageController();
  PageController wheelController;
  int currentQuestion;
  Test test;
  List<int> userChoices;
  @override
  void initState() {
    super.initState();
    currentQuestion = 0;
    List<Answer> options = [
      Answer(answerText: "min(f) = 12, max(f) = 14"),
      Answer(answerText: "min(f) = -8, max(f) = 24"),
      Answer(answerText: "min(f) = 1, max(f) = 12"),
      Answer(answerText: "min(f) = -12, max(f) = 14")
    ];
    List<Question> questions = List.generate(
        40,
        (index) => Question(
            question:
                '${index + 1}: What are the extreme values of the function f on the given region?',
            equation:
                '${index + 1}: f(x,y) = 2x^3 + y^4\nD = {(x,y) | x^2 + y^2 <= 1}',
            options: options,
            answer: 1));
    test = Test(idTest: "1", topic: "Calculus", questions: questions);
    userChoices = List.generate(test.questions.length, (index) => -1);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        init = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    wheelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: init
          ? Scaffold(
              backgroundColor: primaryColor,
              body: Center(
                child: Text(
                  "Mathematics",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'CALCULUS III',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text('10:00',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          )),
                    ),
                  ],
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        CurrentQuestionTracker(
                            questionNumber: test.questions.length,
                            selected: currentQuestion),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWheel(
                          onControllerCreated: (controller) =>
                              wheelController = controller,
                          questionNumber: test.questions.length,
                          userChoices: userChoices,
                          onScroll: (value) {
                            setState(() {
                              if (!locked) {
                                locked = true;
                                pageController.animateTo(value * (width),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                                locked = false;
                              }
                            });
                          },
                          onQuestionChosenByPicker: (value) {
                            setState(() {
                              currentQuestion = value;
                              pageController.jumpToPage(value);
                              wheelController.jumpToPage(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(children: [
                      PageView.builder(
                          itemCount: test.questions.length,
                          controller: pageController,
                          onPageChanged: (index) => setState(() {
                                if (!locked) {
                                  currentQuestion = index;
                                  locked = true;
                                  wheelController.jumpToPage(index);
                                  locked = false;
                                }
                              }),
                          itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 70, 20, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 8.0, 0),
                                        child: Column(
                                          children: [
                                            Text(
                                              test.questions[index].question,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              test.questions[index].equation,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 21.0,
                                      ),
                                      AnswerChooser(
                                        initial: userChoices[index],
                                        options: test.questions[index].options,
                                        onOptionChange: (option) {
                                          setState(() {
                                            userChoices[index] = option;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )),
                    ]),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("submit"))
                ],
              ),
            ),
    );
  }
}
