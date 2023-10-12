import 'package:flutter/material.dart';
import 'package:robot_dreams_logi/domain/models/order.dart';
import 'package:robot_dreams_logi/presentation/screens/order_list/widgets/widgets.dart';
import 'package:robot_dreams_logi/presentation/screens/order_list/controllers/controllers.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key, required this.title});

  final String title;

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  _OrderListScreenState() {
    loadOrders().then((value) => initOrders(value));
  }

  List<Order> _listOrder = <Order>[];

  void initOrders(List<Order> listOrder) {
    setState(() {
      _listOrder = listOrder;
    });
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
      _isSwitched = value ?? false;
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
            //Text('Name: ${itemOrder.name}', style: const TextStyle(fontSize: 18))
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
            mainAxisExtent: 150.0,
          ),
          itemCount: _listOrder.length,
          itemBuilder: (context, index) {
            return Container(
              child: _containerItemOrder(index, _listOrder[index])
            );
          },
        );
      default:
        return ListView().build(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),

      body: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  //color: CupertinoColors.teal[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 50,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ],
      ),
    );

/*
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text(widget.title)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Is ListView? '),
                CupertinoSwitch(
                  value: _isSwitched,
                    activeColor: CupertinoColors.activeBlue,
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

    */
  }
}