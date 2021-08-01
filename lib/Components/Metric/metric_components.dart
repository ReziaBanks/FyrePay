import 'package:flutter/material.dart';
import 'package:green_apple_pay/Utility/Classes/Metric/metric_class.dart';
import 'package:green_apple_pay/Utility/Misc/constants.dart';

class AppMetricCard extends StatelessWidget {
  final AppMetric metric;
  final Function()? onPressed;

  AppMetricCard(
    this.metric, {
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhiteColor,
      borderRadius: BorderRadius.circular(3),
      child: InkWell(
        borderRadius: BorderRadius.circular(3),
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              width: 0.75,
              color: Color(0xFFDFE5E8),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: metric.color, borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  metric.iconData,
                  color: kWhiteColor,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metric.title,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: kLetterSpacing,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      metric.subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: kGray4DColor,
                        letterSpacing: kLetterSpacing,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 18),
              Container(
                height: 30,
                width: 75,
                decoration: BoxDecoration(
                    color: metric.color, borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    '\$${metric.cost}',
                    style: TextStyle(
                      letterSpacing: kLetterSpacing,
                      color: kWhiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
