import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.text,
      required this.img,
      required this.onRemove,
      required this.id});

  final String text;
  final String img;
  final String id;
  final Function() onRemove;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late double totalPrice;
  late double price;
  double number = 1;

  @override
  void initState() {
    price = double.parse(widget.id);
    totalPrice = double.parse(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onRemove,
            child: const Icon(Icons.close),
          ),
          SizedBox(
            width: 400,
            height: 80,
            child: Row(
              children: [
                Image.network(widget.img),
                Text(widget.text),
              ],
            ),
          ),
          const SizedBox(width: 100),
          SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        color: const Color.fromARGB(255, 9, 173, 170),
                        child: const Icon(Icons.remove),
                      ),
                      onTap: () {
                        setState(() {
                          if (number > 1) {
                            number -= 1;
                            totalPrice = price * number;
                          }
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 70,
                      height: 40,
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text(number.toString()),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        color: const Color.fromARGB(255, 9, 173, 170),
                        child: const Icon(Icons.add),
                      ),
                      onTap: () {
                        setState(() {
                          number += 1;
                          totalPrice = price * number;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  '\$${widget.id}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[500]),
                ),
                Text(
                  '\$$totalPrice',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
