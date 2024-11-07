import 'package:flutter/material.dart';

import '../../data/layouts_model.dart';

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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType
              .fixed, // Set type to fixed for custom colors
          backgroundColor:
              Colors.black, // Set navigation bar background to black
          currentIndex: layoutModel.currentIndex,
          items: layoutModel.bottomNavigationBarItems,
          selectedItemColor: Colors.white, // Set selected icon color to white
          unselectedItemColor: Colors.grey, // Set unselected icon color to grey
          onTap: (index) {
            setState(() {
              layoutModel.changeScreen(index);
            });
          },
        ));
  }

  // CustomAppBar _buildAppBar(BuildContext context) {
  //   return const CustomAppBar(
  //     title: 'Shorts App',
  //     centerTitle: true,
  //   );
  // }
}
