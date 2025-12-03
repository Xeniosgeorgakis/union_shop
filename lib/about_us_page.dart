import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/widgets/app_drawer.dart';
import 'package:union_shop/widgets/app_header.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(currentPage: '/about'),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              color: const Color.fromARGB(255, 42, 41, 42),
              child: const Column(
                children: [
                  Text(
                    'About Bearbrick Shop',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Collectors Choice',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            // Content
            Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 800,
                    child: Column(
                      children: [
                        Text(
                          'Welcome to Bearbrick Shop, your number one source for all things Bearbrick. We\'re dedicated to giving you the best of collectible figures, with a focus on authenticity, customer service, and uniqueness.',
                          style: TextStyle(fontSize: 16, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Founded in 2023, Bearbrick Shop has come a long way from its beginnings. When we first started out, our passion for eco-friendly cleaning products drove us to do tons of research, so that Bearbrick Shop can offer you the world\'s most advanced collectibles. We now serve customers all over the world, and are thrilled that we\'re able to turn our passion into our own website.',
                          style: TextStyle(fontSize: 16, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us.',
                          style: TextStyle(fontSize: 16, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Footer(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
