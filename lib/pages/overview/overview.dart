import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/alerts.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/vehicle%20table.dart';
import '../../constants/style.dart';

var city = "New Delhi";

class OverviewPage extends StatefulWidget {
  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool darkMode = false;
  late final List<bool> _selected;
  bool selected = false;
  final List<String> entries = <String>[
    'New Delhi',
    'Jaipur',
    'Bangalore',
    'Agra',
    'Mumbai',
    'Dehradun',
    'Lucknow',
    'Rajkot',
    'Faridabad',
    'Hyderabad',
    'Ahmedabad',
    'Raipur',
    'Bihar',
    'Pune',
    'Noida'
  ];

  @override
  void initState() {
    super.initState();
    _selected = List.generate(entries.length, (i) => false);
    _selected[0] = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10.withAlpha(80)),
          color: Colors.grey.shade200,
          // color: Color.fromARGB(230, 21, 22, 58),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withAlpha(150).withOpacity(0.005),
              blurRadius: 50.0,
              spreadRadius: 0.0,
              blurStyle: BlurStyle.outer,
            ),
          ],
          // color: Colors.white.withOpacity(0.2),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          city = entries[index];
                          for (int i = 0; i < _selected.length; i++) {
                            _selected[i] = false;
                          }
                          _selected[index] = !_selected[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18.0),
                          ),
                          border: Border.all(
                              color: _selected[index]
                                  ? ecosperity
                                  : Colors.tealAccent,
                              width: _selected[index] ? 2.0 : 1.0),
                          // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        margin: EdgeInsets.all(15),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${entries[index]}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color:
                                    _selected[index] ? ecosperity : ecosperity),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            OverviewCards(
              city: city,
            ),
            SizedBox(
              height: 40,
            ),
            Alerts(
              city: city,
            ),
            SizedBox(
              height: 25,
            ),
            VehicleTable(
              city: city,
            ),
          ],
        ),
      ),
    );
  }
}
