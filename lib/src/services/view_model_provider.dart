import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _ViewModelProviderType { WithoutConsumer, WithComsumer }

class ViewModelProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget staticChild;
  final Function(T) onModelReady;
  final Widget Function(BuildContext, T, Widget) builder;
  final T viewModel;
  final _ViewModelProviderType providerType;

  ViewModelProvider.withoutConsumer({
    @required this.viewModel,
    this.onModelReady,
    @required this.builder,
  })  : providerType = _ViewModelProviderType.WithoutConsumer,
        staticChild = null;

  ViewModelProvider.withConsumer({
    @required this.viewModel,
    this.onModelReady,
    @required this.builder,
    this.staticChild,
  }) : providerType = _ViewModelProviderType.WithComsumer;

  @override
  State<StatefulWidget> createState() {
    return _State<T>();
  }
}

class _State<T extends ChangeNotifier> extends State<ViewModelProvider<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    _model = widget.viewModel;
    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerType == _ViewModelProviderType.WithoutConsumer) {
      return ChangeNotifierProvider(
        create: (context) => _model,
        child: widget.builder(context, _model, null),
      );
    }
    return ChangeNotifierProvider(
      create: (context) => _model,
      child: Consumer(
        builder: widget.builder,
        child: widget.staticChild,
      ),
    );
  }
}
