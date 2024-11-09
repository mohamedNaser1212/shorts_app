import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/search/presentation/widgets/search_list_view.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_back_icon_widget.dart';

import '../../../../core/widgets/reusable_text_form_field.dart';
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
            const SearchListView(),
          ],
        ),
      ),
    );
  }
}
