import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gilded_rose_state.freezed.dart';

/// State representing the current state of the [GildedRoseCubit].
@Freezed(
  fromJson: false,
  toJson: false,
)
class GildedRoseState with _$GildedRoseState {
  /// Private zero-args constructor needed for supporting extra
  /// methods with [freezed].
  const GildedRoseState._();

  /// Constructs a [GildedRoseState] used to pass data from the
  /// [GildedRoseCubit] to the UI elements that need to respond changes.
  const factory GildedRoseState({
    GildedRoseModel? data,
    @Default(false) bool hasError,
    @Default(false) bool isLoading,
  }) = _AuthenticationState;
}