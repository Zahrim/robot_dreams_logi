import 'package:robot_dreams_logi/domain/models/order.dart';
/*
int setCountOrders(List<Order> lsOrders, String strStatus) {
  //return lsOrders.where((element) => (element.status == strStatus)).length;

  return -1;
}
*/
int getCountPickUpOrders(List<Order> lsOrders) {
  //int i = 1;
  return lsOrders.where((element) => (element.status == 'Pick Up')).length;
}
