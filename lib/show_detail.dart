import 'package:clip_picker/style/color_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        color: Palette.floatingColor,
                        borderRadius: BorderRadius.circular(20)),
                    width: 350,
                    height: 350,
                  ):Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AssetThumb(
                        asset: Asset(picks.image, "noimg.png", 0, 0),
                        width: 350,
                        height: 350,
                      ),
                    ),
                  ),
                );
              } else if (index == 2) {
                return Container(
                  margin: EdgeInsets.only(left: 25, top: 10,right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      picks.name.isEmpty ? Text(
                        "무제",
                        style: TextStyle(
                            fontSize: 30, color: Palette.textColor),
                      ):Text(
                        picks.name,
                        style: TextStyle(
                            fontSize: 20, color: Palette.textColor),
                      ),
                    ],
                  ),
                );
              } else if (index == 3) {
                String _t = pick.time.toString();
                String _m = _t.substring(
                  _t.length - 2,
                ); //뒤에 분 가져오자
                String _h = _t.substring(
                  0,
                  _t.length - 2,
                );
                TimeOfDay _times =
                TimeOfDay(hour: int.parse(_h), minute: int.parse(_m));

                String _ts = pick.studyTime.toString();
                String _ms = _ts.substring(
                  _t.length - 2,
                ); //뒤에 분 가져오자
                String _hs = _ts.substring(
                  0,
                  _ts.length - 2,
                );
                TimeOfDay _timesa = TimeOfDay(hour: int.parse(_hs), minute: int.parse(_ms));
                return Container(
                  margin: EdgeInsets.only(left: 25,top: 15,),
                  child: Row(
                    children: [
                      Text(
                        "${_times.hour > 11 ? "오후 " : "오전 "}"
                            "${Utils.makeTwoDigit(_times.hour % 12)}"
                            ":${Utils.makeTwoDigit(_times.minute)}분",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        " / ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "${Utils.makeTwoDigit(_timesa.hour % 12)}시간"
                            ":${Utils.makeTwoDigit(_timesa.minute)}분",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              }else if(index == 4){
                return Container(
                  margin: EdgeInsets.only(left: 25,top: 20,right: 20),
                  child: Text(picks.memo,
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
                      SizedBox(width: 10,),
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
                    ],
                  ),
                );
              }else if(index == 6){
                return SizedBox(height: 30,);
              }
              return Container();
            }),
      ),
    );
  }
}
