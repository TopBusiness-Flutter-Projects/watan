import 'dart:async';
import 'dart:convert';

import 'package:elwatn/config/routes/app_routes.dart';
import 'package:elwatn/features/chat/presentation/screens/chat_page.dart';
import 'package:elwatn/features/navigation_bar/presentation/screens/navigator_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../login/data/models/login_data_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  LoginDataModel loginDataModel = const LoginDataModel();

  _goNext() {
    if (Routes.chatModel != null) {
      print('Routes.chatModel');
      print(Routes.chatModel);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: ChatPage(
            myRoomDatum: Routes.chatModel!,
          ),
        ),
      ).then(
        (value) {
          Routes.chatModel = null;
          print('Routes.chatModel');
          print(Routes.chatModel);
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 1300),
              child: NavigatorBar(
                loginDataModel: loginDataModel,
              ),
            ),
          );
        },
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: NavigatorBar(
            loginDataModel: loginDataModel,
          ),
        ),
      );
    }
  }

  _startDelay() async {
    if (await Permission.location.request().isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      print(statuses[Permission.location]);
    }
    if (await Permission.storage.request().isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.storage]);
    }

    _timer = Timer(const Duration(milliseconds: 3000), () => _goNext());
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      LoginDataModel loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    }
  }

  @override
  void initState() {
    super.initState();
    _getStoreUser().then((value) => _startDelay());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              ImageAssets.watanLogo,
            ),
          ),
        ],
      ),
    );
  }
}
