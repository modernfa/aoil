import 'dart:convert';

import 'package:aoil/view/intro_page.dart';
import 'package:aoil/view/widget/buttonWidget.dart';
import 'package:aoil/view/widget/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/model/loginResponseModel.dart';
import 'animatedProgressWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // value
  String txtlogin = "ارسال کد تایید";
  var _formKey = GlobalKey<FormState>();
  var email;
  Color? _fillColor = Color(0xFFF0F0F0);
  var password;
  bool _enterOtpCode = false;
  bool _numdisable = true;
  bool _checkLogin = true;
  bool hidepol = true;

  // bool shoProgress = false;

  // bool _isLogin = false;

  // value

  void _otp() {
    setState(() {
      _enterOtpCode = true;
      _fillColor = Color(0xffdbdbdb);
      _numdisable = false;
      _checkLogin = false;
      txtlogin = "ورود";
      hidepol = false;
      Navigator.of(context).pop(animatedProgress);
    });
  }

  void _otpReset() {
    setState(() {
      _enterOtpCode = false;
      _fillColor = Color(0xFFF0F0F0);
      _numdisable = true;
      _checkLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Container(
                height: 200,
                alignment: Alignment.center,
                width: double.infinity,
                decoration: new BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: new Text('ورود / ثبت نام',
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900))),
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                        child: TextFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "فیلد شماره خالی می باشد";
                        } else if (value.length < 11) {
                          return "فیلد شماره کامل نمی باشد";
                        }
                      },
                      labelText: "شماره",
                      icon: Icons.phone_android_outlined,
                      en: _numdisable,
                      fillColor: _fillColor,
                      // onPre: (){},
                      onSaved: (String? value) {
                        email = value;
                      },
                    )),
                    new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Visibility(
                          visible: _enterOtpCode,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "فیلد شماره خالی می باشد";
                              }
                            },
                            onSaved: (String? value) {
                              password = value;
                            },
                            enabled: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4)
                            ],
                            // textAlign: TextAlign.right,
                            // maxLength: 11,
                            style: new TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "کدتایید",
                              labelStyle: new TextStyle(
                                color: Colors.green,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF0F0F0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.password,
                                size: 16,
                                color: Colors.green,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.refresh),
                                color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    animatedProgress();
                                  });
                                  loginSendRequest(email: email);
                                },
                              ),
                            ),
                          ),
                        )),
                    new Visibility(
                        visible: hidepol,
                        child: GestureDetector(
                          child: Text(
                            "مشاهده قوانین و مقررات",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          onTap: showPolicy2,
                        )),
                    new Container(
                      // margin: EdgeInsets.only(top: 10),
                      child: Visibility(
                        visible: _enterOtpCode,
                        child: new TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                color: Color(0xff4a64fe),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            padding: const EdgeInsets.all(0),
                            primary: Colors.green,
                          ),
                          onPressed: () {
                            _formKey.currentState?.reset();
                            _otpReset();
                          },
                          child: const Text('شماره اشتباه است؟'),
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        child: ButtonWidget(title: txtlogin, hasBorder: false),
                        onTap: () {
                          _formKey.currentState?.validate();
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            if (_checkLogin == true) {
                              showPolicy();
                            } else {
                              setState(() {
                                animatedProgress();
                              });
                              tokenSendRequest(
                                  email: email, password: password);
                            }
                          }
                        },
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 15, bottom: 20),
                      child: GestureDetector(
                        child: ButtonWidget(
                          title: "پشتیبانی",
                          hasBorder: true,
                        ),
                        onTap: () {
                          _launchURL();
                          // getData();
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void loginSendRequest({required String email}) async {
    print("login send");
    var url = Uri.http('roydad.modernfa.co', '/api/register', {'q': '{http}'});
    var body = Map<String, dynamic>();
    body["mobile"] = email;
    Response response = await post(url, body: body);
    if (response.statusCode == 200) {
      var loginJson = json.decode(utf8.decode(response.bodyBytes));
      var model = loginResponseModel(loginJson["success"]);
      if (model.status == true) {
        _showToast1(context);
        // Navigator.of(context).pop(animatedProgress);
        _otp();
        print(model.status);
      }
    } else {
      _showToast(context);
      setState(() {
        Navigator.of(context).pop(animatedProgress);
      });
    }
  }

  void tokenSendRequest(
      {required String email, required String password}) async {
    print("token send");

    var url = Uri.http('roydad.modernfa.co', '/api/login', {'q': '{http}'});
    var body = Map<String, dynamic>();
    body["mobile"] = email;
    body["smsToken"] = password;
    Response response = await post(url, body: body);
    if (response.statusCode == 200) {
      var tokenJson = json.decode(utf8.decode(response.bodyBytes));
      var model = tokenResponseModel(tokenJson["success"], tokenJson["data"]);
      if (model.tokenstatus == true) {
        setData(
            model.data["token"],
            model.data["mobile"]);
        _showToast2(context);
        print(model.data);

        if (model.data["trackId"] == null) {
          print(model.data["trackId"]);
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 300),
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondAnimation) {
                return IntroPage();
              },
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondAnimation,
                  Widget child) {
                return ScaleTransition(
                  child: child,
                  scale: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                          parent: animation, curve: Curves.fastOutSlowIn)),
                );
              }));
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  duration: Duration(milliseconds: 800),
                  child: IntroPage()));
        }
      }
    }
  }

  Future<void> showPolicy() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تایید شرایط و قوانین بیگ بار',
              textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('''
                                    تعاریف و اصطلاحات:                                                                                             
فرستنده بار: افرادی که در برنامۀ به عنوان مشتری حقیقی یا حقوقی در بیگ بار به منظور ارسال بار ثبت‌نام کرده‌اند.
افراد فرستنده شامل باربری ها و کارخانه جات وصاحبان بار میشود.
راننده: افرادی که در وبسایت یا اپلیکیشن بیگ بار به منظور حمل بار ثبت نام کرده‌اند.
بار: محموله ای که قرار است توسط راننده و به درخواست فرستنده حمل شده و به گیرنده برسد.
کاربر: شخصی است که به وبسایت یا اپلیکیشن بیگ بار متصل و از خدمات نرم افزاری بیگ بار بهرمند می‌شود.
کاربران: فرستندگان و رانندگان و پیمانکاران.
شرکت ارائه دهندۀ خدمات: ویرا بار اسپاد.
حساب کاربری: حسابی است که افراد برای استفاده از خدمات بیگ بار در نرم‌افزار بیگ بار ایجاد کرده‌اند.
پیمانکاران:اشخاصی که در بیگ بار یک پروژه حمل و نقل را راه اندازی و ان را در بیگ بار مدیریت میکنند.
قوانین:

1.کاربر با ثبت نام در بیگ بار می‌پذیرد که قوانین و مقررات  بیگ بار را به صورت کامل مطالعه و قبول کرده است. این قوانین ممکن است در طول زمان تغییر کند، استفادۀ مستمر کاربران از بیگ بار به معنی پذیرش هرگونه تغییر در قوانین و مقررات آن است.
2.کاربر می‌پذیرد اطلاعات خواسته شده را به صورت صحیح و به روز در سرویس بیگ بار وارد کند.
3.هر فرد تنها می‌تواند یک حساب کاربری به عنوان فرستنده یا راننده در بیگ بار داشته باشد.
4.مسئولیت همۀ فعالیت‌هایی که از طریق حساب کاربری اشخاص در بیگ بار انجام می‌شود به عهدۀ کاربر است.
5.مسئولیت حفظ امنیت اطلاعات حساب کاربری از جمله نام کاربری و رمز عبور بر عهدۀ کاربر است. در صورت مفقود شدن یا سرقت اطلاعات حساب کاربری، کاربر موظف است در اسرع وقت موضوع را به اطلاع شرکت برساند.
 بدیهی است تا زمانی که اطلاع‌رسانی به شرکت انجام نشده است مسئولیت همۀ فعالیت‌هایی که از طریق حساب کاربری مذکور انجام شده و می‌شود بر عهدۀ کاربر خواهد بود.

6.کاربر حق ندارد به اشخاص حقیقی و حقوقی دیگر اجازه استفاده از حساب کاربری خود را بدهد یا حساب خود را به فرد یا شرکت دیگری منتقل کند.
7.هر کاربر دارای یک کد میباشد و این کد مخصوص خود کاربر است و کاربر با تایید قوانین تایید مینماید در حفظ و نگهداری کد کوشا باشد و نزد خود نگه دارد و ان را به اشخاص دیگر ندهد و سرقت کد به منزله سرقت اطلاعات شخصی کاربر میباشد و عواقب سرقت کد بر عهده کاربر میباشد و اگر کد کاربری به سرقت رفت کاربر موظف است در اولین فرصت این موضوع را به اطلاع شرکت برساند.
8.هرگونه خسارت به بار و کمی و کسری یا اضافه بار در طول مسیر حمل بعد از صدور بارنامه از مبدا به مقصد بر عهده ی راننده و شرکت حمل و نقل و یا فرستنده میباشد و بیگ بار هیچ گونه مسئولیتی را پذیرا نمی باشد.
9.فرستنده موظف است بار را به صورت صحیح و سالم وبدون کم وکسری و بار دیگر دقیقا عین نوع محموله ای که در سیستم اعمال شده است بارگیری نماید در غیر اینصورت راننده موظف است بار را کنسل و به اطلاع شرکت برساند و عواقب بارگیری بر عهده راننده و فرستنده میباشد.
10.در صورت اعلان بارتوسط فرستنده و دریافت توسط راننده مبلغ حواله توسط شرکت اخذ میشود و در صورت لغو بار قابل باز پسگیری نمیباشد لذا کاربران بیگ بار در اعلان بار و دریافت بار دقت لازم را بایستی به عمل بیاورند.
11. در شرایط خاصی ممکن است از کاربر برای استفاده از سرویس، درخواست احراز هویت شود، درچنین شرایطی اگر کاربر اطلاعات کافی در اختیار شرکت قرار ندهد، شرکت می‌تواند حساب کاربری وی را مسدود کرده و از ارائۀ سرویس به کاربر خودداری کند.
12.با استفاده از سرویس بیگ بار کاربر می‌پذیرد که از بیگ بار برای انجام هیچ فعالیت غیرقانونی طبق قوانین جمهوری اسلامی ایران یا مخالف با عرف جامعه استفاده نکند. کاربر حق ندارد اشیاء ومحموله هایی که طبق قانون جمهوری اسلامی ایران مجاز نیست از طریق این سرویس ارسال نموده یا به همراه داشته باشد و مسئولیت این امر بر عهده کاربر متخلف میباشد.
13.فرستنده متعهد است در صورت داشتن بار نامتعارف، هر گونه پرنده یا حیوانات دیگر، یا هر موردی از این قبیل موضوع را از قبل به راننده اعلام کند؛ در غیر این‌صورت چنانچه پس از پذیرش درخواست حمل بار و عزیمت راننده به نقطه مبدا، مواجه با موارد فوق شود، مجاز به لغو (امتناع از انجام) حمل بوده و مسئولیت جبران خسارات وارده برعهدۀ فرستنده است.
14.مسئولیت تامین اینترنت و سخت‌افزار لازم و همچنین پرداخت هزینه‌های مربوط به آنها برای استفاده از اپیکیشن بیگ بار به عهدۀ کاربر است.
15.کاربر می‌پذیرد حداکثر بار مجاز در هر ماشین همان است که در کارت ماشین نوشته شده و زدن اضافه بار به هیچ وجه حتی با توافق فرستنده و راننده مجاز نمی‌باشد.
16.کاربر متعهد به رعایت همۀ قوانین راهنمایی و رانندگی، اسلامی، شرعی، اخلاقی و اجتماعی جمهوری اسلامی ایران هنگام استفاده ازاپلیکیشن بیگ بارمیشود.
17.در اپلیکیشن یا وب سایت بیگ بار ارتباط بین فرستندگان و رانندگان و باربری ها را جهت توافق بر انجام یک حمل فراهم می‌کند.
18. درسرویس بیگ بار راننده مختار است یک درخواست حمل یک بار را بپذیرد یا رد کند، همچنین فرستنده زمانی که باری را در سیستم بیگ بار اعلام مینمایید یعنی قبول کرده است که اگر راننده ای بار را دریافت و قبول به حمل ان کرده است و فرستنده موظف به بارگیری کامیون میباشد.
19.قبل از دریافت بار راننده باید با انتخاب گزینه تماس در اپلیکیشن و برقراری ارتباط با شرکت حمل و نقل مورد نظر هماهنگی لازم جهت دریافت بار و جزئییات بار را انجام دهد و سپس اقدام به بارگیری و صدور حواله مجازی کند و شرکت حمل و نقل میپذیرد تمامی اطلاعات را به صورت صریح و درست به راننده انتقال دهد.
20.تا زمانی که راننده باری را که شرکت حمل و نقل یا فرستنده در اپیلیکیشن جهت حمل و بارگیری اعلام کرده است دریافت نکرده باشد فرستده میتواند بار را بدون خسارت از اپیلیکیشن حذف نمایید.
21.فرستنده می‌پذیرد هیچوقت درخواست حمل به بیگ بار ارسال نکند مگر اینکه قصد استفاده از سرویس بیگ بار را داشته باشد. کاربر فرستنده اگر پس از ارسال درخواست حمل و پذیرش درخواست توسط یک راننده و صدور بارنامه توسط شرکت حمل و نقل، درخواست را لغو کند، یا در مکان مشخص شده به عنوان مبدا حمل در زمان مشخص حضور پیدا نکند قانونا پاسخگوی خسارت وارد شده به راننده خواهد بود.
22.فرستنده موظف است ادرس مبدا و مقصد و نوع محموله حمل و تن و تعداد محموله را به طور دقیق در سیستم بیگ بار اعلام نمایید در غیر این صورت جبران خسارت بر عهده فرستنده میباشد.
23.مبلغ کرایه هر محموله به صورت اتوماتیک بسته به نوع بار و مسیر و نوع کامیون بسته با تناژ و... در سیستم بیگ بار طبق عرف اعلام میشود و فرستندگان(به جز شرکت های حمل و نقل) حق تعیین کرایه را ندارند.
24.کرایه حمل بار توسط خود بیگ بار یا شرکت های حمل و نقل تحت قرارداد با بیگ بار تایید میشود.
25.راننده موظف است پس از صدور بارنامه و بارگیری محموله ، شروع سفر خود را توسط برنامه بیگ بار به اطلاع شرکت و فرستنده برساند.
26.راننده موظف است از زمان شروع سفر پس از بارگیری محموله تا پایان سفر ردیاب نرم افزار بیگ بار را فعال نگه داشته و پس از رسیدن به مقصد تخلیه بار را به اطلاع شرکت رساند.
27.چنانچه بیگ بار به این نتیجه برسد حضور یک کاربر (راننده یا مشتری) می‌تواند برای شرکت یا سایر مشتریان یا راننده‌ها خطرناک یا نامطلوب باشد، حق حذف دسترسی کاربر مذکوربه سرویس را دارد.
28.کاربر توافق می‌کند جهت مبادلۀ آسان اطلاعات، همۀ تغییرات و الحاقیه‌های قوانین و مقررات حاضر اعم از تغییر و اضافه کردن شروط آن، ارسال اخطاریه و ابلاغیه‌های مربوط به بیگ بار، از 
طریق سیستم رایانه‌ای بیگ بار به‌عمل آید و کاربر ضمن پذیرش اطلاع از شرط و روند اجرایی آن موافقت خود را نسبت به اعمال شرط مذکور اعلام می‌کند.
30.کاربر با عضویت در سرویس بیگ بار قصد و اراده خود را نسبت به پذیرش انعقاد هرگونه اقدام و عمل حقوقی از جمله عقود و معاملات از راه دور و از طریق سیستم رایانه‌ای و الکترونیکی اعلام می‌کند.
31.در صورت اخذ بار توسط کاربر.صاحبان بار و فرستندگان موظفند قبل از اقدام بارگیری هویت راننده رامشخص و زدن بار به منزله تایید هویت انها میباشد.و بیگ بار مسئولیتی را پذیرا نمیباشد.
32.پیمانکاران پذیرفته اند که مسئولیت انجام پروژه و نوع محموله بار و اصالت رانندگان و حق کرایه رانندگان خود اطمینان کامل را بدست اورد و بیگ بار مسئولیتی پذیرا نمیباشد.
33.اگر رانندگان پیمانکارها قبول به حمل و انجام پروژه پیمانکار کردند یعنی از اصالت بار و کرایه مطمئن شده اند و در غیر اینصورت نباید بارگیری را انجام دهند و شرکت هیچ گونه مسئولیتی را در انجام پروژه های  پیمانکاری پذیرا نمیباشد.
34.چنانچه در روند ثبت بار و دریافت بار تا زمان صدور بارنامه برای هر یک از کاربران هر نوع اختلال و یا مشکلی پیش بیاید و در صورتی که اثبات شود هر یک از کاربران مقصر نبوده اند مسئولیت با بازارگاه بوده و برای حل مشکل باید پاسخ گو باشد.
 35.کاربران بیگ بار پذیرفته اند که تمامی قوانین شامل همه کاربران بیگ بار میشود.


''', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('پذیرش و ادامه'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  animatedProgress();
                });
                if (_checkLogin == true) {
                  loginSendRequest(email: email);
                } else {
                  tokenSendRequest(email: email, password: password);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showPolicy2() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تایید شرایط و قوانین بیگ بار',
              textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('''
                                    تعاریف و اصطلاحات:                                                                                             
فرستنده بار: افرادی که در برنامۀ به عنوان مشتری حقیقی یا حقوقی در بیگ بار به منظور ارسال بار ثبت‌نام کرده‌اند.
افراد فرستنده شامل باربری ها و کارخانه جات وصاحبان بار میشود.
راننده: افرادی که در وبسایت یا اپلیکیشن بیگ بار به منظور حمل بار ثبت نام کرده‌اند.
بار: محموله ای که قرار است توسط راننده و به درخواست فرستنده حمل شده و به گیرنده برسد.
کاربر: شخصی است که به وبسایت یا اپلیکیشن بیگ بار متصل و از خدمات نرم افزاری بیگ بار بهرمند می‌شود.
کاربران: فرستندگان و رانندگان و پیمانکاران.
شرکت ارائه دهندۀ خدمات: ویرا بار اسپاد.
حساب کاربری: حسابی است که افراد برای استفاده از خدمات بیگ بار در نرم‌افزار بیگ بار ایجاد کرده‌اند.
پیمانکاران:اشخاصی که در بیگ بار یک پروژه حمل و نقل را راه اندازی و ان را در بیگ بار مدیریت میکنند.
قوانین:

1.کاربر با ثبت نام در بیگ بار می‌پذیرد که قوانین و مقررات  بیگ بار را به صورت کامل مطالعه و قبول کرده است. این قوانین ممکن است در طول زمان تغییر کند، استفادۀ مستمر کاربران از بیگ بار به معنی پذیرش هرگونه تغییر در قوانین و مقررات آن است.
2.کاربر می‌پذیرد اطلاعات خواسته شده را به صورت صحیح و به روز در سرویس بیگ بار وارد کند.
3.هر فرد تنها می‌تواند یک حساب کاربری به عنوان فرستنده یا راننده در بیگ بار داشته باشد.
4.مسئولیت همۀ فعالیت‌هایی که از طریق حساب کاربری اشخاص در بیگ بار انجام می‌شود به عهدۀ کاربر است.
5.مسئولیت حفظ امنیت اطلاعات حساب کاربری از جمله نام کاربری و رمز عبور بر عهدۀ کاربر است. در صورت مفقود شدن یا سرقت اطلاعات حساب کاربری، کاربر موظف است در اسرع وقت موضوع را به اطلاع شرکت برساند.
 بدیهی است تا زمانی که اطلاع‌رسانی به شرکت انجام نشده است مسئولیت همۀ فعالیت‌هایی که از طریق حساب کاربری مذکور انجام شده و می‌شود بر عهدۀ کاربر خواهد بود.

6.کاربر حق ندارد به اشخاص حقیقی و حقوقی دیگر اجازه استفاده از حساب کاربری خود را بدهد یا حساب خود را به فرد یا شرکت دیگری منتقل کند.
7.هر کاربر دارای یک کد میباشد و این کد مخصوص خود کاربر است و کاربر با تایید قوانین تایید مینماید در حفظ و نگهداری کد کوشا باشد و نزد خود نگه دارد و ان را به اشخاص دیگر ندهد و سرقت کد به منزله سرقت اطلاعات شخصی کاربر میباشد و عواقب سرقت کد بر عهده کاربر میباشد و اگر کد کاربری به سرقت رفت کاربر موظف است در اولین فرصت این موضوع را به اطلاع شرکت برساند.
8.هرگونه خسارت به بار و کمی و کسری یا اضافه بار در طول مسیر حمل بعد از صدور بارنامه از مبدا به مقصد بر عهده ی راننده و شرکت حمل و نقل و یا فرستنده میباشد و بیگ بار هیچ گونه مسئولیتی را پذیرا نمی باشد.
9.فرستنده موظف است بار را به صورت صحیح و سالم وبدون کم وکسری و بار دیگر دقیقا عین نوع محموله ای که در سیستم اعمال شده است بارگیری نماید در غیر اینصورت راننده موظف است بار را کنسل و به اطلاع شرکت برساند و عواقب بارگیری بر عهده راننده و فرستنده میباشد.
10.در صورت اعلان بارتوسط فرستنده و دریافت توسط راننده مبلغ حواله توسط شرکت اخذ میشود و در صورت لغو بار قابل باز پسگیری نمیباشد لذا کاربران بیگ بار در اعلان بار و دریافت بار دقت لازم را بایستی به عمل بیاورند.
11. در شرایط خاصی ممکن است از کاربر برای استفاده از سرویس، درخواست احراز هویت شود، درچنین شرایطی اگر کاربر اطلاعات کافی در اختیار شرکت قرار ندهد، شرکت می‌تواند حساب کاربری وی را مسدود کرده و از ارائۀ سرویس به کاربر خودداری کند.
12.با استفاده از سرویس بیگ بار کاربر می‌پذیرد که از بیگ بار برای انجام هیچ فعالیت غیرقانونی طبق قوانین جمهوری اسلامی ایران یا مخالف با عرف جامعه استفاده نکند. کاربر حق ندارد اشیاء ومحموله هایی که طبق قانون جمهوری اسلامی ایران مجاز نیست از طریق این سرویس ارسال نموده یا به همراه داشته باشد و مسئولیت این امر بر عهده کاربر متخلف میباشد.
13.فرستنده متعهد است در صورت داشتن بار نامتعارف، هر گونه پرنده یا حیوانات دیگر، یا هر موردی از این قبیل موضوع را از قبل به راننده اعلام کند؛ در غیر این‌صورت چنانچه پس از پذیرش درخواست حمل بار و عزیمت راننده به نقطه مبدا، مواجه با موارد فوق شود، مجاز به لغو (امتناع از انجام) حمل بوده و مسئولیت جبران خسارات وارده برعهدۀ فرستنده است.
14.مسئولیت تامین اینترنت و سخت‌افزار لازم و همچنین پرداخت هزینه‌های مربوط به آنها برای استفاده از اپیکیشن بیگ بار به عهدۀ کاربر است.
15.کاربر می‌پذیرد حداکثر بار مجاز در هر ماشین همان است که در کارت ماشین نوشته شده و زدن اضافه بار به هیچ وجه حتی با توافق فرستنده و راننده مجاز نمی‌باشد.
16.کاربر متعهد به رعایت همۀ قوانین راهنمایی و رانندگی، اسلامی، شرعی، اخلاقی و اجتماعی جمهوری اسلامی ایران هنگام استفاده ازاپلیکیشن بیگ بارمیشود.
17.در اپلیکیشن یا وب سایت بیگ بار ارتباط بین فرستندگان و رانندگان و باربری ها را جهت توافق بر انجام یک حمل فراهم می‌کند.
18. درسرویس بیگ بار راننده مختار است یک درخواست حمل یک بار را بپذیرد یا رد کند، همچنین فرستنده زمانی که باری را در سیستم بیگ بار اعلام مینمایید یعنی قبول کرده است که اگر راننده ای بار را دریافت و قبول به حمل ان کرده است و فرستنده موظف به بارگیری کامیون میباشد.
19.قبل از دریافت بار راننده باید با انتخاب گزینه تماس در اپلیکیشن و برقراری ارتباط با شرکت حمل و نقل مورد نظر هماهنگی لازم جهت دریافت بار و جزئییات بار را انجام دهد و سپس اقدام به بارگیری و صدور حواله مجازی کند و شرکت حمل و نقل میپذیرد تمامی اطلاعات را به صورت صریح و درست به راننده انتقال دهد.
20.تا زمانی که راننده باری را که شرکت حمل و نقل یا فرستنده در اپیلیکیشن جهت حمل و بارگیری اعلام کرده است دریافت نکرده باشد فرستده میتواند بار را بدون خسارت از اپیلیکیشن حذف نمایید.
21.فرستنده می‌پذیرد هیچوقت درخواست حمل به بیگ بار ارسال نکند مگر اینکه قصد استفاده از سرویس بیگ بار را داشته باشد. کاربر فرستنده اگر پس از ارسال درخواست حمل و پذیرش درخواست توسط یک راننده و صدور بارنامه توسط شرکت حمل و نقل، درخواست را لغو کند، یا در مکان مشخص شده به عنوان مبدا حمل در زمان مشخص حضور پیدا نکند قانونا پاسخگوی خسارت وارد شده به راننده خواهد بود.
22.فرستنده موظف است ادرس مبدا و مقصد و نوع محموله حمل و تن و تعداد محموله را به طور دقیق در سیستم بیگ بار اعلام نمایید در غیر این صورت جبران خسارت بر عهده فرستنده میباشد.
23.مبلغ کرایه هر محموله به صورت اتوماتیک بسته به نوع بار و مسیر و نوع کامیون بسته با تناژ و... در سیستم بیگ بار طبق عرف اعلام میشود و فرستندگان(به جز شرکت های حمل و نقل) حق تعیین کرایه را ندارند.
24.کرایه حمل بار توسط خود بیگ بار یا شرکت های حمل و نقل تحت قرارداد با بیگ بار تایید میشود.
25.راننده موظف است پس از صدور بارنامه و بارگیری محموله ، شروع سفر خود را توسط برنامه بیگ بار به اطلاع شرکت و فرستنده برساند.
26.راننده موظف است از زمان شروع سفر پس از بارگیری محموله تا پایان سفر ردیاب نرم افزار بیگ بار را فعال نگه داشته و پس از رسیدن به مقصد تخلیه بار را به اطلاع شرکت رساند.
27.چنانچه بیگ بار به این نتیجه برسد حضور یک کاربر (راننده یا مشتری) می‌تواند برای شرکت یا سایر مشتریان یا راننده‌ها خطرناک یا نامطلوب باشد، حق حذف دسترسی کاربر مذکوربه سرویس را دارد.
28.کاربر توافق می‌کند جهت مبادلۀ آسان اطلاعات، همۀ تغییرات و الحاقیه‌های قوانین و مقررات حاضر اعم از تغییر و اضافه کردن شروط آن، ارسال اخطاریه و ابلاغیه‌های مربوط به بیگ بار، از 
طریق سیستم رایانه‌ای بیگ بار به‌عمل آید و کاربر ضمن پذیرش اطلاع از شرط و روند اجرایی آن موافقت خود را نسبت به اعمال شرط مذکور اعلام می‌کند.
30.کاربر با عضویت در سرویس بیگ بار قصد و اراده خود را نسبت به پذیرش انعقاد هرگونه اقدام و عمل حقوقی از جمله عقود و معاملات از راه دور و از طریق سیستم رایانه‌ای و الکترونیکی اعلام می‌کند.
31.در صورت اخذ بار توسط کاربر.صاحبان بار و فرستندگان موظفند قبل از اقدام بارگیری هویت راننده رامشخص و زدن بار به منزله تایید هویت انها میباشد.و بیگ بار مسئولیتی را پذیرا نمیباشد.
32.پیمانکاران پذیرفته اند که مسئولیت انجام پروژه و نوع محموله بار و اصالت رانندگان و حق کرایه رانندگان خود اطمینان کامل را بدست اورد و بیگ بار مسئولیتی پذیرا نمیباشد.
33.اگر رانندگان پیمانکارها قبول به حمل و انجام پروژه پیمانکار کردند یعنی از اصالت بار و کرایه مطمئن شده اند و در غیر اینصورت نباید بارگیری را انجام دهند و شرکت هیچ گونه مسئولیتی را در انجام پروژه های  پیمانکاری پذیرا نمیباشد.
34.چنانچه در روند ثبت بار و دریافت بار تا زمان صدور بارنامه برای هر یک از کاربران هر نوع اختلال و یا مشکلی پیش بیاید و در صورتی که اثبات شود هر یک از کاربران مقصر نبوده اند مسئولیت با بازارگاه بوده و برای حل مشکل باید پاسخ گو باشد.
 35.کاربران بیگ بار پذیرفته اند که تمامی قوانین شامل همه کاربران بیگ بار میشود.


''', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('تایید قوانین'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> animatedProgress() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => animatedProgressWidget(),
    );
  }
}

_launchURL() async {
  const url = 'tel:09331365455';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('خطا در ارسال کد، لطفا دقایقی دیگر تست کنید'),
      action: SnackBarAction(
          label: 'بستن', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

void _showToast1(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('کد با موفقیت ارسال شد'),
      action: SnackBarAction(
          label: 'بستن', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

void _showToast2(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('شما ثبت نام شدید'),
      action: SnackBarAction(
          label: 'بستن', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

void _showToast3(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('کد اشتباه است'),
      action: SnackBarAction(
          label: 'بستن', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

setData(String auToken, String mobile) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLogin', true);
  prefs.setString('auToken', auToken);
  prefs.setString('mobile', mobile);
  print("data is saved");
}
