import 'package:flutter/material.dart';
import 'package:flutter_experiments/settings/settings_state.dart';

typedef UpdateFunction = SettingsState Function(SettingsState);

class SettingsProvider extends ChangeNotifier {
  SettingsState state = SettingsState.initial;

  void updateState(UpdateFunction update) {
    state = update(state);
    notifyListeners();
  }

  void toggleBasics(bool? value) {
    updateState((state) => state.copyWith(
        basics: state.basics
            .copyWith(isEnabled: value ?? !state.basics.isEnabled)));
  }

  void toggleChannels(bool? value) {
    updateState((state) => state.copyWith(
        channels: state.channels
            .copyWith(isEnabled: value ?? !state.channels.isEnabled)));
  }
}
