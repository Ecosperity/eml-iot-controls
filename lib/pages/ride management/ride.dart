import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:http/http.dart' as http;
import '../../../constants/style.dart';
import '../services/service dialog.dart';

class Rides extends StatefulWidget {
  Rides({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<Rides> {
  String baseUrl = "https://clownfish-app-lfvmm.ondigitalocean.app/complaint/";
  StreamController<List> streamController = StreamController();

  Future<void> getComplaints() async {
    // final headers = {
    //   "Content-type": "application/json",
    // };
    // var response = await http.get(
    //   Uri.parse(baseUrl),
    //   headers: headers,
    // );
    // List<dynamic> data = jsonDecode(response.body);
    List<dynamic> data = [
      {
        "id": 1,
        "Origin": "Okhla Phase 3",
        "Destination": "Nehru Place",
        "Ride ID": "5681256",
        "Status": "Finished",
        "Time": "03:54",
        "Ratting": "4.4",
      },
      {
        "id": 2,
        "Origin": "Sonarpur",
        "Destination": "Badarpur",
        "Ride ID": "2684685",
        "Status": "Finished",
        "Time": "15:56",
        "Ratting": "3.1",
      },
      {
        "id": 3,
        "Origin": "Sadar bazar",
        "Destination": "Nehru Place",
        "Ride ID": "9531247",
        "Status": "Canceled",
        "Time": "11:24",
        "Ratting": "0.0",
      },
      {
        "id": 4,
        "Origin": "Noida",
        "Destination": "Gurugram",
        "Ride ID": "9531247",
        "Status": "Finished",
        "Time": "08:54",
        "Ratting": "2.1",
      },
      {
        "id": 5,
        "Origin": "Nehru Place",
        "Destination": "Lajpat Nagar",
        "Ride ID": "9531247",
        "Status": "Finished",
        "Time": "3:14",
        "Ratting": "5.0",
      },
      {
        "id": 6,
        "Origin": "Okhla Phase 3",
        "Destination": "Nehru Place",
        "Ride ID": "9531247",
        "Status": "Finished",
        "Time": "15:11",
        "Ratting": "4.1",
      },
    ];
    streamController.add(data.toList());
  }

  static const headerStyle = TextStyle(
    color: ecosperity,
    fontWeight: FontWeight.bold,
  );

  final List<String> entries = <String>[
    'Total Riders',
    'On Ride',
    'Finished',
    'Canceled',
    'Due',
    'Earnings',
    'Offenders',
    'Inactive',
  ];

  final List<IconData> leading = <IconData>[
    Icons.app_registration,
    Icons.groups,
    Icons.person,
    Icons.cancel,
    Icons.payment,
    Icons.currency_rupee,
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
    "Ride ID",
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                            onPressed: () {},
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
                                            _selected[2] = !_selected[2];
                                            index = 2;
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
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.local_attraction_outlined,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'RIDE ID',
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
                                            _selected[0] = !_selected[0];
                                            index = 0;
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'ORIGIN',
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
                                                  color: _selected[3]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .home_outlined,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'DESTINATION',
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
                                                  color: _selected[5]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
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
                                            _selected[4] = !_selected[4];
                                            index = 4;
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
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star_border,
                                                    color: ecosperity,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'RATTING',
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
                                                  color: _selected[5]
                                                      ? ecosperity
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.refresh,
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
    required this.origin,
    required this.destination,
    required this.rideID,
    required this.status,
    required this.time,
    required this.ratting,
  });

  String origin;
  String destination;
  String rideID;
  String status;
  String time;
  String ratting;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  late List<_Row> _rows;

  _DataSource(this.context, List<dynamic> data) {
    int length = data.length;
    _rows = List.generate(length, (int index) {
      return _Row(
        origin: data[index]['Origin'] == null ? "" : data[index]['Origin'],
        destination: data[index]['Destination'] == null
            ? ""
            : data[index]['Destination'],
        rideID: data[index]['Ride ID'] == null ? "" : data[index]['Ride ID'],
        status: data[index]['Status'] == null ? "" : data[index]['Status'],
        time: data[index]['Time'] == null ? "" : data[index]['Time'],
        ratting: data[index]['Ratting'] == null ? "" : data[index]['Ratting'],
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
        DataCell(Center(child: Text(row.rideID))),
        DataCell(Center(child: Text(row.origin))),
        DataCell(Center(child: Text(row.destination))),
        DataCell(Center(child: Text(row.time))),
        DataCell(Center(
          child: RatingBar.builder(
            initialRating: double.parse(row.ratting),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: yellow,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        )),
        DataCell(Center(
            child: Text(
              row.status,
              style: TextStyle(
                  color: row.status == 'Canceled' ? Colors.red : ecosperity,
                  fontWeight: FontWeight.bold),
            ))),
        DataCell(IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => ServiceDialog(
                      name: _rows[index].status, ticket: _rows[index].rideID));
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
