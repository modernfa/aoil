import 'package:aoil/util/model/step_model.dart';
import 'package:aoil/view/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<StepModel> list = StepModel.list;
  var _controller = PageController();
  var initialPage = 0;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        initialPage = _controller.page!.round();
      });
    });

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          _body(_controller),
          _indicator(),
        ],
      ),
    );
  }

  _appBar() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.all(12),
    );
  }

  _body(PageController controller) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              index == 1
                  ? _displayText(list[index].text)
                  : _displayImage(list[index].id),
              SizedBox(
                height: 25,
              ),
              index == 1
                  ? _displayImage(list[index].id)
                  : _displayText(list[index].text),
            ],
          );
        },
      ),
    );
  }

  _indicator() {
    return Container(
      width: 90,
      height: 90,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 90,
              height: 90,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purple),
                value: (initialPage + 1) / (list.length + 1),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (initialPage < list.length)
                  _controller.animateToPage(initialPage + 1,
                      duration: Duration(microseconds: 500),
                      curve: Curves.easeIn);
                else if (initialPage == list.length) print(initialPage);
                print(list.length);
                setData(true);
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        duration: Duration(milliseconds: 800),
                        child: LoginScreen()));
              },
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _displayText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  _displayImage(int path) {
    return Image.asset(
      "assets/image/$path.png",
      height: MediaQuery.of(context).size.height * .5,
    );
  }

  setData(bool newuser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isReadIntro', true);
  }
}
