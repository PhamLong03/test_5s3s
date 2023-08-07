import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_5s3s/Custom_Widgets/function_button.dart';
import 'package:test_5s3s/Custom_Widgets/function_button_icon.dart';
import 'package:test_5s3s/controllers/fetchAllMealCategories.dart';
import 'package:test_5s3s/models/category.dart';
import 'package:test_5s3s/views/cart.dart';
import 'package:test_5s3s/views/product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CategoriesController categoriesController = Get.put(CategoriesController());
  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 87, 86),
        toolbarHeight: 50,
        flexibleSpace: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      color: const Color.fromARGB(255, 9, 173, 170),
                      child: const Icon(
                        Icons.menu,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.store,
                      size: 30,
                      color: Colors.white,
                    ),
                    const Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Store: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Colors.white)),
                      TextSpan(
                          text: "Food store",
                          style: TextStyle(fontSize: 18, color: Colors.white))
                    ])),
                    const Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Register: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Colors.white)),
                      TextSpan(
                          text: "Register 1",
                          style: TextStyle(fontSize: 18, color: Colors.white))
                    ]))
                  ],
                ),
              ),
              SizedBox(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      height: 50,
                      width: 70,
                      color: Colors.red[400],
                      child: const Icon(
                        Icons.logout_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Test test",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Container(
                      height: 35,
                      width: 40,
                      color: Colors.grey,
                      padding: EdgeInsetsDirectional.only(),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.zoom_out_map,
                      size: 30,
                      color: Colors.white,
                    ),
                    const Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blueAccent,
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('point of sale '),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const TextField(
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          selectionHeightStyle: BoxHeightStyle.tight,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        color: const Color.fromARGB(255, 67, 87, 86),
                        child: const Icon(Icons.qr_code, color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      FunctionButton(
                        text: 'All',
                        color: Colors.grey,
                      ),
                      FunctionButton(text: 'On sale'),
                      FunctionButton(text: 'Featured'),
                      FunctionButtonIcon(
                        text: 'Add product',
                        icon: Icons.add,
                        isRow: true,
                      ),
                      FunctionButtonIcon(
                        text: 'Scan product',
                        icon: Icons.qr_code,
                        isRow: true,
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.grey[400],
                      child: Obx(
                        () => categoriesController.isLoading == true
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 1.3),
                                itemCount: categoriesController
                                    .categoryModel?.categories?.length,
                                itemBuilder: (context, index) {
                                  return Products(
                                    name: categoriesController.categoryModel
                                            ?.categories![index].strCategory ??
                                        'no',
                                    description: categoriesController
                                            .categoryModel
                                            ?.categories![index]
                                            .strCategoryDescription ??
                                        'no',
                                    thumbnail: categoriesController
                                            .categoryModel
                                            ?.categories![index]
                                            .strCategoryThumb ??
                                        'no',
                                    id: categoriesController.categoryModel
                                            ?.categories![index].idCategory ??
                                        'no',
                                    callback: () => {
                                      setState(() {
                                        categories.add(categoriesController
                                            .categoryModel!.categories![index]);
                                        categories =
                                            categories.toSet().toList();
                                      }),
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(left: BorderSide(color: Colors.grey))),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.grey[400],
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        const FunctionButtonIcon(
                          text: "Cart",
                          icon: Icons.shopping_cart,
                          color: Colors.white,
                          isRow: true,
                        ),
                        FunctionButtonIcon(
                          text: "Customer",
                          icon: Icons.face,
                          color: Colors.grey[400],
                          isRow: true,
                        ),
                        FunctionButtonIcon(
                          text: "Address",
                          icon: Icons.location_on,
                          color: Colors.grey[400],
                          isRow: true,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 7 * 5,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            text: categories[index].strCategory,
                            img: categories[index].strCategoryThumb,
                            id: categories[index].idCategory,
                            onRemove: () {
                              setState(() {
                                categories.remove(categories[index]);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        FunctionButtonIcon(
                          text: "ADD NOTE",
                          icon: Icons.message,
                          color: Colors.black54,
                          isRow: false,
                        ),
                        FunctionButtonIcon(
                          text: "ADD FEE OR DISCOUNT",
                          icon: Icons.add,
                          color: const Color.fromARGB(255, 9, 173, 170),
                          isRow: false,
                        ),
                        FunctionButtonIcon(
                          text: "APPLY COUPON",
                          icon: Icons.card_giftcard,
                          color: const Color.fromARGB(255, 9, 173, 170),
                          isRow: false,
                        ),
                        FunctionButtonIcon(
                          text: "SHIPPING",
                          icon: Icons.local_shipping,
                          color: const Color.fromARGB(255, 9, 173, 170),
                          isRow: false,
                        ),
                        FunctionButtonIcon(
                          text: "SUSPEND & SAVE CART",
                          icon: Icons.shopping_cart,
                          color: const Color.fromARGB(255, 224, 153, 20),
                          isRow: false,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 85,
                          ),
                          margin: EdgeInsets.only(left: 10, right: 10),
                          color: Color.fromARGB(255, 160, 167, 0),
                          child: FunctionButton(
                            text: 'PAY',
                            color: Color.fromARGB(255, 160, 167, 0),
                          ),
                        ),
                      ],
                    ),
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
