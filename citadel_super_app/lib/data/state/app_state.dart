import 'package:citadel_super_app/data/vo/agency_vo.dart';
import 'package:citadel_super_app/data/vo/constant_vo.dart';
import 'package:citadel_super_app/data/vo/key_value_map_vo.dart';
import 'package:citadel_super_app/data/vo/settings_item_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppVo {
  final List<SettingsItemVo>? appSettings;
  final List<AgencyVo>? agencies;
  final List<ConstantVo>? constants;
  final List<KeyValueMapVo>? allConstants;

  AppVo({this.appSettings, this.agencies, this.constants, this.allConstants});

  AppVo copyWith(
      {List<SettingsItemVo>? appSettings,
      List<AgencyVo>? agencies,
      List<ConstantVo>? constants,
      List<KeyValueMapVo>? allConstants}) {
    return AppVo(
      appSettings: appSettings ?? this.appSettings,
      agencies: agencies ?? this.agencies,
      constants: constants ?? this.constants,
      allConstants: allConstants ?? this.allConstants,
    );
  }
}

final appProvider = StateNotifierProvider<AppState, AppVo>((ref) {
  return AppState();
});

class AppState extends StateNotifier<AppVo> {
  AppState() : super(AppVo());

  void setAppSettings(List<SettingsItemVo> appSettings) {
    state = state.copyWith(appSettings: appSettings);
  }

  void setAgencies(List<AgencyVo> agencies) {
    state = state.copyWith(agencies: agencies);
  }

  void setConstants(List<ConstantVo> constants) {
    state = state.copyWith(constants: constants);

    final allItems = constants
        .where((constant) => constant.list != null)
        .expand((constant) => constant.list!)
        .toList();

    state = state.copyWith(allConstants: allItems);
  }
}
