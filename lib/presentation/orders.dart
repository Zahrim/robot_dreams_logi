import 'package:flutter/material.dart';
import 'package:robot_dreams_logi/domain/order.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key, required this.title});
  final String title;

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {

  final List<Order> _listOrder = [];

  _OrderListPageState() {
    for (int i = 0; i < 30; i++) {
      _listOrder.add(Order('Number_$i', 'Name_$i', 'Note_$i'));
    }
  }

  String _strTypeView = 'list';
  bool _isSwitched = true;

  /*
  *
  *   Event Switch
  *
  */
  void _changeView(value) {
    setState(() {
      _isSwitched = value;
    });
    _strTypeView = (_isSwitched) ? 'list' : 'grid';
  }

  /*
  *
  *  Work item element
  *
  */
  Widget _containerItemOrder(int index, Order itemOrder) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          setState(() {
            _listOrder.removeAt(index);
          });
        } else if (direction == DismissDirection.endToStart) {
          // to do
          setState(() {});
        }
      },
      background: Container(
        alignment: Alignment.center,
        child: const Icon(
          Icons.delete,
          color: Colors.black
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No: ${itemOrder.number}', style: const TextStyle(fontSize: 22)),
            Text('Name: ${itemOrder.name}', style: const TextStyle(fontSize: 18))
          ]
        )
      )
    );
  }

  /*
  *
  * Work view
  *
   */
  Widget _buildView() {
    switch(_strTypeView) {
      case 'list':
        return ListView.builder(
          itemCount: _listOrder.length,
          itemBuilder: (context, index) {
            return _containerItemOrder(index, _listOrder[index]);
          }
        );
      case 'grid':
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount (
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            mainAxisExtent: 150.0
          ),
          itemCount: _listOrder.length,
          itemBuilder: (context, index) {
            return Card(
              child: _containerItemOrder(index, _listOrder[index])
            );
          }
        );
      default:
        return ListView().build(context);

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Is ListView? '),
                Switch(
                  value: _isSwitched,
                  onChanged: _changeView
                ),
              ],
            ),
            Expanded(
              child: _buildView()
            ),
          ],
        )
      ),
    );
  }
}