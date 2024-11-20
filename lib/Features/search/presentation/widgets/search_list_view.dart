import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../profile_feature.dart/presentation/screens/user_profile_screen.dart';
import '../cubit/search_cubit.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({super.key, required this.query});
  final String query;
  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      _loadMoreResults();
    }
  }

  Future<void> _loadMoreResults() async {
    final searchCubit = context.read<SearchCubit>();
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);

    final nextPage = searchCubit.getNextPage(widget.query);
    await searchCubit.searchUsers(
        query: widget.query, page: nextPage, isLoadMore: true);

    setState(() => _isLoadingMore = false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final searchResults =
            state is GetSearchResultsSuccessState ? state.searchResults : [];

        if (state is GetSearchResultsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetSearchResultsSuccessState) {
          if (searchResults.isEmpty) {
            return const Center(
              child: CustomTitle(
                title: 'No search results.',
                color: ColorController.whiteColor,
                style: TitleStyle.styleBold20,
              ),
            );
          }
        } else if (state is GetSearchResultsErrorState) {
          return Center(
            child: CustomTitle(
              title: state.errorMessage,
              color: ColorController.whiteColor,
              style: TitleStyle.styleBold20,
            ),
          );
        } else {
          return const Center(
            child: CustomTitle(
              title: 'Search For Users....',
              style: TitleStyle.styleBold20,
            ),
          );
        }

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
                    backgroundImage:
                        CachedNetworkImageProvider(user.profilePic),
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
      },
    );
  }
}
