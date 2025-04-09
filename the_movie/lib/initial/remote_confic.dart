import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfic {
  static final RemoteConfic _instance = RemoteConfic._internal();
  RemoteConfic._internal();
  static RemoteConfic get instance => _instance;

  final remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initRemoteConfig() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );
  }

  Future<bool> getUpdate() async {
    bool isUpdate = false;
    await remoteConfig.fetchAndActivate();
    isUpdate = remoteConfig.getBool('update');
    return isUpdate;
  }

  Future<bool> getWelcomDetail() async {
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getBool('welcome_cast');
  }

  Future<bool> getSearch() async {
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getBool('search');
  }
}
