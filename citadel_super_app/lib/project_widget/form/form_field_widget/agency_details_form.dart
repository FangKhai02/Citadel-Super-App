import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/repository/app_repository.dart';
import 'package:citadel_super_app/data/response/agency_list_response_vo.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/existing_agent_state.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/vo/agency_agent_vo.dart';

class AgencyDetailsForm extends StatefulHookConsumerWidget {
  final GlobalKey<AppFormState> formKey;

  const AgencyDetailsForm({super.key, required this.formKey});

  @override
  AgencyDetailsFormState createState() => AgencyDetailsFormState();
}

class AgencyDetailsFormState extends ConsumerState<AgencyDetailsForm> {
  late TextEditingController agencyIDTec;
  List<AgencyAgentVo> managerList = [];
  late String selectedAgencyCode;

  @override
  void initState() {
    agencyIDTec = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var agencies = ref.read(appProvider).agencies;
    final existingAgentState = ref.watch(existingAgentProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (existingAgentState?.agencyDetails != null) {
          agencyIDTec.text = existingAgentState?.agencyDetails?.agencyId ?? '';

          // signUpNotifier.setPEPDeclarationPoliticalRelated(
          //     existingClientState?.pepDeclaration?.isPep);

          // switch (existingClientState?.getPepRelationship()) {
          //   case 'Self':
          //     signUpNotifier
          //         .setPepDeclarationRelationship(RelationshipWithPep.self);
          //     break;
          //   case 'Immediate Family Member':
          //     signUpNotifier.setPepDeclarationRelationship(
          //         RelationshipWithPep.familyMember);
          //     break;
          //   case 'Close Associate':
          //     signUpNotifier.setPepDeclarationRelationship(
          //         RelationshipWithPep.closeAssociate);
          //     break;
          // }

          // nameController.text = existingClientState
          //         ?.pepDeclaration?.pepDeclarationOptions?.name ??
          //     '';
          // positionController.text = existingClientState
          //         ?.pepDeclaration?.pepDeclarationOptions?.position ??
          //     '';
          // organisationController.text = existingClientState
          //         ?.pepDeclaration?.pepDeclarationOptions?.organization ??
          //     '';
        }
      });
      return;
    }, []);

    List<AppDropDownItem> getAgenciesCodeList() {
      List<AppDropDownItem> list = [];
      if ((agencies ?? []).isEmpty) {
        AppRepository appRepository = AppRepository();

        appRepository.getAgencies().baseThen(context,
            onResponseSuccess: (resp) {
          AgencyListResponseVo agencyListResponseVo =
              AgencyListResponseVo.fromJson(resp);

          if (agencyListResponseVo.code == '200' &&
              (agencyListResponseVo.agencyList ?? []).isNotEmpty) {
            setState(() {
              ref
                  .read(appProvider.notifier)
                  .setAgencies(agencyListResponseVo.agencyList ?? []);
              agencies = agencyListResponseVo.agencyList;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: AppColor.errorRed,
                content: Text('Unable to get agency list, please try again')));
          }
        });
      } else {
        for (final agency in agencies!) {
          if (agency.agencyCode == null) continue;
          list.add(AppDropDownItem(
              value: agency.agencyCode!, text: agency.agencyCode!));
        }
      }

      return list;
    }

    List<AppDropDownItem> getManagerList() {
      List<AppDropDownItem> list = [];
      for (final manager in managerList) {
        list.add(
          AppDropDownItem(
              value: manager.agentId ?? '-', text: manager.agentId ?? '-'),
        );
      }
      return list;
    }

    void getManagerListFromAgencyId(String agencyId) {
      AgentRepository repo = AgentRepository();

      repo.getAgentsById(agencyId).baseThen(context, onResponseSuccess: (resp) {
        setState(() {
          managerList = resp.agentsList ?? [];
        });
      }, onResponseError: (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColor.errorRed,
            content: Text('Unable to get recruitment manager list')));
      });
    }

    return Column(
      children: [
        AppDropdown(
          formKey: widget.formKey,
          label: 'Agency Code',
          fieldKey: AppFormFieldKey.agencyCodeKey,
          hintText: 'Agency Code',
          initialValue: existingAgentState?.agencyCode ?? '',
          options: getAgenciesCodeList(),
          onSelected: (item) {
            setState(() {
              agencyIDTec.text = agencies
                      ?.firstWhere(
                          (element) => element.agencyCode == item.value)
                      .agencyId ??
                  '';
              getManagerListFromAgencyId(agencyIDTec.text);
            });
          },
        ),
        AppTextFormField(
          formKey: widget.formKey,
          label: 'Agency ID',
          fieldKey: AppFormFieldKey.agencyIDKey,
          readOnly: true,
          controller: agencyIDTec,
        ),
        AppTextFormField(
          formKey: widget.formKey,
          label: 'Recruitment Manager (Agent ID)',
          initialValue:
              existingAgentState?.agencyDetails?.recruitManagerCode ?? '',
          fieldKey: AppFormFieldKey.recruitmentManagerKey,
        ),
      ],
    );
  }
}
