import 'package:package_info/package_info.dart';

class SettingRepository{
  Future<PackageInfo> getAppInfo() async{
   return await PackageInfo.fromPlatform();
  }
}