import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionsPage extends HookConsumerWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appProvider).appSettings ?? [];
    final url = settings
            .firstWhere((element) =>
                element.key == AppSettingsKey.termsAndConditionsUrl)
            .value ??
        '';
    final isLoading = useState(true);
    final controller = useMemoized(() {
      final ctrl = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              isLoading.value = true;
            },
            onPageStarted: (String url) {
              isLoading.value = true;
            },
            onPageFinished: (String url) {
              isLoading.value = false;
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
      return ctrl;
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.pureWhite,
      appBar: CitadelAppBar(
        title: 'Terms & Conditions',
        titleColor: Colors.black,
        leading: Center(
            child: AppBackButton(
                image: Image.asset(
                  Assets.images.icons.group7898.path,
                  width: 24,
                  height: 24,
                ),
                color: Colors.black)),
        actions: [
          Image.asset(
            Assets.images.icons.icon.path,
            width: 24,
            height: 24,
          ),
        ],
      ),
      child: Stack(children: [
        WebViewWidget(controller: controller),
        if (isLoading.value)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ]),
    );
  }
}
