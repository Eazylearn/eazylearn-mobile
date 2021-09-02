import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/test_preview.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/screens/test_screen.dart';
import 'package:flutter/material.dart';

class TestPreviewCard extends StatelessWidget {
  final TestPreview preview;
  final bool isFirst;
  const TestPreviewCard({@required this.preview, @required this.isFirst});
  @override
  Widget build(BuildContext context) {
    List<Image> difficultyDisplayer = [];
    for (int i = 0; i < preview.difficulty; i++) {
      difficultyDisplayer.add(Image.asset(
        "lib/images/flash.png",
        scale: 25,
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(left: isFirst ? 35 : 15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) => _buildSheet(context));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: preview.color,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    padding: EdgeInsets.all(15),
                    height: 120,
                    width: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(preview.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          preview.subject.name,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSheet(BuildContext context) {
    String displayedTopics = "";
    for (Topic topic in preview.topics) {
      displayedTopics += topic.name + ", ";
    }
    displayedTopics = displayedTopics.trim() + "...";
    return Theme(
      data: ThemeData(fontFamily: "Open Sans"),
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        height: 600,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(children: [
                SizedBox(
                    width: 60,
                    child: Divider(
                        thickness: 3, color: Colors.white.withOpacity(0.63))),
                SizedBox(height: 5),
                Text(
                  preview.name,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subject",
                                  style: TextStyle(fontSize: 26),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(preview.subject.name,
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(width: 5),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: preview.color),
                                      child: SizedBox(width: 20, height: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            flex: 3,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(fontSize: 26),
                                ),
                                SizedBox(height: 5),
                                Text(preview.time.toString() + " min",
                                    style: TextStyle(fontSize: 18))
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("Topic", style: TextStyle(fontSize: 26)),
                      Text(displayedTopics, style: TextStyle(fontSize: 18)),
                      SizedBox(height: 20),
                      Text(
                        "Description",
                        style: TextStyle(fontSize: 26),
                      ),
                      Text(
                        "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla " +
                            "bla bla bla bla bla bla bla bla bla\n\nbla\nbla\nbla\nbla\nbla ",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TestScreen()));
                },
                child: Text(
                  "START",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(secondaryColor),
                    minimumSize: MaterialStateProperty.all(Size(270, 50)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}