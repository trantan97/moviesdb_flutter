import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/blocs.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingBloc()..add(GetAppVersion()),
      child: Scaffold(
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
      ),
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
        BlocBuilder<SettingBloc, BaseState>(
          builder: (context, state) {
            if (state is LoadedState<String>) {
              return Text(state.data);
            }
            return Text("...");
          },
        )
      ],
    );
  }
}
