import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';
import 'package:stream_vids/utils/utils.dart';
import 'package:stream_vids/view_models/controller/chats/get_all_messages/get_all_messages_controller.dart';

class UserChatScreen extends StatefulWidget {
  final String? chatId;
  const UserChatScreen({super.key, this.chatId});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final GetAllMessagesController controller =
      Get.put(GetAllMessagesController());
  UserPreferences userPreferences = UserPreferences();

  String? myUserId;

  @override
  void initState() {
    super.initState();
    controller.getAllMessages(widget.chatId!);
    getUserId();
  }

  Future<void> getUserId() async {
    final user = await userPreferences.getUser();
    myUserId = user.user!.sId!;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('chats'.tr),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Obx(() {
                  final messages = controller.messages;
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (messages.isEmpty) {
                    return Center(child: Text('no_messages'.tr));
                  }

                  return ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * 0.04,
                        vertical: mq.height * 0.02),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMine = message.sender!.sId == myUserId;
                      final bubbleColor = isMine
                          ? theme.colorScheme.primary
                          : Colors.grey.shade400;

                      final alignment =
                          isMine ? Alignment.centerRight : Alignment.centerLeft;

                      final borderRadius = BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft:
                            isMine ? const Radius.circular(12) : Radius.zero,
                        bottomRight:
                            isMine ? Radius.zero : const Radius.circular(12),
                      );

                      return Align(
                        alignment: alignment,
                        child: Dismissible(
                          key: ValueKey(message.sId),
                          direction: isMine
                              ? DismissDirection.endToStart
                              : DismissDirection.none,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (_) async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("delete_message".tr),
                                content:
                                    Text("are_you_sure_you_want_to_delete".tr),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text("cancel".tr),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text("delete".tr,
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              controller.deleteMessage(
                                  message.sId!, widget.chatId!);
                              return true;
                            }
                            return false;
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: bubbleColor,
                              borderRadius: borderRadius,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: mq.width * 0.75,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.content ?? '',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isDarkMode || isMine
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    Utils.timeAgo(message.createdAt!),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                });
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * 0.04, vertical: mq.height * 0.008),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageTextController.value,
                    focusNode: controller.messageFocusNode.value,
                    textInputAction:
                        TextInputAction.send,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        controller.sendMessage(widget.chatId!);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "send_message".tr,
                      filled: true,
                      fillColor: theme.cardColor,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      if (controller.messageTextController.value.text
                          .trim()
                          .isNotEmpty) {
                        controller.sendMessage(widget.chatId!);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
