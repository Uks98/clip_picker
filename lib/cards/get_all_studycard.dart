import 'package:clip_picker/data/list_box.dart';
import 'package:clip_picker/data/pick_class.dart';
import 'package:clip_picker/data/utils.dart';
import 'package:clip_picker/style/color_style.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import '../show_detail.dart';

class GetAllStudyCard extends StatelessWidget {
  final Pick pick;
  int index;

  GetAllStudyCard({Key key, this.pick, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
            ShowDetail(
              picks: pick,
            )));
      },
      child: Stack(
        children: [
          Center(
              child: Container(
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20),
                    child: Card(
                      color: colorBox[pick.color],
                      elevation: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 25, top: 17, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pick.name.isEmpty
                                ? Text(
                              "무제",
                              style: TextStyle(
                                  color: Palette.textColor,
                                  fontSize: 18,
                                  letterSpacing: 0.3),
                            ).tr()
                                : Container(
                              child: Text(
                                "${pick.name}".toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3),
                              ),
                              width: 400,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("공부 시간 · ", style: TextStyle(
                                    color: Colors.white, fontSize: 16),).tr(),
                                Text(
                                  "${Utils.makeTwoDigit(pick.studyTime ~/ 60)}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),),
                                Text("시간 ", style: TextStyle(
                                    color: Colors.white, fontSize: 16),).tr(),
                                Text(
                                  "${Utils.makeTwoDigit(pick.studyTime % 60)}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),),
                                Text("분", style: TextStyle(
                                    color: Colors.white, fontSize: 16),).tr(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      studyType[pick.studyType],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          letterSpacing: 0.3),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4)),
                                  margin: EdgeInsets.all(2),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        studyHard[pick.hardStudy],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            letterSpacing: 0.3),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            pick.memo.isEmpty
                                ? Container()
                                : Container(
                              width: 400,
                              child: Text(
                                pick.memo.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    letterSpacing: 0.4),
                                maxLines: 10,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            pick.image.isEmpty
                                ? Container()
                                : Container(
                                width: 160,
                                height: 160,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: AssetThumb(
                                    asset: Asset(pick.image, "noimg.png", 0, 0),
                                    width: 160,
                                    height: 160,
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(left: 0,
                                  bottom: 10,
                                  top: 10),
                              child: Text(
                                "${Utils.numToDateTime2(pick.date)}".replaceAll(
                                    '00:00:00.000', ""),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[400]),
                              ),)
                          ],
                        ),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}