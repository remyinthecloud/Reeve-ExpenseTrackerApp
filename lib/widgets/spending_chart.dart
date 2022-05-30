// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:budget_tracker/screens/home_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/notion/item_model.dart';

class SpendingChart extends StatelessWidget {
  final List<Item> items;

  SpendingChart({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final spending = <String, double>{};

      items.forEach(
        (item) => spending.update(
          item.category,
          (value) => value+item.price,
          ifAbsent: () => item.price
        )
      );

    return Card(
      margin: EdgeInsets.all(30.0),
      elevation: 2.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.black26, 
          width: 2.0
        )
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 360.0,
        child: Column(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: spending
                    .map((category, amountSpent) => MapEntry(
                      category,
                      PieChartSectionData(
                        color: getCategoryColor(category),
                        radius: 150.0,
                        title: '\$${amountSpent.toStringAsFixed(2)}',
                        value: amountSpent,
                      ),
                    ))
                    .values
                    .toList(),
                  sectionsSpace: 1,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: spending.keys
                .map((category) => _Indicator(
                  color: getCategoryColor(category),
                  text: category,
                ))
                .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String text;

  _Indicator({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 10.0,
          width: 10.0,
          color: color,
        ),
        SizedBox(
          width: 4.0,
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}