import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import 'driver dialog.dart';
import 'package:http/http.dart' as http;

class VehicleTable extends StatefulWidget {
  final String city;

  const VehicleTable({Key? key, required this.city}) : super(key: key);

  @override
  State<VehicleTable> createState() => _VehicleTableState();
}

class _VehicleTableState extends State<VehicleTable> {
  late int regCount;
  static const headerStyle = TextStyle(
    color: ecosperity,
    fontWeight: FontWeight.bold,
  );

  String baseUrl = "https://apiplatform.intellicar.in/api/standard/listvehicles";
  StreamController<List> streamController = StreamController();

  Future<void> getComplaints() async {
    final headers = {
      "Content-type": "application/json",
    };
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
        body: jsonEncode({
          "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaW5mbyI6eyJ1c2VyaWQiOjg3MTEsInR5cGVpZCI6NCwidXNlcm5hbWUiOiJFY29zcGVyaXR5X2FwaSJ9LCJpYXQiOjE2OTk2NDUwNTYsImV4cCI6MTcwMzI0NTA1Nn0.Si33esB-o8Vddh9nksu8TuV4De6GNtkUh5BmyKdOwrg",
        }));
    var data = jsonDecode(response.body);
    List<dynamic> map = data['data'];
    streamController.add(map);
  }

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
              // .where((element) => element["vehicleno"] == widget.city)
              // .toList();
          regCount = filter.length;

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.app_registration,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Total $regCount Vehicles are Registered in " +
                          widget.city,
                      style: TextStyle(
                          color: ecosperity,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (val) {
                    // initiateSearch(val);
                  },
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        iconSize: 20,
                        onPressed: () {},
                      ),
                      hintText: "Search by Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PaginatedDataTable(
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                    DataColumn(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add_alt_1_outlined,
                          color: ecosperity,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'AGE',
                          style: headerStyle,
                        ),
                      ],
                    )),
                    DataColumn(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.how_to_reg_outlined,
                          color: ecosperity,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'REGISTERED',
                          style: headerStyle,
                        ),
                      ],
                    )),
                    DataColumn(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.precision_manufacturing_outlined,
                          color: ecosperity,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'MANUFACTURED',
                          style: headerStyle,
                        ),
                      ],
                    )),
                    DataColumn(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          color: ecosperity,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'RATINGS',
                          style: headerStyle,
                        ),
                      ],
                    )),
                    DataColumn(label: Text(""))
                  ],
                  source: _DataSource(context, filter),
                ),
              ),
            ],
          );
        });
  }
}

class _Row {
  _Row({
    required this.vehicleNo,
    required this.age,
    required this.regDate,
    required this.yom,
    required this.ratting,
    required this.other,
  });

  String vehicleNo;
  String age;
  String regDate;
  String yom;
  String ratting;
  List<String> other;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  late List<_Row> _rows;

  _DataSource(this.context, List<dynamic> data) {
    int length = data.length;
    _rows = List.generate(length, (int index) {
      return _Row(
          vehicleNo: data[index]['vehicleno'] == null ? " " : data[index]['vehicleno'],
          age: data[index]['Age'] == null ? " " : data[index]['Age'],
          regDate: data[index]['DoR'] == null ? " " : data[index]['DoR'],
          yom: data[index]['DoM'] == null ? " " : data[index]['DoM'],
          ratting: '5',
          other: [
            data[index]['ChassisNo'] == null ? " " : data[index]['ChassisNo'],
            data[index]['Language'] == null ? " " : data[index]['Language'],
            data[index]['modelNo'] == null ? " " : data[index]['modelNo'],
          ]);
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
        DataCell(Text(row.vehicleNo.toString())),
        DataCell(Text(row.age.toString())),
        DataCell(Text(row.regDate.toString())),
        DataCell(Text(row.yom.toString())),
        DataCell(Text(row.ratting.toString())),
        DataCell(IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierColor: Colors.black54.withAlpha(240),
                  builder: (_) => Driver(driver: _rows[index].vehicleNo));
            },
            icon: Icon(
              Icons.visibility,
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
