import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../data/models/main_item_data_model.dart';
import '../../data/models/main_project_item_data_model.dart';
import 'main_item_domain_model.dart';

MainProjectItem mainProjectItemFromJson(String str) =>
    MainProjectItemModel.fromJson(json.decode(str));

String mainProjectItemToJson(MainProjectItemModel data) =>
    json.encode(data.toJson());

class MainProjectItem extends Equatable {
  const MainProjectItem({
    required this.id,
    required this.name,
    required this.locationNameAr,
    required this.locationNameEn,
    required this.locationNameKu,
    required this.phone,
    required this.whatsapp,
    required this.titleAr,
    required this.descriptionAr,
    required this.titleEn,
    required this.descriptionEn,
    required this.titleKu,
    required this.descriptionKu,
    required this.views,
    required this.type,
    required this.companyId,
    required this.agentId,
    required this.userId,
    required this.categoryId,
    required this.subCategoryId,
    required this.areaId,
    required this.subAreaId,
    required this.latitude,
    required this.longitude,
    required this.minPrice,
    required this.maxPrice,
    required this.projectStatus,
    required this.areaRange,
    required this.minPriceOfMeter,
    required this.maxPriceOfMeter,
    required this.desc,
    required this.paymentTerms,
    required this.paymentDetails,
    required this.isInvested,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.agent,
    required this.services,
    required this.currency,
    required this.videos,
    required this.floorPlans,
    required this.paymentPlans,
    required this.unitDetails,
    required this.user,
    required this.isFavourite,
  });

  final int? id;
  final String? name;
  final String? locationNameAr;
  final String? locationNameEn;
  final String? locationNameKu;
  final String? phone;
  final String? whatsapp;
  final String? titleAr;
  final String? descriptionAr;
  final String? titleEn;
  final String? descriptionEn;
  final String? titleKu;
  final String? descriptionKu;
  final int? views;
  final String? type;
  final int? companyId;
  final int? agentId;
  final int? userId;
  final int? categoryId;
  final int? subCategoryId;
  final int? areaId;
  final int? subAreaId;
  final double? latitude;
  final double? longitude;
  final String? minPrice;
  final String? maxPrice;
  final String? projectStatus;
  final String? areaRange;
  final String? minPriceOfMeter;
  final String? maxPriceOfMeter;
  final String? desc;
  final String? paymentTerms;
  final String? paymentDetails;
  final String? isInvested;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<FloorPlan>? images;
  final AgentModel? agent;
  final List<ServiceItemsModel>? services;
  final String currency;
  final List<Video> videos;
  final List<FloorPlan>? floorPlans;
  final List<PaymentPlan> paymentPlans;
  final List<List<UnitDetail>> unitDetails;
  final MainItemUserModel user;
  final bool? isFavourite;

  @override
  List<Object?> get props => [
        id,
        name,
        locationNameAr,
        locationNameEn,
        locationNameKu,
        phone,
        whatsapp,
        titleAr,
        descriptionAr,
        titleEn,
        descriptionEn,
        titleKu,
        descriptionKu,
        views,
        type,
        companyId,
        agentId,
        userId,
        categoryId,
        subCategoryId,
        areaId,
        subAreaId,
        latitude,
        longitude,
        minPrice,
        maxPrice,
        projectStatus,
        areaRange,
        minPriceOfMeter,
        maxPriceOfMeter,
        desc,
        paymentTerms,
        paymentDetails,
        isInvested,
        createdAt,
        updatedAt,
        images,
        agent,
        services,
        currency,
        videos,
        floorPlans,
        paymentPlans,
        unitDetails,
        user,
        isFavourite,
      ];
}

class Video extends Equatable {
  Video({
    required this.id,
    required this.projectId,
    required this.postId,
    required this.attachment,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? projectId;
  int? postId;
  String? attachment;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        projectId: json["project_id"],
        postId: json["post_id"],
        attachment: json["attachment"],
        type: json["type"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime(0),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime(0),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "post_id": postId,
        "attachment": attachment,
        "type": type,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        projectId,
        postId,
        attachment,
        type,
        createdAt,
        updatedAt,
      ];
}

class PaymentPlan extends Equatable {
  PaymentPlan({
    required this.id,
    required this.projectId,
    required this.title,
    required this.percent,
  });

  final int id;
  final int projectId;
  final String title;
  final String percent;

  factory PaymentPlan.fromJson(Map<String, dynamic> json) => PaymentPlan(
        id: json["id"],
        projectId: json["project_id"],
        title: json["title"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "title": title,
        "percent": percent,
      };

  @override
  List<Object?> get props => [
        id,
        projectId,
        title,
        percent,
      ];
}

class UnitDetail extends Equatable {
  UnitDetail({
    required this.id,
    required this.price,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
  });

  int? id;
  int? price;
  String? area;
  String? bedrooms;
  String? bathrooms;

  factory UnitDetail.fromJson(Map<String, dynamic> json) => UnitDetail(
        id: json["id"],
        price: json["price"],
        area: json["area"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "area": area,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
      };

  @override
  List<Object?> get props => [
        id,
        price,
        area,
        bedrooms,
        bathrooms,
      ];
}
