import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/base_bloc/base.dart';
import 'package:moviesdb/src/blocs/setting_bloc/setting_event.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';
import 'package:package_info/package_info.dart';

class SettingBloc extends Bloc<BaseEvent, BaseState> {
  SettingRepositories settingRepositories = locator<SettingRepositories>();

  @override
  BaseState get initialState => InitState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetAppVersion) {
      yield LoadingState();
      PackageInfo packageInfo = await settingRepositories.getAppInfo();
      yield LoadedState<String>(data: packageInfo.version);
    }
  }
}
