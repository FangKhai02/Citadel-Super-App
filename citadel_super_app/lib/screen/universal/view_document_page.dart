import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';

class ViewDocumentPage extends HookWidget {
  final String url;
  final String docName;

  const ViewDocumentPage({super.key, required this.url, required this.docName});

  @override
  Widget build(BuildContext context) {
    final PdfController pdfPinchController = useMemoized(() {
      return PdfController(
        document: PdfDocument.openData(
            http.get(Uri.parse(url)).then((response) => response.bodyBytes)),
      );
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.pureWhite,
        appBar: CitadelAppBar(
          title: docName,
          titleColor: AppColor.mainBlack,
        ),
        child: Column(children: [
          Flexible(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: PdfView(
                  controller: pdfPinchController,
                )),
          )
        ]));
  }
}
