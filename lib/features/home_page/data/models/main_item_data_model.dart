import 'package:dio/dio.dart';

import '../../domain/entities/main_item_domain_model.dart';

class MainItemModel extends MainItem {
  const MainItemModel({
    required super.id,
    required super.status,
    required super.phone,
    required super.phoneCode,
    required super.views,
    required super.titleAr,
    required super.descriptionAr,
    required super.titleEn,
    required super.descriptionEn,
    required super.titleKu,
    required super.descriptionKu,
    required super.furniture,
    required super.price,
    required super.currency,
    required super.size,
    required super.bedroom,
    required super.bathRoom,
    required super.kitchen,
    required super.diningRoom,
    required super.advertizerNameAr,
    required super.advertizerNameEn,
    required super.advertizerNameKu,
    required super.whatsapp,
    required super.latitude,
    required super.longitude,
    required super.isSold,
    required super.isInvesBed,
    required super.agentId,
    required super.companyId,
    required super.areaId,
    required super.subAreaId,
    required super.categoryId,
    required super.subCategoryId,
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
    required super.images,
    required super.agent,
    required super.company,
    required super.floorPlans,
    required super.videos,
    required super.type,
    required super.locationNameAr,
    required super.locationNameEn,
    required super.locationNameKu,
    required super.services,
    required super.userModel,
    required super.livingRoom,
    required super.isFavourite,
  });

  factory MainItemModel.fromJson(Map<String, dynamic> json) => MainItemModel(
        id: json["id"],
        status: json["status"],
        phone: json["phone"],
        phoneCode: json["phone_code"],
        views: json["views"],
        titleAr: json["title_ar"],
        descriptionAr: json["description_ar"] ?? "بدون وصف",
        titleEn: json["title_en"],
        descriptionEn: json["description_en"] ?? "No Description ",
        titleKu: json["title_ku"],
        descriptionKu: json["description_ku"] ?? "هیچ وەسفێک نییە",
        furniture: json["furniture"],
        type: json["type"],
        price: json["price"],
        currency: json["currency"],
        size: json["size"],
        bedroom: json["bedroom"],
        kitchen: json["kitchen"],
        livingRoom: json["living_room"],
        diningRoom: json["dining_room"],
        bathRoom: json["bath_room"] == null ? null : json["bath_room"],
        advertizerNameAr: json["advertizer_name_ar"],
        advertizerNameEn: json["advertizer_name_en"],
        advertizerNameKu: json["advertizer_name_ku"],
        whatsapp: json["whatsapp"],
        latitude: json["latitude"] == 0 ? 0.0 : json["latitude"],
        longitude: json["longitude"] == 0 ? 0.0 : json["longitude"],
        locationNameAr: json["location_name_ar"] ?? "لا يوجد موقع",
        locationNameEn: json["location_name_en"] ?? "No Location",
        locationNameKu: json["location_name_ku"] ?? "هیچ سایتێک نییە",
        isSold: json["is_sold"],
        isInvesBed: json["is_inves_bed"],
        agentId: json["agent_id"],
        companyId: json["company_id"],
        areaId: json["area_id"],
        subAreaId: json["sub_area_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        userModel: json["user"] != null
            ? MainItemUserModel.fromJson(json["user"])
            : MainItemUserModel(),
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavourite: json["is_favourite"],
        images: List<FloorPlan>.from(
            json["images"].map((x) => FloorPlan.fromJson(x))),
        videos: List<FloorPlan>.from(
            json["videos"].map((x) => FloorPlan.fromJson(x))),
        // videos: json["videos"] != null
        //     ? List<FloorPlan>.from(json["videos"].map((x) => x))
        //     : [],
        floorPlans: json["floor_plans"] != null
            ? List<FloorPlan>.from(
                json["floor_plans"].map((x) => FloorPlan.fromJson(x)))
            : [],
        agent: json["agent"] == null
            ? const AgentModel(
                name: "لا يوجد اسم وكيل",
              )
            : AgentModel.fromJson(json["agent"]),
        company: json["company"] != null
            ? CompanyModel.fromJson(json["company"])
            : const CompanyModel(),
        services: List<ServiceItemsModel>.from(
            json["services"].map((x) => ServiceItemsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "phone": phone,
        "phone_code": phoneCode,
        "views": views,
        "title_ar": titleAr,
        "description_ar": descriptionAr,
        "title_en": titleEn,
        "description_en": descriptionEn,
        "title_ku": titleKu,
        "description_ku": descriptionKu,
        "furniture": furniture,
        "type": type,
        "price": price,
        "currency": currency,
        "size": size,
        "bedroom": bedroom,
        "kitchen": kitchen,
        "living_room": livingRoom,
        "dining_room": diningRoom,
        "bath_room": bathRoom == null ? null : bathRoom,
        "advertizer_name_ar": advertizerNameAr,
        "advertizer_name_en": advertizerNameEn,
        "advertizer_name_ku": advertizerNameKu,
        "whatsapp": whatsapp,
        "latitude": latitude,
        "longitude": longitude,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "is_sold": isSold,
        "is_inves_bed": isInvesBed,
        "agent_id": agentId,
        "company_id": companyId,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "images": List<FloorPlan>.from(images!.map((x) => x.toJson())),
        "videos": List<FloorPlan>.from(videos!.map((x) => x)),
        "floor_plans": List<FloorPlan>.from(floorPlans!.map((x) => x.toJson())),
        "agent": agent == null ? null : agent!.toJson(),
        "user": userModel!.toJson(),
        "company": company!.toJson(),
        "is_favourite": isFavourite,
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class AgentModel extends Agent {
  const AgentModel({
    super.id,
    super.name,
    super.email,
    super.password,
    super.image,
    super.about,
    super.phone,
    super.languages,
    super.phoneCode,
    super.whatsapp,
    super.userId,
    super.companyId,
    super.createdAt,
    super.updatedAt,
    super.facebook,
    super.instagram,
    super.twitter,
    super.snapchat,
    super.token,
    super.method,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
        id: json["id"],
        name: json["name"] ?? "لا يوجد اسم وكيل",
        image: json["image"],
        about: json["about"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        languages: json["languages"] != null
            ? List<String>.from(json["languages"].map((x) => x ?? ""))
            : [],
        phoneCode: json["phone_code"],
        whatsapp: json["whatsapp"],
        userId: json["user_id"],
        companyId: json["company_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        snapchat: json["snapchat"],
        method: json["_method"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "about": about,
        "phone": phone,
        "email": email,
        "password": password,
        "phone_code": phoneCode,
        "whatsapp": whatsapp,
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "user_id": userId,
        "company_id": companyId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "_method": method,
      };

  Future<Map<String, dynamic>> postToJson() async => {
        "name": name,
        "about": about,
        "phone": phone,
        "email": email,
        "password": password,
        "phone_code": phoneCode,
        "whatsapp": whatsapp,
        "languages[]": languages,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "image": image != null ? await MultipartFile.fromFile(image!) : "",
        "_method": method,
      };

  Future<Map<String, dynamic>> editToJson() async => {
        "name": name,
        "about": about,
        "phone": phone,
        "email": email,
        "password": password,
        "phone_code": phoneCode,
        "whatsapp": whatsapp,
        "languages[]": languages,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "_method": method,
      };
}

class FloorPlanModel extends FloorPlan {
  const FloorPlanModel(
      {required super.id,
      required super.projectId,
      required super.postId,
      required super.attachment,
      required super.type,
      required super.createdAt,
      required super.updatedAt});

  factory FloorPlanModel.fromJson(Map<String, dynamic> json) => FloorPlanModel(
        id: json["id"],
        projectId: json["project_id"],
        postId: json["post_id"],
        attachment: json["attachment"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "post_id": postId,
        "attachment": attachment,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CompanyModel extends Company {
  const CompanyModel(
      {super.id,
      super.facebook,
      super.instagram,
      super.twitter,
      super.snapchat,
      super.latitude,
      super.longitude,
      super.aboutAr,
      super.aboutEn,
      super.userId,
      super.createdAt,
      super.updatedAt});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json["id"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        snapchat: json["snapchat"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        aboutAr: json["about_ar"],
        aboutEn: json["about_en"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "latitude": latitude,
        "longitude": longitude,
        "about_ar": aboutAr,
        "about_en": aboutEn,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ServiceItemsModel extends ServiceItems {
  const ServiceItemsModel(
      {required super.id,
      required super.serviceId,
      required super.postId,
      required super.projectId,
      required super.service,
      required super.createdAt,
      required super.updatedAt});

  factory ServiceItemsModel.fromJson(Map<String, dynamic> json) =>
      ServiceItemsModel(
        id: json["id"],
        serviceId: json["service_id"],
        postId: json["post_id"],
        projectId: json["project_id"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime(0),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime(0),
        service: json["service"] != null
            ? ServicesItemDataModel.fromJson(json["service"])
            : const ServicesItemDataModel(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "post_id": postId,
        "project_id": projectId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "service": service!.toJson(),
      };
}

class ServicesItemDataModel extends ServicesItemData {
  const ServicesItemDataModel(
      {super.id,
      super.nameAr,
      super.nameEn,
      super.nameKo,
      super.image,
      super.icon,
      super.createdAt,
      super.updatedAt});

  factory ServicesItemDataModel.fromJson(Map<String, dynamic> json) =>
      ServicesItemDataModel(
        id: json["id"],
        nameAr: json["name_ar"] ?? "لا يوجد اسم",
        nameEn: json["name_en"] ?? "No Name",
        nameKo: json["name_ko"] ?? "هيچ ناو نييه‌",
        image: json["image"],
        icon: json["icon"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "name_ko": nameKo,
        "image": image,
        "icon": icon,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class MainItemUserModel extends MainItemUser {
  MainItemUserModel({
    super.id,
    super.name,
    super.email,
    super.whatsapp,
    super.phone,
    super.image,
    super.status,
    super.userType,
    super.packagesBalance,
    super.createdAt,
    super.updatedAt,
  });

  factory MainItemUserModel.fromJson(Map<String, dynamic> json) =>
      MainItemUserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        whatsapp: json["whatsapp"],
        phone: json["phone"],
        image: json["image"],
        status: json["status"],
        userType: json["user_type"],
        packagesBalance: json["packages_balance"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "whatsapp": whatsapp,
        "phone": phone,
        "image": image,
        "status": status,
        "user_type": userType,
        "packages_balance": packagesBalance,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
