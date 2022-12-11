// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'navdrawer_m.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NavDrawerState {
  NavigationDrawer get index => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  List<Customer>? get customersList => throw _privateConstructorUsedError;
  Customer? get selectedCustomer => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(NavigationDrawer index, User? user,
            List<Customer>? customersList, Customer? selectedCustomer)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(NavigationDrawer index, User? user,
            List<Customer>? customersList, Customer? selectedCustomer)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(NavigationDrawer index, User? user,
            List<Customer>? customersList, Customer? selectedCustomer)?
        loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NavDrawerStateCopyWith<NavDrawerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavDrawerStateCopyWith<$Res> {
  factory $NavDrawerStateCopyWith(
          NavDrawerState value, $Res Function(NavDrawerState) then) =
      _$NavDrawerStateCopyWithImpl<$Res>;
  $Res call(
      {NavigationDrawer index,
      User? user,
      List<Customer>? customersList,
      Customer? selectedCustomer});
}

/// @nodoc
class _$NavDrawerStateCopyWithImpl<$Res>
    implements $NavDrawerStateCopyWith<$Res> {
  _$NavDrawerStateCopyWithImpl(this._value, this._then);

  final NavDrawerState _value;
  // ignore: unused_field
  final $Res Function(NavDrawerState) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? user = freezed,
    Object? customersList = freezed,
    Object? selectedCustomer = freezed,
  }) {
    return _then(_value.copyWith(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as NavigationDrawer,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      customersList: customersList == freezed
          ? _value.customersList
          : customersList // ignore: cast_nullable_to_non_nullable
              as List<Customer>?,
      selectedCustomer: selectedCustomer == freezed
          ? _value.selectedCustomer
          : selectedCustomer // ignore: cast_nullable_to_non_nullable
              as Customer?,
    ));
  }
}

/// @nodoc
abstract class _$$LoadedCopyWith<$Res>
    implements $NavDrawerStateCopyWith<$Res> {
  factory _$$LoadedCopyWith(_$Loaded value, $Res Function(_$Loaded) then) =
      __$$LoadedCopyWithImpl<$Res>;
  @override
  $Res call(
      {NavigationDrawer index,
      User? user,
      List<Customer>? customersList,
      Customer? selectedCustomer});
}

/// @nodoc
class __$$LoadedCopyWithImpl<$Res> extends _$NavDrawerStateCopyWithImpl<$Res>
    implements _$$LoadedCopyWith<$Res> {
  __$$LoadedCopyWithImpl(_$Loaded _value, $Res Function(_$Loaded) _then)
      : super(_value, (v) => _then(v as _$Loaded));

  @override
  _$Loaded get _value => super._value as _$Loaded;

  @override
  $Res call({
    Object? index = freezed,
    Object? user = freezed,
    Object? customersList = freezed,
    Object? selectedCustomer = freezed,
  }) {
    return _then(_$Loaded(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as NavigationDrawer,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      customersList: customersList == freezed
          ? _value._customersList
          : customersList // ignore: cast_nullable_to_non_nullable
              as List<Customer>?,
      selectedCustomer: selectedCustomer == freezed
          ? _value.selectedCustomer
          : selectedCustomer // ignore: cast_nullable_to_non_nullable
              as Customer?,
    ));
  }
}

/// @nodoc

class _$Loaded with DiagnosticableTreeMixin implements Loaded {
  const _$Loaded(
      {required this.index,
      this.user,
      final List<Customer>? customersList,
      this.selectedCustomer})
      : _customersList = customersList;

  @override
  final NavigationDrawer index;
  @override
  final User? user;
  final List<Customer>? _customersList;
  @override
  List<Customer>? get customersList {
    final value = _customersList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Customer? selectedCustomer;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NavDrawerState.loaded(index: $index, user: $user, customersList: $customersList, selectedCustomer: $selectedCustomer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NavDrawerState.loaded'))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('customersList', customersList))
      ..add(DiagnosticsProperty('selectedCustomer', selectedCustomer));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Loaded &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality()
                .equals(other._customersList, _customersList) &&
            const DeepCollectionEquality()
                .equals(other.selectedCustomer, selectedCustomer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(_customersList),
      const DeepCollectionEquality().hash(selectedCustomer));

  @JsonKey(ignore: true)
  @override
  _$$LoadedCopyWith<_$Loaded> get copyWith =>
      __$$LoadedCopyWithImpl<_$Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(NavigationDrawer index, User? user,
            List<Customer>? customersList, Customer? selectedCustomer)
        loaded,
  }) {
    return loaded(index, user, customersList, selectedCustomer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(NavigationDrawer index, User? user,
            List<Customer>? customersList, Customer? selectedCustomer)?
        loaded,
  }) {
    return loaded?.call(index, user, customersList, selectedCustomer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(NavigationDrawer index, User? user,
            List<Customer>? customersList, Customer? selectedCustomer)?
        loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(index, user, customersList, selectedCustomer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements NavDrawerState {
  const factory Loaded(
      {required final NavigationDrawer index,
      final User? user,
      final List<Customer>? customersList,
      final Customer? selectedCustomer}) = _$Loaded;

  @override
  NavigationDrawer get index;
  @override
  User? get user;
  @override
  List<Customer>? get customersList;
  @override
  Customer? get selectedCustomer;
  @override
  @JsonKey(ignore: true)
  _$$LoadedCopyWith<_$Loaded> get copyWith =>
      throw _privateConstructorUsedError;
}
