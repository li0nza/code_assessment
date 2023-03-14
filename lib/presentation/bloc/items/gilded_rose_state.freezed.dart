// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gilded_rose_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GildedRoseState {
  GildedRoseModel? get data => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GildedRoseStateCopyWith<GildedRoseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GildedRoseStateCopyWith<$Res> {
  factory $GildedRoseStateCopyWith(
          GildedRoseState value, $Res Function(GildedRoseState) then) =
      _$GildedRoseStateCopyWithImpl<$Res, GildedRoseState>;
  @useResult
  $Res call({GildedRoseModel? data, bool hasError, bool isLoading});

  $GildedRoseModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$GildedRoseStateCopyWithImpl<$Res, $Val extends GildedRoseState>
    implements $GildedRoseStateCopyWith<$Res> {
  _$GildedRoseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? hasError = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GildedRoseModel?,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GildedRoseModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GildedRoseModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AuthenticationStateCopyWith<$Res>
    implements $GildedRoseStateCopyWith<$Res> {
  factory _$$_AuthenticationStateCopyWith(_$_AuthenticationState value,
          $Res Function(_$_AuthenticationState) then) =
      __$$_AuthenticationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GildedRoseModel? data, bool hasError, bool isLoading});

  @override
  $GildedRoseModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$_AuthenticationStateCopyWithImpl<$Res>
    extends _$GildedRoseStateCopyWithImpl<$Res, _$_AuthenticationState>
    implements _$$_AuthenticationStateCopyWith<$Res> {
  __$$_AuthenticationStateCopyWithImpl(_$_AuthenticationState _value,
      $Res Function(_$_AuthenticationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? hasError = null,
    Object? isLoading = null,
  }) {
    return _then(_$_AuthenticationState(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GildedRoseModel?,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AuthenticationState extends _AuthenticationState {
  const _$_AuthenticationState(
      {this.data, this.hasError = false, this.isLoading = false})
      : super._();

  @override
  final GildedRoseModel? data;
  @override
  @JsonKey()
  final bool hasError;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'GildedRoseState(data: $data, hasError: $hasError, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthenticationState &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, hasError, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthenticationStateCopyWith<_$_AuthenticationState> get copyWith =>
      __$$_AuthenticationStateCopyWithImpl<_$_AuthenticationState>(
          this, _$identity);
}

abstract class _AuthenticationState extends GildedRoseState {
  const factory _AuthenticationState(
      {final GildedRoseModel? data,
      final bool hasError,
      final bool isLoading}) = _$_AuthenticationState;
  const _AuthenticationState._() : super._();

  @override
  GildedRoseModel? get data;
  @override
  bool get hasError;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_AuthenticationStateCopyWith<_$_AuthenticationState> get copyWith =>
      throw _privateConstructorUsedError;
}
