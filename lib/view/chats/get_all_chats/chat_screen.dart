import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/res/user_preferences/user_preferences.dart';
import 'package:stream_vids/view_models/controller/chats/get_all_chats/get_all_chats_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GetAllChatsController controller = Get.put(GetAllChatsController());
  UserPreferences userPreferences = UserPreferences();

  late String myUserId;

  @override
  void initState() {
    super.initState();
    controller.getAllChats();
    getUserId();
  }

  Future<void> getUserId() async {
    final user = await userPreferences.getUser();
    myUserId = user.user!.sId!;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'chat_screen'.tr,
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
                    final chatList = controller.chatsList;

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
                      itemCount: chatList.length,
                      separatorBuilder: (_, __) => Divider(
                        color: isDarkMode ? Colors.white10 : Colors.grey[300],
                        thickness: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        final chat = chatList[index];

                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          leading: CircleAvatar(
                            radius: mq.width * 0.06,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  myUserId == chat.participants![0].sId
                                      ? chat.participants![1].avatar!
                                      : chat.participants![0].avatar!,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          title: Text(
                            myUserId == chat.participants![0].sId
                                ? chat.participants![1].fullname!
                                : chat.participants![0].fullname!,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            chat.lastMessage?.content ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall,
                          ),
                          onTap: () {
                            Get.toNamed(
                              RouteName.userChatScreen
                                  .replaceFirst(':chatId', chat.sId!),
                            );
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.searchAvailableUsersScreen);
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
    );
  }
}
