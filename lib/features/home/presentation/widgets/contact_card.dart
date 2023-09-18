import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/styles/theme.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push('/chat/$index'),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: AppTheme.kSecondaryColor.withOpacity(.8),
        child: Icon(
          Icons.person,
          color: AppTheme.kPrimaryColor.withOpacity(.8),
          size: 30,
        ),
      ),
      title: Text(
        'Jerome',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        'Hey, how are you?',
        style: GoogleFonts.openSans(
          color: Colors.grey[400],
          fontSize: 16,
        ),
      ),
      trailing: Column(
        children: [
          Text(
            '12:30',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: AppTheme.kSecondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
