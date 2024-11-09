import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_back_icon_widget.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../../core/widgets/reusable_text_form_field.dart';
import '../../../profile_feature.dart/presentation/screens/user_profile_screen.dart';
import '../cubit/search_cubit.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final query = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: ColorController.blackColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  // Use the CustomBackIcon widget with a size of 32
                  CustomBackIconWidget(
                    size: 32,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      controller: query,
                      suffix: IconButton(
                        onPressed: () {
                          context.read<SearchCubit>().searchUsers(query.text);
                        },
                        icon: const Icon(Icons.search),
                      ),
                      label: 'Search for users...',
                      onSubmit: (query) {
                        if (_formKey.currentState!.validate()) {
                          context.read<SearchCubit>().searchUsers(query!);
                        }
                      },
                      prefix: const Icon(Icons.search),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a search query';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
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
                                screen: const UserProfileScreen(
                                  isShared: false,
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
            ),
          ],
        ),
      ),
    );
  }
}
