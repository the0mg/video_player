
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controller/video_ctr.dart';
import 'downloaded_video_screen.dart';


class VideoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(VideoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Video List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => Get.to(() => DownloadedVideosScreen()),
          ),
        ],
      ),
      body: GetBuilder<VideoController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.videos.length,
            itemBuilder: (context, index) {
              final videoCtrl = controller.controllers[index];
              final progress = controller.downloadProgress[index] ?? 0.0;

              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => controller.togglePlayPause(index),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          videoCtrl != null && videoCtrl.value.isInitialized
                              ? AspectRatio(
                            aspectRatio: videoCtrl.value.aspectRatio,
                            child: VideoPlayer(videoCtrl),
                          )
                              : CachedNetworkImage(
                            imageUrl: controller.videos[index]
                            ["thumbnailUrl"],
                            height: 200,
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/placeholder.png', fit: BoxFit.cover),
                            fit: BoxFit.cover,
                          ),

                          if (progress > 0 && progress < 1)
                            CircularProgressIndicator(value: progress),

                          if (progress == 0)
                            Icon(
                              videoCtrl != null && videoCtrl.value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                              size: 50,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(controller.videos[index]["title"]!),
                      trailing: IconButton(
                        icon: Icon(
                          controller.downloadedIndexes.contains(index)
                              ? Icons.download_done
                              : Icons.download,
                          color: controller.downloadedIndexes.contains(index)
                              ? Colors.green
                              : Colors.blue,
                        ),
                        onPressed: () => controller.downloadVideo(index),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
