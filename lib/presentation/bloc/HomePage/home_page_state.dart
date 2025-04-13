import "package:freezed_annotation/freezed_annotation.dart";

part "home_page_state.freezed.dart";

@freezed
sealed class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState() = _HomePageState;
}
