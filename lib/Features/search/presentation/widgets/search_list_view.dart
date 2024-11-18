import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../profile_feature.dart/presentation/screens/user_profile_screen.dart';
import '../cubit/search_cubit.dart';

class SearchListView extends StatelessWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is GetSearchResultsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetSearchResultsSuccessState) {
            if (state.searchResults.isEmpty) {
              return const Center(
                  child: CustomTitle(
                title: 'No search results.',
                color: ColorController.whiteColor,
                style: TitleStyle.styleBold20,
              ));
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: state.searchResults.length,
              itemBuilder: (context, index) {
                UserEntity user = state.searchResults[index];
                return InkWell(
                  onTap: () {
                    NavigationManager.navigateTo(
                      context: context,
                      screen: UserProfileScreen(
                        user: user,
                      ),
                    );
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(
                        user.profilePic,
                      ),
                    ),
                    title: CustomTitle(
                      style: TitleStyle.styleBold20,
                      title: user.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      color: ColorController.whiteColor,
                    ),
                  ),
                );
              },
            );
          } else if (state is GetSearchResultsErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(
            child: Center(
              child: CustomTitle(
                title: 'Search For Users ...',
                color: ColorController.whiteColor,
                style: TitleStyle.styleBold20,
              ),
            ),
          );
        },
      ),
    );
  }
}
//import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../core/functions/navigations_functions.dart';
// import '../../../../core/managers/styles_manager/color_manager.dart';
// import '../../../../core/user_info/domain/user_entity/user_entity.dart';
// import '../../../../core/widgets/custom_title.dart';
// import '../../../profile_feature.dart/presentation/screens/user_profile_screen.dart';
//
// class SearchListView extends StatefulWidget {
//   const SearchListView({Key? key}) : super(key: key);
//
//   @override
//   State<SearchListView> createState() => _SearchListViewState();
// }
//
// class _SearchListViewState extends State<SearchListView> {
//   final List<UserEntity> _allUsers = List.generate(
//     30,
//     (index) => UserEntity(
//       id: index.toString(),
//       name: 'User ${index + 1}',
//       profilePic: 'https://via.placeholder.com/150',
//       email: 'user${index + 1}',
//       phone: '1234567890',
//       fcmToken: 'fcmToken',
//       bio: 'bio',
//       isVerified: false,
//       likesCount: 0,
//       followingCount: 0,
//       followersCount: 0,
//     ),
//   );
//
//   final List<UserEntity> _displayedUsers = [];
//   final ScrollController _scrollController = ScrollController();
//   final int _itemsPerPage = 10;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMoreItems();
//     _scrollController.addListener(_onScroll);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _loadMoreItems() {
//     if (_isLoading) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     // Simulate a delay for fetching data
//     Future.delayed(const Duration(milliseconds: 500), () {
//       final startIndex = _displayedUsers.length;
//       final endIndex = startIndex + _itemsPerPage;
//       final newItems = _allUsers.sublist(
//         startIndex,
//         endIndex.clamp(0, _allUsers.length),
//       );
//
//       setState(() {
//         _displayedUsers.addAll(newItems);
//         _isLoading = false;
//       });
//     });
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent - 200) {
//       _loadMoreItems();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.separated(
//         controller: _scrollController,
//         separatorBuilder: (context, index) => const SizedBox(height: 10),
//         itemCount: _displayedUsers.length + (_isLoading ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == _displayedUsers.length) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final user = _displayedUsers[index];
//           return InkWell(
//             onTap: () {
//               NavigationManager.navigateTo(
//                 context: context,
//                 screen: UserProfileScreen(user: user),
//               );
//             },
//             child: ListTile(
//               contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
//               leading: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: CachedNetworkImageProvider(
//                   user.profilePic,
//                 ),
//               ),
//               title: CustomTitle(
//                 style: TitleStyle.styleBold20,
//                 title: user.name,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 color: ColorController.whiteColor,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
