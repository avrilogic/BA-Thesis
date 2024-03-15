class SettingsState {
  final SettingsBasicsState basics;
  final SettingsGroupStateBase channels;

  const SettingsState({required this.basics, required this.channels});
  static const initial = SettingsState(
    basics: SettingsBasicsState.initial,
    channels: SettingsGroupStateBase.initial,
  );

  SettingsState copyWith({
    SettingsBasicsState? basics,
    SettingsGroupStateBase? channels,
  }) {
    return SettingsState(
      basics: basics ?? this.basics,
      channels: channels ?? this.channels,
    );
  }
}

final class SettingsBasicsState extends SettingsGroupStateBase {
  final int task;
  final double value;
  final String name;

  const SettingsBasicsState({
    super.isEnabled,
    this.task = 0,
    this.value = 0.0,
    this.name = '',
  });
  static const initial = SettingsBasicsState();

  @override
  SettingsBasicsState copyWith({
    bool? isEnabled,
    int? task,
    double? value,
    String? name,
  }) =>
      SettingsBasicsState(
        isEnabled: isEnabled ?? this.isEnabled,
        task: task ?? this.task,
        value: value ?? this.value,
        name: name ?? this.name,
      );
}

base class SettingsGroupStateBase {
  final bool isEnabled;

  const SettingsGroupStateBase({this.isEnabled = false});
  static const initial = SettingsGroupStateBase();
  SettingsGroupStateBase copyWith({bool? isEnabled}) => SettingsGroupStateBase(
        isEnabled: isEnabled ?? this.isEnabled,
      );
}
