import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/response_message.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/map_failure_message.dart';
import '../../../add/domain/entities/add_ads_model.dart';
import '../../../add/domain/use_cases/add_project_use_case.dart';
import '../../../add/domain/use_cases/update_ads_use_case.dart';
import '../../../filter/data/models/amenities_data_model.dart';
import '../../../filter/data/models/cities_data_model.dart';
import '../../../filter/data/models/cities_location_data_model.dart';
import '../../../filter/domain/use_cases/get_amenities_use_case.dart';
import '../../../filter/domain/use_cases/get_cities_location_use_case.dart';
import '../../../filter/domain/use_cases/get_cities_use_case.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';
import '../../../login/data/models/login_data_model.dart';

part 'add_project_state.dart';

class AddProjectCubit extends Cubit<AddProjectState> {
  AddProjectCubit(
    this.getCitiesUseCase,
    this.getAmenitiesUseCase,
    this.getCitiesLocationUseCase,
    this.addProjectUseCase,
    this.updateAdsUseCase,
  ) : super(AddProjectInitial()) {
    getStoreUser();

  }

  final GetCitiesUseCase getCitiesUseCase;
  final GetAmenitiesUseCase getAmenitiesUseCase;
  final GetCitiesLocationUseCase getCitiesLocationUseCase;
  final AddProjectUseCase addProjectUseCase;
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
  List<int> amenitiesId = [];
  List<MultipartFile> images = [];
  List<MultipartFile> floorPlans = [];
  List<String> paymentPlanTitle = [];
  List<String> paymentPlanPresent = [];
  List<int> unitPlanPrice = [];
  List<int> unitPlanArea = [];
  List<String> unitPlanBedroom = [];
  List<String> unitPlanBathroom = [];
  List<String> removedImages = [];
  List<String> removedFloors = [];
  List<String> removedVideos = [];
  List<int> removedPaymentPlan = [];
  List<int> removedUnitPlan = [];
  List<int> tempIdPaymentPlan = [];
  List<int> tempIdUnitPlan = [];

  List<String> image = [];
  List<String> floorPlan = [];
  XFile? video;
  LoginDataModel? loginDataModel;

  String statusProject = 'new';
  String currency = 'IQD';
  int cityId = 0;
  int locationId = 0;
  int type = -1;
  int projectId = 0;
  int propertySelected = -1;
  double longitude = 0;
  double latitude = 0;

  int paymentPlanCount=0;
  int unitPlanCount=0;

  String btnText = '';
  int selectedCityIndex = 0;
  int selectedLocationIndex = 0;
  String videoLink = '';

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController paymentTitleController = TextEditingController();
  TextEditingController paymentPresentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController bedroomController = TextEditingController();
  TextEditingController bathroomController = TextEditingController();

  getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginDataModel;
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    }
    if(btnText!='update'){
      getAllFilterCities();
      getAllFilterAmenities();
    }
  }

  convertImage(String path) async {
    MultipartFile image = MultipartFile.fromFileSync(path);
    images.add(image);
  }

  convertFloorPlan(String path) async {
    MultipartFile floorPlan = MultipartFile.fromFileSync(path);
    floorPlans.add(floorPlan);
  }

  putDataToUpdate(MainProjectItem mainItem) async {
    btnText='update';
    image.clear();
    floorPlan.clear();
    citiesEn.clear();
    citiesAr.clear();
    citiesKu.clear();
    citiesLocationEn.clear();
    citiesLocationAr.clear();
    citiesLocationKu.clear();
    paymentPlanPresent.clear();
    unitPlanArea.clear();
    unitPlanPrice.clear();
    unitPlanBathroom.clear();
    unitPlanBedroom.clear();
    paymentPlanCount=mainItem.paymentPlans.length;
    unitPlanCount=mainItem.unitDetails.length;
    type = int.parse(mainItem.type!);
    propertySelected = int.parse(mainItem.type!);
    statusProject = mainItem.projectStatus!;
    cityId = mainItem.areaId!;
    projectId = mainItem.id!;
    locationId = mainItem.subAreaId!;
    currency = mainItem.currency;
    titleController.text = mainItem.titleEn!;
    descController.text = mainItem.descriptionEn!;
    phoneController.text = mainItem.phone!;
    whatsappController.text = mainItem.whatsapp!;
    videoLink = mainItem.videos.isNotEmpty
        ? mainItem.videos.first.attachment! +
            '@' +
            '${mainItem.videos.first.id}'
        : '';
    for (var element in mainItem.services!) {
      amenitiesId.add(element.service!.id!);
    }
    for (var element in mainItem.paymentPlans) {
      paymentPlanTitle.add(element.title);
      paymentPlanPresent.add(element.percent);
      tempIdPaymentPlan.add(element.id);
    }
    for (var element in mainItem.unitDetails) {
      for (var ele in element) {
        unitPlanArea.add(int.parse(ele.area!));
        unitPlanPrice.add(ele.price!);
        unitPlanBathroom.add(ele.bathrooms!);
        unitPlanBedroom.add(ele.bedrooms!);
        tempIdUnitPlan.add(ele.id!);
      }
    }
    for (var element in mainItem.images!) {
      image.add('${element.attachment!}@${element.id}');
    }
    for (var element in mainItem.floorPlans!) {
      floorPlan.add('${element.attachment!}@${element.id}');
    }
    await getAllFilterCities().then(
        (value) => getAllLocationOfCitiesById(mainItem.areaId.toString()));
    getAllFilterAmenities();
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
    emit(AddProjectCitiesLoading());
    Either<Failure, CitiesFilterModel> response =
        await getCitiesUseCase(NoParams());
    emit(
      response.fold(
          (failure) => AddProjectCitiesError(
              MapFailureMessage.mapFailureToMessage(failure)),
          (citiesFilterModel) {
        this.citiesFilterModel = citiesFilterModel;
        getCities();
        isCitiesDropdown = true;
        return AddProjectCitiesLoaded(citiesFilterModel);
      }),
    );
  }

  getAllLocationOfCitiesById(String id) async {
    emit(AddProjectCitiesLocationLoading());
    Either<Failure, CitiesLocationsModel> response =
        await getCitiesLocationUseCase(id);
    emit(
      response.fold(
          (failure) => AddProjectCitiesLocationError(
              MapFailureMessage.mapFailureToMessage(failure)),
          (citiesLocationsModel) {
        this.citiesLocationsModel = citiesLocationsModel;
        getCitiesLocations();
        isCitiesLocationsDropdown = true;
        return AddProjectCitiesLocationLoaded(citiesLocationsModel);
      }),
    );
  }

  getAllFilterAmenities() async {
    emit(AddProjectAmenitiesLoading());
    Either<Failure, AmenitiesFilterModel> response =
        await getAmenitiesUseCase(NoParams());
    emit(
      response.fold(
          (failure) => AddProjectAmenitiesError(
              MapFailureMessage.mapFailureToMessage(failure)),
          (amenitiesFilterModel) {
        this.amenitiesFilterModel = amenitiesFilterModel;
        return AddProjectAmenitiesLoaded(amenitiesFilterModel);
      }),
    );
  }

  addProjectPost() async {
    emit(AddProjectPostLoading());
    final response = await addProjectUseCase(AddAdsModel(
      projectStatus: statusProject,
      areaId: cityId,
      subAreaId: locationId,
      type: type,
      titleAr: titleController.text,
      titleEn: titleController.text,
      titleKu: titleController.text,
      descriptionAr: descController.text,
      descriptionEn: descController.text,
      descriptionKu: descController.text,
      areaRange: unitPlanArea.isEmpty
          ? '0'
          : "${unitPlanArea.reduce((value, element) => min(value, element))} - ${unitPlanArea.reduce((value, element) => max(value, element))}",
      paymentTitleList: paymentPlanTitle,
      paymentPresentList: paymentPlanPresent,
      unitPlanAreaList: unitPlanArea,
      unitPlanPriceList: unitPlanPrice,
      unitPlanBathroomList: unitPlanBathroom,
      unitPlanBedroomList: unitPlanBedroom,
      minPrice: unitPlanPrice.isEmpty
          ? '0'
          : unitPlanPrice
              .reduce((value, element) => min(value, element))
              .toString(),
      maxPrice: unitPlanPrice.isEmpty
          ? '0'
          : unitPlanPrice
              .reduce((value, element) => max(value, element))
              .toString(),
      amenities: amenitiesId,
      images: images,
      floorPlans: floorPlan,
      floorPlanesImage: floorPlans,
      videos: video != null ? [video!.path] : [],
      longitude: 30.123,
      latitude: 20.123,
      phone: phoneController.text,
      whatsapp: whatsappController.text,
      token: loginDataModel!.data!.accessToken,
    ));
    response.fold(
      (failure) {
        emit(
          AddProjectPostError(
            MapFailureMessage.mapFailureToMessage(failure),
          ),
        );
        Future.delayed(
          const Duration(seconds: 2),
          () {
            changeState();
          },
        );
      },
      (status) {
        if (status.code == 200) {
          emit(AddProjectPostLoaded(status));
          Future.delayed(
            const Duration(seconds: 1),
            () {
              changeState();
            },
          );
        } else {
          emit(AddProjectPostErrorResponse(status));
          Future.delayed(
            const Duration(seconds: 1),
            () {
              changeState();
            },
          );
        }
      },
    );
  }

  changeState() {
    clearData();
    emit(ProjectChangeState());
  }

  addPaymentPlans() {
    paymentPlanTitle.add(paymentTitleController.text);
    paymentPlanPresent.add(paymentPresentController.text);
    paymentTitleController.clear();
    paymentPresentController.clear();
  }

  removePaymentPlans(int index) {
    paymentPlanTitle.removeAt(index);
    paymentPlanPresent.removeAt(index);
    removedPaymentPlan.add(tempIdPaymentPlan[index]);
    tempIdPaymentPlan.removeAt(index);
    paymentPlanCount--;
  }

  addUnitPlan() {
    unitPlanPrice.add(int.parse(priceController.text));
    unitPlanArea.add(int.parse(areaController.text));
    unitPlanBedroom.add(bedroomController.text);
    unitPlanBathroom.add(bathroomController.text);
    priceController.clear();
    areaController.clear();
    bedroomController.clear();
    bathroomController.clear();
    emit(ChangePaymentState());
    Future.delayed(const Duration(seconds: 1), () {
      emit(ChangeUnitPlanState());
    });
  }

  removeUnitPlan(int index) {
    unitPlanPrice.removeAt(index);
    unitPlanArea.removeAt(index);
    unitPlanBedroom.removeAt(index);
    unitPlanBathroom.removeAt(index);
    removedUnitPlan.add(tempIdUnitPlan[index]);
    tempIdUnitPlan.removeAt(index);
    unitPlanCount--;
    emit(ChangePaymentState());
    Future.delayed(const Duration(seconds: 1), () {
      emit(ChangeUnitPlanState());
    });
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
    floorPlan.clear();
    floorPlans.clear();
    video = null;
    cityId = 0;
    locationId = 0;
    type = -1;
    type = 0;
    propertySelected = -1;
    currency = 'IQD';
    videoLink = '';
    unitPlanBedroom.clear();
    unitPlanBathroom.clear();
    unitPlanPrice.clear();
    unitPlanArea.clear();
    paymentPlanPresent.clear();
    paymentPlanTitle.clear();
  }

  updateAdsPost() async {
    emit(UpdateAdsPostLoading());
    final response = await updateAdsUseCase(
      AddAdsModel(
        kindOfPost: 'project',
        id: projectId,
        projectStatus: statusProject,
        areaId: cityId,
        subAreaId: locationId,
        type: type,
        titleAr: titleController.text,
        titleEn: titleController.text,
        titleKu: titleController.text,
        descriptionAr: descController.text,
        descriptionEn: descController.text,
        descriptionKu: descController.text,

        areaRange: unitPlanArea.isEmpty
            ? '0'
            : "${unitPlanArea.reduce((value, element) => min(value, element))} - ${unitPlanArea.reduce((value, element) => max(value, element))}",
        paymentTitleList: paymentPlanTitle.sublist(paymentPlanCount),
        paymentPresentList: paymentPlanPresent.sublist(paymentPlanCount),
        unitPlanAreaList: unitPlanArea.sublist(unitPlanCount),
        unitPlanPriceList: unitPlanPrice.sublist(unitPlanCount),
        unitPlanBathroomList: unitPlanBathroom.sublist(unitPlanCount),
        unitPlanBedroomList: unitPlanBedroom.sublist(unitPlanCount),
        images: images,
        floorPlans: floorPlan,
        floorPlanesImage: floorPlans,
        videos: video != null ? [video!.path] : [],
        longitude: 30.123,
        latitude: 20.123,
        phone: phoneController.text,
        whatsapp: whatsappController.text,
        token: loginDataModel!.data!.accessToken,
        amenities: amenitiesId,
        removedImage: removedImages,
        removedVideo: removedVideos,
        removedFloors: removedFloors,
        removedPaymentPlan: removedPaymentPlan,
        removedUnitPlan: removedUnitPlan,
        minPrice: unitPlanPrice.isEmpty
            ? '0'
            : unitPlanPrice
                .reduce((value, element) => min(value, element))
                .toString(),
        maxPrice: unitPlanPrice.isEmpty
            ? '0'
            : unitPlanPrice
                .reduce((value, element) => max(value, element))
                .toString(),
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
            changeState();
          },
        );
      },
      (status) {
        if (status.code == 200) {
          emit(UpdateAdsPostLoaded(status));

          Future.delayed(
            const Duration(seconds: 2),
            () {
              changeState();
            },
          );
        } else {
          emit(UpdateAdsPostErrorResponse(status));
          Future.delayed(
            const Duration(seconds: 2),
            () {
              changeState();
            },
          );
        }
      },
    );
  }
}
