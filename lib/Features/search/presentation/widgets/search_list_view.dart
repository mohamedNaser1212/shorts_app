import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/search/presentation/widgets/search_list_view_body.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../cubit/search_cubit.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({super.key, required this.query});
  final String query;

  @override
  _SearchListViewState createState() => _SearchListViewState();
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
        final List<UserEntity> searchResults =
            state is GetSearchResultsSuccessState
                ? state.searchResults
                : <UserEntity>[];

        if (state is GetSearchResultsLoadingState) {
          return const Center(child: CircularProgressIndicator());
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
        // return SearchListViewBody(
        //   searchResults: searchResults,
        //   scrollController: _scrollController,
        //   isLoadingMore: _isLoadingMore,
        // );

        return ListUsers(
            scrollController: _scrollController,
            searchResults: searchResults,
            isLoadingMore: _isLoadingMore);
      },
    );
  }
}
