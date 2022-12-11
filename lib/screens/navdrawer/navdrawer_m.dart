import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chef/base/base.dart';
import 'package:chef/models/models.dart';

import 'package:chef/helpers/enum_helper.dart';

part 'navdrawer_m.freezed.dart';

@freezed
class NavDrawerState extends BaseState with _$NavDrawerState {
  const factory NavDrawerState.loaded({
    required NavigationDrawer index,
    User? user,
    List<Customer>? customersList,
    Customer? selectedCustomer,
  }) = Loaded;
}
