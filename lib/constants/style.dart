import 'package:flutter/material.dart';

const Color light = Color(0xFFF7F8FC);
const Color lightGrey = Color(0xFFA4A6B3);
const Color dark = Color(0xFF363740);
const Color dark2 = Color.fromARGB(255, 21, 50, 58);
const Color active = Color(0xFF3C19C0);
const Color ecosperity = Color.fromRGBO(24, 56, 150, 1); // #183896
const Color yellow = Color.fromARGB(255, 250, 202, 50);

Color bigCardColor = Colors.white;


Color cardIconCircleColor = lightGrey.withOpacity(0.4);
Color cardIconColor = ecosperity;
Color cardColor = Colors.white;

const style = ('''
  [
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.neighborhood",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
  ''');

