import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_5s3s/models/category.dart';

class CategoriesController extends GetxController {
  var isLoading = false.obs;
  CategoryModel? categoryModel;
  @override
  Future<void> onInit() async {
    super.onInit();
    fetchCategories();
  }

  fetchCategories() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'https://www.themealdb.com/api/json/v1/1/categories.php')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        categoryModel = CategoryModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
