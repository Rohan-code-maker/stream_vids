import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/res/routes/route_name.dart';
import 'package:stream_vids/view_models/controller/user/watch_history/add_watch_history_controller.dart';
import 'package:stream_vids/view_models/controller/video_folder/search/search_controller.dart';
import 'package:stream_vids/view_models/services/splash_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.handleAppNavigation();
  }

  final SearchVideoController _searchController =
      Get.put(SearchVideoController());
  final addWatchHistoryController = Get.put(AddWatchHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Search for videos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                _searchController.onSearchChanged(value);
              },
            ),
            const SizedBox(height: 16.0),
            Obx(() {
              if (_searchController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_searchController.videoList.isEmpty) {
                return const Center(
                  child: Text('No videos found'),
                );
              }

              return Flexible(
                child: ListView.builder(
                  itemCount: _searchController.videoList.length,
                  itemBuilder: (context, index) {
                    final video = _searchController.videoList[index];
                    return ListTile(
                      leading: Image.network(
                        video.thumbnail,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image);
                        },
                      ),
                      title: Text(video.title),
                      subtitle: Text(video.description),
                      onTap: () {
                        addWatchHistoryController.addToWatchHistory(
                            _searchController.videoList[index].id);
                        Get.toNamed(
                          RouteName.videoScreen.replaceFirst(':videoId',
                              _searchController.videoList[index].id),
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
