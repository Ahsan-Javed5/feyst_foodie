// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_up_screen_m.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignUpScreenState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)
        initialized,
    required TResult Function() loading,
    required TResult Function(List<ProfessionData> data) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)?
        initialized,
    TResult Function()? loading,
    TResult Function(List<ProfessionData> data)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)?
        initialized,
    TResult Function()? loading,
    TResult Function(List<ProfessionData> data)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpScreenStateCopyWith<$Res> {
  factory $SignUpScreenStateCopyWith(
          SignUpScreenState value, $Res Function(SignUpScreenState) then) =
      _$SignUpScreenStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SignUpScreenStateCopyWithImpl<$Res>
    implements $SignUpScreenStateCopyWith<$Res> {
  _$SignUpScreenStateCopyWithImpl(this._value, this._then);

  final SignUpScreenState _value;
  // ignore: unused_field
  final $Res Function(SignUpScreenState) _then;
}

/// @nodoc
abstract class _$$InitializedCopyWith<$Res> {
  factory _$$InitializedCopyWith(
          _$Initialized value, $Res Function(_$Initialized) then) =
      __$$InitializedCopyWithImpl<$Res>;
  $Res call(
      {String fullName,
      String mobileNumber,
      int age,
      String gender,
      String profession,
      bool isBusy});
}

/// @nodoc
class __$$InitializedCopyWithImpl<$Res>
    extends _$SignUpScreenStateCopyWithImpl<$Res>
    implements _$$InitializedCopyWith<$Res> {
  __$$InitializedCopyWithImpl(
      _$Initialized _value, $Res Function(_$Initialized) _then)
      : super(_value, (v) => _then(v as _$Initialized));

  @override
  _$Initialized get _value => super._value as _$Initialized;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? mobileNumber = freezed,
    Object? age = freezed,
    Object? gender = freezed,
    Object? profession = freezed,
    Object? isBusy = freezed,
  }) {
    return _then(_$Initialized(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: mobileNumber == freezed
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      profession: profession == freezed
          ? _value.profession
          : profession // ignore: cast_nullable_to_non_nullable
              as String,
      isBusy: isBusy == freezed
          ? _value.isBusy
          : isBusy // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Initialized implements Initialized {
  const _$Initialized(
      {required this.fullName,
      required this.mobileNumber,
      required this.age,
      required this.gender,
      required this.profession,
      required this.isBusy});

  @override
  final String fullName;
  @override
  final String mobileNumber;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String profession;
  @override
  final bool isBusy;

  @override
  String toString() {
    return 'SignUpScreenState.initialized(fullName: $fullName, mobileNumber: $mobileNumber, age: $age, gender: $gender, profession: $profession, isBusy: $isBusy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Initialized &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality()
                .equals(other.mobileNumber, mobileNumber) &&
            const DeepCollectionEquality().equals(other.age, age) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality()
                .equals(other.profession, profession) &&
            const DeepCollectionEquality().equals(other.isBusy, isBusy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(mobileNumber),
      const DeepCollectionEquality().hash(age),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(profession),
      const DeepCollectionEquality().hash(isBusy));

  @JsonKey(ignore: true)
  @override
  _$$InitializedCopyWith<_$Initialized> get copyWith =>
      __$$InitializedCopyWithImpl<_$Initialized>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)
        initialized,
    required TResult Function() loading,
    required TResult Function(List<ProfessionData> data) loaded,
  }) {
    return initialized(fullName, mobileNumber, age, gender, profession, isBusy);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)?
        initialized,
    TResult Function()? loading,
    TResult Function(List<ProfessionData> data)? loaded,
  }) {
    return initialized?.call(
        fullName, mobileNumber, age, gender, profession, isBusy);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)?
        initialized,
    TResult Function()? loading,
    TResult Function(List<ProfessionData> data)? loaded,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(
          fullName, mobileNumber, age, gender, profession, isBusy);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class Initialized implements SignUpScreenState {
  const factory Initialized(
      {required final String fullName,
      required final String mobileNumber,
      required final int age,
      required final String gender,
      required final String profession,
      required final bool isBusy}) = _$Initialized;

  String get fullName;
  String get mobileNumber;
  int get age;
  String get gender;
  String get profession;
  bool get isBusy;
  @JsonKey(ignore: true)
  _$$InitializedCopyWith<_$Initialized> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingCopyWith<$Res> {
  factory _$$LoadingCopyWith(_$Loading value, $Res Function(_$Loading) then) =
      __$$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingCopyWithImpl<$Res>
    extends _$SignUpScreenStateCopyWithImpl<$Res>
    implements _$$LoadingCopyWith<$Res> {
  __$$LoadingCopyWithImpl(_$Loading _value, $Res Function(_$Loading) _then)
      : super(_value, (v) => _then(v as _$Loading));

  @override
  _$Loading get _value => super._value as _$Loading;
}

/// @nodoc

class _$Loading implements Loading {
  const _$Loading();

  @override
  String toString() {
    return 'SignUpScreenState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)
        initialized,
    required TResult Function() loading,
    required TResult Function(List<ProfessionData> data) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)?
        initialized,
    TResult Function()? loading,
    TResult Function(List<ProfessionData> data)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)?
        initialized,
    TResult Function()? loading,
    TResult Function(List<ProfessionData> data)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements SignUpScreenState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class _$$LoadedCopyWith<$Res> {
  factory _$$LoadedCopyWith(_$Loaded value, $Res Function(_$Loaded) then) =
      __$$LoadedCopyWithImpl<$Res>;
  $Res call({List<ProfessionData> data});
}

/// @nodoc
class __$$LoadedCopyWithImpl<$Res> extends _$SignUpScreenStateCopyWithImpl<$Res>
    implements _$$LoadedCopyWith<$Res> {
  __$$LoadedCopyWithImpl(_$Loaded _value, $Res Function(_$Loaded) _then)
      : super(_value, (v) => _then(v as _$Loaded));

  @override
  _$Loaded get _value => super._value as _$Loaded;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$Loaded(
      data == freezed
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProfessionData>,
    ));
  }
}

/// @nodoc

class _$Loaded implements Loaded {
  const _$Loaded(final List<ProfessionData> data) : _data = data;

  final List<ProfessionData> _data;
  @override
  List<ProfessionData> get data {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'SignUpScreenState.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Loaded &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  _$$LoadedCopyWith<_$Loaded> get copyWith =>
      __$$LoadedCopyWithImpl<_$Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)
        initialized,
    required TResult Function() loading,
    required TResult Function(List<ProfessionData> data) loaded,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)?
        initialized,
    TResult Function()? loading,
    TResult Function(List<ProfessionData> data)? loaded,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String fullName, String mobileNumber, int age,
            String gender, String profession, bool isBusy)?
        initialized,
    TResult Function()? loading,
    TResult Function(List<ProfessionData> data)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements SignUpScreenState {
  const factory Loaded(final List<ProfessionData> data) = _$Loaded;

  List<ProfessionData> get data;
  @JsonKey(ignore: true)
  _$$LoadedCopyWith<_$Loaded> get copyWith =>
      throw _privateConstructorUsedError;
}
