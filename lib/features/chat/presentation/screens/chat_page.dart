import 'dart:async';
import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elwatn/config/routes/app_routes.dart';
import 'package:elwatn/features/chat/presentation/screens/conversation_screen/cubit/conversation_page_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../../notification/presentation/widgets/notificationlisten.dart';
import '../../data/models/MyRooms.dart';

class ChatPage extends StatefulWidget {
  final MyRoomsDatum myRoomDatum;

  const ChatPage({Key? key, required this.myRoomDatum}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String message = "";
  int user_id = 0;

  // bool isCubit = false;
  bool needscroll = true;
  double current = 0;
  late Stream<LocalNotification> _notificationsStream;
  final TextEditingController _controller = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();

  var hei, wid;
  late ConversationPageCubit cubit;

  bool isend = false;

  int position = 0;

  @override
  initState() {
    super.initState();
    _onRefresh();
    AppRoutes.route = 'chat';
    context
        .read<ConversationPageCubit>()
        .getOneRoomData(widget.myRoomDatum.id.toString());
    _notificationsStream = NotificationsBloc.instance.notificationsStream;
    _notificationsStream.listen((event) {
      print('Er0000r : stream1111');
      if (mounted) {
        if (!context.read<ConversationPageCubit>().isCubit) {
          print('Er0000r : stream2222');
          context.read<ConversationPageCubit>().emitTheSuccess(
                context.read<ConversationPageCubit>().allMessages,
                MyMessage.fromJson(event.data),
              );
        }
      }
    });
  }

  @override
  void dispose() {
    AppRoutes.route = '';
    Routes.chatModel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hei = size.height;
    wid = size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            widget.myRoomDatum.fromUserId != user_id
                ? widget.myRoomDatum.fromUser!.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.myRoomDatum.fromUser!.image,
                        placeholder: (context, url) =>
                            _buildAvatar(width: 48.0, height: 48.0),
                        errorWidget: (context, url, error) =>
                            _buildAvatar(width: 48.0, height: 48.0),
                        width: 48,
                        height: 48,
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 48.0,
                          );
                        },
                      )
                    : _buildAvatar(width: 48.0, height: 48.0)
                : widget.myRoomDatum.toUser!.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.myRoomDatum.toUser!.image,
                        placeholder: (context, url) =>
                            _buildAvatar(width: 48.0, height: 48.0),
                        errorWidget: (context, url, error) =>
                            _buildAvatar(width: 48.0, height: 48.0),
                        width: 48,
                        height: 48,
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 48.0,
                          );
                        },
                      )
                    : _buildAvatar(width: 48.0, height: 48.0),
            const SizedBox(width: 12),
            Text(
              widget.myRoomDatum.fromUserId == user_id
                  ? widget.myRoomDatum.toUser!.name
                  : widget.myRoomDatum.fromUser!.name,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
      backgroundColor: AppColors.grey2,
      body: buildBodySection(),
    );
  }

  buildBodySection() {
    cubit = BlocProvider.of<ConversationPageCubit>(context);
    return Column(
      children: [
        Expanded(
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(180 / 360),
            child: Column(
              children: [
                Expanded(
                  child:
                      BlocBuilder<ConversationPageCubit, ConversationPageState>(
                    builder: (context, state) {
                      if (state is OneRoomLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      } else if (state is OneRoomError) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<ConversationPageCubit>()
                                .getAllRoomsData();
                          },
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.reloadIcon,
                                  color: AppColors.primary,
                                  height: 24.0,
                                  width: 24.0,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                RotationTransition(
                                  turns:
                                      const AlwaysStoppedAnimation(180 / 360),
                                  child: Text(
                                    'reload',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return ScrollablePositionedList.separated(
                          itemScrollController: _scrollController,
                          itemCount: context
                                  .read<ConversationPageCubit>()
                                  .allMessages
                                  .length +
                              1,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index <
                                    context
                                        .read<ConversationPageCubit>()
                                        .allMessages
                                        .length &&
                                context
                                        .read<ConversationPageCubit>()
                                        .allMessages[index]
                                        .fromUserId !=
                                    0) {
                              MyMessage model = context
                                  .read<ConversationPageCubit>()
                                  .allMessages[index];

                              bool isMe = model.fromUserId == user_id;

                              return RotationTransition(
                                turns: const AlwaysStoppedAnimation(180 / 360),
                                child: Align(
                                    alignment: isMe
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Bubble(
                                      color: isMe
                                          ? model.type!.contains("file")
                                              ? AppColors.primary
                                              : AppColors.primary
                                          : model.type!.contains("file")
                                              ? AppColors.grey4
                                              : AppColors.grey4,
                                      margin: const BubbleEdges.only(top: 10),
                                      nip: isMe
                                          ? BubbleNip.rightBottom
                                          : BubbleNip.leftBottom,
                                      elevation:
                                          model.type!.contains("file") ? 0 : 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: (model.type!.contains("file")
                                            ? CachedNetworkImage(
                                                height: 290,
                                                imageUrl: model.file!,
                                                placeholder: (context, url) =>
                                                    Container(
                                                      color: AppColors.gray,
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                          color: AppColors.gray,
                                                        ))
                                            : Text(
                                                model.message!,
                                                softWrap: true,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ),
                                              )),
                                      ),
                                    )),
                              );
                            } else {
                              return Container();
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container();
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        buildBottom()
      ],
    );
  }

  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Photo',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  height: 1,
                  color: AppColors.gray,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                InkWell(
                  onTap: () {
                    needscroll = true;
                    Navigator.pop(context);
                    context.read<ConversationPageCubit>().pickImage(
                          type: 'camera',
                          myRoomsDatum: widget.myRoomDatum,
                        );
                  },
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 18.0, color: AppColors.black),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                InkWell(
                  onTap: () {
                    needscroll = true;
                    Navigator.pop(context);
                    context.read<ConversationPageCubit>().pickImage(
                          type: 'gallery',
                          myRoomsDatum: widget.myRoomDatum,
                        );
                  },
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 18.0, color: AppColors.black),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  height: 1,
                  color: AppColors.gray,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18.0, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          );
        });
  }

  buildBottom() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.photo),
          color: Theme.of(context).primaryColor,
          iconSize: 25.0,
          onPressed: () {
            buildAlertDialog();
          },
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.gray),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              controller: _controller,
              onChanged: (value) {
                message = value;
              },
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          color: Theme.of(context).primaryColor,
          iconSize: 25.0,
          onPressed: () {
            context.read<ConversationPageCubit>().isCubit = true;
            needscroll = true;
            context.read<ConversationPageCubit>().imageType = 'text';
            context
                .read<ConversationPageCubit>()
                .sendMessage(message, widget.myRoomDatum)
                .whenComplete(() {
              Future.delayed(Duration(milliseconds: 500), () {
                context.read<ConversationPageCubit>().isCubit = false;
              });
            });
            message = "";
            _controller.clear();
          },
        ),
      ],
    );
  }

  Future<void> _onRefresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      LoginDataModel loginDataModel = LoginDataModel.fromJson(userMap);
      user_id = loginDataModel.data!.user!.id!;
      setState(
        () {
          user_id;
        },
      );
    }
  }

  Widget _buildAvatar({required double width, required double height}) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width),
        child: Image.asset(
          ImageAssets.avatarImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
