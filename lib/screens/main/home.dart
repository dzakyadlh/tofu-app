import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/tofu.png'))),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.grey,
            ))
      ],
    );
  }

  Widget miniPortolio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Portfolio',
          style: secondaryTextStyle.copyWith(fontSize: 12),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '\$',
                      style: secondaryTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      '125,050',
                      style: secondaryTextStyle.copyWith(
                          fontWeight: semibold, fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Profit',
                  style: subtitleTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '\$52,525',
                  style: primaryTextStyle.copyWith(fontSize: 12),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Yield',
                  style: subtitleTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '+78.8%',
                  style: primaryTextStyle.copyWith(fontSize: 12),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget wallet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(border: Border.all(color: subtitleTextColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tofu Wallet',
                style: subtitleTextStyle.copyWith(fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '\$23',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signin');
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              side: BorderSide(width: 1.0, color: tertiaryColor),
            ),
            child: Text(
              'Top Up',
              style:
                  primaryTextStyle.copyWith(fontWeight: semibold, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          topBar(),
          const SizedBox(
            height: 16,
          ),
          miniPortolio(),
          const SizedBox(
            height: 32,
          ),
          wallet()
        ],
      ),
    );
  }
}
