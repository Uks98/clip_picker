import 'package:clip_picker/data/pick_class.dart';
import 'package:clip_picker/data/utils.dart';
import 'package:clip_picker/show_detail.dart';
import 'package:clip_picker/stydyaddpage.dart';
import 'package:clip_picker/style/color_style.dart';
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
  DateTime dateTime = DateTime.now();
  List<Pick> picks = [];

  void getHistories() async {
    int _d = Utils.getFormatTime(dateTime);
    picks = await dbHelper.queryPickByDate(_d);
    setState(() {});
  }
  void getDelete(int id) async{
    await DatabaseHelper.instance.delete(id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
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
              label: "통계")
        ],
        onTap: (idx) {
          setState(() {
            currentIndex = idx;
          });
        },
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        selectedItemColor: Palette.textColor,
      ),
      backgroundColor: Palette.backgroundColor,
      floatingActionButton: FloatingActionButton(
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => StudyAddPage(
                                      pick: Pick(
                                        date: Utils.getFormatTime(dateTime),
                                        name: "",
                                        memo: "",
                                        time: 1130,
                                        studyTime: 360,
                                        studyType: 0,
                                        hardStudy: 0,
                                        image: "",
                                        color: 0,
                                      ),
                                    )));
                          },
                          child: Text(
                            "공부 추가",
                            style: TextStyle(color: Palette.backgroundColor),
                          )),
                      TextButton(
                        onPressed: () {},
                        child: Text("설정",
                            style: TextStyle(color: Palette.backgroundColor)),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Widget getPage() {
    if (currentIndex == 0) {
      return getRecordStudy();
    }
  }

  Widget getRecordStudy() {
    return Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                child: TableCalendar(
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
                  ),
                  onDaySelected: (date, events, holidays) {
                    dateTime = date;
                    getHistories();
                  },
                  initialCalendarFormat: CalendarFormat.week,
                  availableCalendarFormats: {CalendarFormat.week: ""},
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
                ),
              );
            } else if (index == 1) {
              return Container(child: getStudy());
            } else if (index == 2) {
              return SizedBox(
                height: 20,
              );
            }
            return Container();
          }),
    );
  }

  Widget getStudy() {
    if (picks.isEmpty) {
      return Container(
          margin: EdgeInsets.only(left: 100, top: 250),
          height: 100,
          child: Text("오늘의 공부를 기록해주세요",
              style: TextStyle(color: Colors.white, fontSize: 18)));
    }
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height+900,
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
                            height: 100,
                            child: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => ShowDetail(
                                          index:idx,
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
                                  onPressed: () async{
                                    getDelete(picks[idx].id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("삭제하기",
                                      style: TextStyle(
                                          color: Palette.backgroundColor)),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    child: StudyCard(
                      pick: picks[idx],
                    ),
                  ));
            }),
      ),
    );
  }
}
