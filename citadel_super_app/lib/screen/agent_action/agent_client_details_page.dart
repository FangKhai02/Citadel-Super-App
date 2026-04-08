import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/vo/agent_client_vo.dart';
import 'package:citadel_super_app/extension/agent_client_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/agent_action/component/client_purchased_portfolio_widget.dart';
import 'package:citadel_super_app/screen/agent_action/component/dividend_payout_widget.dart';
import 'package:citadel_super_app/screen/agent_action/consent_request_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_profile_page.dart';
import 'package:citadel_super_app/screen/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentClientDetailsPage extends HookConsumerWidget {
  final AgentRepository repository = AgentRepository();
  final AgentClientVo client;

  AgentClientDetailsPage({super.key, required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCorporate = (client.clientId ?? '').characters.last == 'C';

    final clientPortfolioDetails = isCorporate
        ? ref.watch(corporatePortfolioFutureProvider(client.clientId ?? ''))
        : ref.watch(agentClientPortfolioFutureProvider(client.clientId ?? ''));
    final clientTransactionDetails = isCorporate
        ? ref.watch(corporateTransactionFutureProvider(client.clientId ?? ''))
        : ref.watch(
            agentClientTransactionsFutureProvider(client.clientId ?? ''));

    Widget clientPersonalDetails() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Personal Details',
                  style: AppTextStyle.header2,
                ),
              ),
              AppTextButton(
                  title: 'View More',
                  onTap: () {
                    isCorporate
                        ? Navigator.pushNamed(
                            context, CustomRouter.corporateProfile,
                            arguments: CorporateProfilePage(
                                corporateClientId: client.clientIdDisplay))
                        : Navigator.pushNamed(
                            context, CustomRouter.clientProfile,
                            arguments:
                                ProfilePage(clientId: client.clientIdDisplay));
                  }),
            ],
          ),
          gapHeight16,
          AppInfoContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Name',
                  style: AppTextStyle.label,
                ),
                gapHeight8,
                Text(
                  client.nameDisplay,
                  style: AppTextStyle.bodyText,
                ),
                gapHeight16,
                Text(
                  'Member ID',
                  style: AppTextStyle.label,
                ),
                gapHeight8,
                Text(
                  client.clientIdDisplay,
                  style: AppTextStyle.bodyText,
                ),
                gapHeight16,
                Text(
                  'Date Joined',
                  style: AppTextStyle.label,
                ),
                gapHeight8,
                Text(
                  client.joinedDateDisplay,
                  style: AppTextStyle.bodyText,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        onRefresh: () async {
          // ignore: unused_result
          await ref.refresh(
              agentClientPortfolioFutureProvider(client.clientId ?? '').future);
          // ignore: unused_result
          await ref.refresh(
              agentClientTransactionsFutureProvider(client.clientId ?? '')
                  .future);
        },
        child: Column(
          children: [
            const CitadelAppBar(title: 'Client Details'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  clientPersonalDetails(),
                  gapHeight32,
                  clientPortfolioDetails.when(data: (data) {
                    return ClientPurchasedPortfolioWidget(
                        clientId: client.clientId, clientPortfolioList: data);
                  }, error: (error, stackTrace) {
                    return AppInfoContainer(
                      child: Text(
                        'Unable to retrieve data. Please try again',
                        style: AppTextStyle.label,
                      ),
                    );
                  }, loading: () {
                    return const Center(child: CircularProgressIndicator());
                  }),
                  gapHeight32,
                  clientTransactionDetails.when(data: (data) {
                    return ClientTransactionsWidget(clientTransactions: data);
                  }, error: (error, stackTrace) {
                    return AppInfoContainer(
                        child: Text(
                      'Unable to retrieve data. Please try again',
                      style: AppTextStyle.label,
                    ));
                  }, loading: () {
                    return const Center(child: CircularProgressIndicator());
                  }),
                  gapHeight32,
                  PrimaryButton(
                    title: 'Product Placement',
                    onTap: () async {
                      await getAgentSecureTag(context);
                    },
                  ),
                  gapHeight16,
                  Text(
                      "You will need to request your client's consent, which will be valid for 30 minutes before requiring again.",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.caption),
                ],
              ),
            )
          ],
        ));
  }

  Future<void> getAgentSecureTag(BuildContext context) async {
    EasyLoadingHelper.show();
    await repository
        .requestAgentSecureTag(client.clientIdDisplay)
        .baseThen(context, onResponseSuccess: (_) {
      Navigator.pushNamed(
        context,
        CustomRouter.consentRequest,
        arguments: ConsentRequestPage(client.clientIdDisplay),
      );
    }, onResponseError: (response, s) {
      if (response.message == 'api.secure.tag.already.created') {
        Navigator.pushNamed(
          context,
          CustomRouter.consentRequest,
          arguments: ConsentRequestPage(client.clientIdDisplay),
        );
      }
    }).whenComplete(() => EasyLoadingHelper.dismiss());
  }
}
