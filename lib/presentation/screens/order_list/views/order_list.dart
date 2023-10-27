import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:robot_dreams_logi/domain/models/order.dart';
import 'package:robot_dreams_logi/domain/repositories/order.dart';
import 'package:robot_dreams_logi/presentation/widgets/widgets.dart';
import 'package:robot_dreams_logi/presentation/screens/profile/profile.dart';
import 'package:robot_dreams_logi/presentation/screens/order_list/controllers/controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key, required this.title});

  static const String _strAllBroker = 'All Brokers';
  static const String _strWaiting = 'Waiting for Vehicle';
  static const String _strPickUp = 'Pick Up';

  String get defaultBroker => _strAllBroker;

  String get waiting => _strWaiting;

  String get pickUp => _strPickUp;

  final String title;
  final String broker = _strAllBroker;

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late OrderRepository _repository;
  late List<Order> _lsOrder;
  late List<Order> _lsOrderStorage;
  late List<String> _lsBroker;
  late String _strCurrentBroker;
  late DateTime _dtLoadDate;
  late int _iCurrentOrder;

  late StreamController<List<Order>> _controller;
  late StreamController<int> _controllerCounter;

  @override
  void initState() {
    _repository = OrderRepository();
    _lsBroker = <String>[];
    _lsOrderStorage = <Order>[];
    _strCurrentBroker = widget.defaultBroker;
    _dtLoadDate = DateTime.now();
    _iCurrentOrder = -1;
    _lsOrder = List.empty(growable: true);

    _controller = StreamController();
    _controllerCounter = StreamController();

    compute(setCountPickUpOrders, _lsOrderStorage);

    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void setOrders(List<Order> lsOrder) {
    _lsOrderStorage = lsOrder;
    _lsOrder = _lsOrderStorage
        .where((element) => ((_strCurrentBroker == widget.defaultBroker) ||
            (element.broker == _strCurrentBroker)))
        .toList();

    _lsBroker = lsOrder.map((m) => m.broker).toSet().toList();
    _lsBroker.sort();
    _lsBroker.insert(0, widget.defaultBroker);

    compute(setCountPickUpOrders, _lsOrderStorage)
        .then((value) => {_controllerCounter.sink.add(value)});

    _controller.sink.add(_lsOrder);
  }

  void changeStatus(index) {
    _lsOrder[index].status = (_lsOrder[index].status == widget.pickUp)
        ? widget.waiting
        : widget.pickUp;
    _controller.sink.add(_lsOrder);
    compute(setCountPickUpOrders, _lsOrderStorage)
        .then((value) => {_controllerCounter.sink.add(value)});
  }

  Widget _buildItemContainer(index) => SizedBox(
        child: GestureDetector(
          onTap: () => {
            changeStatus(index),
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
                Text(
                  'Status: ${_lsOrder[index].status}',
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
            //width: 300,
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
                            _strCurrentBroker = _lsBroker[index];
                            _lsOrder = _lsOrderStorage
                                .where((element) => ((_strCurrentBroker ==
                                        widget.defaultBroker) ||
                                    (element.broker == _strCurrentBroker)))
                                .toList();
                            _controller.sink.add(_lsOrder);
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
                    horizontal: 25.0,
                    vertical: 30.0,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    child: Text(AppLocalizations.of(context)!.close),
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
              title: 'Info',
              message: 'Current broker: $_strCurrentBroker',
            ),
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
                  child: StreamBuilder(
                      stream: _controllerCounter.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          );
                        } else {
                          return Text(
                            '${AppLocalizations.of(context)!.count_orders}: ${snapshot.data}',
                          );
                        }
                      }),
                ),
              ),
            if (_iCurrentOrder == -1)
              Container(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 600) {
                      return FutureBuilder(
                        future: _repository.fetchOrders(),
                        //initialData: const <Order>[],
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          } else {
                            //_controller.bro.close();
                            setOrders(snapshot.data!.toList());

                            return StreamBuilder(
                              stream: _controller.stream,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    ),
                                  );
                                } else {
                                  return CustomScrollView(
                                    slivers: [
                                      _buildList(),
                                    ],
                                  );
                                }
                              },
                            );
                          }
                        },
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
                  top: 40,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
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
                        //setState(() {
                        _iCurrentOrder = -1;
                        //}
                        //);
                      },
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
