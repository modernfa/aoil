import 'package:aoil/util/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TWO_PI = 3.14 * 2;
class animatedProgressWidget extends StatefulWidget {
  @override
  animatedProgressWidgetState createState() => animatedProgressWidgetState();
}
class animatedProgressWidgetState extends State<animatedProgressWidget> {
  double _targetSize = 1.0;
  @override
  Widget build(BuildContext context) {
    final size = 120.0;
    return Center(
      // This Tween Animation Builder is Just For Demonstration, Do not use this AS-IS in Projects
      // Create and Animation Controller and Control the animation that way.
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.5,end: _targetSize),
        duration: Duration(milliseconds: 1500),
        onEnd: () {
          setState(() {
            if (_targetSize == 0.0) {
              _targetSize = 1.0;
            } else {
              _targetSize = 0.0;
            }
          });
        },
        builder: (context,double value,child){
          return Container(
            width: size,
            height: size,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect){
                    return SweepGradient(
                        startAngle: 0.0,
                        endAngle: TWO_PI,
                        stops: [value,value],
                        // 0.0 , 0.5 , 0.5 , 1.0
                        center: Alignment.center,
                        colors: [Colors.blue,Colors.grey.withAlpha(55)]
                    ).createShader(rect);
                  },
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: Image.asset("assets/image/radial_scale.png").image)
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: size-40,
                    height: size-40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Center(child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/image/radial_scale.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
