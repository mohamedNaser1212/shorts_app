import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../../../../core/widgets/reusable_text_form_field.dart';
import '../../domain/model/search_model.dart';
import '../cubit/search_cubit.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final query = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextFormField(
              controller: query,
              suffix: IconButton(
                onPressed: () {
                  context.read<SearchCubit>().searchVideos(query.text);
                },
                icon: const Icon(Icons.search),
              ),
              label: 'Search for users...',
              onSubmit: (query) {
                if (_formKey.currentState!.validate()) {
                  context.read<SearchCubit>().searchVideos(query!);
                }
              },
              prefix: const Icon(Icons.search),

              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a search query';
                }
                return null;
                //
              },

              // onSubmitted: (query) {
              //   // Trigger search when the query is submitted
              //   context.read<SearchCubit>().searchVideos(query);
              // },
              // suffixIcon: IconButton(
              //   onPressed: () {
              //     context.read<SearchCubit>().searchVideos(query.text);
              //   },
              // icon: const Icon(Icons.search),
            ),
          ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: TextField(
          //     onSubmitted: (query) {
          //       // Trigger search when the query is submitted
          //       context.read<SearchCubit>().searchVideos(query);
          //     },
          //     decoration: InputDecoration(
          //       labelText: 'Search for users...',
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       suffixIcon: InkWell(
          //         onTap: () {
          //           context.read<SearchCubit>().searchVideos(query.text);
          //         },
          //         child: const Icon(Icons.search),
          //       ),
          //     ),
          //   ),
          // ),
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
                        SearchModel result = state.searchResults[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                result.user.profilePic), // User profile picture
                          ),
                          title: CustomTitle(
                            style: TitleStyle.style16Bold,
                            title: result.user.name,
                            color: ColorController.whiteColor,
                          ), // User name
                          // subtitle: Text(result
                          //     .description), // Video description (you can change this if needed)
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
    );
  }
}
