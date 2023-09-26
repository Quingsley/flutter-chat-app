import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/add/presentation/widgets/new_contact_button.dart';
import 'package:ui/features/home/presentation/widgets/contact_card.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class NewContact extends ConsumerWidget {
  const NewContact({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(currentUserProvider);
    var contacts = ref.watch(contactsFutureProvider(user!.email));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text('New Contact',
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const NewContactBtn(),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Contacts on WeeChat',
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: contacts.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Center(
                        child: Text(
                          'No Contacts found',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ContactCard(
                              user: data[index],
                            );
                          });
                    }
                  },
                  error: (err, stackTrace) =>
                      Center(child: Text(err.toString())),
                  loading: () =>
                      const Center(child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
    );
  }
}
