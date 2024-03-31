import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import '../../../constants/content.dart';

class DataItem {
  int x;
  int y1;
  double y2;
  double y3;

  DataItem(
      {required this.x, required this.y1, required this.y2, required this.y3});
}

class Alerts extends StatefulWidget {
  final String city;

  const Alerts({Key? key, required this.city}) : super(key: key);

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  bool darkMode = true;
  final List<double> driveData = [15, 15, 10, 10, 20, 25];
  final List<double> batteryData = [10, 15, 10, 15, 15, 15];
  final List<double> sensorData = [18, 10, 7, 15, 25, 20];
  bool driveBool = true, batteryBool = false, sensorBool = false;
  final List<bool> _selected = List.generate(7, (i) => false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 430,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: alerts.keys.length,
            itemBuilder: (context, index1) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: 250,
                      height: 50,
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: cardIconCircleColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            alerts.values.elementAt(index1),
                            size: 22,
                            color: ecosperity,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            alerts.keys.elementAt(index1),
                            style: TextStyle(
                                color: ecosperity,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: driveBool
                            ? Color.fromARGB(255, 243, 229, 245)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 250,
                        height: 340,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListView.builder(
                            itemCount: alertsMap[index1].values.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  onTap: () {
                                    for (int a = 0; a < _selected.length; a++) {
                                      _selected[a] = false;
                                    }
                                    setState(() {
                                      _selected[index] = !_selected[index];
                                    });
                                  },
                                  leading: Icon(
                                    alertsMap[index1].values.elementAt(index),
                                    color: ecosperity,
                                  ),
                                  trailing: Text(
                                    "0",
                                    style: TextStyle(
                                        color: ecosperity, fontSize: 15),
                                  ),
                                  tileColor: _selected[index]
                                      ? Color.fromARGB(255, 209, 196, 233)
                                          .withOpacity(0.4)
                                      : Colors.transparent,
                                  title: Text(
                                    alertsMap[index1].keys.elementAt(index),
                                    style: TextStyle(
                                        color: ecosperity,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ));
                            }),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
