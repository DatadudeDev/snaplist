import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'loading_input_model.dart';
export 'loading_input_model.dart';

class LoadingInputWidget extends StatefulWidget {
  const LoadingInputWidget({
    super.key,
    required this.input,
  });

  final String? input;

  @override
  State<LoadingInputWidget> createState() => _LoadingInputWidgetState();
}

class _LoadingInputWidgetState extends State<LoadingInputWidget>
    with TickerProviderStateMixin {
  late LoadingInputModel _model;

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
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingInputModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'loadingInput'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('LOADING_INPUT_loadingInput_ON_INIT_STATE');
      logFirebaseEvent('loadingInput_update_page_state');
      setState(() {
        _model.ten = true;
      });
      logFirebaseEvent('loadingInput_backend_call');
      _model.sendPhotoURLLoading = await DatacenterAPIGroup.postInputCall.call(
        input: widget.input,
        userRef: currentUserReference?.id,
      );
      if ((_model.sendPhotoURLLoading?.succeeded ?? true)) {
        await Future.wait([
          Future(() async {
            logFirebaseEvent('loadingInput_backend_call');
            _model.getPlaylist =
                await DatacenterAPIGroup.getPlaylistURLInputCall.call(
              timestamp: getJsonField(
                (_model.sendPhotoURLLoading?.jsonBody ?? ''),
                r'''$.timestamp''',
              ),
              userRef: currentUserReference?.id,
            );
            if ((_model.getPlaylist?.succeeded ?? true)) {
              logFirebaseEvent('loadingInput_backend_call');

              await SnaplistsRecord.collection
                  .doc()
                  .set(createSnaplistsRecordData(
                    userRef: currentUserReference,
                    name: DatacenterAPIGroup.getPlaylistURLInputCall.name(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    description:
                        DatacenterAPIGroup.getPlaylistURLInputCall.description(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    imageUrl:
                        DatacenterAPIGroup.getPlaylistURLInputCall.imageUrl(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    createdTime: getCurrentTimestamp,
                    url: DatacenterAPIGroup.getPlaylistURLInputCall.playlistUrl(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                    id: DatacenterAPIGroup.getPlaylistURLInputCall.id(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    ),
                  ));
              logFirebaseEvent('loadingInput_backend_call');
              _model.startPlayback =
                  await SpotifyMediaAPIGroup.startPlayerCall.call(
                accessToken: FFAppState().accessToken,
                contextUri: DatacenterAPIGroup.getPlaylistURLInputCall
                    .contextUri(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    )
                    .toString(),
              );
              if (isAndroid) {
                logFirebaseEvent('loadingInput_launch_u_r_l');
                unawaited(
                  () async {
                    await launchURL(
                        DatacenterAPIGroup.getPlaylistURLInputCall.playlistUrl(
                      (_model.getPlaylist?.jsonBody ?? ''),
                    )!);
                  }(),
                );
                logFirebaseEvent('loadingInput_navigate_to');

                context.goNamed('HomePage');

                return;
              } else {
                logFirebaseEvent('loadingInput_launch_u_r_l');
                unawaited(
                  () async {
                    await launchURL(DatacenterAPIGroup.getPlaylistURLInputCall
                        .contextUri(
                          (_model.getPlaylist?.jsonBody ?? ''),
                        )
                        .toString());
                  }(),
                );
                logFirebaseEvent('loadingInput_navigate_to');

                context.goNamed('HomePage');

                return;
              }
            } else {
              logFirebaseEvent('loadingInput_update_app_state');
              setState(() {
                FFAppState().fileBase64 = '';
                FFAppState().playlistUrl = '';
              });
              logFirebaseEvent('loadingInput_backend_call');

              await FeedbackRecord.collection
                  .doc()
                  .set(createFeedbackRecordData(
                    userRef: currentUserReference,
                    feedback: 'get_playlist fucked up ',
                    isBug: true,
                  ));
              logFirebaseEvent('loadingInput_navigate_to');

              context.goNamed(
                'fail',
                queryParameters: {
                  'failReason': serializeParam(
                    '',
                    ParamType.String,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
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
            logFirebaseEvent('loadingInput_wait__delay');
            await Future.delayed(const Duration(milliseconds: 3000));
            logFirebaseEvent('loadingInput_widget_animation');
            if (animationsMap['textOnActionTriggerAnimation1'] != null) {
              setState(() => hasTextTriggered1 = true);
              SchedulerBinding.instance.addPostFrameCallback((_) async =>
                  await animationsMap['textOnActionTriggerAnimation1']!
                      .controller
                      .forward(from: 0.0));
            }
            logFirebaseEvent('loadingInput_update_page_state');
            setState(() {
              _model.ten = false;
              _model.twentyNine = true;
            });
            logFirebaseEvent('loadingInput_wait__delay');
            await Future.delayed(const Duration(milliseconds: 3000));
            logFirebaseEvent('loadingInput_widget_animation');
            if (animationsMap['textOnActionTriggerAnimation2'] != null) {
              await animationsMap['textOnActionTriggerAnimation2']!
                  .controller
                  .forward(from: 0.0);
            }
            logFirebaseEvent('loadingInput_update_page_state');
            setState(() {
              _model.twentyNine = false;
              _model.thirtySeven = true;
            });
            logFirebaseEvent('loadingInput_wait__delay');
            await Future.delayed(const Duration(milliseconds: 3000));
            logFirebaseEvent('loadingInput_widget_animation');
            if (animationsMap['textOnActionTriggerAnimation3'] != null) {
              await animationsMap['textOnActionTriggerAnimation3']!
                  .controller
                  .forward(from: 0.0);
            }
            logFirebaseEvent('loadingInput_update_page_state');
            setState(() {
              _model.thirtySeven = false;
              _model.sixtyFive = true;
            });
            logFirebaseEvent('loadingInput_wait__delay');
            await Future.delayed(const Duration(milliseconds: 3000));
            logFirebaseEvent('loadingInput_widget_animation');
            if (animationsMap['textOnActionTriggerAnimation4'] != null) {
              await animationsMap['textOnActionTriggerAnimation4']!
                  .controller
                  .forward(from: 0.0);
            }
            logFirebaseEvent('loadingInput_update_page_state');
            setState(() {
              _model.sixtyFive = false;
              _model.eightyThree = true;
            });
            logFirebaseEvent('loadingInput_wait__delay');
            await Future.delayed(const Duration(milliseconds: 3000));
            logFirebaseEvent('loadingInput_widget_animation');
            if (animationsMap['textOnActionTriggerAnimation5'] != null) {
              await animationsMap['textOnActionTriggerAnimation5']!
                  .controller
                  .forward(from: 0.0);
            }
            logFirebaseEvent('loadingInput_update_page_state');
            setState(() {
              _model.eightyThree = false;
              _model.oneHundred = true;
            });
            return;
          }),
        ]);
      } else {
        logFirebaseEvent('loadingInput_update_app_state');
        setState(() {
          FFAppState().makePhoto = false;
          FFAppState().fileBase64 = '';
          FFAppState().playlistUrl = '';
        });
        logFirebaseEvent('loadingInput_backend_call');

        await FeedbackRecord.collection.doc().set(createFeedbackRecordData(
              userRef: currentUserReference,
              feedback: 'post_image fucked up ',
              isBug: true,
            ));
        logFirebaseEvent('loadingInput_navigate_to');

        context.goNamed(
          'fail',
          queryParameters: {
            'failReason': serializeParam(
              '',
              ParamType.String,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );

        return;
      }
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
          backgroundColor: Color(0xFF031524),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(),
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
                              alignment: AlignmentDirectional(0.0, 0.0),
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
                                    return Color(0xFFEA42B3);
                                  } else if (_model.twentyNine == true) {
                                    return Color(0xFF41E7F6);
                                  } else if (_model.thirtySeven == true) {
                                    return Color(0xFFF2E645);
                                  } else if (_model.sixtyFive == true) {
                                    return Color(0xFF3DD1A9);
                                  } else if (_model.eightyThree == true) {
                                    return Color(0xFFEA42B3);
                                  } else if (_model.oneHundred == true) {
                                    return Color(0xFF41E7F6);
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
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_model.ten == true)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            'hmmm let\'s see here...',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_model.twentyNine == true)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            'Thinking about some music you\'ll like ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_model.thirtySeven == true)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            'Searching Spotify for some tracks',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_model.sixtyFive == true)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            'Curating your Snaplist',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_model.eightyThree == true)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            'Generating a snappy name',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_model.oneHundred == true)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            'Wrapping up...',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
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
          ),
        ),
      ),
    );
  }
}
