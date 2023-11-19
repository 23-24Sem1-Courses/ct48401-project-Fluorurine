import 'package:flutter/material.dart';
import 'package:ct484_final/config/colors.dart';
import 'package:ct484_final/services/user_provider.dart';
import 'package:ct484_final/screens/home/home_screen.dart';
import 'package:ct484_final/screens/profile_screen/profile_screen.dart';
import 'package:ct484_final/screens/cart/cart_review.dart';
import 'package:ct484_final/screens/wish_list/wish_list.dart';

// This is drawer side that use at the side of home screen
class SideDrawer extends StatefulWidget {
  final UserProvider userProvider;

  const SideDrawer({super.key, required this.userProvider});
  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<SideDrawer> {
  Widget listTile(
      // onTap no parameter and dynamic return value must use Function()?
      {required String title,
      required IconData iconData,
      Function()? onTap}) {
    return SizedBox(
      height: 50,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          iconData,
          size: 28,
        ),
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        color: primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.white54,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        backgroundImage: NetworkImage(
                          userData.userImage ??
                              "https://s3.envato.com/files/328957910/vegi_thumb.png",
                        ),
                        radius: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userData.userName),
                        Text(
                          userData.userEmail,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            listTile(
              iconData: Icons.home_outlined,
              title: "Trang chủ",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            listTile(
              iconData: Icons.shop_outlined,
              title: "Giỏ hàng",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartReview(),
                  ),
                );
              },
            ),
            listTile(
              iconData: Icons.person_outlined,
              title: "Trang cá nhân",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(userProvider: widget.userProvider),
                  ),
                );
              },
            ),
            listTile(
                iconData: Icons.notifications_outlined, title: "Thông báo"),
            listTile(
                iconData: Icons.star_outline, title: "Đánh giá và bình luận"),
            listTile(
                iconData: Icons.favorite_outline,
                title: "Danh sách mua sắm",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WishLsit(),
                    ),
                  );
                }),
            listTile(iconData: Icons.copy_outlined, title: "Phản hồi"),
            listTile(iconData: Icons.format_quote_outlined, title: "FAQs"),
            Container(
              height: 350,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Liên hệ hỗ trợ"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Gọi đến:"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("+9412345678"),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text("Gửi Mail:"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "truongb2111871@student.ctu.edu.vn",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
