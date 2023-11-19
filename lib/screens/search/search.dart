import 'package:flutter/material.dart';
import 'package:ct484_final/models/product_model.dart';
import 'package:ct484_final/widgets/single_item.dart';

class Search extends StatefulWidget {
  final List<ProductModel> search;
  const Search({super.key, required this.search});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  List<ProductModel> searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  //    When querry the state change -> rebuild the widget -> searchAgain
  Widget build(BuildContext context) {
    List<ProductModel> searchItemResult = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sort),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Các kết quả"),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color(0xffc2c2c2),
                filled: true,
                hintText: "Nhập dữ liệu để bắt đầu tìm kiếm",
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: searchItemResult.map((data) {
              return SingleItem(
                isBool: false,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productId: data.productId,
                productQuantity: data.productQuantity,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
