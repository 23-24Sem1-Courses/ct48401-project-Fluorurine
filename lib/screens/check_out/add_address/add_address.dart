import 'package:flutter/material.dart';
import 'package:ct484_final/config/colors.dart';
import 'package:ct484_final/services/check_out_provider.dart';
import 'package:ct484_final/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliverAddress extends StatefulWidget {
  const AddDeliverAddress({super.key});

  @override
  AddDeliverAddressState createState() => AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class AddDeliverAddressState extends State<AddDeliverAddress> {
  AddressTypes? myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context, myType);
                },
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CustomTextField(
              labText: "Họ",
              controller: checkoutProvider.firstName,
            ),
            CustomTextField(
              labText: "Tên",
              controller: checkoutProvider.lastName,
            ),
            CustomTextField(
              labText: "Số điện thoại",
              controller: checkoutProvider.mobileNo,
            ),
            CustomTextField(
              labText: "Số điện thoại thay thế",
              controller: checkoutProvider.alternateMobileNo,
            ),
            CustomTextField(
              labText: "Tỉnh",
              controller: checkoutProvider.scoiety,
            ),
            CustomTextField(
              labText: "Đường",
              controller: checkoutProvider.street,
            ),
            CustomTextField(
              labText: "Só nhà",
              controller: checkoutProvider.landmark,
            ),
            CustomTextField(
              labText: "Thành phố",
              controller: checkoutProvider.city,
            ),
            CustomTextField(
              labText: "Khu vực",
              controller: checkoutProvider.aera,
            ),
            CustomTextField(
              labText: "Mã PIN",
              controller: checkoutProvider.pincode,
            ),
            InkWell(
              onTap: () {},
              child: const SizedBox(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const ListTile(
              title: Text("Loại địa chỉ*"),
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
                Icons.home,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: const Text("Làm việc"),
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
              value: AddressTypes.Other,
              groupValue: myType,
              title: const Text("Khác"),
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
        ),
      ),
    );
  }
}
