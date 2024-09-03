import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        builder: ((_) => ProfileScreen()),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text('Account Settings',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.black)),
              Text(
                  'Update your settings like notification, payments, profile edit etc',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black)),
              SizedBox(
                height: 16,
              ),
              ProfileMenuCard(
                title: 'Profile Information',
                subtitle: 'Change your account information',
                svg: 'assets/icons/profile.svg',
                press: () {},
              ),
              ProfileMenuCard(
                svg: "assets/icons/lock.svg",
                title: "Change Password",
                subtitle: "Change your password",
                press: () {},
              ),
              ProfileMenuCard(
                svg: "assets/icons/card.svg",
                title: "Payment Methods",
                subtitle: "Add your credit & debit cards",
                press: () {},
              ),
              ProfileMenuCard(
                svg: "assets/icons/marker.svg",
                title: "Locations",
                subtitle: "Add or remove your delivery locations",
                press: () {},
              ),
              ProfileMenuCard(
                svg: "assets/icons/fb.svg",
                title: "Add Social Account",
                subtitle: "Add Facebook, Twitter etc ",
                press: () {},
              ),
              ProfileMenuCard(
                svg: "assets/icons/share.svg",
                title: "Refer to Friends",
                subtitle: "Get \$10 for refering friends",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard(
      {super.key, this.title, this.subtitle, this.svg, this.press});

  final String? title, subtitle, svg;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: press,
        borderRadius: BorderRadius.all(Radius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                svg!,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.64),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(subtitle!,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.grey))
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_outlined, size: 20)
            ],
          ),
        ),
      ),
    );
  }
}
