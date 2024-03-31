import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:http/http.dart' as http;
import 'package:odometer/odometer.dart';
import '../../../constants/content.dart';
import '../../../widgets/circular progress.dart';
import '../../../widgets/inner shadow.dart';
import '../../../widgets/ripple.dart';

class DataItem {
  int x;
  int y1;
  double y2;
  double y3;

  DataItem(
      {required this.x, required this.y1, required this.y2, required this.y3});
}

class Driver extends StatefulWidget {
  final String driver;

  const Driver({Key? key, required this.driver}) : super(key: key);

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  static Matrix4 _pmat(num pv) {
    return new Matrix4(
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      pv * 0.001,
      0.0,
      0.0,
      0.0,
      1.0,
    );
  }

  Matrix4 perspective = _pmat(1.0);

  final List<DataItem> _myData = List.generate(
      31,
      (index) => DataItem(
            x: index,
            y1: Random().nextInt(100),
            y2: 0,
            y3: 0,
          ));

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
    Widget text;
    text = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        (value + 1).toString(),
        style: style,
      ),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: text,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
    const style2 = TextStyle(
      color: Colors.redAccent,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0', style: style);
        break;
      case 20:
        text = const Text('20', style: style);
        break;
      case 40:
        text = const Text('40', style: style);
        break;
      case 60:
        text = const Text('60', style: style);
        break;
      case 80:
        text = const Text('80', style: style);
        break;
      case 100:
        text = const Text('100', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: text,
    );
  }

  String baseUrl =
      "https://apiplatform.intellicar.in/api/standard/getlatestcan";
  StreamController<Map> streamController = StreamController();

  Future<void> getComplaints() async {
    final headers = {
      "Content-type": "application/json",
    };
    var response = await http.post(Uri.parse(baseUrl),
        headers: headers,
        body: jsonEncode({
          "token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaW5mbyI6eyJ1c2VyaWQiOjg3MTEsInR5cGVpZCI6NCwidXNlcm5hbWUiOiJFY29zcGVyaXR5X2FwaSJ9LCJpYXQiOjE2OTk2NDUwNTYsImV4cCI6MTcwMzI0NTA1Nn0.Si33esB-o8Vddh9nksu8TuV4De6GNtkUh5BmyKdOwrg",
          "vehicleno": widget.driver
        }));
    var data = jsonDecode(response.body);
    Map<dynamic, dynamic> maping = data['data'];
    // print(map);
    streamController.add(maping);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          getComplaints();
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          // print(snapshot.data!);
          Map<dynamic, dynamic> filter = snapshot.data!;
          // .where((element) => element["Name"] == widget.driver)
          // .toList();
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Scaffold(
                backgroundColor: Colors.grey.shade200,
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.centerStart,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [Colors.black54, Colors.transparent],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )),
                          ),
                          Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(-1.0),
                            alignment: Alignment.center,
                            child: Container(
                              height: 250,
                              // width: 300,
                              margin: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 100),
                              decoration: BoxDecoration(
                                color: dark2,
                                // gradient: LinearGradient(
                                //   colors: [
                                //     Colors.grey,
                                //     dark2,
                                //   ], begin: Alignment.topCenter, end: Alignment.bottomCenter
                                // ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Image.asset("assets/images/side5.png"),
                                ),
                                Tooltip(
                                  message: "Power Status",
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.power_settings_new, size: 40, color: light,),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Tooltip(
                                      message: "No. of Occupants",
                                      child: Row(
                                        children: [
                                          Icon(Icons.person_outline, color: light, size: 30,),
                                          Icon(Icons.person, color: light, size: 30,),
                                          Icon(Icons.person_outline, color: light, size: 30,),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Tooltip(
                                        message: "Weight",child: Text("< 150 Kg", style: TextStyle(color: light),))
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Tooltip(
                                      message: "Charging Cycle",
                                      child: Row(
                                        children: [
                                          Icon(Icons.refresh, color: light,),
                                          SizedBox(width: 10,),
                                          Text("0009", style: TextStyle(color: light),),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: "Battery Voltage",
                                      child: Row(
                                        children: [
                                          Icon(Icons.bolt, color: light,),
                                          SizedBox(width: 10,),
                                          Text("48.6 V", style: TextStyle(color: light),),
                                        ],
                                      ),
                                    ),
                                    Tooltip(
                                      message: "Current",
                                      child: Row(
                                        children: [
                                          Icon(Icons.offline_bolt, color: light,),
                                          SizedBox(width: 10,),
                                          Text("13 A", style: TextStyle(color: light),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Tooltip(
                                        message: "Vehicle Speed",child: InnerShadow(color: ecosperity, offset: const Offset(-10, -10), child: Text("00", style: TextStyle(fontSize: 62, color: light, fontWeight: FontWeight.bold, letterSpacing: 2),))),
                                    Text("kmph", style: TextStyle(fontSize: 12, color: light),),
                                    SizedBox(height: 10,),
                                    Tooltip(
                                      message: "Odometer",
                                      child: AnimatedSlideOdometerNumber(
                                          letterWidth: 18,
                                          odometerNumber: OdometerNumber(18392),
                                          duration: const Duration(milliseconds: 70),
                                          numberTextStyle: TextStyle(
                                            color: light,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          )),
                                    ),
                                  ],
                                ),
                                Tooltip(
                                  message: "SOC",
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    child: CustomPaint(
                                      painter: CircularProg(
                                        val: 140,
                                        color: ecosperity,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.battery_charging_full, color: light,),
                                          Text(
                                            (140 / 3.6).round().toString() + "%",
                                            style: TextStyle(
                                                color: light,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Tooltip(
                                  message: "SOH",
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    child: CustomPaint(
                                      painter: CircularProg(
                                        val: 180,
                                        color: Colors.red,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.battery_alert_rounded, color: light,),
                                          Text(
                                            (180 / 3.6).round().toString() + "%",
                                            style: TextStyle(
                                                color: light,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.device_thermostat, color: yellow, size: 35,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Motor", style: TextStyle(color: light),),
                                            Text("70°C", style: TextStyle(color: light),)
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.device_thermostat, color: yellow, size: 35,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Battery", style: TextStyle(color: light),),
                                            Text("42°C", style: TextStyle(color: light),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.device_thermostat, color: yellow, size: 35,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("MCU", style: TextStyle(color: light),),
                                            Text("38°C", style: TextStyle(color: light),)
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.device_thermostat, color: yellow, size: 35,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("VCU", style: TextStyle(color: light),),
                                            Text("34°C", style: TextStyle(color: light),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 400,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: alerts.keys.length,
                            itemBuilder: (context, index1) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      tileColor: Colors.transparent,
                                      leading: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: dark2,
                                          child: Icon(
                                              alerts.values.elementAt(index1),
                                              size: 30)),
                                      title: Text(
                                        alerts.keys.elementAt(index1),
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: dark2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      height: 110,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              alertsMap[index1].values.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    backgroundColor: dark2,
                                                    builder: (context) {
                                                      return Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.98,
                                                        height: 200,
                                                        decoration: BoxDecoration(
                                                            // color:
                                                            //     Colors.white,
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        20))),
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .center,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                      alertsMap[index1].keys.elementAt(index),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize: 20, letterSpacing: 1.5),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          130,
                                                                      width: MediaQuery.of(context).size.width *
                                                                          0.7,
                                                                      child: BarChart(BarChartData(
                                                                          maxY: 100,
                                                                          borderData: FlBorderData(
                                                                            show: false,
                                                                          ),
                                                                          gridData: FlGridData(show: false),
                                                                          titlesData: FlTitlesData(
                                                                            rightTitles: AxisTitles(
                                                                              sideTitles: SideTitles(showTitles: false),
                                                                            ),
                                                                            topTitles: AxisTitles(
                                                                              sideTitles: SideTitles(showTitles: false),
                                                                            ),
                                                                            leftTitles: AxisTitles(
                                                                              sideTitles: SideTitles(showTitles: true, getTitlesWidget: leftTitles, interval: 20, reservedSize: 30),
                                                                            ),
                                                                            bottomTitles: AxisTitles(
                                                                              sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitles, reservedSize: 30),
                                                                            ),
                                                                          ),
                                                                          barTouchData: BarTouchData(
                                                                              touchTooltipData: BarTouchTooltipData(
                                                                            tooltipBgColor: Colors.white,
                                                                            getTooltipItem: (
                                                                              BarChartGroupData group,
                                                                              int groupIndex,
                                                                              BarChartRodData rod,
                                                                              int rodIndex,
                                                                            ) {
                                                                              return BarTooltipItem(
                                                                                _myData[groupIndex].y1.toString(),
                                                                                TextStyle(color: ecosperity, fontWeight: FontWeight.bold),
                                                                              );
                                                                            },
                                                                          )),
                                                                          barGroups: _myData
                                                                              .map((dataItem) => BarChartGroupData(x: dataItem.x, barRods: [
                                                                                    BarChartRodData(
                                                                                        toY: dataItem.y1.toDouble(),
                                                                                        width: 5,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          topLeft: Radius.circular(10),
                                                                                          topRight: Radius.circular(10),
                                                                                          bottomLeft: Radius.circular(0),
                                                                                          bottomRight: Radius.circular(0),
                                                                                        ),
                                                                                        gradient: LinearGradient(colors: [Colors.tealAccent, ecosperity.withOpacity(0.5)], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                                                                                  ]))
                                                                              .toList())),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  padding: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            alertsMap[index1]
                                                                .keys
                                                                .elementAt(
                                                                    index),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    ecosperity,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            "0",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color:
                                                                    ecosperity,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "🕐 04:31, 27 May 2023",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor:
                                                            cardIconCircleColor,
                                                        child: Icon(
                                                          alertsMap[index1]
                                                              .values
                                                              .elementAt(index),
                                                          size: 30,
                                                          color: ecosperity,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
