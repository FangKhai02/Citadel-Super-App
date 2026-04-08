import 'dart:io';

import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';

class PdfViewerWidget extends HookWidget {
  final dynamic file;

  const PdfViewerWidget({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final PdfControllerPinch pdfPinchController = useMemoized(() {
      if (file is NetworkFile) {
        return PdfControllerPinch(
          document: PdfDocument.openData(
            http
                .get(Uri.parse(file.url))
                .then((response) => response.bodyBytes),
          ),
        );
      } else if (file is File) {
        return PdfControllerPinch(
          document: PdfDocument.openFile(file.path),
        );
      } else {
        throw Exception('Invalid file type');
      }
    }, []);

    return PdfViewPinch(controller: pdfPinchController);
  }
}
