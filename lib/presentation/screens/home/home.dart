import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_connect/presentation/screens/home/conference.dart';
import '../../../data/repository/module.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final typography = theme.textTheme;
    final userProvider = ref.watch(usersProvider).getUsers();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Let's Connect", style: typography.displaySmall),
          toolbarHeight: 100,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Conference'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ConferenceScreen(userProvider),
            ConferenceScreen(userProvider),
          ],
        ),
      ),
    );
  }

}
