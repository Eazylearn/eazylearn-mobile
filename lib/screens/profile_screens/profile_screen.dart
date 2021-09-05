import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/screens/profile_screens/profile_editting_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    if (Session.user == null) Session.user = Session.defaultUser;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(children: [
              _buildAppBar(context),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(children: [
                  Row(
                    children: [
                      _buildUpperBox(
                          heading: "Finished test",
                          num: "100",
                          color: primaryColor),
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: _buildUpperBox(
                                heading: "Average score",
                                num: "7.5",
                                color: secondaryColor)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ]),
              ),
              _buildPersonalInfoCard(context)
            ]),
            _buildNameCard(context)
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: _buildRoundedBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Personal info",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          print("asdf");
                          _edit(context);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date of birth",
                              style: TextStyle(color: grey, fontSize: 18)),
                          Text(
                              DateFormat("dd/MM/yyyy").format(Session.user.dob),
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dial num",
                              style: TextStyle(color: grey, fontSize: 18)),
                          Text(Session.user.phone,
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Email address:",
                    style: TextStyle(color: grey, fontSize: 18)),
                Text(Session.user.email, style: TextStyle(fontSize: 18))
              ],
            ),
          )),
    );
  }

  Widget _buildRoundedBox({@required Color color, @required Widget child}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }

  Widget _buildUpperBox(
      {@required String heading, @required String num, @required Color color}) {
    return _buildRoundedBox(
        color: color,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Column(
            children: [
              Text(heading,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold)),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  num,
                  style: TextStyle(
                      fontFamily: "Open Sans",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45),
                ),
              ))
            ],
          ),
        ));
  }

  Widget _buildAppBar(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(color: primaryColor),
        child: Center(
          child: CircleAvatar(
            radius: 120,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 100,
              backgroundImage: Image.asset(
                "lib/images/default_avatar.png",
                fit: BoxFit.fill,
              ).image,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 40, left: 5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 40,
            color: Colors.white,
          ))
    ]);
  }

  Widget _buildNameCard(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 340, left: 20, right: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Session.user.firstname + " " + Session.user.lastname,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(
                    Session.user.username,
                    style: TextStyle(color: grey),
                  ),
                ],
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    print("asdf");
                    _edit(context);
                  },
                  icon: Icon(Icons.edit),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _edit(BuildContext context) {
    Navigator.of(context)
        .push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProfileEdittingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            }))
        .then((value) => setState(() {}));
  }
}