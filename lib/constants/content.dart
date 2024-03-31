import 'package:flutter/material.dart';

List<Map> alertsMap = [
  drivingPattern,
  motor,
  battery,
  sensors,
  lights,
  controllers,
  geofence
];

Map<String, IconData> alerts = {
  "Driving Pattern Alerts": Icons.apps_outage_rounded,
  "Motor Alerts": Icons.motion_photos_on_rounded,
  "Battery Alerts": Icons.battery_charging_full,
  "Sensors Alerts": Icons.sensors,
  "Lights Alerts": Icons.wb_twighlight,
  "Controllers Alerts": Icons.memory,
  "Geofence Alerts": Icons.crisis_alert,
};

Map<String, IconData> drivingPattern = {
  "Over Load": Icons.scale,
  "Rash Throttling": Icons.sync_problem,
  "Rash Braking": Icons.settings_backup_restore,
  "Rash Steering": Icons.move_up,
  "Over Speed": Icons.speed,
  "Abnormal Boost Request": Icons.network_ping,
  "False Direction": Icons.multiple_stop
};

Map<String, IconData> motor = {
  "Left Motor Failure": Icons.scale,
  "Right Motor Failure": Icons.sync_problem,
  "Left Motor Over Temperature": Icons.settings_backup_restore,
  "Right Motor Over Temperature": Icons.move_up,
  "Left Motor Over Current": Icons.speed,
  "Right Motor Over Current": Icons.network_ping
};

Map<String, IconData> battery = {
  "Battery Short Circuit": Icons.scale,
  "Cell Unbalanced": Icons.sync_problem,
  "Deep Discharged": Icons.settings_backup_restore,
  "Bad Battery Health": Icons.move_up,
  "Over Current": Icons.speed,
  "Battery Over Temperature": Icons.network_ping
};

Map<String, IconData> sensors = {
  "Brake System Failure": Icons.scale,
  "Throttle Failure": Icons.sync_problem,
  "Brake Sensor Failure": Icons.settings_backup_restore,
  "Steering Sensor Failure": Icons.move_up,
  "Suspension Sensor Failure": Icons.speed
};

Map<String, IconData> lights = {
  "Headlight Failure": Icons.flashlight_off,
  "Left Indicator Failure": Icons.scale,
  "Right Indicator Failure": Icons.sync_problem,
  "Reverse Indicator Failure": Icons.settings_backup_restore,
  "Brake Indicator Failure": Icons.move_up
};

Map<String, IconData> controllers = {
  "Left Motor Controller Failure": Icons.join_left,
  "Right Motor Controller Failure": Icons.join_right,
  "Vehicle Controller Failure": Icons.sync_problem,
  "Telematics Controller Failure": Icons.settings_backup_restore,
  "Brake Indicator Failure": Icons.move_up
};

Map<String, IconData> geofence = {"Geo-offenders": Icons.scale};
