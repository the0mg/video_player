import 'dart:io';

import 'package:assesment_adintors/controller/video_ctr.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoDownloader {
  static Future<void> downloadVideo(String url, int index, BuildContext context) async {
    final videoController = Get.find<VideoController>();
    // Request storage permission
    if (await requestStoragePermission()) {
      try {
        Directory? dir = await getDownloadsDirectory();
        String savePath = "${dir!.path}/video.mp4";

        Dio dio = Dio();
        await dio.download(url, savePath, onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = (received / total);
            videoController.updateDownloadProgress(index, progress);
            print("Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        });

        print("Video downloaded to: $savePath");
        var snackBar = SnackBar(content: Text('Video downloaded'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Storage permission denied");
    }
  }

  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }
}