import 'package:ct484_final/screens/check_out/delivery_detail/delivery_detail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ct484_final/config/colors.dart';
import 'package:ct484_final/models/review_cart_model.dart';
import 'package:ct484_final/services/review_cart_provider.dart';

// import 'package:ct484_final/screens/check_out/delivery_details/delivery_details.dart';
import 'package:ct484_final/widgets/single_item.dart';
import 'package:provider/provider.dart';

class CartReview extends StatelessWidget {
  // TODO: why add final here ?
  late ReviewCartProvider reviewCartProvider;

  CartReview({
    super.key,
  });
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Không"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Có"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Sản phẩm trong giỏ hàng"),
      content: const Text("Bạn muốn xóa sản phẩm trong giỏ hàng chứ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: const Text("Tổng số lượng sản phẩm"),
        subtitle: Text(
          "\$ ${reviewCartProvider.getTotalPrice()}",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            onPressed: () {
              if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Không có địa chỉ giao hàng được chọn");
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  // TODO: here
                  // DeliveryDetails
                  builder: (context) => const DeliveryDetails(),
                ),
              );
            },
            child: const Text("Gủi"),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Giỏ hàng",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? const Center(
              child: Text("Không có sản phẩm trong giỏ hàng"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider.getReviewCartDataList[index];
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SingleItem(
                      isBool: true,
                      wishList: false,
                      productImage: data.cartImage,
                      productName: data.cartName,
                      productPrice: data.cartPrice,
                      productId: data.cartId,
                      productQuantity: data.cartQuantity,
                      productUnit: data.cartUnit,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
