import 'dart:ui';

import 'package:clip_picker/data/pick_class.dart';
import 'package:clip_picker/style/color_style.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> studyType = [
  "국어".tr(),
  "영어".tr(),
  "수학".tr(),
  "자격증".tr(),
  "독서".tr(),
  "토익".tr(),
  "컴퓨터".tr(),
  "기타".tr()
];
List<String> studyHard = ["가볍게".tr(), "적당히".tr(), "보통".tr(), "열심히".tr()];

List<Color> colorBox = [
  Palette.listPick,
  Palette.listPick1,
  Palette.listPick2,
  Palette.listPick3,
  Palette.listPick4,
  Palette.listPick5,
  Palette.listPick6,
  Palette.listPick7
];
List<String> bottomTitle = ["분".tr()];


class GetLength {
  Widget getStudyLgt(var let) {
    if (let < 10) {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 390,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.listPick6,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "lib/assets/1.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "내가 작성한 기록",
                            style: TextStyle(fontSize: 20, color: Palette.textColor1),
                          ).tr(),
                          Text(
                            "${let}",
                            style: TextStyle(fontSize: 20, color: Palette.textColor1),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "당신의 도전을 응원합니다.",
                        style: TextStyle(fontSize: 16, color: Palette.textColor1),
                      ).tr(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else if (let >= 10) {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.listPick6,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "lib/assets/2.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                      children: [
                        Text(
                          "내가 작성한 기록",
                          style: TextStyle(fontSize: 20, color: Palette.textColor1),
                        ).tr(),
                        Text(
                          " ${let}",
                          style: TextStyle(fontSize: 20, color: Palette.textColor1),
                        )
                      ],
                    ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "자라나는 새싹",
                        style: TextStyle(fontSize: 16, color: Palette.textColor1),
                      ).tr()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else if (let < 30) {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.listPick6,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "lib/assets/3.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "내가 작성한 기록 ${let}",
                        style: TextStyle(fontSize: 20, color: Palette.textColor1),
                      ).tr(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "파릇파릇한 나무",
                        style: TextStyle(fontSize: 16, color: Palette.textColor1),
                      ).tr()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
