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
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: state.searchResults.length,
                itemBuilder: (context, index) {
                  UserEntity user = state.searchResults[index];
                  return InkWell(
                    onTap: () {
                      NavigationManager.navigateTo(
                        context: context,
                        screen: UserProfileScreen(
                          user: user,
                          // isShared: false,
                          // user: user,
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                      ),
                      title: CustomTitle(
                        style: TitleStyle.style16Bold,
                        title: user.name,
                        color: ColorController.whiteColor,
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is SearchError) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text('No search results.'));
        },
      ),
    );
  }
}
