import 'package:elwatn/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat/data/models/MyRooms.dart';
import '../../../chat/presentation/cubit/chat_cubit.dart';
import '../../../chat/presentation/screens/chat_page.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(MyRoomsDatum chatModel) {
    return navigationKey.currentState!.push(
      MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ChatCubit(),
            child: ChatPage(
              myRoomDatum: chatModel,
            ),
          )),
    );
  }

  Future<dynamic> navigateToNotification() {
    return navigationKey.currentState!.pushNamed(
      Routes.notificationRoute,
    );
  }

  goback() {
    return navigationKey.currentState!.pop();
  }
}
