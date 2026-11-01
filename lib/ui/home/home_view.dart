import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.read<HomeViewModel>();
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            homeViewModel.test();
          },
          child: Text('test'),
        ),
      ],
    );
  }
}
