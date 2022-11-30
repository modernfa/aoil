
import 'package:aoil/view/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class item extends StatelessWidget {
  const item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(2.0, 2.0),
            // 10% of the width, so there are ten blinds.
            colors: <Color>[
              Color(0xff70d2fc),
              Color(0xff008ec7),
              Color(0xff001219)
            ], // red to yellow
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: 70, left: 12, right: 12, bottom: 100),
          child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: (10 / 12),
              // crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              //physics:BouncingScrollPhysics(),
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                              child: LoginScreen()));
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(2.0, 3.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: <Color>[
                                    Color(0xff00ff88),
                                    Color(0xff001219)
                                  ], // red to yellow
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage("assets/image/item_1.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),

                        Text(
                          'سالن اعلام بار',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Vazir",
                              color: Colors.white70,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                              child: LoginScreen()));
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(2.0, 3.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: <Color>[
                                    Color(0xff1effba),
                                    Color(0xff001219)
                                  ], // red to yellow
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage("assets/image/item_3.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'حواله دریافتی',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Vazir",
                              color: Colors.white70,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                              child: LoginScreen()));
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(2.0, 3.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: <Color>[
                                    Color(0xffaaffeb),
                                    Color(0xff001219)
                                  ], // red to yellow
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage("assets/image/item_2.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'سوابق بار',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Vazir",
                              color: Colors.white70,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),


                //
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                              child: LoginScreen()));
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(2.0, 3.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: <Color>[
                                    Color(0xffbeff3b),
                                    Color(0xff001219)
                                  ], // red to yellow
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage("assets/image/item_4.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'صدور بارنامه',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Vazir",
                              color: Colors.white70,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                              child: LoginScreen()));
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(2.0, 3.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: <Color>[
                                    Color(0xfff5ff74),
                                    Color(0xff001219)
                                  ], // red to yellow
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage("assets/image/item_5.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'سوابق بارنامه',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Vazir",
                              color: Colors.white70,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                              child: LoginScreen()));
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(2.0, 3.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: <Color>[
                                    Color(0xffffff46),
                                    Color(0xff001219)
                                  ], // red to yellow
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage("assets/image/item_6.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'کیف پول',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Vazir",
                              color: Colors.white70,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
                //
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500),
                              child: LoginScreen()));
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(2.0, 3.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: <Color>[
                                    Color(0xfff9bd55),
                                    Color(0xff001219)
                                  ], // red to yellow
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage("assets/image/item_7.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'آب و هوا',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Vazir",
                              color: Colors.white70,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
              ]),
        ),
      ),
    );
  }
}
