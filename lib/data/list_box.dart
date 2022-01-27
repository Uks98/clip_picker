import 'dart:ui';

import 'package:clip_picker/style/color_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> studyType = [
  "국어",
  "영어",
  "수학",
  "비문학",
  "자격증",
  "토익",
  "코딩",
  "독서",
  "기타"
];
List<String> studyHard = ["가볍게", "보통", "열심히", "빡세게"];
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

class GetLength {
  Widget getStudyLgt(var let) {
    if (let < 10) {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 380,
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
                      Text(
                        "내가 작성한 기록 ${let}",
                        style: TextStyle(fontSize: 20, color: Palette.textColor1),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "당신의 도전을 응원합니다.",
                        style: TextStyle(fontSize: 16, color: Palette.textColor1),
                      )
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
                width: 380,
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
                      Text(
                        "내가 작성한 기록 ${let}",
                        style: TextStyle(fontSize: 20, color: Palette.textColor1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "자라나는 새싹",
                        style: TextStyle(fontSize: 16, color: Palette.textColor1),
                      )
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
                width: 380,
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "파릇파릇한 나무.",
                        style: TextStyle(fontSize: 16, color: Palette.textColor1),
                      )
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
