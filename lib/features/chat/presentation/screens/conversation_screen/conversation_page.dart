import 'dart:convert';

import 'package:elwatn/features/chat/presentation/screens/chat_page.dart';
import 'package:elwatn/features/chat/presentation/screens/conversation_screen/widget/accounting_chat_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/translate_text_method.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../login/data/models/login_data_model.dart';
import '../../../data/models/MyRooms.dart';
import 'cubit/conversation_page_cubit.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key, required this.loginDataModel})
      : super(key: key);
  final LoginDataModel loginDataModel;

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  var hei, wid;

  int user_id = 0;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hei = size.height;
    wid = size.width;
    return Scaffold(
      backgroundColor: AppColors.grey2,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ConversationPageCubit>().getAllRoomsData();
        },
        child: buildBodySection(),
      ),
    );
  }

  buildBodySection() {
    return BlocBuilder<ConversationPageCubit, ConversationPageState>(
      builder: (context, state) {
        if (state is IsLoadingData) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else if (state is OnError) {
          return Center(
              child: InkWell(
            onTap: () =>
                context.read<ConversationPageCubit>().getAllRoomsData(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(ImageAssets.reloadIcon,
                    color: AppColors.primary, height: 24.0, width: 24.0),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'reload',
                  style: TextStyle(color: AppColors.primary, fontSize: 15.0),
                )
              ],
            ),
          ));
        } else {
          if (context
              .read<ConversationPageCubit>()
              .allMyRooms!
              .data!
              .isNotEmpty) {
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
                itemCount: context
                    .read<ConversationPageCubit>()
                    .allMyRooms!
                    .data!
                    .length,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  MyRoomsDatum model = context
                      .read<ConversationPageCubit>()
                      .allMyRooms!
                      .data![index];
                  return InkWell(
                    onTap: () => _onTaped(myRoomsDatum: model, index: index),
                    child: AccountingChatWidgets().buildListItem(
                      context: context,
                      model: model,
                      user_id: user_id,
                      index: index,
                    ),
                  );
                }));
          } else {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<ConversationPageCubit>().getAllRoomsData(),
              child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.longestSide,
                    child: Center(
                        child: Text(
                      translateText(AppStrings.noConversationsText, context),
                      style:
                          TextStyle(color: AppColors.black, fontSize: 15.0),
                    )),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }

  void _onTaped({required MyRoomsDatum myRoomsDatum, required int index}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(myRoomDatum: myRoomsDatum);
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    if (Routes.isLogout) {
      context.read<ConversationPageCubit>().getStoreUser().whenComplete(
            () => context
                .read<ConversationPageCubit>()
                .getAllRoomsData()
                .whenComplete(
                  () => Routes.isLogout = false,
                ),
          );
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      LoginDataModel loginDataModel = LoginDataModel.fromJson(userMap);
      print('object');
      print(loginDataModel.data!.user!.name);
      user_id = loginDataModel.data!.user!.id!;
      setState(() {
        user_id;
      });
    }
  }
}
