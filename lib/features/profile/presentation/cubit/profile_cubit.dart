import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/models/response_message.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/map_failure_message.dart';
import '../../../home_page/data/models/main_item_data_model.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../domain/entities/agent_list_domain_model.dart';
import '../../domain/use_cases/delete_agent_use_case.dart';
import '../../domain/use_cases/delete_user_account_use_case.dart';
import '../../domain/use_cases/edit_agent_use_case.dart';
import '../../domain/use_cases/get_agent_list_use_case.dart';
import '../../domain/use_cases/post_new_agent_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.getAgentProfileListUseCase,
    this.postNewAgentUseCase,
    this.deleteAgentUseCase,
    this.editAgentUseCase,
    this.deleteUserAccountUseCase,
  ) : super(ProfileInitial()) {
    getStoreUser().then(
      (value) => value.data!.user!.userType != 1
          ? value.data!.accessToken != null
              ? getAgentList(value.data!.accessToken!)
              : null
          : null,
    );
  }

  // getStoredate(){}

  changeStatus(int code) {
    Future.delayed(const Duration(seconds: 3), () {
      statusCode = code;
    });
  }

  final GetAgentProfileListUseCase getAgentProfileListUseCase;
  final PostNewAgentUseCase postNewAgentUseCase;
  final DeleteAgentUseCase deleteAgentUseCase;
  final EditAgentUseCase editAgentUseCase;
  final DeleteUserAccountUseCase deleteUserAccountUseCase;

  late AgentProfileList agentList;
  late LoginDataModel loginDataModel;
  late AgentModel agentModel;
  XFile? image;
  final picker = ImagePicker();
  List<String> languages = [];

  int statusCode = 0;
  String phoneValidator = "";
  String emailValidator = "";
  String agentBtnText = "";
  String imageLink = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController snapController = TextEditingController();

  language(String lan, bool isAdded) {
    if (isAdded) {
      languages.add(lan);
    } else {
      languages
          .removeAt(languages.indexWhere((element) => element.startsWith(lan)));
    }
  }

  removeUserFromLocal(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.remove('user');
    if (result) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.initialRoute,
        (route) => false,
      );
      Future.delayed(Duration(seconds: 1), () {
        emit(ProfileInitial());
      });
    } else {
      print("يا دى النيله المنيله بسواد ");
    }
  }

  Future<LoginDataModel> getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginDataModel;
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    } else {
      loginDataModel = LoginDataModel.fromJson({});
    }
    return loginDataModel;
  }

  putDataToEdit(AgentModel agentModel) {
    this.agentModel = agentModel;
    emailController.text = agentModel.email!;
    passwordController.text = "";
    nameController.text = agentModel.name ?? "";
    whatsappController.text = agentModel.whatsapp ?? "";
    phoneController.text = agentModel.phone ?? "";
    aboutController.text = agentModel.about ?? "";
    facebookController.text = agentModel.facebook ?? "";
    instaController.text = agentModel.instagram ?? "";
    twitterController.text = agentModel.twitter ?? "";
    snapController.text = agentModel.snapchat ?? "";
    languages = agentModel.languages!;
    imageLink = agentModel.image ?? "";
    for (var element in agentModel.languages!) {
      print(element);
    }
  }

  Color isLanguage(String lan) {
    if (languages.contains(lan)) {
      return AppColors.primary;
    } else {
      return AppColors.buttonBackground;
    }
  }

  //Agent Methods
  getAgentList(String token) async {
    emit(ProfileAgentLoading());
    final response = await getAgentProfileListUseCase(token);
    emit(
      response.fold(
        (failure) => ProfileAgentError(
          message: MapFailureMessage.mapFailureToMessage(failure),
        ),
        (agentList) {
          this.agentList = agentList;
          return ProfileAgentLoaded(agentProfileList: agentList);
        },
      ),
    );
  }

  postNewAgent() async {
    emit(ProfileAddedAgentLoading());
    final response = await postNewAgentUseCase(
      AgentModel(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        whatsapp: whatsappController.text,
        phone: phoneController.text,
        about: aboutController.text,
        phoneCode: "+20",
        facebook: facebookController.text,
        instagram: instaController.text,
        twitter: twitterController.text,
        snapchat: snapController.text,
        languages: languages,
        image: image!.path,
        token: loginDataModel.data!.accessToken,
      ),
    );
    response.fold(
      (failure) => emit(
        ProfileAddedAgentError(
          message: MapFailureMessage.mapFailureToMessage(failure),
        ),
      ),
      (statusResponse) {
        if (statusResponse.code == 200) {
          emit(
            ProfileAddedAgentLoaded(statusResponse: statusResponse),
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            getAgentList(loginDataModel.data!.accessToken!);
          });
        } else if (statusResponse.code == 422) {
          statusCode = statusResponse.code;
          phoneValidator = statusResponse.messages!.phone!.isNotEmpty
              ? statusResponse.messages!.phone!.first
              : "";
          emailValidator = statusResponse.messages!.email!.isNotEmpty
              ? statusResponse.messages!.email!.first
              : "";
          emit(ProfileAgentValidator());
        }
      },
    );
  }

  deleteAgent(int id, context) async {
    emit(ProfileAddedAgentLoading());
    final response = await deleteAgentUseCase(
      AgentModel(
        id: id,
        token: loginDataModel.data!.accessToken,
      ),
    );
    response.fold(
      (failure) => emit(
        ProfileAddedAgentError(
          message: MapFailureMessage.mapFailureToMessage(failure),
        ),
      ),
      (statusResponse) {
        if (statusResponse.code == 200) {
          emit(ProfileAgentDeletedSuccessfully());
          Future.delayed(const Duration(milliseconds: 700), () {
            getAgentList(loginDataModel.data!.accessToken!);
          });
        } else if (statusResponse.code == 204) {}
      },
    );
  }

  editAgent(AgentModel agentModel) async {
    emit(ProfileEditAgentLoading());
    final response = await editAgentUseCase(
      AgentModel(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        whatsapp: whatsappController.text,
        phone: phoneController.text,
        about: aboutController.text,
        phoneCode: "+20",
        facebook: facebookController.text,
        instagram: instaController.text,
        twitter: twitterController.text,
        snapchat: snapController.text,
        languages: languages,
        image: image != null ? image!.path : null,
        token: loginDataModel.data!.accessToken,
        id: agentModel.id,
        method: "PUT",
      ),
    );
    response.fold(
      (failure) => emit(
        ProfileEditAgentError(
          message: MapFailureMessage.mapFailureToMessage(failure),
        ),
      ),
      (statusResponse) {
        if (statusResponse.code == 200) {
          emit(
            ProfileEditAgentLoaded(statusResponse: statusResponse),
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            getAgentList(loginDataModel.data!.accessToken!);
          });
        } else if (statusResponse.code == 422) {
          statusCode = statusResponse.code;
          phoneValidator = statusResponse.messages!.phone!.isNotEmpty
              ? statusResponse.messages!.phone!.first
              : "";
          emailValidator = statusResponse.messages!.email!.isNotEmpty
              ? statusResponse.messages!.email!.first
              : "";
          emit(ProfileAgentValidator());
        }
      },
    );
  }

//User Methods
  deleteUserAccount(String token) async {
    emit(ProfileUserDeletedLoading());
    final response = await deleteUserAccountUseCase(token);
    response.fold(
      (failure) => emit(ProfileUserDeletedError()),
      (statusResponse) {
        if (statusResponse.code == 200) {
          emit(ProfileUserDeletedSuccessfully());
        }
      },
    );
  }
}
