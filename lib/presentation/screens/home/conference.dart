import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_connect/data/repository/module.dart';
import 'package:lets_connect/domain/model/call_history.dart';
import 'package:lets_connect/presentation/widgets/viewUtils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../domain/model/user.dart';

@immutable
class ConferenceScreen extends ConsumerWidget {
  ConferenceScreen(this.userProvider, this.authUserId, this.authUserName, this.authUserEmail, {super.key});
  final Future<List<UserData?>?> userProvider;
  final String authUserId;
  final String authUserName;
  final String authUserEmail;
  late BuildContext widgetContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callHistoryProvider = ref.read(callProvider);
    widgetContext = context;
    return FutureBuilder<List<UserData?>?>(
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
                    title: Text('${snapshot.data?[index]?.fullname}'),
                    subtitle: Text('${snapshot.data?[index]?.email}'),
                    leading: CircleAvatar(
                      child: Text('${snapshot.data?[index]?.fullname[0]}'),
                    ),
                    trailing: sendCall('${snapshot.data?[index]?.email}', '${snapshot.data?[index]?.fullname}', (String code, String message, List<String> errorInvitees) {
                      // debugPrint('code: $code || message: $message || errorInvitees: $errorInvitees');
                      if(code.isEmpty && message.isEmpty) {
                        final model = CallHistory(
                            uid: '${snapshot.data?[index]?.uid}',
                            fullname: '${snapshot.data?[index]?.fullname}',
                            email: '${snapshot.data?[index]?.email}',
                            createdate: DateTime.now().toString());
                        callHistoryProvider.insertCall(authUserId, authUserName, authUserEmail, model);
                      } else {
                        context.showSnackBar('User not available.');
                      }
                    }),
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

  Widget sendCall(String userId, String userName, Function(String code, String message, List<String> errorInvitees) callback) {
    debugPrint('userId: $userId');
    final invitees = getInvitee(userId, userName);
    return ZegoSendCallInvitationButton(
      isVideoCall: true,
      invitees: invitees,
      resourceID: "zego_data",
      iconSize: const Size(40, 40),
      buttonSize: const Size(50, 50),
      onPressed: callback,
    );
  }

  List<ZegoUIKitUser> getInvitee(String userId, String userName) {
    List<ZegoUIKitUser> invitees = [];
    invitees.add(
      ZegoUIKitUser(id: userId, name: userName)
    );
    return invitees;
  }

}
