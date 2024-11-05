import 'package:flutter/material.dart';

import '../../data/layouts_model.dart';
import '../widgets/bottom_nav_bar_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  final LayoutModel layoutModel = LayoutModel();

  @override
  void initState() {
    super.initState();
    // FavouritesCubit.get(context).getFavorites();
    // CartsCubit.get(context).getCarts();

    // GetHomeDataCubit.get(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  appBar: _buildAppBar(context),
      body: layoutModel.currentScreen,
      bottomNavigationBar: BottomNavBar(
        
        state: this,
      ),
    );
  }

  // CustomAppBar _buildAppBar(BuildContext context) {
  //   return const CustomAppBar(
  //     title: 'Shorts App',
  //     centerTitle: true,
  //   );
  // }
}
