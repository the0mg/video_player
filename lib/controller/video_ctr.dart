import 'dart:io';

import 'package:assesment_adintors/utility/video_downloader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {

  final List<Map<String, dynamic>> videos = [
    {
      "id":"1",
      "title":"Big Buck Bunny",
      "thumbnailUrl":"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Big_Buck_Bunny_thumbnail_vlc.png/1200px-Big_Buck_Bunny_thumbnail_vlc.png",
      "duration":"8:18",
      "uploadTime":"May 9, 2011",
      "views":"24,969,123",
      "author":"Vlc Media Player",
      "videoUrl":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "description":"Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttps://www.bigbuckbunny.org",
      "subscriber":"25254545 Subscribers",
      "isLive":true
    },
    {
      "id":"2",
      "title":"The first Blender Open Movie from 2006",
      "thumbnailUrl":"https://i.ytimg.com/vi_webp/gWw23EYM9VM/maxresdefault.webp",
      "duration":"12:18",
      "uploadTime":"May 9, 2011",
      "views":"24,969,123",
      "author":"Blender Inc.",
      "videoUrl":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "description":"Song : Raja Raja Kareja Mein Samaja\nAlbum : Raja Kareja Mein Samaja\nArtist : Radhe Shyam Rasia\nSinger : Radhe Shyam Rasia\nMusic Director : Sohan Lal, Dinesh Kumar\nLyricist : Vinay Bihari, Shailesh Sagar, Parmeshwar Premi\nMusic Label : T-Series",
      "subscriber":"25254545 Subscribers",
      "isLive":true
    },
    {
      "id":"3",
      "title":"For Bigger Blazes",
      "thumbnailUrl":"https://i.ytimg.com/vi/Dr9C2oswZfA/maxresdefault.jpg",
      "duration":"8:18",
      "uploadTime":"May 9, 2011",
      "views":"24,969,123",
      "author":"T-Series Regional",
      "videoUrl":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      "description":"Song : Raja Raja Kareja Mein Samaja\nAlbum : Raja Kareja Mein Samaja\nArtist : Radhe Shyam Rasia\nSinger : Radhe Shyam Rasia\nMusic Director : Sohan Lal, Dinesh Kumar\nLyricist : Vinay Bihari, Shailesh Sagar, Parmeshwar Premi\nMusic Label : T-Series",
      "subscriber":"25254545 Subscribers",
      "isLive":true
    },
    {
      "id":"4",
      "title":"For Bigger Escape",
      "thumbnailUrl":"https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg",
      "duration":"8:18",
      "uploadTime":"May 9, 2011",
      "views":"24,969,123",
      "author":"T-Series Regional",
      "videoUrl":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "description":" Introducing Chromecast. The easiest way to enjoy online video and music on your TV—for when Batman's escapes aren't quite big enough. For \$35. Learn how to use Chromecast with Google Play Movies and more at google.com/chromecast.",
      "subscriber":"25254545 Subscribers",
      "isLive":false
    },
    {
      "id":"5",
      "title":"Big Buck Bunny",
      "thumbnailUrl":"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Big_Buck_Bunny_thumbnail_vlc.png/1200px-Big_Buck_Bunny_thumbnail_vlc.png",
      "duration":"8:18",
      "uploadTime":"May 9, 2011",
      "views":"24,969,123",
      "author":"Vlc Media Player",
      "videoUrl":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "description":"Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttps://www.bigbuckbunny.org",
      "subscriber":"25254545 Subscribers",
      "isLive":true
    },
    {
      "id":"6",
      "title":"For Bigger Blazes",
      "thumbnailUrl":"https://i.ytimg.com/vi/Dr9C2oswZfA/maxresdefault.jpg",
      "duration":"8:18",
      "uploadTime":"May 9, 2011",
      "views":"24,969,123",
      "author":"T-Series Regional",
      "videoUrl":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      "description":"Song : Raja Raja Kareja Mein Samaja\nAlbum : Raja Kareja Mein Samaja\nArtist : Radhe Shyam Rasia\nSinger : Radhe Shyam Rasia\nMusic Director : Sohan Lal, Dinesh Kumar\nLyricist : Vinay Bihari, Shailesh Sagar, Parmeshwar Premi\nMusic Label : T-Series",
      "subscriber":"25254545 Subscribers",
      "isLive":false
    },
    {
      "id":"7",
      "title":"For Bigger Escape",
      "thumbnailUrl":"https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg",
      "duration":"8:18",
      "uploadTime":"May 9, 2011",
      "views":"24,969,123",
      "author":"T-Series Regional",
      "videoUrl":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "description":" Introducing Chromecast. The easiest way to enjoy online video and music on your TV—for when Batman's escapes aren't quite big enough. For \$35. Learn how to use Chromecast with Google Play Movies and more at google.com/chromecast.",
      "subscriber":"25254545 Subscribers",
      "isLive":true
    },
    {
      "id":"8",
      "title":"The first Blender Open Movie from 2006",
      "thumbnailUrl":"https://i.ytimg.com/vi_webp/gWw23EYM9VM/maxresdefault.webp",
      "duration":"12:18",
      "uploadTime":"May 9, 2011",
      "views":"24,969,123",
      "author":"Blender Inc.",
      "videoUrl":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "description":"Song : Raja Raja Kareja Mein Samaja\nAlbum : Raja Kareja Mein Samaja\nArtist : Radhe Shyam Rasia\nSinger : Radhe Shyam Rasia\nMusic Director : Sohan Lal, Dinesh Kumar\nLyricist : Vinay Bihari, Shailesh Sagar, Parmeshwar Premi\nMusic Label : T-Series",
      "subscriber":"25254545 Subscribers",
      "isLive":false
    }
  ];

  final List<VideoPlayerController?> controllers = [];
  RxMap<int, double> downloadProgress = <int, double>{}.obs;
  final RxSet<int> downloadedIndexes = <int>{}.obs;
  RxList<String> downloadedVideos = <String>[].obs;

  void updateDownloadProgress(int index, double progress) {
    downloadProgress[index] = progress;
    update();
  }

  Future<void> downloadVideo(int index) async {
    final url = videos[index]["videoUrl"]!;
    final directory = await getDownloadsDirectory();
    final filePath = "${directory!.path}/video_$index.mp4";

    if (File(filePath).existsSync()) {
      Get.snackbar("Download", "Already downloaded!");
      return;
    }
    if (await VideoDownloader.requestStoragePermission()) {
      try {
        downloadProgress[index] = 0.0;
        update();

        await Dio().download(
          url,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              downloadProgress[index] = received / total;
              update();
            }
          },
        );

        downloadedIndexes.add(index);
        _saveDownloadedVideo(filePath);
        downloadProgress.remove(index);
        update();
        Get.snackbar("Download", "Download completed!");
      } catch (e) {
        Get.snackbar("Error", "Download failed!");
        downloadProgress.remove(index);
        update();
      }
    }else{
      Get.snackbar("Error", "Permission required!");
    }

  }

  Future<void> _saveDownloadedVideo(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    downloadedVideos.add(path);
    prefs.setStringList("downloaded_videos", downloadedVideos);
  }

  Future<void> _loadDownloadedVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    downloadedVideos.assignAll(prefs.getStringList("downloaded_videos") ?? []);
    update();
  }


  @override
  void onInit() {
    super.onInit();
    for (var i = 0; i < videos.length; i++) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(videos[i]["videoUrl"]!));

      controllers.add(controller);
      controller.initialize().then((_) {
        if (i == 0) {
          // Auto-play the first video
          controller.play();
        }
        update(); // Auto update UI after initialization
      });
    }
    _loadDownloadedVideos();
  }


  void togglePlayPause(int index) {
    final controller = controllers[index];

    if (controller != null && controller.value.isInitialized) {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        // Pause all other videos
        for (var c in controllers) {
          c?.pause();
        }
        controller.play();
      }
      update();
    }
  }

  @override
  void onClose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.onClose();
  }
}
