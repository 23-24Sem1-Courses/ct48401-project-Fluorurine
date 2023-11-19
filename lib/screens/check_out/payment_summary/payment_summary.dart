import 'package:ct484_final/services/check_out_provider.dart';
import 'package:flutter/material.dart';
import 'package:ct484_final/config/colors.dart';
import 'package:ct484_final/models/delivery_address_model.dart';
import 'package:ct484_final/services/review_cart_provider.dart';
import 'package:ct484_final/screens/check_out/delivery_detail/delivery_item.dart';
import 'package:ct484_final/screens/check_out/payment_summary/order_item.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;
  const PaymentSummary({super.key, required this.deliverAddressList});

  @override
  PaymentSummaryState createState() => PaymentSummaryState();
}

enum AddressTypes {
  Home,
  OnlinePayment,
}

//  Simple logic for the PaymentSummary widget just checking and await later implement of payment service
class PaymentSummaryState extends State<PaymentSummary> {
  AddressTypes? myType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    CheckoutProvider checkoutProvider = Provider.of(context);
    double discount = 30;
    double discountValue = 0.0;
    double shippingChanrge = 3.7;
    double total = 0;
    double totalPrice = reviewCartProvider.getTotalPrice();
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tông kết thanh toán",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: const Text("Tổng tiền trả"),
        subtitle: Text(
          "\$${total + 5 ?? totalPrice}",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              checkoutProvider.addPlaceOderData(
                  oderItemList: reviewCartProvider.getReviewCartDataList,
                  subTotal: totalPrice);
              print("Đã thanh toán");
            },
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Đặt hàng",
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                DeliveryItem(
                  address:
                      "Khu vực, ${widget.deliverAddressList.aera}, Đường, ${widget.deliverAddressList.street}, Thành phố ${widget.deliverAddressList.scoirty}, Mã PIN ${widget.deliverAddressList.pinCode}",
                  title:
                      "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                  number: widget.deliverAddressList.mobileNo,
                  addressType: widget.deliverAddressList.addressType ==
                          "AddressTypes.Home"
                      ? "Home"
                      : widget.deliverAddressList.addressType ==
                              "AddressTypes.Other"
                          ? "Other"
                          : "Work",
                ),
                const Divider(),
                ExpansionTile(
                  title: Text(
                      "Số lượng: ${reviewCartProvider.getReviewCartDataList.length}"),
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(
                      e: e,
                    );
                  }).toList(),
                ),
                const Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: const Text(
                    "Tổng tiền",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "\$${totalPrice + 5}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Phí vận chuyển",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "\$$discountValue",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Tổng tiên giảm giá",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: const Text(
                    "\$10",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                const ListTile(
                  leading: Text("Phương thức thanh taons"),
                ),
                RadioListTile(
                  value: AddressTypes.Home,
                  groupValue: myType,
                  title: const Text("Nhà riêng"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Icon(
                    Icons.work,
                    color: primaryColor,
                  ),
                ),
                RadioListTile(
                  value: AddressTypes.OnlinePayment,
                  groupValue: myType,
                  title: const Text("Thanh toán trực tuyến"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Icon(
                    Icons.devices_other,
                    color: primaryColor,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
