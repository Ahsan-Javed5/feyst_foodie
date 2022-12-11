// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'custom_field_sidebar_m.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomFieldSideBarState {
  List<Attachment> get attachmentList => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Attachment> attachmentList) loading,
    required TResult Function(List<Attachment> attachmentList) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Attachment> attachmentList)? loading,
    TResult Function(List<Attachment> attachmentList)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Attachment> attachmentList)? loading,
    TResult Function(List<Attachment> attachmentList)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomFieldSideBarStateCopyWith<CustomFieldSideBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFieldSideBarStateCopyWith<$Res> {
  factory $CustomFieldSideBarStateCopyWith(CustomFieldSideBarState value,
          $Res Function(CustomFieldSideBarState) then) =
      _$CustomFieldSideBarStateCopyWithImpl<$Res>;
  $Res call({List<Attachment> attachmentList});
}

/// @nodoc
class _$CustomFieldSideBarStateCopyWithImpl<$Res>
    implements $CustomFieldSideBarStateCopyWith<$Res> {
  _$CustomFieldSideBarStateCopyWithImpl(this._value, this._then);

  final CustomFieldSideBarState _value;
  // ignore: unused_field
  final $Res Function(CustomFieldSideBarState) _then;

  @override
  $Res call({
    Object? attachmentList = freezed,
  }) {
    return _then(_value.copyWith(
      attachmentList: attachmentList == freezed
          ? _value.attachmentList
          : attachmentList // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

/// @nodoc
abstract class _$$LoadingCopyWith<$Res>
    implements $CustomFieldSideBarStateCopyWith<$Res> {
  factory _$$LoadingCopyWith(_$Loading value, $Res Function(_$Loading) then) =
      __$$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({List<Attachment> attachmentList});
}

/// @nodoc
class __$$LoadingCopyWithImpl<$Res>
    extends _$CustomFieldSideBarStateCopyWithImpl<$Res>
    implements _$$LoadingCopyWith<$Res> {
  __$$LoadingCopyWithImpl(_$Loading _value, $Res Function(_$Loading) _then)
      : super(_value, (v) => _then(v as _$Loading));

  @override
  _$Loading get _value => super._value as _$Loading;

  @override
  $Res call({
    Object? attachmentList = freezed,
  }) {
    return _then(_$Loading(
      attachmentList == freezed
          ? _value._attachmentList
          : attachmentList // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

/// @nodoc

class _$Loading implements Loading {
  const _$Loading(final List<Attachment> attachmentList)
      : _attachmentList = attachmentList;

  final List<Attachment> _attachmentList;
  @override
  List<Attachment> get attachmentList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentList);
  }

  @override
  String toString() {
    return 'CustomFieldSideBarState.loading(attachmentList: $attachmentList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Loading &&
            const DeepCollectionEquality()
                .equals(other._attachmentList, _attachmentList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_attachmentList));

  @JsonKey(ignore: true)
  @override
  _$$LoadingCopyWith<_$Loading> get copyWith =>
      __$$LoadingCopyWithImpl<_$Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Attachment> attachmentList) loading,
    required TResult Function(List<Attachment> attachmentList) loaded,
  }) {
    return loading(attachmentList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Attachment> attachmentList)? loading,
    TResult Function(List<Attachment> attachmentList)? loaded,
  }) {
    return loading?.call(attachmentList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Attachment> attachmentList)? loading,
    TResult Function(List<Attachment> attachmentList)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(attachmentList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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

abstract class Loading implements CustomFieldSideBarState {
  const factory Loading(final List<Attachment> attachmentList) = _$Loading;

  @override
  List<Attachment> get attachmentList;
  @override
  @JsonKey(ignore: true)
  _$$LoadingCopyWith<_$Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedCopyWith<$Res>
    implements $CustomFieldSideBarStateCopyWith<$Res> {
  factory _$$LoadedCopyWith(_$Loaded value, $Res Function(_$Loaded) then) =
      __$$LoadedCopyWithImpl<$Res>;
  @override
  $Res call({List<Attachment> attachmentList});
}

/// @nodoc
class __$$LoadedCopyWithImpl<$Res>
    extends _$CustomFieldSideBarStateCopyWithImpl<$Res>
    implements _$$LoadedCopyWith<$Res> {
  __$$LoadedCopyWithImpl(_$Loaded _value, $Res Function(_$Loaded) _then)
      : super(_value, (v) => _then(v as _$Loaded));

  @override
  _$Loaded get _value => super._value as _$Loaded;

  @override
  $Res call({
    Object? attachmentList = freezed,
  }) {
    return _then(_$Loaded(
      attachmentList == freezed
          ? _value._attachmentList
          : attachmentList // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

/// @nodoc

class _$Loaded implements Loaded {
  const _$Loaded(final List<Attachment> attachmentList)
      : _attachmentList = attachmentList;

  final List<Attachment> _attachmentList;
  @override
  List<Attachment> get attachmentList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentList);
  }

  @override
  String toString() {
    return 'CustomFieldSideBarState.loaded(attachmentList: $attachmentList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Loaded &&
            const DeepCollectionEquality()
                .equals(other._attachmentList, _attachmentList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_attachmentList));

  @JsonKey(ignore: true)
  @override
  _$$LoadedCopyWith<_$Loaded> get copyWith =>
      __$$LoadedCopyWithImpl<_$Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Attachment> attachmentList) loading,
    required TResult Function(List<Attachment> attachmentList) loaded,
  }) {
    return loaded(attachmentList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Attachment> attachmentList)? loading,
    TResult Function(List<Attachment> attachmentList)? loaded,
  }) {
    return loaded?.call(attachmentList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Attachment> attachmentList)? loading,
    TResult Function(List<Attachment> attachmentList)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(attachmentList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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

abstract class Loaded implements CustomFieldSideBarState {
  const factory Loaded(final List<Attachment> attachmentList) = _$Loaded;

  @override
  List<Attachment> get attachmentList;
  @override
  @JsonKey(ignore: true)
  _$$LoadedCopyWith<_$Loaded> get copyWith =>
      throw _privateConstructorUsedError;
}
