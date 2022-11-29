import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/utils/map_failure_message.dart';
import '../../../../../login/data/models/login_data_model.dart';
import '../../../../data/models/MyRooms.dart';
import '../../../../data/models/get_one_message_model.dart';
import '../../../../data/models/send_message_model.dart';
import '../../../../domain/entities/open_room_model.dart';
import '../../../../domain/use_cases/my_rooms_use_case.dart';
import '../../../../domain/use_cases/one_room_use_case.dart';
import '../../../../domain/use_cases/open_room_use_case.dart';
import '../../../../domain/use_cases/send_message_use_case.dart';

part 'conversation_page_state.dart';

class ConversationPageCubit extends Cubit<ConversationPageState> {
  late ChatModel allMyRooms;
  late ChatModel oneRoom;
  LoginDataModel? loginDataModel;
  List<MyMessage> allMessages = [];
  List<MyMessage> tempMessages = [];
  late String imagePath;
  XFile? imageFile;
  String imageType = '';
  int i = 0;
  bool isCubit = false;

  ConversationPageCubit(this.getMyRoomsUseCase, this.getOneRoomUseCase,
      this.sendMessageUseCase, this.openRoomUseCase)
      : super(IsLoadingData()) {
    _getStoreUser().then((value) => getAllRoomsData());
  }

  final GetMyRoomsUseCase getMyRoomsUseCase;
  final GetOneRoomUseCase getOneRoomUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final OpenRoomUseCase openRoomUseCase;

  Future _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      LoginDataModel loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    }
  }

  void getAllRoomsData() async {
    emit(IsLoadingData());
    final response =
        await getMyRoomsUseCase(loginDataModel!.data!.accessToken!);
    emit(
      response.fold(
        (failure) => OnError(MapFailureMessage.mapFailureToMessage(failure)),
        (myRooms) {
          allMyRooms = myRooms;
          return OnDataSuccess(myRooms);
        },
      ),
    );
  }

  emitTheSuccess(List<MyMessage> myRooms,MyMessage message) {
    if(!isCubit){
      tempMessages = allMessages.reversed.toList();
      tempMessages.add(message);
      allMessages = tempMessages.reversed.toList();
    }
    emit(OneRoomLoaded(myRooms));
  }

  void getOneRoomData(String roomId) async {
    emit(OneRoomLoading());
    if (loginDataModel != null) {
      final response =
          await getOneRoomUseCase([roomId, loginDataModel!.data!.accessToken!]);
      emit(
        response.fold(
          (failure) =>
              OneRoomError(MapFailureMessage.mapFailureToMessage(failure)),
          (myRooms) {
            oneRoom = myRooms;
            allMessages = myRooms.oneRoomData!.allMessages!.reversed.toList();
            return OneRoomLoaded(allMessages);
          },
        ),
      );
    } else {
      _getStoreUser().whenComplete(() => getOneRoomData(roomId));
    }
  }

  pickImage({
    required String type,
    required MyRoomsDatum myRoomsDatum,
  }) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    imageType = 'file';
    sendMessage(imageFile!.path, myRoomsDatum);
  }

  Future <void> sendMessage(String message, MyRoomsDatum myRoomsDatum) async {
    emit(SendLoading());
    final response = await sendMessageUseCase(
      imageType == 'file'
          ? SendMessage(
              roomId: myRoomsDatum.id,
              type: imageType,
              toUserId: myRoomsDatum.toUserId,
              file: message,
              token: loginDataModel!.data!.accessToken,
            )
          : SendMessage(
              roomId: myRoomsDatum.id,
              type: imageType,
              toUserId: myRoomsDatum.toUserId,
              message: message,
              token: loginDataModel!.data!.accessToken,
            ),
    );
    emit(
      response.fold(
        (failure) => SendError(MapFailureMessage.mapFailureToMessage(failure)),
        (message) {
          print('Er0000r : cubit');
            tempMessages = allMessages.reversed.toList();
            tempMessages.add(message.data!);
            allMessages = tempMessages.reversed.toList();
            // isCubit = true;
          return SendLoaded(message);
        },
      ),
    );
  }

  Future<ChatModel> createRoom(OpenRoom openRoom) async {
    int code = 0;
    ChatModel? chatModel;
    final response = await openRoomUseCase(openRoom);
    response.fold((l) {
      code = 400;
    }, (r) {
      chatModel = r;
      code = 200;
    });
    if (code != 200) {
      return ChatModel(code: code);
    } else {
      return chatModel!;
    }
  }
}
