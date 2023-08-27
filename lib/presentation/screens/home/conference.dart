import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/model/user.dart';

class ConferenceScreen extends ConsumerWidget {
  const ConferenceScreen(this.userProvider, {super.key});
  final Future<List<UserData>?> userProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<UserData>?>(
      future: userProvider,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                child: Card(
                  child: ListTile(
                    title: Text('${snapshot.data?[index].fullname}'),
                    subtitle: Text('${snapshot.data?[index].email}'),
                    leading: CircleAvatar(
                      child: Text('${snapshot.data?[index].fullname[0]}'),
                    ),
                    trailing: IconButton(onPressed: () {
                      context.push(
                        '/call/random_101/user/${snapshot.data?[index].email}/name/${snapshot.data?[index].fullname}',
                      );
                    }, icon: const Icon(Icons.video_call_outlined)),
                  ),
                ),
              );
            },
          );
        } else if(snapshot.hasError) {
          return const Center(
            child: Text('No users available.'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
