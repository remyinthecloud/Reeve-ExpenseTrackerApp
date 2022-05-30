// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:budget_tracker/notion/item_model.dart';
import 'package:budget_tracker/notion/failure_model.dart';

class BudgetRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';

  final http.Client _client;

  BudgetRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<Item>> getItems() async {
    try {
      final url =
        '${_baseUrl}databases/${dotenv.env['NOTION_DATABASE_ID']}/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${dotenv.env['NOTION_API_KEY']}',
            'Notion-Version': '2022-02-22',
        },
      );

      if(response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['results'] as List).map((e) => Item.fromMap(e)).toList()
          ..sort((a, b) => b.date.compareTo(a.date));
      } else {
        throw Failure(message: 'Oops! Something went wrong!');
      }
    } catch (_) {
        throw Failure(message: 'Oops! Something went wrong!');
    }
  }
}