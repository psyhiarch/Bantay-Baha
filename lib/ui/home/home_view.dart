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
    Provider.of<HomeViewModel>(context, listen: false).initFlood();
  }

  @override
  Widget build(BuildContext context) {
    final stations = context.watch<HomeViewModel>().stations;

    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(stations[index].stationName));
      },
    );
  }
}
