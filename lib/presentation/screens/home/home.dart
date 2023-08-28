import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_connect/constants.dart';
import 'package:lets_connect/domain/listener.dart';
import 'package:lets_connect/presentation/screens/home/conference.dart';
import 'package:lets_connect/presentation/screens/home/history.dart';
import 'package:lets_connect/presentation/screens/home/user_provider.dart';
import 'package:lets_connect/presentation/widgets/viewUtils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../data/repository/module.dart';

class HomeScreen extends ConsumerWidget implements DataListener {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final typography = theme.textTheme;
    final authActions = ref.read(authActionsProvider);
    final authUser = ref.watch(authUserProvider);
    final userProvider = ref.watch(usersProvider).getUsers(authUser!.uid);
    onUserLogin(authUser.email, authUser.fullname);
    final callHistoryProvider = ref.watch(callProvider).getCallHistory(authUser.uid);
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: () {
                authActions.signOut(this);
              }, icon: const Icon(Icons.login_outlined)),
            ],
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
              ConferenceScreen(userProvider, authUser.uid, authUser.fullname, authUser.email),
              HistoryScreen(callHistoryProvider),
            ],
          ),
        ),
      ),
    );
  }

  void onUserLogin(String userId, String userName) async {
    ZegoUIKitPrebuiltCallController? callController = ZegoUIKitPrebuiltCallController();
    await ZegoUIKitPrebuiltCallInvitationService().init(
        appID: Constants.appID,
        appSign: Constants.appSign,
        userID: userId,
        userName: userName,
        notifyWhenAppRunningInBackgroundOrQuit: true,
        androidNotificationConfig: ZegoAndroidNotificationConfig(
          channelID: "ZegoUIKit",
          channelName: "Call Notifications",
          sound: "notification",
        ),
        requireConfig: (ZegoCallInvitationData data) {
          final config = ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
          //config.avatarBuilder = customAvatarBuilder;
          config.topMenuBarConfig.isVisible = true;
          config.topMenuBarConfig.buttons
              .insert(0, ZegoMenuBarButtonName.minimizingButton);

          return config;
        },
        plugins: [ZegoUIKitSignalingPlugin()],
      controller: callController,
    );
  }

  @override
  void onFailure(String message) {
    _scaffoldKey.currentContext!.hideDialog();
  }

  @override
  void onStarted() {
    _scaffoldKey.currentContext!.showProgressDialog();
  }

  @override
  void onSuccess() async {
    _scaffoldKey.currentContext!.hideDialog();
    await ZegoUIKitPrebuiltCallInvitationService().uninit();
    _scaffoldKey.currentContext!.pop();
  }

}
