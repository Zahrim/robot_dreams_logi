import 'package:robot_dreams_logi/data/api/order.dart';
import 'package:robot_dreams_logi/data/models/order.dart';
import 'package:robot_dreams_logi/domain/models/location.dart';
import 'package:robot_dreams_logi/domain/models/order.dart';

class OrderRepository {
  final OrderAPI _api;

  OrderRepository(this._api);

  Future<List<Order>> fetchOrders() async {
    List<OrderData> lsOrderData = await _api.getOrders();

    List<Order> lsOrder = <Order>[];

    for (var item in lsOrderData) {
      lsOrder.add(
        Order(
          item.number,
          item.broker,
          item.weight,
          Location(item.pickup.zip, item.pickup.state, item.pickup.city,
              item.pickup.address, item.pickup.lat, item.pickup.lng),
          Location(item.drop.zip, item.drop.state, item.drop.city,
              item.drop.address, item.drop.lat, item.drop.lng),
        ),
      );
    }

    return lsOrder;
  }

  Stream<Order> updateOrder(Order order, String status) async* {
    await Future.delayed(const Duration(seconds: 1));
    order.status = status;
    yield order;
  }
}
