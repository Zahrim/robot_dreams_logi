import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:robot_dreams_logi/data/models/order.dart';

class OrderAPI {

  Future<List<OrderData>> getOrders() async {
    await Future.delayed(const Duration(seconds: 2));

    final jsonString = await rootBundle.loadString('assets/orders.json');
    final jsonData = json.decode(jsonString);

    final lsOrder = <OrderData>[];
    for (var item in jsonData) {
      lsOrder.add(OrderData.fromAPI(item));
    }

    return lsOrder;
  }
}
