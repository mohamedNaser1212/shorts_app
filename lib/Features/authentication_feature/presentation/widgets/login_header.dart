import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/custom_title.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Column _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitle(
          title: 'LOGIN Screen',
          style: TitleStyle.style14,
        ),
        Text(
          'login now to browse our hot offers',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}
