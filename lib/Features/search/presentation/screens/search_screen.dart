import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/search/presentation/cubit/search_cubit.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../domain/use_case/search_use_case.dart';
import '../widgets/dummy_search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(searchUseCase: getIt.get<SearchUseCase>()),
      child: const Scaffold(
        backgroundColor: ColorController.blackColor,
        body: DummySearchField(),
      ),
    );
  }
}
