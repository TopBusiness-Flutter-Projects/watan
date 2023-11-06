import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elwatn/core/models/response_message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/map_failure_message.dart';
import '../../../filter/data/models/amenities_data_model.dart';
import '../../../filter/data/models/cities_data_model.dart';
import '../../../filter/data/models/cities_location_data_model.dart';
import '../../../filter/domain/use_cases/get_amenities_use_case.dart';
import '../../../filter/domain/use_cases/get_cities_location_use_case.dart';
import '../../../filter/domain/use_cases/get_cities_use_case.dart';
import '../../../home_page/domain/entities/main_item_domain_model.dart';
import '../../../home_page/presentation/cubit/home_page_cubit.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../domain/entities/add_ads_model.dart';
import '../../domain/use_cases/add_ads_use_case.dart';
import '../../domain/use_cases/update_ads_use_case.dart';
part 'add_ads_state.dart';

class AddAdsCubit extends Cubit<AddAdsState> {
  AddAdsCubit(
    this.getCitiesUseCase,
    this.getAmenitiesUseCase,
    this.getCitiesLocationUseCase,
    this.addAdsUseCase,
    this.updateAdsUseCase,
  ) : super(AddAdsInitial()) {
    getStoreUser();
  }

  final GetCitiesUseCase getCitiesUseCase;
  final GetAmenitiesUseCase getAmenitiesUseCase;
  final GetCitiesLocationUseCase getCitiesLocationUseCase;
  final AddAdsUseCase addAdsUseCase;
  final UpdateAdsUseCase updateAdsUseCase;

  late CitiesFilterModel citiesFilterModel;
  late CitiesLocationsModel citiesLocationsModel;
  AmenitiesFilterModel? amenitiesFilterModel;

  bool isCitiesDropdown = false;
  bool isCitiesLocationsDropdown = false;

  List<String> citiesEn = [];
  List<String> citiesAr = [];
  List<String> citiesKu = [];
  List<String> citiesLocationEn = [];
  List<String> citiesLocationAr = [];
  List<String> citiesLocationKu = [];
  List<String> agentNameEn = [];
  List<String> agentNameAr = [];
  List<String> agentNameKu = [];
  List<int> amenitiesId = [];
  List<MultipartFile> images = [];
  List<String> removedImages = [];
  List<String> removedVideos = [];

  List<String> image = [];
  XFile? video;
  LoginDataModel? loginDataModel;

  String status = 'sale';
  String currency = 'IQD';
  int furnished = 1;
  int cityId = 0;
  int locationId = 0;
  int type = -1;
  String price = '';
  int bedroom = -1;
  int bathroom = 0;
  int kitchen = 0;
  int livingRoom = 0;
  int diningRoom = 0;
  String size = '';
  int propertySelected = -1;
  int postId = 0;
  double longitude = 0;
  double latitude = 0;

  String btnText = '';
  int selectedCityIndex = 0;
  int selectedLocationIndex = 0;
  String videoLink = '';

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();

  getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginDataModel;
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    }
    if (btnText != 'update') {
      getAllFilterCities();
      getAllFilterAmenities();
    }
  }

  putDataToUpdate(MainItem mainItem) async {
    image.clear();
    citiesEn.clear();
    citiesAr.clear();
    citiesKu.clear();
    citiesLocationEn.clear();
    citiesLocationAr.clear();
    citiesLocationKu.clear();
    btnText = 'update';
    type = int.parse(mainItem.type!);
    size = mainItem.size!;
    furnished = int.parse(mainItem.furniture!);
    propertySelected = int.parse(mainItem.type!);
    status = mainItem.status!;
    cityId = mainItem.areaId!;
    locationId = mainItem.subAreaId!;
    currency = mainItem.currency!;
    longitude = mainItem.longitude!;
    latitude = mainItem.latitude!;
    titleController.text = mainItem.titleEn!;
    descController.text = mainItem.descriptionEn!;
    priceController.text = mainItem.price.toString();
    price = mainItem.price!;
    areaController.text = mainItem.size!;
    bedroom = mainItem.bedroom!;
    bathroom = mainItem.bathRoom!;
    kitchen = mainItem.kitchen!;
    livingRoom = mainItem.livingRoom!;
    postId = mainItem.id!;
    diningRoom = mainItem.diningRoom!;
    nameController.text = mainItem.advertizerNameEn!;
    phoneController.text = mainItem.phone!;
    whatsappController.text = mainItem.whatsapp!;
    videoLink = mainItem.videos!.isNotEmpty
        ? mainItem.videos!.first.attachment! +
            '@' +
            '${mainItem.videos!.first.id}'
        : '';
    for (var element in mainItem.services!) {
      amenitiesId.add(element.service!.id!);
    }
    for (var element in mainItem.images!) {
      image.add('${element.attachment!}@${element.id}');
    }

    await getAllFilterCities().then(
        (value) => getAllLocationOfCitiesById(mainItem.areaId.toString()));
  }

  convertImage(String path) async {
    MultipartFile image = MultipartFile.fromFileSync(path);
    images.add(image);
  }

  getCities() {
    for (var element in citiesFilterModel.data!) {
      citiesEn.add("${element.nameEn!}/${element.id}/");
      citiesAr.add("${element.nameAr!}/${element.id}/");
      citiesKu.add("${element.nameKu!}/${element.id}/");
    }
  }

  getCitiesLocations() {
    for (var element in citiesLocationsModel.data!) {
      citiesLocationEn.add("${element.nameEn!}/${element.id}/");
      citiesLocationAr.add("${element.nameAr!}/${element.id}/");
      citiesLocationKu.add("${element.nameKu!}/${element.id}/");
    }
  }

  clearCitiesLocations() {
    citiesLocationEn.clear();
    citiesLocationAr.clear();
    citiesLocationKu.clear();
  }

  Future<void> getAllFilterCities() async {
    emit(AddCitiesLoading());
    Either<Failure, CitiesFilterModel> response =
        await getCitiesUseCase(NoParams());
    emit(
      response.fold(
          (failure) =>
              AddCitiesError(MapFailureMessage.mapFailureToMessage(failure)),
          (citiesFilterModel) {
        this.citiesFilterModel = citiesFilterModel;
        getCities();
        isCitiesDropdown = true;
        return AddCitiesLoaded(citiesFilterModel);
      }),
    );
  }

  getAllLocationOfCitiesById(String id) async {
    emit(AddCitiesLocationLoading());
    Either<Failure, CitiesLocationsModel> response =
        await getCitiesLocationUseCase(id);
    emit(
      response.fold(
          (failure) => AddCitiesLocationError(
              MapFailureMessage.mapFailureToMessage(failure)),
          (citiesLocationsModel) {
        this.citiesLocationsModel = citiesLocationsModel;
        getCitiesLocations();
        isCitiesLocationsDropdown = true;
        return AddCitiesLocationLoaded(citiesLocationsModel);
      }),
    );
  }

  getAllFilterAmenities() async {
    emit(AddAmenitiesLoading());
    Either<Failure, AmenitiesFilterModel> response =
        await getAmenitiesUseCase(NoParams());
    emit(
      response.fold(
          (failure) =>
              AddAmenitiesError(MapFailureMessage.mapFailureToMessage(failure)),
          (amenitiesFilterModel) {
        this.amenitiesFilterModel = amenitiesFilterModel;
        return AddAmenitiesLoaded(amenitiesFilterModel);
      }),
    );
  }

  addAdsPost(BuildContext context) async {
    emit(AddAdsPostLoading());
    final response = await addAdsUseCase(
      AddAdsModel(
        status: status,
        areaId: cityId,
        subAreaId: locationId,
        type: type,
        titleAr: titleController.text,
        titleEn: titleController.text,
        titleKu: titleController.text,
        descriptionAr: descController.text,
        descriptionEn: descController.text,
        descriptionKu: descController.text,
        furniture: furnished.toString(),
        price: priceController.text,
        currency: currency,
        size: areaController.text,
        amenities: amenitiesId,
        bedroom: bedroom.toString(),
        bathRoom: bathroom.toString(),
        kitchen: kitchen.toString(),
        livingRoom: livingRoom.toString(),
        diningRoom: diningRoom.toString(),
        images: images,
        videos: video != null ? [video!.path] : [],
        longitude: longitude,
        latitude: latitude,
        advertizerNameAr: nameController.text,
        advertizerNameEn: nameController.text,
        advertizerNameKu: nameController.text,
        phone: phoneController.text,
        whatsapp: whatsappController.text,
        token: loginDataModel!.data!.accessToken,
      ),
    );
    response.fold(
      (failure) {
        emit(
          AddAdsPostError(
            MapFailureMessage.mapFailureToMessage(failure),
          ),
        );
        Future.delayed(
          const Duration(seconds: 2),
          () {
            changeStates();
          },
        );
      },
      (status) {
        if (status.code == 200) {
          emit(AddAdsPostLoaded(status));
          Future.delayed(
            const Duration(seconds: 2),
            () {
              changeStates();
            },
          );
          context.read<HomePageCubit>().getAllDataOfHomePage();
        } else {
          emit(AddAdsPostErrorResponse(status));
          Future.delayed(
            const Duration(seconds: 2),
            () {
              changeStates();
            },
          );
        }
      },
    );
  }

  updateAdsPost() async {
    emit(UpdateAdsPostLoading());
    final response = await updateAdsUseCase(
      AddAdsModel(
        id: postId,
        status: status,
        areaId: cityId,
        subAreaId: locationId,
        type: type,
        titleAr: titleController.text,
        titleEn: titleController.text,
        titleKu: titleController.text,
        descriptionAr: descController.text,
        descriptionEn: descController.text,
        descriptionKu: descController.text,
        furniture: furnished.toString(),
        price: priceController.text,
        currency: currency == '1' ? 'USD' : 'IQD',
        size: areaController.text,
        amenities: amenitiesId,
        bedroom: bedroom.toString(),
        bathRoom: bathroom.toString(),
        kitchen: kitchen.toString(),
        livingRoom: livingRoom.toString(),
        diningRoom: diningRoom.toString(),
        images: images,
        videos: video != null ? [video!.path] : [],
        longitude: longitude,
        latitude: latitude,
        advertizerNameAr: nameController.text,
        advertizerNameEn: nameController.text,
        advertizerNameKu: nameController.text,
        phone: phoneController.text,
        whatsapp: whatsappController.text,
        token: loginDataModel!.data!.accessToken,
        removedImage: removedImages,
        removedVideo: removedVideos,
      ),
    );
    response.fold(
      (failure) {
        emit(
          UpdateAdsPostError(
            MapFailureMessage.mapFailureToMessage(failure),
          ),
        );
        Future.delayed(
          const Duration(seconds: 2),
          () {
            changeStates();
          },
        );
      },
      (status) {
        if (status.code == 200) {
          emit(UpdateAdsPostLoaded(status));
          Future.delayed(
            const Duration(seconds: 2),
            () {
              print('************************************');
              changeStates();
            },
          );
        } else {
          emit(UpdateAdsPostErrorResponse(status));
          Future.delayed(
            const Duration(seconds: 2),
            () {
              changeStates();
            },
          );
        }
      },
    );
  }

  changeStates() {
    titleController.clear();
    descController.clear();
    priceController.clear();
    areaController.clear();
    nameController.clear();
    phoneController.clear();
    whatsappController.clear();
    video = null;
    furnished = 1;
    images = [];
    cityId = 0;
    locationId = 0;
    type = -1;
    price = '';
    bedroom = -1;
    bathroom = 0;
    kitchen = 0;
    livingRoom = 0;
    diningRoom = 0;
    size = '';
    propertySelected = -1;
    status = 'sale';
    currency = 'IQD';
    latitude = 0;
    longitude = 0;
    print('#############################################3');
    emit(ChangeState());
  }

  clearData() {
    titleController.clear();
    descController.clear();
    priceController.clear();
    areaController.clear();
    nameController.clear();
    phoneController.clear();
    whatsappController.clear();
    amenitiesId.clear();
    video = null;
    furnished = 1;
    cityId = 0;
    locationId = 0;
    type = -1;
    price = '';
    bedroom = -1;
    bathroom = 0;
    kitchen = 0;
    livingRoom = 0;
    diningRoom = 0;
    size = '';
    type = 0;
    propertySelected = -1;
    status = 'sale';
    currency = 'IQD';
    videoLink = '';
    latitude = 0;
    longitude = 0;
  }

  void updateLocation(double latitude, double longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
    emit(ChangeLocationState());
  }
}
