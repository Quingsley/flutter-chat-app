import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/home/presentation/widgets/contact_card.dart';
import 'package:ui/styles/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool isExtended = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isExtended = true;
        });
      } else {
        setState(() {
          isExtended = false;
        });
      }
    });
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 900), // Adjust the duration as needed
    );

    _animation = Tween<double>(
      begin: 0.0, // Initial value, fully retracted
      end: 1.0, // Final value, fully extended
    ).animate(_controller);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppTheme.kSecondaryColor,
        title: Text(
          'Your Contacts',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 10,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ContactCard(
              index: index,
            );
          }),
      // Center(
      //   child: Text(
      //     'No contacts yet',
      //     style: GoogleFonts.poppins(
      //       color: Colors.white,
      //       fontSize: 16,
      //     ),
      //   ),
      // ),
      floatingActionButton: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => FloatingActionButton.extended(
          onPressed: () => context.push('/new-contact'),
          label: const Text('New Contact'),
          isExtended: isExtended, // to edit later when we hve scrolling
          icon: const Icon(
            Icons.message,
            size: 26,
          ),
          backgroundColor: AppTheme.kSecondaryColor,
          foregroundColor: AppTheme.kPrimaryColor,
        ),
      ),
    );
  }
}
