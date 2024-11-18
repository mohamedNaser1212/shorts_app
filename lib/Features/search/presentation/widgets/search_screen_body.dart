// SearchScreenBody.dart
import 'package:flutter/material.dart';
import 'package:shorts/Features/search/presentation/cubit/search_cubit.dart';
import 'package:shorts/Features/search/presentation/widgets/search_form_field.dart';
import 'package:shorts/Features/search/presentation/widgets/search_list_view.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_back_icon_widget.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  late TextEditingController query;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    query = TextEditingController();
    SearchCubit.get(context).clearSearch();
  }

  @override
  void dispose() {
    query.dispose();
    //SearchCubit.get(context).clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorController.blackColor,
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
              child: Row(
                children: [
                  CustomBackIconWidget(
                    size: 32,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  SearchFormField(
                    query: query,
                    formKey: formKey,
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
