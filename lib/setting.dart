import 'package:clip_picker/copy_right/copy_right.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/database.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isSwitched = false;
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.clear),
          color:Colors.grey[500],
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          '설정',
          style: TextStyle(
              fontSize: 20,
              color:Colors.grey[700],
              fontWeight: FontWeight.bold
          ),
        ).tr(),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          SizedBox(
          ),
          ListTile(
            title: Text(
              'Study picker',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          ListTile(
              trailing: Icon(Icons.arrow_drop_down),
              onTap: (){
             //   Get.to(
             //       IntroductionScreen(
             //         showNextButton: true,
             //         isProgressTap: true,
             //         isProgress: true,
             //         showSkipButton: true,
             //         next: Text('다음',
             //             style: TextStyle(
             //                 fontWeight: FontWeight.bold, color: Colors.grey[800])),
             //         onSkip: () {
             //           Get.to(MyHomePage());
             //         },
             //         skip: Text('넘어가기',
             //             style: TextStyle(
             //                 fontWeight: FontWeight.bold, color: Colors.grey[800])),
             //         done: Text('시작하기',
             //             style: TextStyle(
             //                 fontWeight: FontWeight.bold, color: Colors.grey[800])),
             //         onDone: () {
             //           Get.to(MyHomePage());
             //         },
             //         pages: getPages(),
             //         globalBackgroundColor: Colors.white,
             //       ));


              },
              title: Text(
                '설명서',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ).tr()),
          //Padding(
          //  padding: EdgeInsets.only(
          //      left: 10,
          //      right: 10
          //  ),
          //  child: Row(
          //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //    children: [
          //      Text(
          //        '야간모드',
          //        style: TextStyle(
          //          fontSize: 18,
          //          fontFamily: 'gom_KR',
          //          fontWeight: FontWeight.bold,
          //        ),
          //      ),
          //      CupertinoSwitch(value: isSwitched, onChanged: (value){
          //        setState(() {
          //        });
          //      }),
          //    ],
          //  ),
          //),
           ListTile(
              trailing: Icon(Icons.arrow_drop_down),
              onTap: _sendEmail,
              title: Text(
                '의견 전달하기',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'gom_KR',
                    fontWeight: FontWeight.bold
                ),
              ).tr()),
          SizedBox(
            height: 10,
          ),
          ListTile(
              trailing: Icon(Icons.arrow_drop_down),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CopyRight()));
              },
              title: Text(
                '저작권',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'gom_KR',
                    fontWeight: FontWeight.bold
                ),
              ).tr()),
          ListTile(
              trailing: Icon(Icons.arrow_drop_down),
              onTap: _qmail,
              title: Text(
                '질문 보내기',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'gom_KR',
                    fontWeight: FontWeight.bold
                ),
              ).tr()),
          Padding(
            padding: EdgeInsets.only(
              left:20,
            ),
            child: Text(
              '정보',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'gom_KR',
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
              trailing: Icon(Icons.arrow_drop_down),
              onTap: () {
                InAppReview.instance.requestReview();},
              title: Text(
                '개발자 칭찬하기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'gom_KR',
                ),
              ).tr()),
          SizedBox(
            height: 10,
          ),
          ListTile(
              trailing: Icon(Icons.arrow_drop_down),
              onTap: (){},
              title: Text(
                '어플리케이션 정보',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'gom_KR',
                    fontWeight: FontWeight.bold
                ),
              ).tr()),
          ListTile(
              trailing: Icon(Icons.arrow_drop_down),
              onTap: (){
              },
              title: Text(
                '이용약관 및 개인정보취급방침',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'gom_KR',
                    fontWeight: FontWeight.bold
                ),
              ).tr()),
        ],
      ),
    );
  }

  _sendEmail() {
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'rozyfactory@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': '[Study picker] 의견 보내기',
        'body': '''많이 부족한 Study picker을 이용해 주셔서 감사합니다.
          주신 의견을 토대로 발전해 나가겠습니다.'''
      }),
    );
    launch(emailLaunchUri.toString());
  }

  _qmail() {
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries.map((e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'rozyfactory@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': '[Study picker] 질문 보내기',
        'body': '''궁금하신점이 있으신가요?.'''
      }),
    );
    launch(emailLaunchUri.toString());
  }
}
