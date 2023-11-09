import 'package:carousel_slider/carousel_slider.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/home_page/domain/entities/slider_domain_model.dart';
import '../../features/home_page/presentation/widgets/dotes.dart';

// ignore: must_be_immutable
class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key, this.isDotes = true, required this.sliderData})
      : super(key: key);
  final List<Datum> sliderData;
  final bool isDotes;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.sliderData.isEmpty) {
      return Image.asset(ImageAssets.watanLogo);
    } else {
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                onPageChanged: (int i, CarouselPageChangedReason c) {
                  setState(() {
                    page = i;
                  });
                },
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlay: true,
                height: MediaQuery.of(context).size.height * 0.25,
                reverse: false,
                viewportFraction: 1.0),
            items: widget.sliderData.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () async {
                      String url = i.link.toString();
                      await launchUrl(Uri.parse(url));
                    },
                    child: ManageNetworkImage(
                      imageUrl: i.image!,
                      borderRadius: 0,
                      width: double.infinity,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          widget.isDotes == true
              ? const SizedBox(height: 18)
              : const SizedBox(height: 0),
          widget.isDotes == true
              ? DotesWidget(
                  page: page,
                  length: widget.sliderData.length,
                )
              : Container(),
        ],
      );
    }
  }
}
