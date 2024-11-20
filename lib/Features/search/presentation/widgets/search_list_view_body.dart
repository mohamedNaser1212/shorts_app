import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../profile_feature.dart/presentation/screens/user_profile_screen.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({
    super.key,
    required ScrollController scrollController,
    required this.searchResults,
    required bool isLoadingMore,
  })  : _scrollController = scrollController,
        _isLoadingMore = isLoadingMore;

  final ScrollController _scrollController;
  final List<UserEntity> searchResults;
  final bool _isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: searchResults.length + 1,
        itemBuilder: (context, index) {
          if (index == searchResults.length) {
            return _isLoadingMore
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox.shrink();
          }

          final user = searchResults[index];
          return InkWell(
            onTap: () {
              NavigationManager.navigateTo(
                context: context,
                screen: UserProfileScreen(user: user),
              );
            },
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              leading: CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(user.profilePic),
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
      ),
    );
  }
}
