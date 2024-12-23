import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_vids/view_models/controller/search/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final SearchVideoController _searchController = Get.put(SearchVideoController());
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
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
                        video.thumbnail ?? 'https://via.placeholder.com/150',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image);
                        },
                      ),
                      title: Text(video.title),
                      subtitle: Text(video.description),
                      onTap: () {
                        // Handle video tap
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

