// ignore: file_names
import 'dart:convert';
import 'package:test_5s3s/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:test_5s3s/models/meal.dart';

Future<List<Category>> fetchCategories() async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
  final data = json.decode(response.body);
  final List<dynamic> categoryList = data['categories'];
  final List<Category> categories = [];
  for (var element in categoryList) {
    final Category album = Category.fromJson(element);
    categories.add(album);
  }

  if (response.statusCode == 200) {
    return categories;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Meal>> fetchMealByCategory(String category) async {
  final response = await http.get(Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));
  final data = json.decode(response.body);
  final List<dynamic> meals = data['meals'];
  final List<Meal> categories = [];
  for (var element in meals) {
    final Meal meal = Meal.fromJson(element);
    categories.add(meal);
  }

  if (response.statusCode == 200) {
    return categories;
  } else {
    throw Exception('Failed to load album');
  }
}
