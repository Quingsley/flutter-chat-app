import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/features/home/presentation/widgets/contact_card.dart';
import 'package:ui/main.dart';
import 'package:ui/shared/providers/shared_providers.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
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
    var isDarkMode = ref.watch(switchThemeStateProvider);
    var user = ref.watch(currentUserProvider);
    var contacts = ref.watch(contactsFutureProvider(user!.email));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 80,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: IconButton(
              onPressed: () {},
              icon: Text(
                user.userName.substring(0, 1).toUpperCase(),
                style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          'Your Contacts',
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.secondary,
            iconSize: 30,
            onPressed: () {
              ref.read(switchThemeStateProvider.notifier).state =
                  !ref.read(switchThemeStateProvider.notifier).state;
            },
            icon: isDarkMode
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: contacts.when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Text(
                  'No contacts yet\nPress the button below to add a new contact',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: data.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ContactCard(
                    user: data[index],
                  );
                });
          },
          error: (err, stackTrace) => Center(child: Text(err.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
      floatingActionButton: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () => context.push('/new-contact'),
          label: Text(
            'New Contact',
            style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          isExtended: !isExtended, // to edit later when we hve scrolling
          icon: Icon(
            Icons.message,
            color: Theme.of(context).colorScheme.secondary,
            size: 26,
          ),
        ),
      ),
    );
  }
}
