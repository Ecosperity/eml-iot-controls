import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/services/service%20dialog.dart';
import 'package:http/http.dart' as http;
import '../../../constants/style.dart';

class Services extends StatefulWidget {
  @override
  State<Services> createState() => _VehicleTableState();
}

class _VehicleTableState extends State<Services> {
  String baseUrl = "https://clownfish-app-lfvmm.ondigitalocean.app/complaint/";
  StreamController<List> streamController = StreamController();

  Future<void> getComplaints() async {
    final headers = {
      "Content-type": "application/json",
    };
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: headers,
    );
    List<dynamic> data = jsonDecode(response.body);
    streamController.add(data.toList());
  }

  static const headerStyle = TextStyle(
    color: ecosperity,
    fontWeight: FontWeight.bold,
  );

  final List<String> entries = <String>[
    'Registered',
    'Loaded',
    'Empty',
    'Stationary',
    'Charging',
    'Discharged',
    'Offenders',
    'Invisible',
  ];

  final List<IconData> leading = <IconData>[
    Icons.app_registration,
    Icons.groups,
    Icons.person,
    Icons.near_me_disabled,
    Icons.ev_station,
    Icons.battery_alert,
    Icons.error,
    Icons.wrong_location_rounded,
  ];

  final List<String> value = <String>[
    '45',
    '23',
    '89',
    '10',
    '57',
    '36',
    '78',
    '94',
  ];

  TextEditingController searchController = TextEditingController();
  List<bool> _selected = List.generate(7, (i) => false);
  List<String> searchMenu = [
    "Name",
    "Ticket",
    "Subject",
    "Vehicle ID",
    "Region",
    "Time",
    "Status"
  ];
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          getComplaints();
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          List filter = snapshot.data!;

          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white10.withAlpha(80)),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: entries.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              elevation: 5,
                              color: yellow,
                              child: SizedBox(
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        leading[index],
                                        size: 25,
                                        color: ecosperity,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            entries[index],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: ecosperity,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            value[index],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: ecosperity,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          // return Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 10),
                          //   child: Card(
                          //     elevation: 5,
                          //     color: yellow,
                          //     child: SizedBox(
                          //       width: 150,
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: Stack(
                          //           alignment: AlignmentDirectional.centerEnd,
                          //           clipBehavior: Clip.none,
                          //           children: [
                          //             Column(
                          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //               crossAxisAlignment: CrossAxisAlignment.end,
                          //               children: [
                          //                 Text(entries[index], style: TextStyle(fontWeight: FontWeight.bold, color: ecosperity, fontSize: 15),),
                          //                 Text(value[index], style: TextStyle(color: ecosperity, fontSize: 20)),
                          //               ],
                          //             ),
                          //             Icon(
                          //               leading[index],
                          //               color: Colors.indigo,
                          //               size: 25,
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (input) {},
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.delete),
                            iconSize: 20,
                            onPressed: () {
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.blueGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: ecosperity),
                          ),
                          hintText: "Search by " + searchMenu[index],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: PaginatedDataTable(
                      rowsPerPage: 10,
                      arrowHeadColor: ecosperity,
                      columns: [
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected =
                                                List<bool>.filled(7, false);
                                            _selected[0] = !_selected[6];
                                            index = 0;
                                          });
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 2.0,
                                                  color: _selected[0]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.person_outline,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'NAME',
                                                    style: headerStyle,
                                                  ),
                                                ],
                                              )),
                                        ))))),
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected =
                                                List<bool>.filled(7, false);
                                            _selected[1] = !_selected[1];
                                            index = 1;
                                          });
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 2.0,
                                                  color: _selected[1]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .confirmation_number_outlined,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'TICKET',
                                                    style: headerStyle,
                                                  ),
                                                ],
                                              )),
                                        ))))),
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected =
                                                List<bool>.filled(7, false);
                                            _selected[2] = !_selected[2];
                                            index = 2;
                                          });
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 2.0,
                                                  color: _selected[2]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.error_outline,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'SUBJECT',
                                                    style: headerStyle,
                                                  ),
                                                ],
                                              )),
                                        ))))),
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected =
                                                List<bool>.filled(7, false);
                                            _selected[3] = !_selected[3];
                                            index = 3;
                                          });
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 2.0,
                                                  color: _selected[3]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.directions_car_outlined,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'VEHICLE ID',
                                                    style: headerStyle,
                                                  ),
                                                ],
                                              )),
                                        ))))),
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected =
                                                List<bool>.filled(7, false);
                                            _selected[4] = !_selected[4];
                                            index = 4;
                                          });
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 2.0,
                                                  color: _selected[4]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'REGION',
                                                    style: headerStyle,
                                                  ),
                                                ],
                                              )),
                                        ))))),
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected =
                                                List<bool>.filled(7, false);
                                            _selected[5] = !_selected[5];
                                            index = 5;
                                          });
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 2.0,
                                                  color: _selected[5]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer_outlined,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'TIME',
                                                    style: headerStyle,
                                                  ),
                                                ],
                                              )),
                                        ))))),
                        DataColumn(
                            label: Expanded(
                                child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected =
                                                List<bool>.filled(7, false);
                                            _selected[6] = !_selected[6];
                                            index = 6;
                                          });
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 2.0,
                                                  color: _selected[6]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.published_with_changes,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'STATUS',
                                                    style: headerStyle,
                                                  ),
                                                ],
                                              )),
                                        ))))),
                        DataColumn(label: Text("")),
                      ],
                      source: _DataSource(context, filter),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class _Row {
  _Row({
    required this.name,
    required this.ticket,
    required this.subject,
    required this.vehicleId,
    required this.region,
    required this.time,
    required this.status,
  });

  String name;
  String ticket;
  String subject;
  String vehicleId;
  String region;
  String time;
  String status;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  late List<_Row> _rows;

  _DataSource(this.context, List<dynamic> data) {
    int length = data.length;
    _rows = List.generate(length, (int index) {
      return _Row(
        name: data[index]['Name'] == null ? "" : data[index]['Name'],
        ticket: data[index]['Ticket'] == null ? "" : data[index]['Ticket'],
        subject: data[index]['Subject'] == null ? "" : data[index]['Subject'],
        vehicleId:
            data[index]['VID'] == null ? "" : data[index]['VID'],
        region: data[index]['City'] == null ? "" : data[index]['City'],
        time: data[index]['Time'] == null ? "" : data[index]['Time'],
        status: data[index]['Status'] == null ? "" : data[index]['Status'],
      );
    });
  }

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow(
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Center(child: Text(row.name))),
        DataCell(Center(child: Text(row.ticket))),
        DataCell(Center(child: Text(row.subject))),
        DataCell(Center(child: Text(row.vehicleId))),
        DataCell(Center(child: Text(row.region))),
        DataCell(Center(child: Text(row.time))),
        DataCell(Center(
            child: Text(
          row.status,
          style: TextStyle(
              color: row.status == 'Pending' ? Colors.red : ecosperity,
              fontWeight: FontWeight.bold),
        ))),
        DataCell(IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => ServiceDialog(
                      name: _rows[index].name, ticket: _rows[index].ticket));
            },
            icon: Icon(
              Icons.local_attraction_outlined,
              color: ecosperity,
            ))),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
