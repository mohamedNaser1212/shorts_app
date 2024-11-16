import 'package:flutter/material.dart';

import '../../../../core/widgets/reusable_text_form_field.dart';
import '../cubit/search_cubit.dart';

class SearchFormField extends StatefulWidget {
  const SearchFormField({
    super.key,
    required this.query,
    required this.formKey,
  });

  final TextEditingController query;
  final GlobalKey<FormState> formKey;

  @override
  _SearchFormFieldState createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _controller = widget.query;
    _focusNode = FocusNode();
    _searchCubit = SearchCubit.get(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    if (query.isEmpty) {
      _searchCubit.clearSearch();
    } else {
      _searchCubit.searchUsers(query: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: _controller,
        label: 'Search for users...',
        onChanged: (value) {
          _onQueryChanged(value!);
          return null;
        },
        onSubmit: (query) {
          if (widget.formKey.currentState!.validate()) {
            _searchCubit.searchUsers(query: query!);
          }
          return null;
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
    );
  }
}
