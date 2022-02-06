import 'package:clip_picker/data/list_box.dart';
import 'package:clip_picker/data/pick_class.dart';
import 'package:clip_picker/data/utils.dart';
import 'package:clip_picker/style/color_style.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class StudyCard extends StatelessWidget {
  final Pick pick;

  StudyCard({Key key, this.pick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                    color: colorBox[pick.color],
                    elevation: 1,
                    child: Container(
                      margin: const EdgeInsets.only(left: 25, top: 17, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pick.name.isEmpty
                              ? Text(
                            "무제",
                            style: TextStyle(
                                color: Palette.textColor1,
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
                                  letterSpacing: 0.4),
                            ),
                            width: 200,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("공부 시간 · ", style: TextStyle(color: Colors.white, fontSize: 16),).tr(),
                              Text("${Utils.makeTwoDigit(pick.studyTime ~/ 60)}", style: TextStyle(color: Colors.white, fontSize: 16),),
                              Text("시간", style: TextStyle(color: Colors.white, fontSize: 16),).tr(),
                              Text("${Utils.makeTwoDigit(pick.studyTime % 60)}", style: TextStyle(color: Colors.white, fontSize: 16),),
                              Text("분", style: TextStyle(color: Colors.white, fontSize: 16),).tr(),
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
                            height: 10,
                          ),
                          pick.memo.isEmpty
                              ? Container()
                              : Container(
                            width: 240,
                            child: Text(
                              pick.memo.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  letterSpacing: 0.3),
                              maxLines: 10,
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
      ],
    );
  }
}