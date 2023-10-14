import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:robot_dreams_logi/domain/models/order.dart';
import 'package:robot_dreams_logi/presentation/screens/order_list/controllers/controllers.dart';
import 'package:robot_dreams_logi/presentation/widgets/widgets.dart';
import 'package:robot_dreams_logi/presentation/screens/profile/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key, required this.title});

  static const String _strAllBroker = 'All Brokers';

  String get defaultBroker => _strAllBroker;

  final String title;
  final String broker = _strAllBroker;

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  _OrderListScreenState() {
    loadOrders().then((value) => initOrders(value));
  }

  List<Order> _lsOrder = <Order>[];
  List<Order> _lsOrderStorage = <Order>[];
  List<String> _lsBroker = <String>[];
  String _strCurrentBroker = "";
  DateTime _dtLoadDate = DateTime.now();
  int _iCurrentOrder = -1;

  void initOrders(List<Order> lsOrder) {
    setState(() {
      _lsOrderStorage = lsOrder;
      _lsOrder = lsOrder;
      _lsBroker = lsOrder.map((m) => m.broker).toSet().toList();
      _lsBroker.sort();
      _lsBroker.insert(0, widget.defaultBroker);
      _strCurrentBroker = widget.defaultBroker;
      _dtLoadDate = DateTime.now();
    });
  }

  Widget _buildItemContainer(index) => SizedBox(
        child: GestureDetector(
          onTap: () => {
            setState(() {
              _iCurrentOrder = index;
            })
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black26
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No: ${_lsOrder[index].number}',
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'From: ${_lsOrder[index].pickup.state}, ${_lsOrder[index].pickup.city}',
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'To: ${_lsOrder[index].drop.state}, ${_lsOrder[index].drop.city}',
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Weight: ${_lsOrder[index].weight}',
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildGrid() => SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _buildItemContainer(index);
          },
          childCount: _lsOrder.length,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          mainAxisExtent: 90,
        ),
      );

  Widget _buildList() => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _buildItemContainer(index);
          },
          childCount: _lsOrder.length,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                      title: AppLocalizations.of(context)!.profile),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      drawer: Builder(
        builder: (BuildContext context) {
          return Drawer(
            width: 300,
            child: ListView(
              children: [
                SizedBox(
                  height: 64.0,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.white60,
                    ),
                    child:
                        Text('${AppLocalizations.of(context)?.broker_company}'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                      itemCount: _lsBroker.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _strCurrentBroker = _lsBroker[index];
                              _lsOrder = _lsOrderStorage
                                  .where((element) => ((_strCurrentBroker ==
                                          widget.defaultBroker) ||
                                      (element.broker == _strCurrentBroker)))
                                  .toList();
                            });
                            Scaffold.of(context).closeDrawer();
                          },
                          child: Chip(
                            label: Row(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: Text(_lsBroker[index]),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 30.0),
                  child: TextButton(
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    child: Text("${AppLocalizations.of(context)?.close}"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) => InfoMessage(
                title: 'Info', message: 'Current broker: $_strCurrentBroker'),
          )
        },
        child: const Icon(Icons.info),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/truck.png"),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
        child: Stack(
          children: [
            if (_iCurrentOrder == -1)
              Container(
                color: Colors.grey,
                height: 30,
                child: Center(
                  child: Text(
                      '${AppLocalizations.of(context)?.order_information_on} ${DateFormat('dd.MM.yyyy HH:mm:ss').format(_dtLoadDate)}'),
                ),
              ),
            if (_iCurrentOrder == -1)
              Container(
                padding: const EdgeInsets.only(
                    top: 40, left: 10, right: 10, bottom: 10),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 600) {
                      return CustomScrollView(
                        slivers: [
                          _buildList(),
                        ],
                      );
                    } else {
                      return CustomScrollView(
                        slivers: [
                          _buildGrid(),
                        ],
                      );
                    }
                  },
                ),
              ),
            if (_iCurrentOrder != -1)
              Container(
                padding: const EdgeInsets.only(
                    top: 40, left: 10, right: 10, bottom: 10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'No: ${_lsOrder[_iCurrentOrder].number}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('===='),
                    Text(
                      'Pick up location: ${_lsOrder[_iCurrentOrder].pickup.state}, ${_lsOrder[_iCurrentOrder].pickup.city}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _lsOrder[_iCurrentOrder].pickup.address,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('===='),
                    Text(
                      'Drop location: ${_lsOrder[_iCurrentOrder].drop.state}, ${_lsOrder[_iCurrentOrder].drop.city}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _lsOrder[_iCurrentOrder].drop.address,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('===='),
                    Text(
                      'Weight: ${_lsOrder[_iCurrentOrder].weight}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('===='),
                    Text(
                      'Broker: ${_lsOrder[_iCurrentOrder].broker}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('===='),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _iCurrentOrder = -1;
                        });
                      },
                      child: const Text("Close"),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
