import '../../domain/entities/new_popular_domain_model.dart';
import 'main_item_data_model.dart';

class NewPopularItemsModel extends NewPopularItems {
  const NewPopularItemsModel({required super.data});

  factory NewPopularItemsModel.fromJson(Map<String, dynamic> json) =>
      NewPopularItemsModel(
        data: NewPopularDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class NewPopularDataModel extends NewPopularData {
  const NewPopularDataModel({required super.dataNew, required super.popular});

  factory NewPopularDataModel.fromJson(Map<String, dynamic> json) =>
      NewPopularDataModel(
        dataNew:
            List<MainItemModel>.from(json["new"].map((x) => MainItemModel.fromJson(x))),
        popular: List<MainItemModel>.from(json["popular"].map((x) => MainItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "new": List<dynamic>.from(dataNew!.map((x) => x.toJson())),
        "popular": List<dynamic>.from(popular!.map((x) => x.toJson())),
      };
}
