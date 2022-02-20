import 'package:clip_picker/style/color_style.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'data/list_box.dart';
import 'data/pick_class.dart';
import 'data/utils.dart';

class ShowDetail extends StatelessWidget {
  final Pick picks;
  int index;

  ShowDetail({Key key, this.picks, this.index}) : super(key: key);

  Pick get pick => picks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
          Navigator.of(context).maybePop();
          InAppReview.instance.requestReview();
        }, icon: Icon(Icons.clear)),
        elevation: 0.0,
        backgroundColor: Palette.backgroundColor,
        title: Text(""),
      ),
      body: Container(
        height: 800,
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(
                  height: 5,
                );
              }
              if (index == 1) {
                return Center(
                  child: picks.image.isEmpty?Container(
                    child: Image.asset("lib/assets/noimg.png",fit: BoxFit.cover,),
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        color: Palette.floatingColor,
                        borderRadius: BorderRadius.circular(10)),
                    width: 350,
                    height: 350,
                  ):InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ImageDetail(pickImage: picks)));
                    },
                    child: Container(
                      margin: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width - 10,
                      height: 350,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AssetThumb(
                          asset: Asset(picks.image, "pickImage", 0, 0),
                          width: 350,
                          height: 350,
                        ),
                      ),
                    ),
                  ),
                );
              } else if (index == 2) {
                return Container(
                  margin: EdgeInsets.only(left: 25, top: 15,right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      picks.name.isEmpty ? Text(
                        "무제",
                        style: TextStyle(
                            fontSize: 20, color: Palette.textColor1),
                      ).tr() :Text(
                        picks.name,
                        style: TextStyle(
                            fontSize: 20, color: Palette.textColor1),
                      ),
                    ],
                  ),
                );
              }else if(index ==3 ){
                return Container(
                  margin: EdgeInsets.only(left: 25,top: 15,right: 20),
                  child: Row(
                    children: [
                      Text("공부 시간 · ".tr(), style: TextStyle(color: Colors.white, fontSize: 17),).tr(),
                      Text("${Utils.makeTwoDigit(pick.studyTime ~/ 60)}", style: TextStyle(color: Colors.white, fontSize: 16),),
                      Text("시간".tr(), style: TextStyle(color: Colors.white, fontSize: 17),),
                      Text("${Utils.makeTwoDigit(pick.studyTime % 60)}", style: TextStyle(color: Colors.white, fontSize: 16),),
                      Text("분".tr(), style: TextStyle(color: Colors.white, fontSize: 17),),
                    ],
                  ),
                );
              }else if(index == 4){
                return picks.memo.isEmpty ? Container():Container(
                  margin: EdgeInsets.only(left: 25,top: 15,right: 20),
                  child: Text(picks.memo,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ));
              }else if(index == 5){
                return Container(
                  margin: EdgeInsets.only(left: 25,top: 15),
                  child: Row(
                    children: [
                      Container(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              studyType[picks.studyType],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  letterSpacing: 0.3),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              studyHard[picks.hardStudy],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  letterSpacing: 0.3),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ],
                  ),
                );
              }else if(index == 6){
                return SizedBox(height: 20);
              }
              return Container();
            }),
      ),
    );
  }
}

class ImageDetail extends StatelessWidget {
  Pick pickImage;
   ImageDetail({Key key,this.pickImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Palette.backgroundColor,
        leading: CloseButton(),
      ),
      backgroundColor: Palette.backgroundColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.zero,
            constrained: false,
             child: AssetThumb(
               asset: Asset(pickImage.image, "noimg.png", 400, 400),
               width: 400,
               height: 400,
             ),
          ),
        ),
      )
    );
  }
}

