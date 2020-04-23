import 'package:flutter/material.dart';
import 'package:moviesdb/services/services.dart';
import 'package:moviesdb/viewmodels/view_models.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SettingViewModel>.withoutConsumer(
      viewModel: SettingViewModel(),
      onModelReady: (model) => model.getVersionName(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                appVersion(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget appVersion(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "App version",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Consumer<SettingViewModel>(
          builder: (context, model, _) {
            if (model.versionName == null) {
              return Text("...");
            }
            return Text(model.versionName);
          },
        )
      ],
    );
  }
}
