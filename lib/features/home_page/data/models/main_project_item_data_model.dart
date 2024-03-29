import '../../domain/entities/main_item_domain_model.dart';
import '../../domain/entities/main_project_item_domain_model.dart';
import 'main_item_data_model.dart';

class MainProjectItemModel extends MainProjectItem {
  const MainProjectItemModel({
    required super.id,
    required super.name,
    required super.locationNameAr,
    required super.locationNameEn,
    required super.locationNameKu,
    required super.phone,
    required super.whatsapp,
    required super.titleAr,
    required super.descriptionAr,
    required super.titleEn,
    required super.descriptionEn,
    required super.titleKu,
    required super.descriptionKu,
    required super.views,
    required super.type,
    required super.companyId,
    required super.agentId,
    required super.userId,
    required super.categoryId,
    required super.subCategoryId,
    required super.areaId,
    required super.subAreaId,
    required super.latitude,
    required super.longitude,
    required super.minPrice,
    required super.maxPrice,
    required super.projectStatus,
    required super.areaRange,
    required super.minPriceOfMeter,
    required super.maxPriceOfMeter,
    required super.desc,
    required super.paymentTerms,
    required super.paymentDetails,
    required super.isInvested,
    required super.createdAt,
    required super.updatedAt,
    required super.images,
    required super.agent,
    required super.services,
    required super.currency,
    required super.videos,
    required super.floorPlans,
    required super.paymentPlans,
    required super.unitDetails,
    required super.user,
    required super.isFavourite,
  });

  factory MainProjectItemModel.fromJson(Map<String, dynamic> json) =>
      MainProjectItemModel(
        id: json["id"],
        name: json["name"],
        locationNameAr: json["location_name_ar"],
        locationNameEn: json["location_name_en"],
        locationNameKu: json["location_name_ku"],
        phone: json["phone"],
        whatsapp: json["whatsapp"],
        titleAr: json["title_ar"],
        descriptionAr: json["description_ar"],
        titleEn: json["title_en"],
        descriptionEn: json["description_en"],
        titleKu: json["title_ku"],
        descriptionKu: json["description_ku"],
        views: json["views"],
        type: json["type"],
        companyId: json["company_id"],
        agentId: json["agent_id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        areaId: json["area_id"],
        subAreaId: json["sub_area_id"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        projectStatus: json["project_status"],
        areaRange: json["area_range"],
        minPriceOfMeter: json["min_price_of_meter"],
        maxPriceOfMeter: json["max_price_of_meter"],
        desc: json["desc"],
        user: json["user"] != null
            ? MainItemUserModel.fromJson(json["user"])
            : MainItemUserModel(),
        paymentTerms: json["payment_terms"],
        paymentDetails: json["payment_details"],
        isInvested: json["is_invested"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavourite: json["is_favourite"],
        images: List<FloorPlan>.from(
            json["images"].map((x) => FloorPlan.fromJson(x))),
        floorPlans: json["floor_plans"] != null
            ? List<FloorPlan>.from(
                json["floor_plans"].map((x) => FloorPlan.fromJson(x)))
            : [],
        agent: json["agent"] == null
            ? const AgentModel(
                name: "لا يوجد اسم وكيل",
              )
            : AgentModel.fromJson(json["agent"]),
        services: List<ServiceItemsModel>.from(
            json["services"].map((x) => ServiceItemsModel.fromJson(x))),
        videos: List<Video>.from(
          json["videos"].map(
            (x) => Video.fromJson(x),
          ),
        ),
        currency: json["currency"],
        paymentPlans: List<PaymentPlan>.from(
          json["payment_plans"].map(
            (x) => PaymentPlan.fromJson(x),
          ),
        ),
        unitDetails: List<List<UnitDetail>>.from(json["unit_details"].map((x) =>
            List<UnitDetail>.from(x.map((x) => UnitDetail.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location_name_ar": locationNameAr,
        "location_name_en": locationNameEn,
        "location_name_ku": locationNameKu,
        "phone": phone,
        "whatsapp": whatsapp,
        "title_ar": titleAr,
        "description_ar": descriptionAr,
        "title_en": titleEn,
        "description_en": descriptionEn,
        "title_ku": titleKu,
        "description_ku": descriptionKu,
        "views": views,
        "type": type,
        "currency": currency,
        "company_id": companyId,
        "agent_id": agentId,
        "user_id": userId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "area_id": areaId,
        "sub_area_id": subAreaId,
        "latitude": latitude,
        "longitude": longitude,
        "min_price": minPrice,
        "max_price": maxPrice,
        "project_status": projectStatus,
        "area_range": areaRange,
        "min_price_of_meter": minPriceOfMeter,
        "max_price_of_meter": maxPriceOfMeter,
        "desc": desc,
        "payment_terms": paymentTerms,
        "payment_details": paymentDetails,
        "is_invested": isInvested,
        "user": user.toJson(),
        "is_favourite": isFavourite,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "images": List<dynamic>.from(images!.map((x) => x)),
        "floor_plans": List<dynamic>.from(floorPlans!.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "agent": agent,
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
        "payment_plans":
            List<dynamic>.from(paymentPlans.map((x) => x.toJson())),
        "unit_details": List<dynamic>.from(unitDetails
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}
