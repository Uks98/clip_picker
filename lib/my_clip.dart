import 'package:clip_picker/data/list_box.dart';
import 'package:clip_picker/data/pick_class.dart';
import 'package:clip_picker/data/utils.dart';
import 'package:clip_picker/funtion.dart';
import 'package:clip_picker/setting.dart';
import 'package:clip_picker/show_detail.dart';
import 'package:clip_picker/stydyaddpage.dart';
import 'package:clip_picker/style/color_style.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:table_calendar/table_calendar.dart';
import 'cards/get_all_studycard.dart';
import 'cards/study_card.dart';
import 'data/database.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:timezone/timezone.dart' as tz;
import 'main.dart';

class MyClip extends StatefulWidget {
  const MyClip({Key key}) : super(key: key);

  @override
  _MyClipState createState() => _MyClipState();
}

class _MyClipState extends State<MyClip> {

  Alarm alarm = Alarm();
  BannerAd banner;
  final addMobId = "ca-app-pub-4051456724877953/3768717446";
  FirebaseAnalytics analytics = FirebaseAnalytics();

  final dbHelper = DatabaseHelper.instance;
  CalendarController calendarController = CalendarController();
  int currentIndex = 0;
  int chartIndex = 0;
  DateTime dateTime = DateTime.now();
  final Map<DateTime, List<dynamic>> _events = {};
  List<Pick> picks = [];
  List<Pick> allPicks = [];
  List<Pick> dataPicks = [];
  List<Pick> events = [];
  int _d;
  DateTime date;
  bool switchStatus = true;

  var latestTime;
  List latestNum;
  List addNum;

  int findLatesTitle() {
    for(final t in allPicks){
      final l = t.date;
      latestNum = [l];
      latestNum.sort();
      final m = latestNum.first;
      latestTime = Utils.numToDateTime2(m);
    }
  }

  void getHistories() async {
    _d = Utils.getFormatTime(dateTime);
    picks = await dbHelper.queryPickByDate(_d);
    setState(() {});
    analytics.setUserProperty(name: "sex", value: "남자");
    analytics.setUserProperty(value: "여자", name: "sex");
  }

  void getPicks() {
    for (final picker in allPicks) {
      date = Utils.numToDateTime2(picker.date);
      _events[date] = [picker];
    }
  }

  void getAllStudy() async {
    allPicks = await dbHelper.queryAllPick();
    setState(() {});
  }

  void getDelete(int id) async {
    await DatabaseHelper.instance.delete(id);
  }

 void _getAddStudyPage(){
     Navigator.of(context)
         .push(MaterialPageRoute(
         builder: (ctx) => StudyAddPage(
           pick: Pick(
             date: Utils.getFormatTime(dateTime),
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
 }

 void _showAddBottomsheet(){
   showModalBottomSheet(
       context: context,
       builder: (context) {
         return Container(
           height: 150,
           child: Column(
             children: [
               TextButton(
                   onPressed: _getAddStudyPage,
                   child: Text(
                     "공부 추가",
                     style: TextStyle(
                         color: Palette.backgroundColor),
                   ).tr()),
               TextButton(
                 onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (BuildContext context) =>
                           Setting()));
                 },
                 child: Text("설정",
                     style: TextStyle(
                         color: Palette.backgroundColor)).tr(),
               ),
               TextButton(
                 onPressed: () {
                   setState(() {
                     switchStatus = false;
                   });
                 },
                 child: Text("달력 영어로 변경하기",
                     style: TextStyle(
                         color: Palette.backgroundColor)).tr(),
               ),
             ],
           ),
         );
       });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistories();
    getAllStudy();
    alarm.initNotification();
    alarm.setScheduling();
    banner = BannerAd(
      listener: AdListener(),
      size: AdSize.banner,
      adUnitId: addMobId,
      request: AdRequest(),
    )..load();
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
                  Icons.calendar_today_outlined,
                  color: Palette.textColor,
                ),
                label: "기록".tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.padding, color: Palette.textColor1),
                label: "전체보기".tr()),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.bar_chart,
                  color: Palette.textColor,
                ),
                label: "통계".tr()),
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
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          unselectedItemColor: Colors.grey[600],
        ),
        backgroundColor: Palette.backgroundColor,

        floatingActionButton: [0].contains(currentIndex)
            ? FloatingActionButton(
                backgroundColor: Palette.floatingColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed:_showAddBottomsheet,
              )
            : Container());
  }


  Widget getRecordStudy() {
    return Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              getPicks();
              return TableCalendar(
                events: _events,
                locale: switchStatus == true ? "ko-KR": 'en-US',
                calendarStyle:
                    CalendarStyle(weekdayStyle: TextStyle(color: Colors.white)),
                builders: CalendarBuilders(
                    weekendDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    dayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: Palette.textColor1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
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
                            fontSize: 20,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    markersBuilder: (context, date, events, holiday) {
                      if (events.isNotEmpty) {
                        return [
                          Container(
                            width: 13,
                            height: 3,
                            color: Palette.calendarMarkerColor,
                          ),
                        ];
                      } else {
                        return [Container()];
                      }
                    }),
                onDaySelected: (date, events, holidays) {
                  dateTime = date;
                },
                initialCalendarFormat: CalendarFormat.twoWeeks,
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
            }
            return Container();
          }),
    );
  }

  Widget getStudy() {
    if (picks.isEmpty) {
      return Container(
          margin: const EdgeInsets.only(top: 170),
          height: 300,
          child: Column(
            children: [
              Text("아직 작성한 기록이 없어요",
                  style: TextStyle(color: Colors.white, fontSize: 18)).tr(),
              SizedBox(
                height: 10,
              ),
              Text("+ 를 눌러 오늘의 공부를 기록하세요",
                  style: TextStyle(color: Colors.white, fontSize: 18)).tr()
            ],
          ));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 20),
      child: Container(
        height: 390,
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
                                    ).tr()),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => StudyAddPage(
                                                  pick: picks[idx],
                                                )));
                                  },
                                  child: Text("수정하기",
                                      style: TextStyle(
                                          color: Palette.backgroundColor)).tr(),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            title: Text("삭제").tr(),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "기록을 삭제 하시겠습니까?",
                                                ).tr(),
                                                Row(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            getDelete(
                                                                picks[idx].id);
                                                            getHistories();
                                                            setState(() {});
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            '삭제하기',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .redAccent),
                                                          ).tr(),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            '취소', style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ).tr(),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text("삭제하기",
                                      style:
                                          TextStyle(color: Colors.redAccent)).tr(),
                                ),
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
                ).tr(),
              );
            } else if (idx == 2) {
              Widget growImages = GetLength().getStudyLgt(allPicks.length);

              return Container(child: growImages);
            } else if (idx == 3) {
              List<FlSpot> spots = [];
              for (final w in allPicks) {
                if (chartIndex == 0) {
                  //공부시간
                  spots.add(FlSpot(w.date.toDouble(), w.studyTime.toDouble()));
                }
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Palette.chartColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "공부 시간 그래프",
                                  style: TextStyle(color: Colors.black),
                                ).tr()),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                      decoration: BoxDecoration(
                          color: Palette.chartColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 4,
                                color: Colors.black12)
                          ]),
                      height: 300,
                      width: 400,
                      child: spots.isEmpty
                          ? Container()
                          : LineChart(
                          LineChartData(
                              lineBarsData: [
                                  //각 항목에 대한 데이터가 들어가는 곳
                                  LineChartBarData(
                                    isCurved:true,
                                      barWidth: 3.3,
                                      spots: spots,
                                      belowBarData: BarAreaData(
                                        show: true,
                                        colors: [Palette.gradientColor.withOpacity(0.2)]
                                      ),
                                      colors: [Palette.chartLineColor]),
                                ],
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              lineTouchData: LineTouchData(
                                  touchTooltipData:
                                  LineTouchTooltipData(
                                      getTooltipItems: (spots) {
                                return [
                                  LineTooltipItem(
                                      "${Utils.doubleToDateTime2(spots.first.x)}\n${spots.first.y} 분".replaceAll("00:00:00.000",""),
                                      TextStyle(
                                          color: Colors.black, fontSize: 20))
                                ];
                              })),
                              titlesData: FlTitlesData(
                                  bottomTitles: SideTitles(
                                      showTitles: false,
                                      //하단 아래에 날짜표시
                                      getTitles: (value) {
                                        DateTime date = Utils.stringToDateTime(
                                            value.toInt().toString());
                                        return "${date.day}일";
                                      }),
                                  leftTitles: SideTitles(showTitles: false)),),),
                    )
                  ],
                ),
              );
            } else if (idx == 4) {
              return Center(
                  child: Text(
                "공부 분석",
                style: TextStyle(fontSize: 25, color: Palette.textColor1),
              ).tr());
            } else if (idx == 5) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10),
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
                                  return
                                     Stack(
                                      children: [
                                        Container(
                                          child: Text("${studyType[index]}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[800])),
                                          margin: EdgeInsets.only(left: 30),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 260),
                                          child: Container(
                                            child: Text(
                                                "${allPicks.where((element) => element.studyType == index).length}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[800])),
                                          ),
                                        ),
                                      ],
                                    );
                                })),
                      ],
                    )
                  ],
                ),
              );
            } else if (idx == 6) {
              return Center(
                child: Text(
                  "공부 강도",
                  style: TextStyle(fontSize: 25, color: Palette.textColor1),
                ).tr(),
              );
            } else if (idx == 7) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10),
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
                                    child: Stack(
                                      children: [
                                        Container(
                                          child: Text("${studyHard[idx]}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[800])),
                                          margin: EdgeInsets.only(left: 30),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 260.0),
                                          child: Text(
                                              "${allPicks.where((element) => element.hardStudy == idx).length}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[800])),
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                      ],
                    )
                  ],
                ),
              );
            }else if(idx ==8){
              findLatesTitle();
              return Column(
                children: [
                  Container(
                    child: Text("가장 최근 기록 ",style: TextStyle(color: Colors.white),).tr(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: latestTime == null ? Text("아직 작성한 기록이 없어요",style: TextStyle(color: Colors.white,fontSize: 12)):Text("${latestTime}".toString().replaceAll('00:00:00.000', ""),style: TextStyle(color: Colors.white),).tr(),
                  ),
                  SizedBox(height: 20,)
                ],
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
                  child: Container(
                      width: 400,
                      height: 70,
                      child: this.banner == null
                          ? Container()
                          : AdWidget(ad: this.banner)));
            }
            if (idx == 1) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical:10,horizontal: 20),
                child: Text(
                  "나의 공부 기록",
                  style: TextStyle(fontSize: 25, color: Palette.textColor1),
                ).tr(),
              );
            }
            if (idx == 2) {
              return Container(
                  child: Column(
                children: List.generate(
                  allPicks.length,
                  (index) {
                    return allPicks.isEmpty
                        ? Container(
                            //margin: const EdgeInsets.only(left: 100, top: 250),
                            height: 500,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("아직 작성한 기록이 없어요",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ))
                        : Container(
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
