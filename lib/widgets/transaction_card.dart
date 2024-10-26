import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.title,
    required this.date,
    required this.price,
    required this.category,
    required this.isOutcome,
  });

  final String title;
  final String date;
  final double price;
  final String category;
  final bool isOutcome;

  @override
  Widget build(BuildContext context) {
    IconData transactionIcon;
    switch (category) {
      case 'electricity':
        transactionIcon = Icons.lightbulb;
        break;
      case 'salary':
        transactionIcon = Icons.attach_money;
        break;
      case 'investment':
        transactionIcon = Icons.show_chart;
        break;
      case 'grocery':
        transactionIcon = Icons.shopping_cart;
        break;
      case 'business':
        transactionIcon = Icons.business_center;
        break;
      case 'self-development':
        transactionIcon = Icons.person;
        break;
      case 'enjoyments':
        transactionIcon = Icons.tag_faces;
        break;
      default:
        transactionIcon = Icons.question_mark;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(defaultRadius)),
                child: Icon(
                  transactionIcon,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    ),
                  ),
                  Text(
                    date,
                    style: subtitleTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: light,
                    ),
                  )
                ],
              ),
            ],
          ),
          isOutcome
              ? Text(
                  '-\$$price',
                  style: alertTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semibold,
                  ),
                )
              : Text(
                  '+\$$price',
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semibold,
                  ),
                )
        ],
      ),
    );
  }
}
