import 'package:flutter/material.dart';
import 'package:shorts/Features/search/presentation/widgets/search_form_field.dart';
import 'package:shorts/Features/search/presentation/widgets/search_list_view.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_back_icon_widget.dart';

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
                  CustomBackIconWidget(
                    size: 32,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SearchFormField(query: query, formKey: _formKey),
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
