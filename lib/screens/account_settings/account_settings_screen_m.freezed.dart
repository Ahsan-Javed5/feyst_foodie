// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_settings_screen_m.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountSettingsScreenState {
  String get selectedDateFormat => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String selectedDateFormat) initialized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String selectedDateFormat)? initialized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String selectedDateFormat)? initialized,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialized value)? initialized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountSettingsScreenStateCopyWith<AccountSettingsScreenState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountSettingsScreenStateCopyWith<$Res> {
  factory $AccountSettingsScreenStateCopyWith(AccountSettingsScreenState value,
          $Res Function(AccountSettingsScreenState) then) =
      _$AccountSettingsScreenStateCopyWithImpl<$Res,
          AccountSettingsScreenState>;
  @useResult
  $Res call({String selectedDateFormat});
}

/// @nodoc
class _$AccountSettingsScreenStateCopyWithImpl<$Res,
        $Val extends AccountSettingsScreenState>
    implements $AccountSettingsScreenStateCopyWith<$Res> {
  _$AccountSettingsScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDateFormat = null,
  }) {
    return _then(_value.copyWith(
      selectedDateFormat: null == selectedDateFormat
          ? _value.selectedDateFormat
          : selectedDateFormat // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitializedImplCopyWith<$Res>
    implements $AccountSettingsScreenStateCopyWith<$Res> {
  factory _$$InitializedImplCopyWith(
          _$InitializedImpl value, $Res Function(_$InitializedImpl) then) =
      __$$InitializedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String selectedDateFormat});
}

/// @nodoc
class __$$InitializedImplCopyWithImpl<$Res>
    extends _$AccountSettingsScreenStateCopyWithImpl<$Res, _$InitializedImpl>
    implements _$$InitializedImplCopyWith<$Res> {
  __$$InitializedImplCopyWithImpl(
      _$InitializedImpl _value, $Res Function(_$InitializedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDateFormat = null,
  }) {
    return _then(_$InitializedImpl(
      selectedDateFormat: null == selectedDateFormat
          ? _value.selectedDateFormat
          : selectedDateFormat // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InitializedImpl implements Initialized {
  const _$InitializedImpl({this.selectedDateFormat = 'dd/MM/yyyy'});

  @override
  @JsonKey()
  final String selectedDateFormat;

  @override
  String toString() {
    return 'AccountSettingsScreenState.initialized(selectedDateFormat: $selectedDateFormat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializedImpl &&
            (identical(other.selectedDateFormat, selectedDateFormat) ||
                other.selectedDateFormat == selectedDateFormat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDateFormat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitializedImplCopyWith<_$InitializedImpl> get copyWith =>
      __$$InitializedImplCopyWithImpl<_$InitializedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String selectedDateFormat) initialized,
  }) {
    return initialized(selectedDateFormat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String selectedDateFormat)? initialized,
  }) {
    return initialized?.call(selectedDateFormat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String selectedDateFormat)? initialized,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(selectedDateFormat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initialized value)? initialized,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class Initialized implements AccountSettingsScreenState {
  const factory Initialized({final String selectedDateFormat}) =
      _$InitializedImpl;

  @override
  String get selectedDateFormat;
  @override
  @JsonKey(ignore: true)
  _$$InitializedImplCopyWith<_$InitializedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
