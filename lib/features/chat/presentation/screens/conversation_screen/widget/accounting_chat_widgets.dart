import 'package:cached_network_image/cached_network_image.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../data/models/MyRooms.dart';

class AccountingChatWidgets {
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

  Widget buildListItem(
      {required BuildContext context,
      required MyRoomsDatum model,
      required int user_id,
      required int index}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: model.fromUser!.id == user_id
                ? model.toUser!.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: model.toUser!.image,
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
                : model.fromUser!.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: model.fromUser!.image,
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
            title: Text(
              model.toUser!.id == user_id
                  ? model.fromUser!.name
                  : model.toUser!.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: AppColors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(model.lastMessage != null
                ? model.lastMessage!.type!.contains("file")
                    ? "Attachment"
                    : model.lastMessage!.message!
                : ""),
            trailing: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      model.lastMessage!= null
                          ? model.lastMessage!.date!.toString().substring(0, 10)
                          : " ",
                      style: const TextStyle(
                          fontSize: 13.0, color: AppColors.color1),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      model.lastMessage!=null
                          ? model.lastMessage!.time!
                          : "",
                      style: const TextStyle(
                          fontSize: 12.0, color: AppColors.color1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Divider(
            color: AppColors.grey4,
          )
        ],
      ),
    );
  }
}
