import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:robot_dreams_logi/domain/models/driver.dart';

Future<List<Driver>> loadDrivers() async {
  final jsonString = await rootBundle.loadString('assets/drivers.json');
  final jsonData = json.decode(jsonString);

  final lsDriver = <Driver>[];
  for (var item in jsonData) {
    lsDriver.add(Driver.fromJson(item));
  }

  return lsDriver;
}
