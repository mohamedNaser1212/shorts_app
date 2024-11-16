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
          return const Center(child: Text('No search results.'));
        },
      ),
    );
  }
}
