import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Opening Hours Column
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OPENING HOURS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Monday - Friday: 9:00 AM - 6:00 PM',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    Text(
                      'Saturday: 10:00 AM - 4:00 PM',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    Text(
                      'Sunday: Closed',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Information Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'INFORMATION',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/about');
                        },
                        child: const Text(
                          'About Us',
                          style: TextStyle(color: Colors.black, height: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Help Column
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HELP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Shipping & Returns',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    Text(
                      'FAQ',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    Text(
                      'Terms & Conditions',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          const Divider(color: Colors.grey),
          const SizedBox(height: 24),
          const Text(
            '© 2024 Bearbrick Shop. All rights reserved.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
