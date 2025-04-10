import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/models/chats/get_all_messages/get_all_messages_model.dart';
import 'package:stream_vids/repository/chats/delete_message/delete_message_repo.dart';
import 'package:stream_vids/repository/chats/get_all_messages/get_all_messages_repo.dart';
import 'package:stream_vids/repository/chats/send_message/send_message_repo.dart';
import 'package:stream_vids/utils/utils.dart';

class GetAllMessagesController extends GetxController {
  final _api = GetAllMessagesRepo();
  final _sendApi = SendMessageRepo();
  final _deleteApi = DeleteMessageRepo();

  var messages = <Data>[].obs;
  var isLoading = false.obs;
  var editingMessageId = ''.obs;

  final messageTextController = TextEditingController().obs;
  final messageFocusNode = FocusNode().obs;

  void getAllMessages(String chatId) async {
    isLoading(true);
    try {
      final response = await _api.getAllMessages(chatId);
      if (response != null) {
        final model = GetAllMessageModel.fromJson(response);
        if (model.success == true) {
          messages.value = model.data!;
        } else {
          Utils.snackBar("error".tr, model.message.toString());
        }
      } else {
        Utils.snackBar("error".tr, response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading(false);
    }
  }

  Future<void> sendMessage(String chatId) async {
    isLoading(true);
    try {
      if (messageTextController.value.text.trim().isEmpty) return;

      Map<String, dynamic> content = {
        'content': messageTextController.value.text.trim()
      };

      final response = await _sendApi.sendMessage(content, chatId);
      if (response['statusCode'] == 200) {
        messageTextController.value.clear();
        getAllMessages(chatId);
      } else {
        Utils.snackBar("error".tr, response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteMessage(String messageId, String chatId) async {
    isLoading(true);
    try {
      final response = await _deleteApi.deleteMessage(messageId, chatId);

      if (response['statusCode'] == 200) {
        getAllMessages(chatId);
      } else {
        Utils.snackBar("Error", response['message']);
      }
    } catch (e) {
      final String err = Utils.extractErrorMessage(e.toString());
      Utils.snackBar("error".tr, err);
    } finally {
      isLoading(false);
    }
  }
}
