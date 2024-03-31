import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class Registration extends StatefulWidget {
  @override
  _PageFormState createState() => _PageFormState();
}

class _PageFormState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  var name;
  var age;
  var state;
  var city;
  var regDate;
  var phoNo;
  var chasNo;
  var modelNo;
  var yom;
  var insuranceDate;
  var language;
  var insuranceDura;
  bool _value = false;

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  final _regDateController = TextEditingController();
  final _yomDateController = TextEditingController();
  final _insuranceDateController = TextEditingController();

  String baseUrl = "https://clownfish-app-lfvmm.ondigitalocean.app/driver/";

  var ageSel = [for (var i = 18; i < 60; i += 1) i];
  var stateSel = ['Gujarat', 'Delhi'];
  var citySel = ['Rajkot', 'New Delhi'];
  var langSel = ['Hindi', 'Punjabi'];
  var insuranceDuraSel = [for (var i = 0; i < 10; i += 1) i];

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2
        ? setState(() => _currentStep += 1)
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Problem submitting form')));
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Future<void> addUser() async {
    final headers = {"Content-type": "application/json"};
    final json = {
      "Name": name,
      "Age": age,
      "State": state,
      "City": city,
      "phoneNo": phoNo,
      "Language": language,
      "DoM": yom,
      "DoR": regDate,
      "DoIns": insuranceDate,
      "InsDuration": insuranceDura,
      "ChassisNo": chasNo,
      "modelNo": modelNo,
    };
    final response = await post(Uri.parse(baseUrl),
        headers: headers, body: jsonEncode(json));
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10.withAlpha(80)),
          color: Colors.grey[100],
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
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                      ExactAssetImage("assets/images/driver_female.png"),
                    ),
                  ),
                ],
              ),
              Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: Text("Owner Information"),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.tealAccent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: ecosperity),
                                    ),
                                    labelText: 'Owner',
                                    labelStyle: TextStyle(color: Colors.teal)),
                                onChanged: (value) {
                                  name = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the Name';
                                  }
                                  return null;
                                }),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 730,
                                  child: TextFormField(
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.phone_outlined),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Colors.tealAccent),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2, color: ecosperity),
                                          ),
                                          labelText: 'Phone Number',
                                          labelStyle:
                                          TextStyle(color: Colors.teal)),
                                      onChanged: (value) {
                                        phoNo = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the Name';
                                        }
                                        return null;
                                      }),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.tealAccent,
                                      width: 1,
                                    ), //Border.all
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: age,
                                        elevation: 0,
                                        isDense: true,
                                        focusColor: Colors.transparent,
                                        icon: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: Colors.teal,
                                        ),
                                        iconEnabledColor: ecosperity,
                                        menuMaxHeight: 100.0,
                                        hint: Row(
                                          children: [
                                            Icon(Icons.person_add_alt_1_outlined,
                                                color: Colors.teal, size: 20),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Age",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(color: ecosperity),
                                        items: ageSel.map((int items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (int? value) {
                                          setState(() {
                                            age = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.tealAccent,
                                      width: 1,
                                    ), //Border.all
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: state,
                                        isDense: true,
                                        focusColor: Colors.transparent,
                                        icon: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: Colors.teal,
                                        ),
                                        iconEnabledColor: ecosperity,
                                        menuMaxHeight: 100.0,
                                        hint: Row(
                                          children: [
                                            Icon(Icons.map_outlined,
                                                color: Colors.teal, size: 20),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "State",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(color: ecosperity),
                                        items: stateSel.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            state = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.tealAccent,
                                      width: 1,
                                    ), //Border.all
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: city,
                                        isDense: true,
                                        focusColor: Colors.transparent,
                                        icon: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: Colors.teal,
                                        ),
                                        iconEnabledColor: Colors.teal,
                                        menuMaxHeight: 100.0,
                                        hint: Row(
                                          children: [
                                            Icon(Icons.location_city_outlined,
                                                color: Colors.teal, size: 20),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "City",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(color: ecosperity),
                                        items: citySel.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            city = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.tealAccent,
                                      width: 1,
                                    ), //Border.all
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: language,
                                        isDense: true,
                                        focusColor: Colors.transparent,
                                        icon: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: Colors.teal,
                                        ),
                                        iconEnabledColor: Colors.teal,
                                        menuMaxHeight: 100.0,
                                        hint: Row(
                                          children: [
                                            Icon(Icons.translate_outlined,
                                                color: Colors.teal, size: 20),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Language",
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(color: ecosperity),
                                        items: langSel.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            language = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text("Vehicle Information"),
                      content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                      Icon(Icons.pivot_table_chart_outlined),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.tealAccent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: ecosperity),
                                      ),
                                      labelText: 'Chassis Number',
                                      labelStyle: TextStyle(color: Colors.teal)),
                                  onChanged: (value) {
                                    chasNo = value;
                                  },
                                  validator: (value) {
                                    if (chasNo != value) {
                                      return 'Please enter the Chassis Number';
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 20),
                              TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                      Icon(Icons.format_shapes_outlined),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.tealAccent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: ecosperity),
                                      ),
                                      labelText: 'Model Number',
                                      labelStyle: TextStyle(color: Colors.teal)),
                                  onChanged: (value) {
                                    modelNo = value;
                                  },
                                  validator: (value) {
                                    if (modelNo != value) {
                                      return 'Please enter the Chassis Number';
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 20),
                              TextFormField(
                                readOnly: true,
                                controller: _regDateController,
                                decoration: InputDecoration(
                                    prefixIcon:
                                    Icon(Icons.calendar_month_outlined),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.tealAccent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: ecosperity),
                                    ),
                                    labelText: 'Registration Date',
                                    labelStyle: TextStyle(color: Colors.teal)),
                                onTap: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(2025),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      _regDateController.text =
                                          DateFormat('d MMM yyyy')
                                              .format(selectedDate);
                                    }
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter date.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                readOnly: true,
                                controller: _yomDateController,
                                decoration: InputDecoration(
                                    prefixIcon:
                                    Icon(Icons.precision_manufacturing),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.tealAccent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: ecosperity),
                                    ),
                                    labelText: 'Manufacturing Date',
                                    labelStyle: TextStyle(color: Colors.teal)),
                                onTap: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(2025),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      _yomDateController.text =
                                          DateFormat('d MMM yyyy')
                                              .format(selectedDate);
                                    }
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter date.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width - 900,
                                    child: CheckboxListTile(
                                      title: const Text('Insurance Coverage'),
                                      subtitle: const Text(
                                          'Please mark check box for Insurance Coverage'),
                                      controlAffinity:
                                      ListTileControlAffinity.leading,
                                      autofocus: false,
                                      activeColor: ecosperity,
                                      checkColor: Colors.white,
                                      selected: _value,
                                      value: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  _value
                                      ? SizedBox(
                                    width: 500,
                                    child: TextFormField(
                                      controller: _insuranceDateController,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons
                                              .health_and_safety_outlined),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Colors.tealAccent),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2,
                                                color: ecosperity),
                                          ),
                                          labelText: 'Date of Insurance',
                                          labelStyle: TextStyle(
                                              color: Colors.teal)),
                                      onTap: () async {
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2015),
                                          lastDate: DateTime(2025),
                                        ).then((selectedDate) {
                                          if (selectedDate != null) {
                                            _insuranceDateController.text =
                                                DateFormat('d MMM yyyy')
                                                    .format(selectedDate);
                                          }
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'Please enter date.';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                      : SizedBox(),
                                  if (_value)
                                    SizedBox(
                                      width: 150,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.tealAccent,
                                            width: 1,
                                          ), //Border.all
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              value: insuranceDura,
                                              elevation: 0,
                                              isDense: true,
                                              focusColor: Colors.transparent,
                                              icon: Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: Colors.teal,
                                              ),
                                              iconEnabledColor: Colors.grey,
                                              menuMaxHeight: 100.0,
                                              hint: Row(
                                                children: [
                                                  Icon(Icons.date_range_outlined,
                                                      color: Colors.teal,
                                                      size: 20),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Duration",
                                                    style: TextStyle(
                                                        color: Colors.teal,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              style: TextStyle(color: ecosperity),
                                              items: insuranceDuraSel
                                                  .map((int items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items.toString()),
                                                );
                                              }).toList(),
                                              onChanged: (int? value) {
                                                setState(() {
                                                  insuranceDura = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    SizedBox()
                                ],
                              ),
                            ],
                          )),
                      isActive: _currentStep >= 0,
                      state: _currentStep == 1
                          ? StepState.complete
                          : StepState.disabled,
                    )
                  ]),
              SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text('SUBMIT',
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: 18
                          )),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          regDate = _regDateController.text.trim();
                          yom = _yomDateController.text.trim();
                          insuranceDate = _insuranceDateController.text.trim();
                          addUser();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text('Driver added to the system successfully')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text('Problem submitting form')));
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
