import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';

class OverviewCards extends StatefulWidget {
  final String city;

  const OverviewCards({Key? key, required this.city}) : super(key: key);

  @override
  State<OverviewCards> createState() => _OverviewCardsState();
}

class _OverviewCardsState extends State<OverviewCards> {
  bool darkMode = false;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: entries.length,
          itemBuilder: (BuildContext ctx, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
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
                            Random().nextInt(100).toString(),
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
            );
          }),
    );
  }
}
