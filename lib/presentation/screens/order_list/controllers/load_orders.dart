import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:robot_dreams_logi/domain/models/order.dart';

Future<List<Order>> loadOrders() async {
  final jsonString = await rootBundle.loadString('assets/orders.json');
  final jsonData = json.decode(jsonString);

  final lsOrder = <Order>[];
  for (var item in jsonData) {
    lsOrder.add(Order.fromJson(item));
  }

  return lsOrder;
}
