import 'package:flutter/material.dart';
import 'package:ct484_final/config/colors.dart';
import 'package:ct484_final/services/product_provider.dart';
import 'package:ct484_final/services/user_provider.dart';
import 'package:ct484_final/screens/product_overview/product_overview.dart';
import 'package:ct484_final/screens/home/home_product.dart';
import 'package:ct484_final/screens/cart/cart_review.dart';
import 'package:ct484_final/screens/search/search.dart';
import 'package:provider/provider.dart';
import 'side_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;

  Widget buildCat1Product(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Trà sữa',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getCat1ProductDataList,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Xem tất cả >>',
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getCat1ProductDataList.map(
              (cat1ProductData) {
                return HomeProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      // Preview each of the data and use it in the product overview. wish list will use those infomation to paycheck and test the project.
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: cat1ProductData.productId,
                          productPrice: cat1ProductData.productPrice,
                          productName: cat1ProductData.productName,
                          productImage: cat1ProductData.productImage,
                        ),
                      ),
                    );
                  },
                  productId: cat1ProductData.productId,
                  productPrice: cat1ProductData.productPrice,
                  productImage: cat1ProductData.productImage,
                  productName: cat1ProductData.productName,
                  productUnit: cat1ProductData,
                );
              },
            ).toList(),
            // children: [

            // ],
          ),
        ),
      ],
    );
  }

  Widget buildCat2Product(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Thức ăn nhanh',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getCat2ProductDataList,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Xem tất cả >>',
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getCat2ProductDataList.map(
              (cat2ProductData) {
                return HomeProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: cat2ProductData.productId,
                          productImage: cat2ProductData.productImage,
                          productName: cat2ProductData.productName,
                          productPrice: cat2ProductData.productPrice,
                        ),
                      ),
                    );
                  },
                  productId: cat2ProductData.productId,
                  productImage: cat2ProductData.productImage,
                  productName: cat2ProductData.productName,
                  productPrice: cat2ProductData.productPrice,
                  productUnit: cat2ProductData,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildCat3Product() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Combo lẩu nướng',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getCat3ProductDataList,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Xem tất cả >>',
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getCat3ProductDataList.map(
              (cat3Productdata) {
                return HomeProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: cat3Productdata.productId,
                          productImage: cat3Productdata.productImage,
                          productName: cat3Productdata.productName,
                          productPrice: cat3Productdata.productPrice,
                        ),
                      ),
                    );
                  },
                  productId: cat3Productdata.productId,
                  productImage: cat3Productdata.productImage,
                  productName: cat3Productdata.productName,
                  productPrice: cat3Productdata.productPrice,
                  productUnit: cat3Productdata,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
  // CHo nay la cho lay du lieu lai jhai lan de xua ly nay

  @override
  void initState() {
    print("Here is the home screen");
    ProductProvider initproductProvider =
        Provider.of<ProductProvider>(context, listen: false);
    initproductProvider.emptySearch();
    initproductProvider.fetchCat1ProductData();
    initproductProvider.fetchCat2ProductData();
    initproductProvider.fetchCat3ProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 238, 238),
      drawer: SideDrawer(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Trang chủ',
          style: TextStyle(color: textColor, fontSize: 17),
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: const Color.fromARGB(255, 243, 239, 113),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Search(search: productProvider.getAllProductSearch),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                size: 17,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartReview(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: const Color(0xffd6d382),
                radius: 15,
                child: Icon(
                  Icons.shop,
                  size: 17,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi0Xg-k622Sbztlrb-L1o1CAla3zCbVc2lUw&usqp=CAU'),
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 130, bottom: 10),
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: const BoxDecoration(
                                color: Color(0xffd1ad17),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Deal',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.green,
                                          blurRadius: 10,
                                          offset: Offset(3, 3))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Giảm 30%',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.green[100],
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Cho các loại rau củ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            buildCat1Product(context),
            buildCat2Product(context),
            buildCat3Product(),
          ],
        ),
      ),
    );
  }
}
