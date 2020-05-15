import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';
import 'package:moviesdb/src/viewmodels/view_models.dart';
import 'package:package_info/package_info.dart';

class SettingViewModel extends BaseModel {
  SettingRepositories settingRepositories = locator<SettingRepositories>();
  String versionName;

  Future getVersionName() async {
    setBusy(true);
    PackageInfo packageInfo = await settingRepositories.getAppInfo();
    versionName = packageInfo.version;
    setBusy(false);
  }
}
