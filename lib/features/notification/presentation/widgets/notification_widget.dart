import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/notifications_model.dart';

class NotificationModelWidget extends StatelessWidget {
  const NotificationModelWidget({Key? key, required this.notificationsDatum}) : super(key: key);
  final NotificationsDatum notificationsDatum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 18,horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
              ),
              child: Image.asset(
                ImageAssets.watanLogoImage,
                width: 80,
                height: 80,
              ),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notificationsDatum.title!),
                  SizedBox(height: 18),
                  Text(notificationsDatum.message!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
