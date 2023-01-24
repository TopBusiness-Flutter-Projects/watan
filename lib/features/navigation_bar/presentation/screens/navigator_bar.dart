import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/features/home_page/presentation/screens/home_page.dart';
import 'package:elwatn/features/profile/presentation/screens/user_profile.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/no_login_page.dart';
import '../../../add/presentation/screens/add_screen.dart';
import '../../../add_project/presentation/Screens/add_project_screen.dart';
import '../../../chat/presentation/screens/conversation_screen/conversation_page.dart';
import '../../../favorite/presentation/screens/favorite.dart';
import '../../../login/data/models/login_data_model.dart';
import '../widgets/drawer_widget.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key, required this.loginDataModel})
      : super(key: key);
  final LoginDataModel loginDataModel;

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _page = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        closeDrawer: () => _scaffoldKey.currentState!.closeDrawer(),
        loginDataModel: widget.loginDataModel,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: [
          _page != 0
              ? const Icon(Icons.favorite_border, size: 30)
              : const Icon(Icons.favorite_border,
                  size: 40, color: Colors.white),
          _page != 1
              ? const Icon(Icons.person, size: 30)
              : const Icon(Icons.person, size: 40, color: Colors.white),
          _page != 2
              ? const Icon(Icons.home, size: 30)
              : const Icon(Icons.home, size: 40, color: Colors.white),
          _page != 3
              ? const Icon(Icons.chat, size: 30)
              : const Icon(Icons.chat, size: 40, color: Colors.white),
          _page != 4
              ? const Icon(Icons.add_box_sharp, size: 30)
              : const Icon(Icons.add_box_sharp, size: 40, color: Colors.white),
        ],
        color: Colors.white,
        buttonBackgroundColor: AppColors.primary,
        backgroundColor: AppColors.scaffoldBackground,
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 100),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: SafeArea(
        child: pages(),
      ),
    );
  }

  Widget pages() {
    if (_page == 0) {
      return widget.loginDataModel.message == null
          ? NotLoginPage()
          : FavoriteScreen();
    } else if (_page == 1) {
      return widget.loginDataModel.message == null
          ? NotLoginPage()
          : UserProfile(loginDataModel: widget.loginDataModel);
    } else if (_page == 2) {
      return HomePage(
        scaffoldKey: _scaffoldKey,
      );
    } else if (_page == 3) {
      return widget.loginDataModel.message == null
          ? NotLoginPage()
          : ConversationPage(loginDataModel: widget.loginDataModel);
    } else {
      return widget.loginDataModel.message == null
          ? NotLoginPage()
          : widget.loginDataModel.data!.user!.userType == 3
              ? AddProjectScreen()
              : AddScreen();
    }
  }
}
