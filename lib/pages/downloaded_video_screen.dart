import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controller/video_ctr.dart';

class DownloadedVideosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videoController = Get.find<VideoController>();

    return Scaffold(
      appBar: AppBar(title: Text("Downloaded Videos")),
      body: GetBuilder<VideoController>(
        builder: (controller) {
          if (controller.downloadedVideos.isEmpty) {
            return Center(child: Text("No videos downloaded yet."));
          }

          return ListView.builder(
            itemCount: controller.downloadedVideos.length,
            itemBuilder: (context, index) {
              final videoPath = controller.downloadedVideos[index];
              final videoPlayerController = VideoPlayerController.file(File(videoPath));

              return FutureBuilder(
                future: videoPlayerController.initialize(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(videoPlayerController),
                        ),
                        ListTile(
                          title: Text("Downloaded Video ${index + 1}"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              videoController.downloadedVideos.removeAt(index);
                              File(videoPath).deleteSync();
                              videoController.update();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
