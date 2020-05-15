import 'package:flutter/material.dart';
import 'package:moviesdb/src/resources/resources.dart';
import 'package:moviesdb/src/services/services.dart';
import 'package:moviesdb/src/ui/screens/screens.dart';
import 'package:moviesdb/src/viewmodels/view_models.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/MainScreen";
  final List<Widget> _children = [HomeScreen(), Container(), SettingScreen()];

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MainViewModel>.withConsumer(
      viewModel: MainViewModel(),
      builder: (context, model, _){
        return  Scaffold(
          body: _children[model.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.film_roll)),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.favorite)),
                title: Text("Favorite"),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Images.settings)),
                title: Text("Settings"),
              ),
            ],
            selectedItemColor: Colors.black,
            currentIndex: model.selectedIndex,
            onTap: (index) {
              model.setIndex(index);
            },
          ),
        );
      },
    );
  }
}
