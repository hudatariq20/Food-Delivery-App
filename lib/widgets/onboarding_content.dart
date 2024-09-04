import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent(
      {super.key, this.illustration, this.title, this.subtitle});

  final String? illustration, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: AspectRatio(
          aspectRatio: 1,
          child: SvgPicture.asset(illustration!))),
        SizedBox(
          height: 16,
        ),
        Text(
          title!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          subtitle!,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.grey),
        )
      ],
    );
  }
}
