import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

// Events
abstract class SupportEvent {}

class LoadSupportData extends SupportEvent {}

class SendChatMessage extends SupportEvent {
  final String message;
  SendChatMessage(this.message);
}

// States
class SupportState {
  final List<ChatMessage> messages;

  SupportState({required this.messages});
}

// BLoC
class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc()
      : super(SupportState(messages: [
    ChatMessage(
      text: 'Hello! How can we help you with your order today?',
      isUser: false,
      timestamp: '09:00 AM',
    ),
  ])) {
    on<LoadSupportData>((event, emit) {
      // Retain initial state or reload
    });

    on<SendChatMessage>((event, emit) async {
      final updatedMessages = List<ChatMessage>.from(state.messages)
        ..add(ChatMessage(
          text: event.message,
          isUser: true,
          timestamp: '09:01 AM',
        ));

      emit(SupportState(messages: updatedMessages));

      // Simulate automated response
      await Future.delayed(const Duration(milliseconds: 1000));
      final botResponse = List<ChatMessage>.from(updatedMessages)
        ..add(ChatMessage(
          text: 'Thanks for reaching out! A support agent will respond shortly.',
          isUser: false,
          timestamp: '09:01 AM',
        ));

      emit(SupportState(messages: botResponse));
    });
  }
}