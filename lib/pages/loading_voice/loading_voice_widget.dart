import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'loading_voice_model.dart';
export 'loading_voice_model.dart';

class LoadingVoiceWidget extends StatefulWidget {
  const LoadingVoiceWidget({
    super.key,
    required this.url,
  });

  final String? url;

  @override
  State<LoadingVoiceWidget> createState() => _LoadingVoiceWidgetState();
}

class _LoadingVoiceWidgetState extends State<LoadingVoiceWidget>
    with TickerProviderStateMixin {
  late LoadingVoiceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasTextTriggered1 = false;
  final animationsMap = {
    'textOnActionTriggerAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1.0,
          end: 0.0,
        ),
      ],
    ),
    'textOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1.0,
          end: 0.0,
        ),
      ],
    ),
    'textOnActionTriggerAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1.0,
          end: 0.0,
        ),
      ],
    ),
    'textOnActionTriggerAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1.0,
          end: 0.0,
        ),
      ],
    ),
    'textOnActionTriggerAnimation5': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1.0,
          end: 0.0,
        ),
      ],
    ),
    'textOnActionTriggerAnimation6': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1.0,
          end: 0.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingVoiceModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'loadingVoice'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('LOADING_VOICE_loadingVoice_ON_INIT_STATE');
      await Future.wait([
        Future(() async {
          logFirebaseEvent('loadingVoice_update_page_state');
          setState(() {
            _model.ten = true;
          });
          logFirebaseEvent('loadingVoice_backend_call');
          _model.sendVoice = await DatacenterAPIGroup.postVoiceCall.call(
            userRef: currentUserReference?.id,
            voice: widget.url,
          );
          if ((_model.sendVoice?.succeeded ?? true)) {
            logFirebaseEvent('loadingVoice_backend_call');
            _model.getPlaylist =
                await DatacenterAPIGroup.getPlaylistURLCall.call(
              timestamp: DatacenterAPIGroup.postVoiceCall.timestamp(
                (_model.sendVoice?.jsonBody ?? ''),
              ),
              userRef: currentUserReference?.id,
            );
            if ((_model.getPlaylist?.succeeded ?? true)) {
              logFirebaseEvent('loadingVoice_backend_call');

              await SnaplistsRecord.collection
                  .doc()
                  .set(createSnaplistsRecordData(
                    userRef: currentUserReference,
                    name: DatacenterAPIGroup.getPlaylistURLCall.name(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    description:
                        DatacenterAPIGroup.getPlaylistURLCall.description(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    imageUrl: DatacenterAPIGroup.getPlaylistURLCall.imageUrl(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    createdTime: getCurrentTimestamp,
                    url: DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    id: DatacenterAPIGroup.getPlaylistURLCall.id(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    type: 'voice',
                  ));
              logFirebaseEvent('loadingVoice_launch_u_r_l');
              unawaited(
                () async {
                  await launchURL(
                      DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
                    (_model.getPlaylist?.jsonBody ?? ''),
                  )!);
                }(),
              );
              logFirebaseEvent('loadingVoice_backend_call');
              _model.startPlayback =
                  await SpotifyMediaAPIGroup.startPlayerCall.call(
                accessToken: FFAppState().accessToken,
                contextUri: DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
                  (_model.getPlaylist?.jsonBody ?? ''),
                ),
              );
              if (isAndroid) {
                logFirebaseEvent('loadingVoice_launch_u_r_l');
                unawaited(
                  () async {
                    await launchURL(
                        DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    )!);
                  }(),
                );
                logFirebaseEvent('loadingVoice_navigate_to');

                context.goNamed('HomePage');

                return;
              } else {
                logFirebaseEvent('loadingVoice_launch_u_r_l');
                unawaited(
                  () async {
                    await launchURL(
                        DatacenterAPIGroup.getPlaylistURLCall.contextUri(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    )!);
                  }(),
                );
                logFirebaseEvent('loadingVoice_navigate_to');

                context.goNamed('HomePage');

                return;
              }
            } else {
              logFirebaseEvent('loadingVoice_update_app_state');
              setState(() {
                FFAppState().makePhoto = false;
                FFAppState().fileBase64 = '';
                FFAppState().playlistUrl = '';
              });
              logFirebaseEvent('loadingVoice_backend_call');

              await FeedbackRecord.collection
                  .doc()
                  .set(createFeedbackRecordData(
                    userRef: currentUserReference,
                    feedback: 'gt_playlist fucked up',
                    isBug: true,
                  ));
              logFirebaseEvent('loadingVoice_navigate_to');

              context.goNamed(
                'fail',
                queryParameters: {
                  'failReason': serializeParam(
                    '',
                    ParamType.String,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  kTransitionInfoKey: const TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );

              return;
            }
          } else {
            logFirebaseEvent('loadingVoice_update_app_state');
            setState(() {
              FFAppState().makePhoto = false;
              FFAppState().fileBase64 = '';
              FFAppState().playlistUrl = '';
            });
            logFirebaseEvent('loadingVoice_backend_call');

            await FeedbackRecord.collection.doc().set(createFeedbackRecordData(
                  userRef: currentUserReference,
                  feedback: 'post_image fucked up ',
                  isBug: true,
                ));
            logFirebaseEvent('loadingVoice_navigate_to');

            context.pushNamed(
              'fail',
              queryParameters: {
                'failReason': serializeParam(
                  '',
                  ParamType.String,
                ),
              }.withoutNulls,
              extra: <String, dynamic>{
                kTransitionInfoKey: const TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );

            return;
          }
        }),
        Future(() async {
          logFirebaseEvent('loadingVoice_wait__delay');
          await Future.delayed(const Duration(milliseconds: 3500));
          logFirebaseEvent('loadingVoice_widget_animation');
          if (animationsMap['textOnActionTriggerAnimation1'] != null) {
            setState(() => hasTextTriggered1 = true);
            SchedulerBinding.instance.addPostFrameCallback((_) async =>
                await animationsMap['textOnActionTriggerAnimation1']!
                    .controller
                    .forward(from: 0.0));
          }
          logFirebaseEvent('loadingVoice_update_page_state');
          setState(() {
            _model.ten = false;
            _model.twentyNine = true;
          });
          logFirebaseEvent('loadingVoice_wait__delay');
          await Future.delayed(const Duration(milliseconds: 3500));
          logFirebaseEvent('loadingVoice_widget_animation');
          if (animationsMap['textOnActionTriggerAnimation2'] != null) {
            await animationsMap['textOnActionTriggerAnimation2']!
                .controller
                .forward(from: 0.0);
          }
          logFirebaseEvent('loadingVoice_update_page_state');
          setState(() {
            _model.twentyNine = false;
            _model.thirtySeven = true;
          });
          logFirebaseEvent('loadingVoice_wait__delay');
          await Future.delayed(const Duration(milliseconds: 3500));
          logFirebaseEvent('loadingVoice_widget_animation');
          if (animationsMap['textOnActionTriggerAnimation3'] != null) {
            await animationsMap['textOnActionTriggerAnimation3']!
                .controller
                .forward(from: 0.0);
          }
          logFirebaseEvent('loadingVoice_update_page_state');
          setState(() {
            _model.thirtySeven = false;
            _model.fifty = true;
          });
          logFirebaseEvent('loadingVoice_wait__delay');
          await Future.delayed(const Duration(milliseconds: 3500));
          logFirebaseEvent('loadingVoice_widget_animation');
          if (animationsMap['textOnActionTriggerAnimation4'] != null) {
            await animationsMap['textOnActionTriggerAnimation4']!
                .controller
                .forward(from: 0.0);
          }
          logFirebaseEvent('loadingVoice_update_page_state');
          setState(() {
            _model.fifty = false;
            _model.sixtyFive = true;
          });
          logFirebaseEvent('loadingVoice_wait__delay');
          await Future.delayed(const Duration(milliseconds: 4000));
          logFirebaseEvent('loadingVoice_widget_animation');
          if (animationsMap['textOnActionTriggerAnimation5'] != null) {
            await animationsMap['textOnActionTriggerAnimation5']!
                .controller
                .forward(from: 0.0);
          }
          logFirebaseEvent('loadingVoice_update_page_state');
          setState(() {
            _model.sixtyFive = false;
            _model.eightyThree = true;
          });
          logFirebaseEvent('loadingVoice_wait__delay');
          await Future.delayed(const Duration(milliseconds: 3500));
          logFirebaseEvent('loadingVoice_widget_animation');
          if (animationsMap['textOnActionTriggerAnimation6'] != null) {
            await animationsMap['textOnActionTriggerAnimation6']!
                .controller
                .forward(from: 0.0);
          }
          logFirebaseEvent('loadingVoice_update_page_state');
          setState(() {
            _model.eightyThree = false;
            _model.oneHundred = true;
          });
        }),
      ]);
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: const Color(0xFF031524),
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/f9a037eb45548f6f79d1f73fae94f701.gif',
                                    width: double.infinity,
                                    height: 340.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: CircularPercentIndicator(
                                    percent: () {
                                      if (_model.ten == true) {
                                        return 0.1;
                                      } else if (_model.twentyNine == true) {
                                        return 0.29;
                                      } else if (_model.thirtySeven == true) {
                                        return 0.37;
                                      } else if (_model.sixtyFive == true) {
                                        return 0.65;
                                      } else if (_model.eightyThree == true) {
                                        return 0.83;
                                      } else if (_model.oneHundred == true) {
                                        return 1.0;
                                      } else if (_model.fifty == true) {
                                        return 0.5;
                                      } else {
                                        return 0.0;
                                      }
                                    }(),
                                    radius: 182.5,
                                    lineWidth: 2.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor: () {
                                      if (_model.ten == true) {
                                        return const Color(0xFFEA42B3);
                                      } else if (_model.twentyNine == true) {
                                        return const Color(0xFF41E7F6);
                                      } else if (_model.thirtySeven == true) {
                                        return const Color(0xFFF2E645);
                                      } else if (_model.sixtyFive == true) {
                                        return const Color(0xFF3DD1A9);
                                      } else if (_model.eightyThree == true) {
                                        return const Color(0xFFF2E645);
                                      } else if (_model.oneHundred == true) {
                                        return const Color(0xFF41E7F6);
                                      } else if (_model.fifty == true) {
                                        return const Color(0xFFEA42B3);
                                      } else {
                                        return Colors.white;
                                      }
                                    }(),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).info,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300.0,
                                  decoration: const BoxDecoration(),
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.ten == true)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: Text(
                                                'Listening...',
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ).animateOnActionTrigger(
                                                  animationsMap[
                                                      'textOnActionTriggerAnimation1']!,
                                                  hasBeenTriggered:
                                                      hasTextTriggered1),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.twentyNine == true)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: Text(
                                                'mmmkay I think I\'ve got something...',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ).animateOnActionTrigger(
                                                animationsMap[
                                                    'textOnActionTriggerAnimation2']!,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.thirtySeven == true)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: Text(
                                                'Searching Spotify for some tracks',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ).animateOnActionTrigger(
                                                animationsMap[
                                                    'textOnActionTriggerAnimation3']!,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.fifty == true)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: Text(
                                                'Searching Spotify for some tracks',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ).animateOnActionTrigger(
                                                animationsMap[
                                                    'textOnActionTriggerAnimation4']!,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.sixtyFive == true)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: Text(
                                                'Curating your Snaplist',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ).animateOnActionTrigger(
                                                animationsMap[
                                                    'textOnActionTriggerAnimation5']!,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.eightyThree == true)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: Text(
                                                'Generating a snappy name',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ).animateOnActionTrigger(
                                                animationsMap[
                                                    'textOnActionTriggerAnimation6']!,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.oneHundred == true)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 0.0),
                                              child: Text(
                                                'Wrapping up...',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (_model.twentyNine == true)
                  Align(
                    alignment: const AlignmentDirectional(1.0, 1.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 50.0, 175.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Mackey_(1).jpg',
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.cover,
                        ),
                      ),
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
