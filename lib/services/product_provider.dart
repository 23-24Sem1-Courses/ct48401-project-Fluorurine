import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ct484_final/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  late ProductModel productModel;

// This is where take the id of the product as named in Firebase collecetion and return to model id part.
  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    print(element.data());
    productModel = ProductModel(
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.id,
      productUnit: element.get("productUnit"),
    );
    // The search list will return all the data from the database
    search.add(productModel);
  }

  // Renember to limit the data to fix the size of homepage
  /////////////// herbsProduct ///////////////////////////////
  List<ProductModel> catProduct1 = [];

  fetchCat1ProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("CAT1product").get();

    for (var element in value.docs) {
      productModels(element);

      newList.add(productModel);
    }
    catProduct1 = newList;
    notifyListeners();
  }

  List<ProductModel> get getCat1ProductDataList {
    return catProduct1;
  }

//////////////// Fresh Product ///////////////////////////////////////

  List<ProductModel> catProduct2 = [];

  fetchCat2ProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("CAT2product").get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel);
    }
    catProduct2 = newList;
    notifyListeners();
  }

  List<ProductModel> get getCat2ProductDataList {
    return catProduct2;
  }

//////////////// Root Product ///////////////////////////////////////

  List<ProductModel> catProduct3 = [];

  fetchCat3ProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("CAT3product").get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel);
    }
    catProduct3 = newList;
    notifyListeners();
  }

  List<ProductModel> get getCat3ProductDataList {
    return catProduct3;
  }

  /////////////////// Search Return ////////////
  List<ProductModel> get getAllProductSearch {
    return search;
  }

  void emptySearch() {
    search = [];
    notifyListeners();
  }
}
