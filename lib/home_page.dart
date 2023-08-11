import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_5s3s/Custom_Widgets/function_button.dart';
import 'package:test_5s3s/Custom_Widgets/function_button_icon.dart';
import 'package:test_5s3s/controllers/fetch_data_http.dart';
import 'package:test_5s3s/models/meal.dart';
import 'package:test_5s3s/views/cart.dart';
import 'package:test_5s3s/views/product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> categoryList = ['Beef'];
  late List<Meal> mealsCard = [];
  late String category = categoryList.first;
  late Future<List<Meal>> meals;
  @override
  void initState() {
    super.initState();
    meals = fetchMealByCategory('Beef');
    fetchCategories().then((value) {
      for (int i = 1; i < value.length; i++) {
        categoryList.add(value[i].strCategory);
      }
    });
  }

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
                      padding: const EdgeInsetsDirectional.only(),
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
            SingleChildScrollView(
              child: Container(
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
                    Row(
                      children: [
                        const FunctionButton(
                          text: 'All',
                          color: Colors.grey,
                        ),
                        const FunctionButton(text: 'On sale'),
                        const FunctionButton(text: 'Featured'),
                        const FunctionButtonIcon(
                          text: 'Add product',
                          icon: Icons.add,
                          isRow: true,
                        ),
                        const FunctionButtonIcon(
                          text: 'Scan product',
                          icon: Icons.qr_code,
                          isRow: true,
                        ),
                        DropdownButton<String>(
                          value: category,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) async {
                            setState(() {
                              category = value!;
                              meals = fetchMealByCategory(category);
                            });
                          },
                          items: categoryList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.grey[400],
                        child: FutureBuilder(
                          future: meals,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 1.3),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Products(
                                    name: snapshot.data![index].strMeal,
                                    thumbnail:
                                        snapshot.data![index].strMealThumb,
                                    callback: () => {
                                      setState(() {
                                        mealsCard.add(snapshot.data![index]);
                                      }),
                                    },
                                  );
                                },
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
                        itemCount: mealsCard.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            text: mealsCard[index].strMeal,
                            img: mealsCard[index].strMealThumb,
                            id: mealsCard[index].idMeal,
                            onRemove: () {
                              setState(() {
                                mealsCard.remove(mealsCard[index]);
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
                        const FunctionButtonIcon(
                          text: "ADD NOTE",
                          icon: Icons.message,
                          color: Colors.black54,
                          isRow: false,
                        ),
                        const FunctionButtonIcon(
                          text: "ADD FEE OR DISCOUNT",
                          icon: Icons.add,
                          color: Color.fromARGB(255, 9, 173, 170),
                          isRow: false,
                        ),
                        const FunctionButtonIcon(
                          text: "APPLY COUPON",
                          icon: Icons.card_giftcard,
                          color: Color.fromARGB(255, 9, 173, 170),
                          isRow: false,
                        ),
                        const FunctionButtonIcon(
                          text: "SHIPPING",
                          icon: Icons.local_shipping,
                          color: Color.fromARGB(255, 9, 173, 170),
                          isRow: false,
                        ),
                        const FunctionButtonIcon(
                          text: "SUSPEND & SAVE CART",
                          icon: Icons.shopping_cart,
                          color: Color.fromARGB(255, 224, 153, 20),
                          isRow: false,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 85,
                          ),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          color: const Color.fromARGB(255, 160, 167, 0),
                          child: const FunctionButton(
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
