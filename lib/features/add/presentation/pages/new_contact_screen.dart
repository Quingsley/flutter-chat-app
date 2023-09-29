import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/add/presentation/viewmodels/add_view_model.dart';
import 'package:ui/features/auth/presentation/widgets/auth_button.dart';
import 'package:ui/features/auth/presentation/widgets/text_input.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class AddNewContactScreen extends ConsumerStatefulWidget {
  const AddNewContactScreen({super.key});

  @override
  ConsumerState<AddNewContactScreen> createState() => _NewContactCardState();
}

class _NewContactCardState extends ConsumerState<AddNewContactScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<bool?>>(addVmProvider, (previous, state) {
      state.handleErrorAndDataStates(
        context,
        () {
          _controller.clear();
          var user = ref.watch(currentUserProvider);
          ref.invalidate(contactsFutureProvider(user!.email));
          context.pop();
        },
      );
    });

    Size size = MediaQuery.sizeOf(context);
    var addVm = ref.watch(addVmProvider);
    var isLoading = addVm is AsyncLoading;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add new contact',
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: size.height * .7,
            width: size.width * .7,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInput(
                  controller: _controller,
                  hintText: 'Enter new contact email address',
                ),
                SizedBox(
                  height: size.height * .1,
                ),
                OutlinedButton(
                  onPressed: !isLoading
                      ? () => addContactHandler(_controller, ref)
                      : null,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                  ),
                  child: !isLoading
                      ? Text(
                          'Save',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 20,
                          ),
                        )
                      : CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void addContactHandler(TextEditingController controller, WidgetRef ref) {
  ref.read(addVmProvider.notifier).addContact(controller.text);
}
