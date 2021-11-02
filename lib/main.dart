// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'dart:io';
import 'package:expense_app/widgets/adaptive_button.dart';
import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            title: 'Expense App',
            home: MyHomePage(),
            theme: CupertinoThemeData(
                primaryColor: Colors.white,
                scaffoldBackgroundColor: Colors.grey,
                barBackgroundColor: Colors.purple.shade500,
                //primaryContrastingColor: Colors.blue,
                textTheme: CupertinoTextThemeData(
                  primaryColor: Colors.white,
                )),
          )
        : MaterialApp(
            title: 'Expense App',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.amber,
              applyElevationOverlayColor: true,
            ),
            home: MyHomePage(),
          );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: "1", title: "Shirt", amount: 999, date: DateTime.now()),
    // Transaction(id: "2", title: "Pant", amount: 999, date: DateTime.now()),
    // Transaction(id: "3", title: "Cap", amount: 159, date: DateTime.now()),
    // Transaction(id: "1", title: "Shirt", amount: 999, date: DateTime.now()),
    // Transaction(id: "2", title: "Pant", amount: 999, date: DateTime.now()),
    // Transaction(id: "3", title: "Cap", amount: 159, date: DateTime.now()),
    // Transaction(id: "1", title: "Shirt", amount: 999, date: DateTime.now()),
    // Transaction(id: "2", title: "Pant", amount: 999, date: DateTime.now()),
    // Transaction(id: "3", title: "Cap", amount: 159, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newtitle = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(() {
      _userTransactions.add(newtitle);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xFF9E9E9E),
      constraints: BoxConstraints(
          //maxHeight: 350,
          ),
      context: context,
      builder: (builder) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Expense App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            trailing: CupertinoButton(
              // alignment: Alignment.bottomRight,
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.add),
              onPressed: () {
                _startAddNewTransaction(context);
              },
            ),
          )
        : AppBar(
            title: Text("Expense App"),
            actions: [
              IconButton(
                  onPressed: () {
                    _startAddNewTransaction(context);
                  },
                  icon: Icon(Icons.add))
            ],
          ) as PreferredSizeWidget;
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                -mediaQuery.padding.top) *
            0.730,
        child: TransactionList(_userTransactions, _deleteTransaction));
    final chartWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.270,
      child: Chart(_recentTransaction),
    );

    final pagebody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape) chartWidget,
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransaction),
                    )
                  : txListWidget,
            Platform.isIOS
                ? CupertinoButton(
                    child: Text("Add New Transaction"),
                    onPressed: () {},
                  )
                : Container(),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            backgroundColor: Colors.grey,
            body: pagebody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                  ),
          );
  }
}
