import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<HomeViewModel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final stations = context.watch<HomeViewModel>().stations;
    // final metrics = context.watch<HomeViewModel>().metrics;
    // final telemetry = context.watch<HomeViewModel>().telemetry;
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final stations = viewModel.stations;
        return RefreshIndicator(
          onRefresh: viewModel.init,
          child: ListView.builder(
            itemCount: stations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(stations[index].stationName),
                subtitle: child,
              );
            },
          ),
        );
      },
    );
  }
}
