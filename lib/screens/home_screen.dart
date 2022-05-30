// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:budget_tracker/notion/budget_repository.dart';
import 'package:budget_tracker/notion/failure_model.dart';
import 'package:budget_tracker/widgets/spending_chart.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/notion/item_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Item>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = BudgetRepository().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 246, 246),
        title: Text(
          'Budget Tracker',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
                  ),
              ),
      ),
      backgroundColor: Colors.amber,
      body: RefreshIndicator(
        onRefresh: () async {
          _futureItems = BudgetRepository().getItems();
          setState(() {});
        },
        child: FutureBuilder<List<Item>>(
          future: _futureItems,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              //Showing pie chart with list of items if the snapshot has data
              final items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if(index==0) return SpendingChart(items: items);
                  
                  final item = items[index-1];
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 2.0,
                        color: getCategoryColor(item.category),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text(
                        '${item.category} ${DateFormat.yMd().format(item.date)}',
                      ),
                      trailing: Text(
                        '-\$${item.price.toStringAsFixed(2)}',
                      ),
                    ),
                  );
                },
              );
            } else if(snapshot.hasError) {
              //Showing failure message
              final failure = snapshot.error as Failure;
              return Center(child: Text(failure.message));
            }
            //Otherwise show a loading spinner
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      
     

    );
  }
}

Color getCategoryColor(String category) {
  switch (category) {
    case 'Bills':
      return Colors.red[300]!;
    case 'Food':
      return Colors.blue[300]!;
    case 'Investments':
      return Colors.green[300]!;
    default:
      return Colors.deepOrange[300]!;
  }
}