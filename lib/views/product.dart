import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  const Products({
    super.key,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.id,
    required this.callback,
  });
  final String id;
  final String name;
  final String description;
  final String thumbnail;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => callback(),
      child: Container(
          alignment: Alignment.bottomCenter,
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              image: DecorationImage(
                  image: NetworkImage(thumbnail), fit: BoxFit.fill)),
          child: Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.sizeOf(context).width,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color.fromRGBO(114, 114, 114, 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Text(
                    'Id: $id',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ],
              ))),
    );
  }
}
