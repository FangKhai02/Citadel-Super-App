import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentCreateProductPurchaseOrderResultPage extends HookConsumerWidget {
  final String clientId;
  const AgentCreateProductPurchaseOrderResultPage(
      {super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResultPage(
        imagePath: Assets.images.icons.paymentSuccess.path,
        title: 'Order created',
        description: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text:
                  'We have sent the order to your client to complete the payment. You may check the order progress in ',
              style: AppTextStyle.bodyText,
              children: [
                TextSpan(text: 'Home > My Clients.', style: AppTextStyle.action)
              ]),
        ),
        bottomButton: PrimaryButton(
          title: 'Back to Home',
          onTap: () {
            ref.invalidate(agentClientPortfolioFutureProvider(clientId));
            Navigator.pushNamedAndRemoveUntil(
                context, CustomRouter.dashboard, (route) => route.isFirst);
          },
        ));
  }
}
