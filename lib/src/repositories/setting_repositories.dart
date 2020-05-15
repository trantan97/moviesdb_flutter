import 'package:package_info/package_info.dart';

class SettingRepositories{
  Future<PackageInfo> getAppInfo() async{
   return await PackageInfo.fromPlatform();
  }
}