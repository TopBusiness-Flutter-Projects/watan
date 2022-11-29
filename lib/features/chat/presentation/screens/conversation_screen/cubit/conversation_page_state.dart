part of 'conversation_page_cubit.dart';

@immutable
abstract class ConversationPageState {}


class IsLoadingData extends ConversationPageState {}
class OnDataSuccess extends ConversationPageState {
  ChatModel myRooms;
  OnDataSuccess(this.myRooms);
}
class OnError extends ConversationPageState {
  String error;
  OnError(this.error);
}

class OneRoomLoading extends ConversationPageState {}
class OneRoomLoaded extends ConversationPageState {
  List<MyMessage> myRooms;
  OneRoomLoaded(this.myRooms);
}
class OneRoomError extends ConversationPageState {
  String error;
  OneRoomError(this.error);
}


class SendLoading extends ConversationPageState {}
class SendLoaded extends ConversationPageState {
  GetOneMessage message;
  SendLoaded(this.message);
}
class SendError extends ConversationPageState {
  String error;
  SendError(this.error);
}
