class CategoryModel {
  List<Category>? categories;

  CategoryModel({required this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categories =
        List.from(json['categories']).map((e) => Category.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories'] = categories!.map((e) => e.toJson()).toList();
    return data;
  }
}

class Category {
  late String idCategory;
  late String strCategory;
  late String strCategoryThumb;
  late String strCategoryDescription;

  Category(
      {required this.idCategory,
      required this.strCategory,
      required this.strCategoryThumb,
      required this.strCategoryDescription});

  Category.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCategory'] = this.idCategory;
    data['strCategory'] = this.strCategory;
    data['strCategoryThumb'] = this.strCategoryThumb;
    data['strCategoryDescription'] = this.strCategoryDescription;
    return data;
  }
}
