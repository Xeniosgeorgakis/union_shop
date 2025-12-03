import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/widgets/app_drawer.dart';
import 'package:union_shop/widgets/app_header.dart';

class PrintsharkPage extends StatefulWidget {
  const PrintsharkPage({super.key});

  @override
  State<PrintsharkPage> createState() => _PrintsharkPageState();
}

class _PrintsharkPageState extends State<PrintsharkPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(currentPage: '/printshark'),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              color: Colors.black,
              child: const Column(
                children: [
                  Text(
                    'ABOUT PRINT SHACK',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What Is Print Shack?',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Print Shack is our personalised T-shirt service that lets you create unique, made-to-order shirts with your own text, artwork, or branding.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'What We Offer',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _buildFeatureRow(
                        'Text Personalisation',
                        'Add names, slogans, quotes, or any custom text using your choice of fonts and styles.',
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureRow(
                        'Multiple Font Options',
                        'Choose from a selection of clean, professional fonts to match your design aesthetic.',
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureRow(
                        'Flexible Placement',
                        'Select from chest print, full-width front print, small logo placement, oversized back print, or sleeve printing.',
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureRow(
                        'Premium T-Shirt Quality',
                        'Soft, comfortable cotton shirts available in multiple colours and sizes.',
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'How It Works',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _buildStepRow(
                          '1️⃣', 'Choose your T-shirt style and colour'),
                      const SizedBox(height: 16),
                      _buildStepRow(
                          '2️⃣', 'Enter your text or upload your design'),
                      const SizedBox(height: 16),
                      _buildStepRow('3️⃣',
                          'Pick your preferred font, size, and placement'),
                      const SizedBox(height: 16),
                      _buildStepRow(
                          '4️⃣', 'Review your preview and place your order'),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/personalise');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Start Personalising',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Footer(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('✔', style: TextStyle(fontSize: 16, color: Colors.green)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepRow(String emoji, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ],
    );
  }
}
