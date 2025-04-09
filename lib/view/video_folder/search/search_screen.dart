import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/user/watch_history/add_watch_history_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/search/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final SearchVideoController _searchController = Get.put(SearchVideoController());
  final AddWatchHistoryController addWatchHistoryController = Get.put(AddWatchHistoryController());

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'search'.tr,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? mq.width * 0.08 : mq.width * 0.04,
              vertical: mq.height * 0.02,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _textEditingController,
                  onChanged: _searchController.onSearchChanged,
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: 'search_video'.tr,
                    labelStyle: theme.textTheme.bodyMedium,
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
                    if (_searchController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_searchController.videoList.isEmpty) {
                      return Center(
                        child: Text(
                          'no_data'.tr,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _searchController.videoList.length,
                      separatorBuilder: (_, __) => SizedBox(height: mq.height * 0.01),
                      itemBuilder: (context, index) {
                        final video = _searchController.videoList[index];
                        final thumbnailWidth = isWideScreen ? 160.0 : mq.width * 0.3;
                        final thumbnailHeight = isWideScreen ? 100.0 : mq.width * 0.2;

                        return InkWell(
                          onTap: () {
                            addWatchHistoryController.addToWatchHistory(video.id);
                            Get.toNamed(RouteName.videoScreen.replaceFirst(':videoId', video.id));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode ? Colors.black12 : Colors.grey.shade300,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    video.thumbnail,
                                    width: thumbnailWidth,
                                    height: thumbnailHeight,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: thumbnailWidth,
                                      height: thumbnailHeight,
                                      color: Colors.grey,
                                      child: const Icon(Icons.broken_image, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(mq.width * 0.03),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          video.title,
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          video.createdBy.username,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: isDarkMode ? Colors.white60 : Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
