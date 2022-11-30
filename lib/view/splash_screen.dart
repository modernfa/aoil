import 'dart:async';
import 'dart:io';
import 'package:aoil/util/images.dart';
import 'package:aoil/view/homePage.dart';
import 'package:aoil/view/intro_page.dart';
import 'package:aoil/view/login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isConnectionSuccessful = true;
  bool _shoprogress = true;

  @override
  initState() {
    super.initState();
    _tryConnection();
  }

  Future<void> _tryConnection() async {
    try{
      Timer(Duration(seconds: 1), () async {
        final response = await InternetAddress.lookup('jahromkala.com').timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            setState(() {
              _isConnectionSuccessful = false;
              _shoprogress = false;
            });
            return throw TimeoutException('Can\'t connect in 5 seconds.');
          },
        );

        if (response.isEmpty) {
          setState(() {
            _isConnectionSuccessful = false;
            _shoprogress = false;
          });
        }
      });
      Timer(
          Duration(seconds: 3),
              () => _getData());

    }catch(Exception){
      setState(() {
        _isConnectionSuccessful = false;
        _shoprogress = false;
        print("false");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.bg),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Container(
                      margin: EdgeInsets.only(top: 50),
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.logo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    new Container(
                        child: new Text('فوتبالی به پهنای ایران زمین...!',
                            textDirection: TextDirection.rtl,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white30))),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 60,right: 20,left: 20),
                        child: _isConnectionSuccessful == true
                            ?SizedBox()
                            :Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: ElevatedButton(
                              onPressed: () {
                              },
                              style:
                              ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors
                                      .greenAccent,
                                  shape:
                                  new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius
                                        .circular(
                                        10.0),
                                  )),
                              child: Container(
                                padding: EdgeInsets.only(
                                    right: 3,
                                    left: 3,
                                    top: 9,
                                    bottom: 9),
                                alignment: Alignment.center,
                                child: new Text(
                                  "تلاش مجدد",
                                  style: new TextStyle(
                                      color:
                                      Color(0xFFF0F0F0),
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w700),
                                ),
                              ),
                            )),
                            SizedBox(width: 8,),
                            Expanded(child: ElevatedButton(
                              onPressed: () {
                                callsupport();
                              },
                              style:
                              ElevatedButton.styleFrom(
                                  primary: Colors.lightGreen,
                                  // background
                                  onPrimary: Colors
                                      .greenAccent,
                                  // foreground
                                  shape:
                                  new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius
                                        .circular(
                                        10.0),
                                  )),
                              child: Container(
                                padding: EdgeInsets.only(
                                    right: 3,
                                    left: 3,
                                    top: 9,
                                    bottom: 9),
                                alignment: Alignment.center,
                                child: new Text(
                                  "پشتیبانی",
                                  style: new TextStyle(
                                      color:
                                      Color(0xFFF0F0F0),
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight.w700),
                                ),
                              ),
                            )),
                          ],
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 25),
                      child: Center(
                        child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: _shoprogress,
                          child: CircularProgressIndicator(strokeWidth: 9,color: Colors.amberAccent),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),

      ),
    );
  }
  callsupport() async {
    const url = 'tel:09331365455';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('isReadIntro') == true
    ?prefs.getBool('isLogin') == true
      ?Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 800),
            child: HomePage(indexset: 1)))
      :Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 800),
            child: LoginScreen()))
    :Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: Duration(milliseconds: 800),
            child: IntroPage()));


  }
}
