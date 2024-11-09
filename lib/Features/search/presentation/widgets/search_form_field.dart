import 'package:flutter/material.dart';

import '../../../../core/widgets/reusable_text_form_field.dart';
import '../cubit/search_cubit.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({
    super.key,
    required this.query,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final TextEditingController query;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: query,
        suffix: IconButton(
          onPressed: () {
            //  context.read<SearchCubit>().searchUsers(query.text);
            SearchCubit.get(context).searchUsers(query: query.text);
          },
          icon: const Icon(Icons.search),
        ),
        label: 'Search for users...',
        onSubmit: (query) {
          if (_formKey.currentState!.validate()) {
            SearchCubit.get(context).searchUsers(query: query!);

            // context.read<SearchCubit>().searchUsers(query!);
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
    );
  }
}
