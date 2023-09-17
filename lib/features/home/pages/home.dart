import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/home/widgets/contact_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2e6b47),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDC100),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('New Contact'),
        isExtended: false, // to edit later when we hve scrolling
        icon: const Icon(
          Icons.message,
          size: 26,
        ),
        backgroundColor: const Color(0xFFFDC100),
        foregroundColor: const Color(0xFF2e6b47),
      ),
    );
  }
}
