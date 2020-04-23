import 'package:moviesdb/viewmodels/view_models.dart';
import 'package:package_info/package_info.dart';

class SettingViewModel extends BaseModel {
  String versionName;

  Future getVersionName() async {
    setBusy(true);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
    setBusy(false);
  }
}
