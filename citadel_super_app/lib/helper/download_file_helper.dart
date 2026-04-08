import 'dart:async';
import 'dart:io';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFileHelper {
  Future<void> downloadAndOpenPDF(BuildContext context, String url) async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;

        if (!status.isGranted) {
          status = await Permission.storage.request();
        }

        if (status.isGranted) {
          print("Storage permission granted");
        } else {
          print("Storage permission denied");
        }
      }

      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) return;

      final fileName =
          url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf(".pdf") + 4);

      String filePath = "${directory.path}/$fileName";

      Dio dio = Dio();
      await dio.download(url, filePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          // context.showSnackBar('Downloading...', AppColor.noteBlack);
        }
      });

      // context.showSuccessSnackBar('Download done.');

      OpenFilex.open(filePath);
    } catch (e) {
      context.showErrorSnackBar(
          'There was a problem with download, please try again.');
    }
  }

  Future<File> createFileOfPdfFromUrl(String url) async {
    Completer<File> completer = Completer();

    EasyLoadingHelper.show();
    try {
      final fileName =
          url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf(".pdf") + 4);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();

      File file = File("${dir.path}/$fileName");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      EasyLoadingHelper.dismiss();
      throw Exception('Error parsing asset file!');
    }

    EasyLoadingHelper.dismiss();
    return completer.future;
  }
}
