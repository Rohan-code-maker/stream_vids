import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/view_models/controller/chats/available_users/available_users_controller.dart';
import 'package:stream_vids/view_models/controller/chats/create_one_chat/create_one_chat_controller.dart';

class AvailableUsers extends StatefulWidget {
  const AvailableUsers({super.key});

  @override
  State<AvailableUsers> createState() => _AvailableUsersState();
}

class _AvailableUsersState extends State<AvailableUsers> {
  final AvailableUsersController controller = Get.put(AvailableUsersController());
  final CreateOneChatController createOneChatController = Get.put(CreateOneChatController());

  @override
  void initState() {
    super.initState();
    controller.getAllChats(); // Fetch chats on screen load
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'available_users'.tr,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mq.width * 0.04,
              vertical: mq.height * 0.015,
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: controller.updateSearch,
                  decoration: InputDecoration(
                    hintText: 'search'.tr,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: isDarkMode ? Colors.grey[850] : Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: mq.height * 0.02),
                Expanded(
                  child: Obx(() {
                    var chatList = controller.availableUsersList;

                    if (chatList.isEmpty) {
                      return Center(
                        child: Text(
                          "no_chats".tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatList.length,
                      separatorBuilder: (_, __) => Divider(
                        color: isDarkMode ? Colors.white10 : Colors.grey[300],
                        thickness: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        final chat = chatList[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          leading: CircleAvatar(
                            radius: mq.width * 0.06,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                chat.avatar ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person,
                                    size: mq.width * 0.08,
                                    color: Colors.white,
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            chat.username ?? '',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              createOneChatController.addChat(chat.sId!);
                            },
                            icon: Icon(Icons.person_add_alt_1,
                                color: isDarkMode ? Colors.white : Colors.black54),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
