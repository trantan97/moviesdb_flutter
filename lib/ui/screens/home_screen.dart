import 'package:flutter/material.dart';
import 'package:moviesdb/services/services.dart';
import 'package:moviesdb/ui/widgets/home_list_movies.dart';
import 'package:moviesdb/utils/utils.dart';
import 'package:moviesdb/viewmodels/view_models.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.loadData(),
      builder: (context, model, _) {
        if (model.busy)
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ));
        return Scaffold(
          body: ScrollConfiguration(
            behavior: NoGrowlingBehavior(),
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
//                    title: Text("Movie Info",
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 16.0,
//                        )),
                        background: Image.network(
                          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                          fit: BoxFit.cover,
                        )),
                  ),
                ];
              },
              body: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    HomeListMovies(title: "Top Rate"),
                    HomeListMovies(title: "Popular"),
                    HomeListMovies(title: "Now Playing"),
                    HomeListMovies(title: "Up Coming"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
