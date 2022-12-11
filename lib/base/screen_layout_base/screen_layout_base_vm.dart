import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/services/services.dart';
import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/base/screen_layout_base/screen_layout_base_m.dart';

@injectable
class ScreenLayoutBaseViewModel extends BaseViewModel<ScreenLayoutBaseState> {
  ScreenLayoutBaseViewModel({
    required ApplicationService appService,
    required IStorageService storage,
    required WorkspaceHelper workspaceHelper,
  })  : _appService = appService,
        _storage = storage,
        _workspaceHelper = workspaceHelper,
        super(const Initialized());

  final ApplicationService _appService;
  final IStorageService _storage;
  final WorkspaceHelper _workspaceHelper;

  void logout() async {
    _appService.logout();
  }

  void fetchPreSelectedWorkspace(BuildContext context) async {
    final workspace = _workspaceHelper.fetchPreSelectedWorkspace(
      workspaceList: _appService.state.workspaceList ?? [],
      context: context,
      storage: _storage,
    );
    emit(Loaded(workspace));
  }

  bool? getSearchVisiblity() => _appService.state.searchVisible;
}
