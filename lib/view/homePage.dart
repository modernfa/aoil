import 'dart:io';

import 'package:aoil/view/item.dart';
import 'package:aoil/view/login.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_share/flutter_share.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.indexset}) : super(key: key);
  final int indexset;

  @override
  _HomePageState createState() => _HomePageState();

// final String title = "shayan";
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    // _getData();
  }

  String name4 = "";
  var mobile;
  String? img = null;
  bool isOpened = false;
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  // bottom
  List<Widget> _options = [item(), LoginScreen(), LoginScreen()];
  late int _currentIndex = widget.indexset;

  // bottom
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          final message = "برای خروج دوباره دکمه برگشت را بزنید";
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          SystemNavigator.pop();
          return true;
        }
      },
      child: SideMenu(
        key: _endSideMenuKey,
        inverse: true,
        // end side menu
        background: Color(0xff045e09),
        type: SideMenuType.shrinkNSlide,
        menu: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: buildMenu(),
        ),
        onChange: (_isOpened) {
          setState(() => isOpened = _isOpened);
        },
        child: SideMenu(
          key: _sideMenuKey,
          menu: buildMenu(),
          type: SideMenuType.shrinkNSlide,
          onChange: (_isOpened) {
            setState(() => isOpened = _isOpened);
          },
          child: IgnorePointer(
            ignoring: isOpened,
            child: Scaffold(
              body: Container(
                color: Colors.blue,
                child: PageView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return _options[_currentIndex];
                  },
                  itemCount: 1,
                  // scrollDirection: Axis.horizontal,
                ),
                // child: Text(
                //   _options[_currentIndex],
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 40),
                // )),
              ),

              bottomNavigationBar: CurvedNavigationBar(
                index: _currentIndex,
                buttonBackgroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                animationDuration: Duration(milliseconds: 600),
                animationCurve: Curves.easeInOutCubic,
                items: <Widget>[
                  Icon(
                    Icons.app_registration,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.home,
                    color: Color(0xFF05388E),
                    size: 40,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                    // print(_currentIndex);
                  });
                },
              ),

              extendBodyBehindAppBar: true,
              // backgroundColor: NowUIColors.bgColorScreen,
              extendBody: true,

              appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,

                centerTitle: true,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => toggleMenu(true),
                  )
                ],
                // title: Text(widget.title),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 60, bottom: 50, right: 30),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/image/logo.png"),
                      backgroundColor: Colors.white,
                      radius: 22.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("محمد صحت", style: TextStyle(color: Colors.white)),
                    SizedBox(height: 80.0),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 700),
                          child: LoginScreen()));
                },
                leading:
                    const Icon(Icons.settings, size: 20.0, color: Colors.white),
                title: const Text("حساب کاربری"),
                textColor: Colors.white,
                dense: true,
                horizontalTitleGap: 0,
                minLeadingWidth: 30,
              ),
              ListTile(
                onTap: () {
                  _launchURL();
                },
                leading: const Icon(Icons.contact_support,
                    size: 20.0, color: Colors.white),
                title: const Text("پشتیبانی"),
                textColor: Colors.white,
                dense: true,
                horizontalTitleGap: 0,
                minLeadingWidth: 30,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 700),
                          child: LoginScreen()));
                },
                leading: const Icon(Icons.contact_mail,
                    size: 20.0, color: Colors.white),
                title: const Text("درباره ما"),
                textColor: Colors.white,
                dense: true,
                horizontalTitleGap: 0,
                minLeadingWidth: 30,
                // padding: EdgeInsets.zero,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 700),
                          child: LoginScreen()));
                },
                leading: const Icon(Icons.message_rounded,
                    size: 20.0, color: Colors.white),
                title: const Text("شکایات و انتقادات"),
                textColor: Colors.white,
                dense: true,
                horizontalTitleGap: 0,
                minLeadingWidth: 30,
                // padding: EdgeInsets.zero,
              ),
              ListTile(
                onTap: () {
                  share();
                },
                leading:
                    const Icon(Icons.share, size: 20.0, color: Colors.white),
                title: const Text("معرفی به دوستان"),
                textColor: Colors.white,
                dense: true,
                horizontalTitleGap: 0,
                minLeadingWidth: 30,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 700),
                          child: LoginScreen()));
                },
                leading:
                    const Icon(Icons.policy, size: 20.0, color: Colors.white),
                title: const Text("قوانین و مقررات"),
                textColor: Colors.white,
                dense: true,
                horizontalTitleGap: 0,
                minLeadingWidth: 30,

                // padding: EdgeInsets.zero,
              ),
              // ListTile(
              //   onTap: () {},
              //   leading:
              //       const Icon(Icons.email, size: 20.0, color: Colors.white),
              //   title: const Text("پیشنهادات و انتقادات"),
              //   textColor: Colors.white,
              //   dense: true,
              //   horizontalTitleGap: 0,
              //   minLeadingWidth: 30,
              //
              //   // padding: EdgeInsets.zero,
              // ),
              ListTile(
                onTap: () {
                  logOut();
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 400),
                          child: LoginScreen()));
                },
                leading: const Icon(Icons.power_settings_new,
                    size: 20.0, color: Colors.white),
                title: const Text("خروج"),
                textColor: Colors.white,
                dense: true,
                horizontalTitleGap: 0,
                minLeadingWidth: 30,

                // padding: EdgeInsets.zero,
              ),
            ],
          ),
        ));
  }

}

void logOut() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

_launchURL() async {
  const url = 'tel:09331365455';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void share() async {
  await FlutterShare.share(
      title: 'معرفی به دوستان',
      text: '''
     سلام
بیا تو برنامه بیگ بار ی عالمه بار هست.
لینک زیر رو بزن برنامه رو دانلود کن و بارتو بگیر
''',
      linkUrl: 'https://cafebazaar.ir/app/com.virabar.bigbaar',
      chooserTitle: 'ارسال بیگ بار به دوستان');
}

openregister() async {
  var url = "https://portal.bigbaar.com/";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Card generateItem(griditem, context) {
  return Card(
    elevation: 1,
    child: InkWell(
      onTap: () {},
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              griditem,
              style: TextStyle(
                  fontFamily: "Vazir", color: Colors.red[700], fontSize: 16.0),
            ),
          ],
        ),
      ),
    ),
  );
}
