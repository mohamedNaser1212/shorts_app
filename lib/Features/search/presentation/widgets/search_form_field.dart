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
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  late final FocusNode _focusNode;
  late final SearchCubit _searchCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchCubit = SearchCubit.get(context);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    if (query.isEmpty) {
      _searchCubit.clearSearch();
    } else {
      _searchCubit.searchUsers(query: query, page: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomTextFormField(
            controller: widget.query,
            label: 'Search for users...',
            onChanged: (value) {
              _onQueryChanged(value!);
              return null;
            },
            onSubmit: (query) {
              setState(() {
                widget.query.text = query!;
              });
              if (widget.formKey.currentState!.validate()) {
                _searchCubit.searchUsers(query: query!, page: 1);
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
        ],
      ),
    );
  }
}
