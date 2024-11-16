import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import '../../../../Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';
import '../../../functions/navigations_functions.dart';
import '../../../widgets/custom_snack_bar.dart';
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
    return BlocListener<UploadVideosCubit, UploadVideosState>(
      listener: (context, state) {
        // if (state is VideoUploadLoadingState) {
        //   rootScaffoldMessengerKey.currentState!.showSnackBar(
        //     const SnackBar(
        //       content: Text(
        //         'Video is now uploading, we will notify you when upload is complete',
        //         style: TextStyle(color: Colors.white),
        //       ),
        //       backgroundColor: ColorController.greenAccent,
        //     ),
        //   );
        // } else

        if (state is VideoUploadedSuccessState) {
          showMySnackBar(
            message: "Successs At Upload",
            context: context,
            onActionPressed: () => NavigationManager.navigateTo(
                context: context,
                screen: VideoListItem(videoEntity: state.videoEntity)),
            actionLabel: "Show",
          );
        }
      },
      child: Scaffold(
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
            unselectedItemColor:
                Colors.grey, // Set unselected icon color to grey
            onTap: (index) {
              setState(() {
                layoutModel.changeScreen(index);
              });
            },
          )),
    );
  }

  // CustomAppBar _buildAppBar(BuildContext context) {
  //   return const CustomAppBar(
  //     title: 'Shorts App',
  //     centerTitle: true,
  //   );
  // }
}
