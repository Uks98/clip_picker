import 'package:clip_picker/data/list_box.dart';
import 'package:clip_picker/data/pick_class.dart';
import 'package:clip_picker/data/utils.dart';
import 'package:clip_picker/show_detail.dart';
import 'package:clip_picker/stydyaddpage.dart';
import 'package:clip_picker/style/color_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'data/database.dart';

class MyClip extends StatefulWidget {
  const MyClip({Key key}) : super(key: key);

  @override
  _MyClipState createState() => _MyClipState();
}

class _MyClipState extends State<MyClip> {
  final dbHelper = DatabaseHelper.instance;
  CalendarController calendarController = CalendarController();
  int currentIndex = 0;
  int chartIndex = 0;
  DateTime dateTime = DateTime.now();
  DateTime _date;
  List<Pick> picks = [];
  List<Pick> allPicks = [];
  List<Pick> dataPicks = [];
  List<Pick> events = [];

  int _d;
  int _s;

  void getHistories() async {
    _d = Utils.getFormatTime(dateTime);
    picks = await dbHelper.queryPickByDate(_d);
    setState(() {});
  }

  void getPicks() async {
    for (final p in dataPicks) {
      _date = Utils.numToDateTime2(p.date);
      print(p.date);
      events[p.date] = p;
    }
  }

  void getAllStudy() async {
    allPicks = await dbHelper.queryAllPick();
    setState(() {});
  }

  void getDelete(int id) async {
    await DatabaseHelper.instance.delete(id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistories();
    getAllStudy();
    getPicks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getPage(),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          backgroundColor: Palette.backgroundColor,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  color: Palette.textColor,
                ),
                label: "기록"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart, color: Palette.textColor1),
                label: "전체보기"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  color: Palette.textColor,
                ),
                label: "통계"),
          ],
          onTap: (idx) {
            setState(() {
              currentIndex = idx;
            });
            if (currentIndex == 0) {
              return getAllStudy();
            } else {
              print(allPicks.length);
              return getAllStudy();
            }
          },
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          selectedItemColor: Palette.textColor,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
           unselectedItemColor: Colors.grey[600],
        ),
        backgroundColor: Palette.backgroundColor,

        floatingActionButton: [0].contains(currentIndex)
            ? FloatingActionButton(
                backgroundColor: Palette.floatingColor,
                child: Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 100,
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => StudyAddPage(
                                                  pick: Pick(
                                                    date: Utils.getFormatTime(
                                                        dateTime),
                                                    name: "",
                                                    memo: "",
                                                    time: 0110,
                                                    studyTime: 0,
                                                    studyType: 0,
                                                    hardStudy: 0,
                                                    image: "",
                                                    color: 0,
                                                  ),
                                                )));
                                    getHistories();
                                  },
                                  child: Text(
                                    "공부 추가",
                                    style: TextStyle(
                                        color: Palette.backgroundColor),
                                  )),
                              TextButton(
                                onPressed: () {},
                                child: Text("설정",
                                    style: TextStyle(
                                        color: Palette.backgroundColor)),
                              )
                            ],
                          ),
                        );
                      });
                },
              )
            : Container());
  }

  Widget getPage() {
    if (currentIndex == 0) {
      return getRecordStudy();
    } else if (currentIndex == 1) {
      return getAllHistories();
    } else if (currentIndex == 2) {
      return getAllStudyPicker();
    }
  }

  Widget getRecordStudy() {
    return Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            //Map<DateTime, List<dynamic>> _events = {_date: []};
            if (index == 0) {
              return TableCalendar(
                // events: _events,
                locale: 'ko-KR',
                calendarStyle: CalendarStyle(
                  outsideWeekendStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  outsideStyle: TextStyle(
                      color: Palette.textColor1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  weekdayStyle: TextStyle(
                      // 블로그
                      color: Palette.textColor1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(
                      // 블로그
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                builders: CalendarBuilders(
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Palette.calendarPickColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'gom_KR',
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Palette.calendarPickColor2,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'gom_KR',
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    markersBuilder: (context, date, events, holiday) {
                      dateTime = date;
                      if (events.isNotEmpty) {
                        return [
                          Container(
                            width: 10,
                            height: 10,
                            color: Colors.redAccent,
                          )
                        ];
                      } else {
                        return [Container()];
                      }
                    }),
                onDaySelected: (date, events, holidays) {
                  dateTime = date;
                },
                initialCalendarFormat: CalendarFormat.twoWeeks,
                availableCalendarFormats: {CalendarFormat.twoWeeks: ""},
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  titleTextStyle: TextStyle(
                      color: Palette.textColor1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  formatButtonDecoration: BoxDecoration(
                    color: Palette.textColor1,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                initialSelectedDay: dateTime,
                calendarController: calendarController,
              );
            } else if (index == 1) {
              getHistories();
              return Container(child: getStudy());
            } else if (index == 2) {
              return Container();
            }
            return Container();
          }),
    );
  }

  Widget getStudy() {
    if (picks.isEmpty) {
      return Container(
          //margin: const EdgeInsets.only(left: 100, top: 250),
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("아직 작성한 기록이 없어요",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Text("+ 를 눌러 오늘의 공부를 기록하세요",
              style: TextStyle(color: Colors.white, fontSize: 18))
            ],)
          );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 20),
      child: Container(
        height: 450,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            itemCount: picks.length,
            itemBuilder: (ctx, idx) {
              return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 150,
                            child: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => ShowDetail(
                                          index: idx,
                                          picks: Pick(
                                            date: Utils.getFormatTime(dateTime),
                                            name: picks[idx].name,
                                            memo: picks[idx].memo,
                                            time: picks[idx].time,
                                            studyTime: picks[idx].studyTime,
                                            studyType: picks[idx].studyType,
                                            hardStudy: picks[idx].hardStudy,
                                            image: picks[idx].image,
                                            color: 0,
                                          ),
                                        ),
                                      ));
                                    },
                                    child: Text(
                                      "공부기록 상세보기",
                                      style: TextStyle(
                                          color: Palette.backgroundColor),
                                    )),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => StudyAddPage(
                                                pick: picks[idx])));
                                  },
                                  child: Text("수정하기",
                                      style: TextStyle(
                                          color: Palette.backgroundColor)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0)),
                                            title: Text("삭제"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "기록을 삭제 하시겠습니까?",
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              getDelete(picks[idx].id);
                                                              getHistories();
                                                              setState(() {});
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text(
                                                              '삭제하기',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  color: Colors.redAccent),
                                                            ),),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text(
                                                            '취소',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text("삭제하기",
                                      style:
                                          TextStyle(color: Colors.redAccent)),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      child: StudyCard(
                        pick: picks[idx],
                      ),
                    ),
                  ));
            }),
      ),
    );
  }

  Widget getAllStudyPicker() {
    return Container(
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, idx) {
            if (idx == 1) {
              return Container(
                margin: EdgeInsets.only(left: 20, top: 30),
                child: Text(
                  "통계",
                  style: TextStyle(fontSize: 30, color: Palette.textColor1),
                ),
              );
            } else if (idx == 2) {
              Widget growImages = GetLength().getStudyLgt(allPicks.length);
              return Container(child: growImages);
            } else if (idx == 3) {
              return Container(
                  margin: EdgeInsets.only(left: 150, top: 30),
                  child: Text(
                    "공부 분석",
                    style: TextStyle(fontSize: 25, color: Palette.textColor1),
                  ));
            } else if (idx == 4) {
              return Container(
                margin: const EdgeInsets.only(left: 30, top: 15),
                child: Stack(
                  children: [
                    Container(
                      width: 350,
                      height: 340,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 350,
                            child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  );
                                },
                                itemCount: studyType.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("${studyType[index]}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[800])),
                                        Text(
                                            "${allPicks.where((element) => element.studyType == index).length}개",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[800])),
                                      ],
                                    ),
                                  );
                                })),
                      ],
                    )
                  ],
                ),
              );
            } else if (idx == 5) {
              return Container(
                  margin: EdgeInsets.only(left: 150, top: 10),
                  child: Text(
                    "공부 강도",
                    style: TextStyle(fontSize: 25, color: Palette.textColor1),
                  ));
            } else if (idx == 6) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Stack(
                  children: [
                    Container(
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 200,
                            child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, _index) {
                                  return Divider(
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  );
                                },
                                itemCount: studyHard.length,
                                itemBuilder: (context, idx) {
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("${studyHard[idx]}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[800])),
                                        Text(
                                            "${allPicks.where((element) => element.hardStudy == idx).length}개",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[800])),
                                      ],
                                    ),
                                  );
                                })),
                      ],
                    )
                  ],
                ),
              );
            }else if(idx == 7){
              List<FlSpot> spots = [];
              for (final w in allPicks) {
                if (chartIndex == 0) {
                  //몸무게
                  spots.add(FlSpot(w.date.toDouble(), w.studyTime.toDouble()));}
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {
                              chartIndex = 0;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: chartIndex == 0 ? Palette.chartColor : Palette.unchartColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Text(
                                "운동시간",
                                style: TextStyle(
                                    color: chartIndex == 0
                                        ? Palette.chartColor : Palette.unchartColor),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                      decoration: BoxDecoration(
                          color: Palette.chartColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 4,
                                color: Colors.black12)
                          ]),
                      height: 200,
                      child: spots.isEmpty?Container():LineChart(
                          LineChartData(
                              lineBarsData: [
                                //각 항목에 대한 데이터가 들어가는 곳
                                LineChartBarData(spots: spots, colors: [Palette.chartColor])
                              ],
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              lineTouchData: LineTouchData(touchTooltipData:
                              LineTouchTooltipData(getTooltipItems: (spots) {
                                return [
                                  LineTooltipItem("${spots.first.y}",
                                      TextStyle(color: Palette.chartColor))
                                ];
                              })),
                              titlesData: FlTitlesData(
                                  bottomTitles: SideTitles(
                                      showTitles: true,
                                      //하단 아래에 날짜표시
                                      getTitles: (value) {
                                        DateTime date = Utils.stringToDateTime(
                                            value.toInt().toString());
                                        return "${date.day}일";
                                      }),
                                  leftTitles: SideTitles(showTitles: false)))),
                    )
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }

  Widget getAllHistories() {
    return Container(
      child: ListView.builder(
          itemBuilder: (ctx, idx) {
            if (idx == 0) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Text(
                  "나의 공부 기록",
                  style: TextStyle(fontSize: 25, color: Palette.textColor1),
                ),
              );
            }
            if (idx == 1) {
              return Container(
                  child: Column(
                children: List.generate(
                  allPicks.length,
                  (index) {
                    return Container(
                      child: InkWell(
                        child: GetAllStudyCard(
                          pick: allPicks[index],
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
              ));
            }
            return Container();
          },
          itemCount: 10),
    );
  }
}
