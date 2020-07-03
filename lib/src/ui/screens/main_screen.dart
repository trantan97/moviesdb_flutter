import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/blocs/main_bloc/blocs.dart';
import 'package:moviesdb/src/resources/resources.dart';
import 'package:moviesdb/src/ui/screens/screens.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/MainScreen";
  final List<Widget> _children = [
    BlocProvider(
      create: (_) => HomeBloc()..add(GetData()),
      child: HomeScreen(),
    ),
    FavoriteScreen(),
    SettingScreen(),
  ];
  final bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, BaseState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is MainState) {
          return Scaffold(
            body: _children[state.index],
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
              currentIndex: state.index,
              onTap: (index) {
                bloc.add(ChangeIndexBottomNavigation(index));
              },
            ),
          );
        }
        return Wrap();
      },
    );
  }
}
