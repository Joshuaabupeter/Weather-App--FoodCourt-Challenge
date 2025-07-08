
import 'package:flutter/material.dart';

class WeatherStatCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;

  const WeatherStatCard({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        Container(
          height: 50,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(icon, size: 24, color: Colors.blue[800]),
          ),
        ),
        SizedBox(height: 6),
        Flexible(child: Text(value, style: TextStyle(fontSize: 14))),
      ],
    );
  }
}
