import 'dart:math';

import 'package:clip_picker/data/database.dart';
import 'package:clip_picker/data/list_box.dart';
import 'package:clip_picker/data/utils.dart';
import 'package:clip_picker/style/color_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'data/pick_class.dart';

class StudyAddPage extends StatefulWidget {
  Pick pick;

  StudyAddPage({Key key, this.pick}) : super(key: key);

  @override
  _StudyAddPageState createState() => _StudyAddPageState();
}

class _StudyAddPageState extends State<StudyAddPage> {

  DateTime dateTime = DateTime.now();
  Pick get pick => widget.pick;
  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  TextEditingController studyTimeController = TextEditingController();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = pick.name;
    memoController.text = pick.memo;
    studyTimeController.text = pick.studyTime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () async {
                  final db = DatabaseHelper.instance;
                  pick.name = titleController.text;
                  pick.memo = memoController.text;
                  if(studyTimeController.text.isEmpty){
                    pick.studyTime = 0;
                  }else{
                    pick.studyTime = int.tryParse(studyTimeController.text) ?? 0;
                  }
                  await db.insertPick(pick);
                  Navigator.of(context).pop();
                },
                child: Text("저장"))
          ],
          backgroundColor: Palette.backgroundColor,
          elevation: 0,
        ),
        body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 13,
              itemBuilder: (ctx, idx) {
                if (idx == 0) {
                  return Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "공부 제목",
                          style: TextStyle(
                              color: Palette.textColor1, fontSize: 18),
                        ),
                        Container(
                          child: TextField(
                            style: TextStyle(color: Palette.textColor1),
                            cursorColor: Colors.white,
                            controller: titleController,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                hintText: "어떤 공부를 하셨나요?",
                                hintStyle: TextStyle(
                                    fontSize: 18, color: Colors.grey[400]),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Palette.textColor, width: 0.5),
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (idx == 1) {

                } else if (idx == 2) {
                  return Container(
                    margin: EdgeInsets.only(left: 20,top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "공부 시간",
                          style: TextStyle(color: Palette.textColor1,fontSize: 18),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: TextField(
                                    style: TextStyle(color: Palette.textColor1),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: studyTimeController,
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor, width: 1.0),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 0.5),
                                            borderRadius: BorderRadius.circular(8)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor, width: 2.0),
                                      ),
                                    ),
                                  ),
                                  width: 70,
                                ),
                                Container(
                                  child: Text(" 분", style: TextStyle(color: Palette.textColor1,fontSize: 18),),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else if (idx == 3) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "메모",
                            style: TextStyle(
                                fontSize: 20, color: Palette.textColor1),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(15),
                            child: TextField(
                              style: TextStyle(color: Palette.textColor1),
                              cursorColor: Colors.white,
                              controller: memoController,
                              maxLines: 10,
                              minLines: 10,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.textColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                fillColor: Palette.textColor,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.textColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusColor: Palette.textColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Palette.textColor,
                                      width: 2,
                                    )),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                } else if (idx == 4) {
                  return Divider(
                    thickness: 0.4,
                    indent: 15,
                    endIndent: 15,
                    color: Palette.textColor1,
                  );
                } else if (idx == 5) {
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "세부 사항",
                                style: TextStyle(
                                    fontSize: 22, color: Palette.textColor1),
                              ),
                            ],
                          ),
                        ],
                      ));
                } else if (idx == 6) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "공부 종류",
                            style: TextStyle(
                                fontSize: 16, color: Palette.textColor1),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(studyType.length, (_idx) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    pick.studyType = _idx;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: pick.studyType == _idx
                                          ? Palette.pick2
                                          : Colors.white),
                                  alignment: Alignment.center,
                                  child: Text(
                                    studyType[_idx],
                                    style: TextStyle(
                                        color: pick.studyType == _idx
                                            ? Colors.white
                                            : Colors.grey[800]),
                                  ),
                                ),
                              );
                            }),
                            crossAxisCount: 4,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                            childAspectRatio: 2.5,
                          ),
                        )
                      ],
                    ),
                  );
                } else if (idx == 7) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "공부 강도",
                            style: TextStyle(
                                fontSize: 16, color: Palette.textColor1),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(studyHard.length, (idx) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    pick.hardStudy = idx;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: pick.hardStudy == idx
                                          ? Palette.pick
                                          : Colors.white),
                                  alignment: Alignment.center,
                                  child: Text(
                                    studyHard[idx],
                                    style: TextStyle(
                                        color: pick.hardStudy == idx
                                            ? Colors.white
                                            : Colors.grey[800]),
                                  ),
                                ),
                              );
                            }),
                            crossAxisCount: 4,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                            childAspectRatio: 2.5,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                } else if (idx == 8) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("색상",style: TextStyle(fontSize: 18,color: Palette.textColor1),),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: colorBox.length,
                            itemBuilder: (ctx, idx) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        pick.color = idx;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 3,
                                          color: idx == pick.color
                                              ? Colors.yellow[200]
                                              : Colors.transparent,
                                        ),
                                          color: colorBox[idx],
                                          borderRadius: BorderRadius.circular(20),),
                                      width: 40,
                                      height: 40,
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                    ],
                  );
                } else if (idx == 9) {
                  return Divider(
                    thickness: 0.8,
                    indent: 15,
                    endIndent: 15,
                    color: Palette.textColor1,
                  );
                } else if (idx == 10) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0,top: 10),
                          child: Text(
                            "사진으로 기록남기기",
                            style: TextStyle(
                                color: Palette.textColor1, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            width: 130,
                            height: 130,
                            child: InkWell(
                              onTap: () {
                                selectImage();
                              },
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Align(
                                  child: pick.image.isEmpty
                                      ? Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Palette.textColor)),
                                          child: Center(
                                              child: Text(
                                            "사진 붙이기",
                                            style: TextStyle(
                                                color: Palette.textColor1),
                                          )),
                                          width: 130,
                                          height: 130,
                                        )
                                      : AssetThumb(
                                          asset: Asset(
                                              pick.image, "noimg.png", 0, 0),
                                          width: 130,
                                          height: 130,
                                        ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }

  Future<void> selectImage() async {
    final _img =
        await MultiImagePicker.pickImages(maxImages: 1, enableCamera: true);
    if (_img.isEmpty) {
      return Container();
    }
    setState(() {
      pick.image = _img.first.identifier;
    });
  }
}

class StudyCard extends StatelessWidget {
  final Pick pick;

  StudyCard({Key key, this.pick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: Container(
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
                              color: Palette.textColor,
                              fontSize: 18,
                              letterSpacing: 0.3),
                        )
                      : Container(
                        child: Text(
                            "${pick.name}".toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3),
                          ),
                    width: 200,
                      ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "공부 시간 · ${Utils.makeTwoDigit(pick.studyTime ~/ 60)}:${Utils.makeTwoDigit(pick.studyTime  % 60)}분".toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
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
                    width: 200,
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
        )))
      ],
    );
  }
}
