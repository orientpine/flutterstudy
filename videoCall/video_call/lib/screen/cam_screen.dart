// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/const/agora.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoveView;

class CamScreen extends StatefulWidget {
  CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  int? uid;
  int? otheruid;
  RtcEngine? engine;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIVE',
        ),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    renderMainView(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.grey,
                        height: 160,
                        width: 120,
                        child: renderSubView(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (engine != null) {
                      await engine!.leaveChannel();
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('?????? ?????????'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget renderSubView() {
    if (otheruid == null) {
      return Center(
        child: Text('????????? ????????? ????????????.'),
      );
    } else {
      return RtcRemoveView.SurfaceView(
        uid: otheruid!,
        channelId: CHANNEL_NAME,
      );
    }
  }

  Widget renderMainView() {
    if (uid == null) {
      return Center(
        child: Text('????????? ??????????????????'),
      );
    } else {
      return RtcLocalView.SurfaceView();
    }
  }

  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      throw ' ????????? ?????? ???????????? ????????? ????????????.';
    }
    if (engine == null) {
      RtcEngineContext context = RtcEngineContext(APP_ID);
      engine = await RtcEngine.createWithContext(context);

      engine!.setEventHandler(
        RtcEngineEventHandler(
            joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('????????? ??????????????????. uid:$uid');
          setState(
            () {
              this.uid = uid;
            },
          );
        }, leaveChannel: (state) {
          print('?????? ??????');
          setState(() {
            uid = null;
          });
        }, userJoined: (int uid, int elapsed) {
          print('????????? ????????? ??????????????????. uid:$uid');
          setState(() {
            otheruid = uid;
          });
        }, userOffline: (int uid, UserOfflineReason reason) {
          print('????????? ???????????? ???????????????. uid:$uid');
          setState(() {
            otheruid = null;
          });
        }),
      );
      await engine!.enableVideo();
      // ????????? ????????????
      await engine!.joinChannel(TEMP_TOKEN, CHANNEL_NAME, null, 0);
    }

    return true;
  }
}
