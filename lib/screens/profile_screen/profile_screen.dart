import 'package:ct484_final/auth/sign_in.dart';
import 'package:ct484_final/screens/check_out/delivery_detail/delivery_detail.dart';
import 'package:flutter/material.dart';
import 'package:ct484_final/config/colors.dart';
import 'package:ct484_final/services/user_provider.dart';
import 'package:ct484_final/screens/home/side_drawer.dart';

//This screen is use to display user profile and the link to other manage system/ if the user is admin it will display addtion page to admin manage system
class ProfileScreen extends StatefulWidget {
  final UserProvider userProvider;

  const ProfileScreen({super.key, required this.userProvider});

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<ProfileScreen> {
  Widget listTile({required icon, required String title}) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;

    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Trang cá nhân",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
      drawer: SideDrawer(
        userProvider: widget.userProvider,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: Colors.blue[300],
              ),
              Container(
                height: 548,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 280,
                          height: 80,
                          padding: const EdgeInsets.only(left: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.userName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    userData.userEmail,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: primaryColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: scaffoldBackgroundColor,
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    listTile(
                        icon: Icons.shop_outlined, title: "Đơn hàng của tôi"),
                    GestureDetector(
                      child: listTile(
                          icon: Icons.location_on_outlined,
                          title: "Địa chỉ liên hệ"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DeliveryDetails()));
                      },
                    ),
                    listTile(
                        icon: Icons.person_outline, title: "Đề xuất bạn bè"),
                    listTile(
                        icon: Icons.file_copy_outlined,
                        title: "Điều khoản và điểu kiện"),
                    listTile(
                        icon: Icons.policy_outlined,
                        title: "Chính sách dịch vu"),
                    listTile(icon: Icons.add_chart, title: "About"),
                    GestureDetector(
                        child: listTile(
                            icon: Icons.exit_to_app_outlined,
                            title: "Đăng xuất"),
                        onTap: () {
                          widget.userProvider.signOut();
                          // go back to login screen

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        }),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue[300],
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userData.userImage ??
                        "https://s3.envato.com/files/328957910/vegi_thumb.png",
                  ),
                  radius: 45,
                  backgroundColor: Colors.blue[300]),
            ),
          )
        ],
      ),
    );
  }
}
