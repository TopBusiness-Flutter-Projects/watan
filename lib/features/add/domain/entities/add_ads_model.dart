// To parse this JSON data, do
//
//     final openRoom = openRoomFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

String openRoomToJsonWithVideo(AddAdsModel data) =>
    json.encode(data.toJsonWithVideo());

String openRoomToJson(AddAdsModel data) =>
    json.encode(data.toJsonWithoutVideo());

class AddAdsModel {
  AddAdsModel({
    this.status,
    this.projectStatus,
    this.areaId,
    this.subAreaId,
    this.titleAr,
    this.titleEn,
    this.titleKu,
    this.descriptionAr,
    this.descriptionEn,
    this.descriptionKu,
    this.furniture,
    this.type,
    this.price,
    this.amenities,
    this.images,
    this.floorPlanesImage,
    this.floorPlans,
    this.videos,
    this.currency,
    this.size,
    this.bedroom,
    this.bathRoom,
    this.kitchen,
    this.livingRoom,
    this.diningRoom,
    this.latitude,
    this.longitude,
    this.locationNameAr,
    this.locationNameEn,
    this.locationNameKu,
    this.advertizerNameAr,
    this.advertizerNameEn,
    this.advertizerNameKu,
    this.phone,
    this.whatsapp,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.isFavourite,
    this.token,
    this.paymentTitleList,
    this.paymentPresentList,
    this.unitPlanAreaList,
    this.unitPlanBedroomList,
    this.unitPlanBathroomList,
    this.unitPlanPriceList,
    this.areaRange,
    this.maxPrice,
    this.minPrice,
    this.removedImage,
    this.removedFloors,
    this.removedVideo,
    this.removedUnitPlan,
    this.removedPaymentPlan,
    this.kindOfPost,
  });

  String? status;
  String? projectStatus;
  int? areaId;
  int? subAreaId;
  String? titleAr;
  String? titleEn;
  String? titleKu;
  String? descriptionAr;
  String? descriptionEn;
  String? descriptionKu;
  String? furniture;
  int? type;
  String? price;
  List<int>? amenities;
  List<MultipartFile>? images;
  List<MultipartFile>? floorPlanesImage;
  List<String>? floorPlans;
  List<String>? videos;
  String? currency;
  String? size;
  String? bedroom;
  String? bathRoom;
  String? kitchen;
  String? livingRoom;
  String? diningRoom;
  double? latitude;
  double? longitude;
  String? locationNameAr;
  String? locationNameEn;
  String? locationNameKu;
  String? advertizerNameAr;
  String? advertizerNameEn;
  String? advertizerNameKu;
  String? phone;
  String? whatsapp;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  bool? isFavourite;
  String? token;
  List<String>? paymentTitleList;
  List<String>? paymentPresentList;
  List<int>? unitPlanAreaList;
  List<String>? unitPlanBedroomList;
  List<String>? unitPlanBathroomList;
  List<int>? unitPlanPriceList;
  String? areaRange;
  String? maxPrice;
  String? minPrice;
  List<String>? removedImage;
  List<String>? removedFloors;
  List<String>? removedVideo;
  List<int>? removedUnitPlan;
  List<int>? removedPaymentPlan;
  String? kindOfPost;

  Future<Map<String, dynamic>> toJsonWithVideo() async => {
        "status": status,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "title_ar": titleAr,
        "phone_code": '+964',
        "title_en": titleEn,
        "title_ku": titleKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "description_ku": descriptionKu,
        "furniture": furniture,
        "type": type,
        "price": price,
        "amenities[]": amenities,
        "images[]": images,
        "videos[]": await MultipartFile.fromFile(videos!.first),
        "currency": currency,
        "size": size,
        "bedroom": bedroom,
        "bath_room": bathRoom,
        "kitchen": kitchen,
        "living_room": livingRoom,
        "dining_room": diningRoom,
        "latitude": latitude,
        "longitude": longitude,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "advertizer_name_ar": advertizerNameAr,
        "advertizer_name_en": advertizerNameEn,
        "advertizer_name_ku": advertizerNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
      };

  Future<Map<String, dynamic>> toJsonWithoutVideo() async => {
        "status": status,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "title_ar": titleAr,
        "phone_code": '+964',
        "title_en": titleEn,
        "title_ku": titleKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "description_ku": descriptionKu,
        "furniture": furniture,
        "type": type,
        "price": price,
        "amenities[]": amenities,
        "images[]": images,
        "currency": currency,
        "size": size,
        "bedroom": bedroom,
        "bath_room": bathRoom,
        "kitchen": kitchen,
        "living_room": livingRoom,
        "dining_room": diningRoom,
        "latitude": latitude,
        "longitude": longitude,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "advertizer_name_ar": advertizerNameAr,
        "advertizer_name_en": advertizerNameEn,
        "advertizer_name_ku": advertizerNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
        // "is_favourite": isFavourite,
      };

  Future<Map<String, dynamic>> toJsonProjectWithVideo() async => {
        "project_status": projectStatus,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "phone_code": '+964',
        "title_ar": titleAr,
        "title_en": titleEn,
        "title_ku": titleKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "description_ku": descriptionKu,
        "type": type,
        "amenities[]": amenities,
        "images[]": images,
        "floor_plans[]": floorPlanesImage,
        "videos[]": await MultipartFile.fromFile(videos!.first),
        "area_range": areaRange,
        "min_price": minPrice,
        "max_price": maxPrice,
        for (int i = 0; i < paymentTitleList!.length; i++)
          "payment_plans[$i][title]": paymentTitleList![i],
        for (int i = 0; i < paymentPresentList!.length; i++)
          "payment_plans[$i][percent]": paymentPresentList![i],
        for (int i = 0; i < unitPlanPriceList!.length; i++)
          "unit_details[$i][price]": unitPlanPriceList![i],
        for (int i = 0; i < unitPlanAreaList!.length; i++)
          "unit_details[$i][area]": unitPlanAreaList![i],
        for (int i = 0; i < unitPlanBedroomList!.length; i++)
          "unit_details[$i][bedrooms]": unitPlanBedroomList![i],
        for (int i = 0; i < unitPlanBathroomList!.length; i++)
          "unit_details[$i][bathrooms]": unitPlanBathroomList![i],
        "latitude": latitude,
        "longitude": longitude,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
      };

  Future<Map<String, dynamic>> toJsonProjectWithoutVideo() async => {
        "project_status": projectStatus,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "phone_code": '+964',
        "title_ar": titleAr,
        "title_en": titleEn,
        "title_ku": titleKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "description_ku": descriptionKu,
        "type": type,
        "amenities[]": amenities,
        "images[]": images,
        "floor_plans[]": floorPlanesImage,
        "area_range": areaRange,
        "min_price": minPrice,
        "max_price": maxPrice,
        for (int i = 0; i < paymentTitleList!.length; i++)
          "payment_plans[$i][title]": paymentTitleList![i],
        for (int i = 0; i < paymentPresentList!.length; i++)
          "payment_plans[$i][percent]": paymentPresentList![i],
        for (int i = 0; i < unitPlanPriceList!.length; i++)
          "unit_details[$i][price]": unitPlanPriceList![i],
        for (int i = 0; i < unitPlanAreaList!.length; i++)
          "unit_details[$i][area]": unitPlanAreaList![i],
        for (int i = 0; i < unitPlanBedroomList!.length; i++)
          "unit_details[$i][bedrooms]": unitPlanBedroomList![i],
        for (int i = 0; i < unitPlanBathroomList!.length; i++)
          "unit_details[$i][bathrooms]": unitPlanBathroomList![i],
        "latitude": latitude,
        "longitude": longitude,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
      };

  Future<Map<String, dynamic>> toJsonProjectWithVideoUpdate() async => {
        "project_status": projectStatus,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "phone_code": '+964',
        "title_ar": titleAr,
        "title_en": titleEn,
        "title_ku": titleKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "description_ku": descriptionKu,
        "type": type,
        "amenities[]": amenities,
        "images[]": images,
        "floor_plans[]": floorPlanesImage,
        "videos[]": await MultipartFile.fromFile(videos!.first),
        "area_range": areaRange,
        "min_price": minPrice,
        "max_price": maxPrice,
        for (int i = 0; i < paymentTitleList!.length; i++)
          "payment_plans[$i][title]": paymentTitleList![i],
        for (int i = 0; i < paymentPresentList!.length; i++)
          "payment_plans[$i][percent]": paymentPresentList![i],
        for (int i = 0; i < unitPlanPriceList!.length; i++)
          "unit_details[$i][price]": unitPlanPriceList![i],
        for (int i = 0; i < unitPlanAreaList!.length; i++)
          "unit_details[$i][area]": unitPlanAreaList![i],
        for (int i = 0; i < unitPlanBedroomList!.length; i++)
          "unit_details[$i][bedrooms]": unitPlanBedroomList![i],
        for (int i = 0; i < unitPlanBathroomList!.length; i++)
          "unit_details[$i][bathrooms]": unitPlanBathroomList![i],
        "latitude": latitude,
        "longitude": longitude,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
        "deleted_images[]": removedImage,
        "deleted_floor_plans[]": removedFloors,
        "deleted_videos[]": removedVideo,
        "deleted_payment_plans[]": removedPaymentPlan,
        "deleted_unit_details[]": removedUnitPlan,
      };

  Future<Map<String, dynamic>> toJsonProjectWithoutVideoUpdate() async => {
        "project_status": projectStatus,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "phone_code": '+964',
        "title_ar": titleAr,
        "title_en": titleEn,
        "title_ku": titleKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "description_ku": descriptionKu,
        "type": type,
        "amenities[]": amenities,
        "images[]": images,
        "floor_plans[]": floorPlanesImage,
        "area_range": areaRange,
        "min_price": minPrice,
        "max_price": maxPrice,
        for (int i = 0; i < paymentTitleList!.length; i++)
          "payment_plans[$i][title]": paymentTitleList![i],
        for (int i = 0; i < paymentPresentList!.length; i++)
          "payment_plans[$i][percent]": paymentPresentList![i],
        for (int i = 0; i < unitPlanPriceList!.length; i++)
          "unit_details[$i][price]": unitPlanPriceList![i],
        for (int i = 0; i < unitPlanAreaList!.length; i++)
          "unit_details[$i][area]": unitPlanAreaList![i],
        for (int i = 0; i < unitPlanBedroomList!.length; i++)
          "unit_details[$i][bedrooms]": unitPlanBedroomList![i],
        for (int i = 0; i < unitPlanBathroomList!.length; i++)
          "unit_details[$i][bathrooms]": unitPlanBathroomList![i],
        "latitude": latitude,
        "longitude": longitude,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
        "deleted_images[]": removedImage,
        "deleted_floor_plans[]": removedFloors,
        "deleted_videos[]": removedVideo,
        "deleted_payment_plans[]": removedPaymentPlan,
        "deleted_unit_details[]": removedUnitPlan,
      };

  Future<Map<String, dynamic>> toJsonWithVideoUpdate() async => {
        "status": status,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "title_ar": titleAr,
        "phone_code": '+964',
        "title_en": titleEn,
        "title_ku": titleKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "description_ku": descriptionKu,
        "furniture": furniture,
        "type": type,
        "price": price,
        "amenities[]": amenities,
        "images[]": images,
        "videos[]": await MultipartFile.fromFile(videos!.first),
        "currency": currency,
        "size": size,
        "bedroom": bedroom,
        "bath_room": bathRoom,
        "kitchen": kitchen,
        "living_room": livingRoom,
        "dining_room": diningRoom,
        "latitude": latitude,
        "longitude": longitude,
        "advertizer_name_ar": advertizerNameAr,
        "advertizer_name_en": advertizerNameEn,
        "advertizer_name_ku": advertizerNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
      };

  Future<Map<String, dynamic>> toJsonWithoutVideoUpdate() async => {
        "status": status,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "title_ar": titleAr,
        "phone_code": '+964',
        "title_en": titleEn,
        "title_ku": titleKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "description_ku": descriptionKu,
        "furniture": furniture,
        "type": type,
        "price": price,
        "amenities[]": amenities,
        "images[]": images,
        "currency": currency,
        "size": size,
        "bedroom": bedroom,
        "bath_room": bathRoom,
        "kitchen": kitchen,
        "living_room": livingRoom,
        "dining_room": diningRoom,
        "latitude": latitude,
        "longitude": longitude,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "advertizer_name_ar": advertizerNameAr,
        "advertizer_name_en": advertizerNameEn,
        "advertizer_name_ku": advertizerNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
      };
}
