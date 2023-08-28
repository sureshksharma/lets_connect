import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_connect/domain/model/call_history.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen(this.callList, {super.key});
  final Future<List<CallHistory?>?> callList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<CallHistory?>?>(
      future: callList,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('${snapshot.data?[index]?.fullname}'),
                  subtitle: Text('${snapshot.data?[index]?.email}'),
                  leading: CircleAvatar(
                    child: Text('${snapshot.data?[index]?.fullname[0]}'),
                  ),
                  trailing: Text(getCallDuration(snapshot.data![index]!.createdate)),
                ),
              );
            },
          );
        } else if(snapshot.hasError) {
          return const Center(
            child: Text('No calls available to show.'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  String getCallDuration(String createDate) {
    final createDt = DateTime.parse(createDate);
    final duration = DateTime.now().difference(createDt);
    if(duration.inDays == 0) {
      if(duration.inHours == 0) {
        if(duration.inMinutes == 0) {
          return '${duration.inSeconds} secs ago';
        }
        return '${duration.inMinutes} mins ago';
      }
      return '${duration.inHours} hours ago';
    }
    return '${duration.inDays} days ago';
  }

}
