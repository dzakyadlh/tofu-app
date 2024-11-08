import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tofu/providers/auth_provider.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);

    handleSignOut() async {
      await authProvider.signOut();
      if (!authProvider.isAuthenticated) {
        Navigator.pushNamedAndRemoveUntil(context, ('/landing'), (_) => false);
      }
    }

    Widget header() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return Skeletonizer(
                  enabled: provider.isLoading ? true : false,
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
                        'Hello, ${provider.user['name']}',
                        style: primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semibold,
                        ),
                      ),
                    ],
                  ),
                );
              },
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
                InkWell(
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
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return Skeletonizer(
                  enabled: provider.isLoading ? true : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Full Name',
                            style: secondaryTextStyle.copyWith(fontSize: 14),
                          ),
                          Text(
                            '${provider.user['name']}',
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
                            '${provider.user['birthDate']}',
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
                            '${provider.user['occupation']}',
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
                            '${provider.user['phoneNumber']}',
                            style: subtitleTextStyle.copyWith(fontSize: 14),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
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
            Consumer<UserProvider>(builder: (context, provider, child) {
              return Skeletonizer(
                  enabled: provider.isLoading,
                  child: Text(
                    '${provider.user['wallet']?['balance'] ?? 0}',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 20, fontWeight: bold),
                  ));
            }),
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/add-connected-account');
                  },
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
            Consumer<ConnectedAccountsProvider>(
                builder: (context, provider, child) {
              if (provider.connectedAccounts.isEmpty) {
                return Text(
                  'No connected accounts',
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                );
              }

              return Column(
                children: provider.connectedAccounts.map((account) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.white12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              account['icon'],
                              width: 40,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              account['name'],
                              style: secondaryTextStyle.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          account['accountNumber'],
                          style: subtitleTextStyle.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  );
                }).toList(), // Convert the Iterable to a List of Widgets
              );
            })
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
            child: Column(
              children: [
                personalData(),
                balance(),
                settings(),
                signOutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
