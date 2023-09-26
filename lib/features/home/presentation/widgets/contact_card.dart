import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/auth/data/models/user_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push('/chat/${user.userName}'),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 30,
        child: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 30,
        ),
      ),
      title: Text(
        'Jerome',
        style: GoogleFonts.poppins(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        'Hey, how are you?',
        style: GoogleFonts.openSans(
          color: Colors.grey[600],
          fontSize: 16,
        ),
      ),
      trailing: Column(
        children: [
          Text(
            '12:30',
            style: GoogleFonts.openSans(
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
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                '2',
                style: TextStyle(
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
