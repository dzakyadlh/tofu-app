import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/auth_provider.dart';
import 'package:tofu/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);

    handleSignOut() async {
      setState(() {
        isLoading = true;
      });
      await authProvider.signOut();
      if (!authProvider.isAuthenticated) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamedAndRemoveUntil(context, ('/landing'), (_) => false);
      }
    }

    Widget header() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/images/song.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Text(
              'Hello, Mizuki Akai',
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'We hope you have a great day today!',
              style: secondaryTextStyle.copyWith(fontSize: 14),
            )
          ],
        ),
      );
    }

    Widget personalData() {
      return Container(
        color: backgroundPrimaryColor,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Personal Data',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.edit,
                    size: 24,
                    color: Colors.white24,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Full Name',
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                ),
                Text(
                  'Mizuki Akai',
                  style: subtitleTextStyle.copyWith(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date of Birth',
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                ),
                Text(
                  '1 January 2000',
                  style: subtitleTextStyle.copyWith(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Occupation',
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                ),
                Text(
                  'Software Engineer',
                  style: subtitleTextStyle.copyWith(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phone Number',
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                ),
                Text(
                  '+6281234567890',
                  style: subtitleTextStyle.copyWith(fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      );
    }

    Widget balance() {
      return Container(
        color: backgroundPrimaryColor,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Balance',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '\$125,000',
              style:
                  secondaryTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Connected accounts',
                  style: subtitleTextStyle.copyWith(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.add,
                    color: Colors.white24,
                    size: 24,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white12))),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/visa.png',
                    width: 40,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Visa',
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white12))),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/paypal.png',
                    width: 40,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Paypal',
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget settings() {
      return Container(
        color: backgroundPrimaryColor,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.light_mode,
                    size: 24,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Appearance',
                    style: secondaryTextStyle.copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    size: 24,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Notifications',
                    style: secondaryTextStyle.copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    size: 24,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Privacy and Security',
                    style: secondaryTextStyle.copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.accessibility,
                    size: 24,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Accessibility',
                    style: secondaryTextStyle.copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget signOutButton() {
      return Row(
        children: [
          Expanded(
            child: FilledButton(
                onPressed: () {
                  handleSignOut();
                },
                style: FilledButton.styleFrom(
                    side: BorderSide(color: alertColor),
                    backgroundColor: backgroundPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Text(
                  'Sign out of my account',
                  style: alertTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semibold,
                  ),
                )),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: backgroundPrimaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [header()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              personalData(),
              balance(),
              settings(),
              signOutButton(),
            ]),
          )
        ],
      ),
    );
  }
}
