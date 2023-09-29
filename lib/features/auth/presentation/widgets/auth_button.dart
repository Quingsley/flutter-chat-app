import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({
    super.key,
    required this.isSignUp,
    required this.usernameController,
    required this.emailController,
  });

  final bool isSignUp;
  final TextEditingController usernameController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(
      authControllerProvider,
      (previousState, state) => state.handleErrorAndDataStates(
        context,
        () {
          ref.read(currentUserProvider.notifier).state = state.value;
          context.go('/home');
        },
      ),
    );
    var authProvider = ref.watch(authControllerProvider);
    var isLoading = authProvider is AsyncLoading;
    return OutlinedButton(
      onPressed: !isLoading
          ? () {
              if (isSignUp) {
                signUpHandler(usernameController, emailController, ref);
              } else {
                loginHandler(emailController, ref);
              }
            }
          : null,
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32,
        ),
      ),
      child: !isLoading
          ? Text(
              isSignUp ? 'Sign Up' : 'Sign In',
              style: GoogleFonts.poppins(
                fontSize: 20,
              ),
            )
          : CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
    );
  }
}

void loginHandler(TextEditingController emailController, WidgetRef ref) {
  if (emailController.text.isNotEmpty && emailController.text.contains('@')) {
    ref.read(authControllerProvider.notifier).signIn(emailController.text);
    ref.read(authControllerProvider.notifier).connect();
    emailController.clear();
  }
}

void signUpHandler(TextEditingController usernameController,
    TextEditingController emailController, WidgetRef ref) {
  if (usernameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      emailController.text.contains('@')) {
    ref
        .read(authControllerProvider.notifier)
        .signUp(usernameController.text, emailController.text);
    usernameController.clear();
    emailController.clear();
  }
}

extension AsyncValueUI<T> on AsyncValue<T?> {
  // isLoading shorthand (AsyncLoading is a subclass of AsyncValue)
  bool get isLoading => this is AsyncLoading;
  // show a snackbar on error only
  void handleErrorAndDataStates(BuildContext context, Function navigate) =>
      whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
        data: (data) {
          if (data != null) {
            debugPrint('data: $data');
            navigate();
          }
        },
      );
}
