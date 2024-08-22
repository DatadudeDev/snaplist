import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'loading_image_model.dart';
export 'loading_image_model.dart';

class LoadingImageWidget extends StatefulWidget {
  const LoadingImageWidget({
    super.key,
    this.imageUrl,
    this.imageString,
  });

  final FFUploadedFile? imageUrl;
  final String? imageString;

  @override
  State<LoadingImageWidget> createState() => _LoadingImageWidgetState();
}

class _LoadingImageWidgetState extends State<LoadingImageWidget>
    with TickerProviderStateMixin {
  late LoadingImageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasTextTriggered1 = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingImageModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'loadingImage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('LOADING_IMAGE_loadingImage_ON_INIT_STATE');
      await Future.wait([
        Future(() async {
          logFirebaseEvent('loadingImage_update_page_state');
          _model.ten = true;
          setState(() {});
        }),
        Future(() async {
          logFirebaseEvent('loadingImage_upload_media_to_firebase');
          {
            setState(() => _model.isDataUploading = true);
            var selectedUploadedFiles = <FFUploadedFile>[];
            var selectedMedia = <SelectedFile>[];
            var downloadUrls = <String>[];
            try {
              selectedUploadedFiles = widget.imageUrl!.bytes!.isNotEmpty
                  ? [widget.imageUrl!]
                  : <FFUploadedFile>[];
              selectedMedia = selectedFilesFromUploadedFiles(
                selectedUploadedFiles,
              );
              downloadUrls = (await Future.wait(
                selectedMedia.map(
                  (m) async => await uploadData(m.storagePath, m.bytes),
                ),
              ))
                  .where((u) => u != null)
                  .map((u) => u!)
                  .toList();
            } finally {
              _model.isDataUploading = false;
            }
            if (selectedUploadedFiles.length == selectedMedia.length &&
                downloadUrls.length == selectedMedia.length) {
              setState(() {
                _model.uploadedLocalFile = selectedUploadedFiles.first;
                _model.uploadedFileUrl = downloadUrls.first;
              });
            } else {
              setState(() {});
              return;
            }
          }

          if (FFAppState().godmode) {
            logFirebaseEvent('loadingImage_backend_call');
            _model.sendPhotoURLGod =
                await DatacenterAPIDEVGroup.postPhotoDevCall.call(
              userRef: currentUserReference?.id,
              imageBase64: _model.uploadedFileUrl,
            );

            if ((_model.sendPhotoURLGod?.succeeded ?? true)) {
              await Future.wait([
                Future(() async {
                  logFirebaseEvent('loadingImage_backend_call');
                  _model.getPlaylistGod =
                      await DatacenterAPIGroup.getPlaylistURLCall.call(
                    timestamp: getJsonField(
                      (_model.sendPhotoURLGod?.jsonBody ?? ''),
                      r'''$.timestamp''',
                    ),
                    userRef: currentUserReference?.id,
                  );

                  if ((_model.getPlaylistGod?.succeeded ?? true)) {
                    logFirebaseEvent('loadingImage_backend_call');

                    await SnaplistsRecord.collection
                        .doc()
                        .set(createSnaplistsRecordData(
                          userRef: currentUserReference,
                          name: DatacenterAPIGroup.getPlaylistURLCall.name(
                            (_model.getPlaylistGod?.jsonBody ?? ''),
                          ),
                          description:
                              DatacenterAPIGroup.getPlaylistURLCall.description(
                            (_model.getPlaylistGod?.jsonBody ?? ''),
                          ),
                          imageUrl:
                              DatacenterAPIGroup.getPlaylistURLCall.imageUrl(
                            (_model.getPlaylistGod?.jsonBody ?? ''),
                          ),
                          createdTime: getCurrentTimestamp,
                          url:
                              DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
                            (_model.getPlaylistGod?.jsonBody ?? ''),
                          ),
                          id: DatacenterAPIGroup.getPlaylistURLCall.id(
                            (_model.getPlaylistGod?.jsonBody ?? ''),
                          ),
                          type: 'image',
                          userImage: true,
                        ));
                    logFirebaseEvent('loadingImage_wait__delay');
                    await Future.delayed(const Duration(milliseconds: 4000));
                    logFirebaseEvent('loadingImage_backend_call');
                    _model.startPlaybackGod =
                        await SpotifyMediaAPIGroup.startPlayerCall.call(
                      accessToken: FFAppState().accessToken,
                      contextUri:
                          DatacenterAPIGroup.getPlaylistURLCall.contextUri(
                        (_model.getPlaylistGod?.jsonBody ?? ''),
                      ),
                    );

                    if (isAndroid) {
                      logFirebaseEvent('loadingImage_launch_u_r_l');
                      unawaited(
                        () async {
                          await launchURL(
                              DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
                            (_model.getPlaylistGod?.jsonBody ?? ''),
                          )!);
                        }(),
                      );
                      logFirebaseEvent('loadingImage_navigate_to');

                      context.goNamed('HomePage');

                      return;
                    } else {
                      logFirebaseEvent('loadingImage_launch_u_r_l');
                      unawaited(
                        () async {
                          await launchURL(
                              DatacenterAPIGroup.getPlaylistURLCall.contextUri(
                            (_model.getPlaylistGod?.jsonBody ?? ''),
                          )!);
                        }(),
                      );
                      logFirebaseEvent('loadingImage_navigate_to');

                      context.goNamed('HomePage');

                      return;
                    }
                  } else {
                    logFirebaseEvent('loadingImage_update_app_state');
                    FFAppState().makePhoto = false;
                    FFAppState().fileBase64 = '';
                    FFAppState().playlistUrl = '';
                    setState(() {});
                    logFirebaseEvent('loadingImage_navigate_to');

                    context.goNamed(
                      'fail',
                      queryParameters: {
                        'failReason': serializeParam(
                          'get_playlist API failed',
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
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation1'] != null) {
                    setState(() => hasTextTriggered1 = true);
                    SchedulerBinding.instance.addPostFrameCallback((_) async =>
                        await animationsMap['textOnActionTriggerAnimation1']!
                            .controller
                            .forward(from: 0.0));
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.ten = false;
                  _model.twentyNine = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation2'] != null) {
                    await animationsMap['textOnActionTriggerAnimation2']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.twentyNine = false;
                  _model.thirtySeven = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation3'] != null) {
                    await animationsMap['textOnActionTriggerAnimation3']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.thirtySeven = false;
                  _model.fifty = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation4'] != null) {
                    await animationsMap['textOnActionTriggerAnimation4']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.fifty = false;
                  _model.sixtyFive = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4500));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation5'] != null) {
                    await animationsMap['textOnActionTriggerAnimation5']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.sixtyFive = false;
                  _model.eightyThree = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation6'] != null) {
                    await animationsMap['textOnActionTriggerAnimation6']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.eightyThree = false;
                  _model.oneHundred = true;
                  setState(() {});
                  return;
                }),
              ]);
            } else {
              logFirebaseEvent('loadingImage_update_app_state');
              FFAppState().makePhoto = false;
              FFAppState().fileBase64 = '';
              FFAppState().playlistUrl = '';
              setState(() {});
              logFirebaseEvent('loadingImage_backend_call');

              await FeedbackRecord.collection
                  .doc()
                  .set(createFeedbackRecordData(
                    userRef: currentUserReference,
                    feedback: 'post_image fucked up ',
                    isBug: true,
                  ));
              logFirebaseEvent('loadingImage_navigate_to');

              context.pushNamed(
                'fail',
                queryParameters: {
                  'failReason': serializeParam(
                    'post_image API failed',
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
            logFirebaseEvent('loadingImage_backend_call');
            _model.sendPhotoURL =
                await DatacenterAPIGroup.sendUploadedImageCopyCall.call(
              imageUrl: _model.uploadedFileUrl,
              userRef: currentUserReference?.id,
            );

            if ((_model.sendPhotoURL?.succeeded ?? true)) {
              await Future.wait([
                Future(() async {
                  logFirebaseEvent('loadingImage_backend_call');
                  _model.getPlaylist =
                      await DatacenterAPIGroup.getPlaylistURLCall.call(
                    timestamp:
                        DatacenterAPIGroup.sendUploadedImageCopyCall.timestamp(
                      (_model.sendPhotoURL?.jsonBody ?? ''),
                    ),
                    userRef: currentUserReference?.id,
                  );

                  if ((_model.getPlaylist?.succeeded ?? true)) {
                    logFirebaseEvent('loadingImage_backend_call');

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
                          imageUrl:
                              DatacenterAPIGroup.getPlaylistURLCall.imageUrl(
                            (_model.getPlaylist?.jsonBody ?? ''),
                          ),
                          createdTime: getCurrentTimestamp,
                          url:
                              DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
                            (_model.getPlaylist?.jsonBody ?? ''),
                          ),
                          id: DatacenterAPIGroup.getPlaylistURLCall.id(
                            (_model.getPlaylist?.jsonBody ?? ''),
                          ),
                          type: 'image',
                          userImage: true,
                        ));
                    logFirebaseEvent('loadingImage_backend_call');
                    _model.startPlayback =
                        await SpotifyMediaAPIGroup.startPlayerCall.call(
                      accessToken: FFAppState().accessToken,
                      contextUri:
                          DatacenterAPIGroup.getPlaylistURLCall.contextUri(
                        (_model.getPlaylist?.jsonBody ?? ''),
                      ),
                    );

                    if (isAndroid) {
                      logFirebaseEvent('loadingImage_launch_u_r_l');
                      unawaited(
                        () async {
                          await launchURL(
                              DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
                            (_model.getPlaylist?.jsonBody ?? ''),
                          )!);
                        }(),
                      );
                      logFirebaseEvent('loadingImage_navigate_to');

                      context.goNamed('HomePage');

                      return;
                    } else {
                      logFirebaseEvent('loadingImage_launch_u_r_l');
                      unawaited(
                        () async {
                          await launchURL(
                              DatacenterAPIGroup.getPlaylistURLCall.contextUri(
                            (_model.getPlaylist?.jsonBody ?? ''),
                          )!);
                        }(),
                      );
                      logFirebaseEvent('loadingImage_navigate_to');

                      context.goNamed('HomePage');

                      return;
                    }
                  } else {
                    logFirebaseEvent('loadingImage_update_app_state');
                    FFAppState().makePhoto = false;
                    FFAppState().fileBase64 = '';
                    FFAppState().playlistUrl = '';
                    setState(() {});
                    logFirebaseEvent('loadingImage_navigate_to');

                    context.goNamed(
                      'fail',
                      queryParameters: {
                        'failReason': serializeParam(
                          'get_playlist API failed',
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
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation2'] != null) {
                    await animationsMap['textOnActionTriggerAnimation2']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.ten = false;
                  _model.twentyNine = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation2'] != null) {
                    await animationsMap['textOnActionTriggerAnimation2']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.twentyNine = false;
                  _model.thirtySeven = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation3'] != null) {
                    await animationsMap['textOnActionTriggerAnimation3']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.thirtySeven = false;
                  _model.fifty = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation4'] != null) {
                    await animationsMap['textOnActionTriggerAnimation4']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.fifty = false;
                  _model.sixtyFive = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4500));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation5'] != null) {
                    await animationsMap['textOnActionTriggerAnimation5']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.sixtyFive = false;
                  _model.eightyThree = true;
                  setState(() {});
                  logFirebaseEvent('loadingImage_wait__delay');
                  await Future.delayed(const Duration(milliseconds: 4000));
                  logFirebaseEvent('loadingImage_widget_animation');
                  if (animationsMap['textOnActionTriggerAnimation6'] != null) {
                    await animationsMap['textOnActionTriggerAnimation6']!
                        .controller
                        .forward(from: 0.0);
                  }
                  logFirebaseEvent('loadingImage_update_page_state');
                  _model.eightyThree = false;
                  _model.oneHundred = true;
                  setState(() {});
                  return;
                }),
              ]);
            } else {
              logFirebaseEvent('loadingImage_update_app_state');
              FFAppState().makePhoto = false;
              FFAppState().fileBase64 = '';
              FFAppState().playlistUrl = '';
              setState(() {});
              logFirebaseEvent('loadingImage_backend_call');

              await FeedbackRecord.collection
                  .doc()
                  .set(createFeedbackRecordData(
                    userRef: currentUserReference,
                    feedback: 'post_image fucked up ',
                    isBug: true,
                  ));
              logFirebaseEvent('loadingImage_navigate_to');

              context.pushNamed(
                'fail',
                queryParameters: {
                  'failReason': serializeParam(
                    'post_image API failed',
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
          }
        }),
      ]);
    });

    animationsMap.addAll({
      'textOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).alternate,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (FFAppState().isPremium == false)
                      FlutterFlowAdBanner(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 50.0,
                        showsTestAd: true,
                      ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.4,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/IMG_0441-1713140029091.gif',
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: CircularPercentIndicator(
                                        percent: () {
                                          if (_model.ten == true) {
                                            return 0.1;
                                          } else if (_model.twentyNine ==
                                              true) {
                                            return 0.29;
                                          } else if (_model.thirtySeven ==
                                              true) {
                                            return 0.37;
                                          } else if (_model.sixtyFive == true) {
                                            return 0.65;
                                          } else if (_model.eightyThree ==
                                              true) {
                                            return 0.83;
                                          } else if (_model.oneHundred ==
                                              true) {
                                            return 1.0;
                                          } else if (_model.fifty == true) {
                                            return 0.5;
                                          } else {
                                            return 0.0;
                                          }
                                        }(),
                                        radius:
                                            MediaQuery.sizeOf(context).width *
                                                0.425,
                                        lineWidth: 3.0,
                                        animation: true,
                                        animateFromLastPercent: true,
                                        progressColor: () {
                                          if (_model.ten == true) {
                                            return FlutterFlowTheme.of(context)
                                                .primary;
                                          } else if (_model.twentyNine ==
                                              true) {
                                            return FlutterFlowTheme.of(context)
                                                .secondary;
                                          } else if (_model.thirtySeven ==
                                              true) {
                                            return FlutterFlowTheme.of(context)
                                                .tertiary;
                                          } else if (_model.sixtyFive == true) {
                                            return FlutterFlowTheme.of(context)
                                                .primary;
                                          } else if (_model.eightyThree ==
                                              true) {
                                            return FlutterFlowTheme.of(context)
                                                .secondary;
                                          } else if (_model.oneHundred ==
                                              true) {
                                            return FlutterFlowTheme.of(context)
                                                .tertiary;
                                          } else if (_model.fifty == true) {
                                            return FlutterFlowTheme.of(context)
                                                .primary;
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
                              ),
                            ],
                          ),
                        ],
                      ),
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
                              Stack(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_model.ten == true)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'xt9s04a6' /* Analyzing Photo */,
                                            ),
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
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'bh3wq3vm' /* Thinking about some music you'... */,
                                            ),
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
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'a2id7jrh' /* Searching Spotify for some tra... */,
                                            ),
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
                                      if (_model.fifty == true)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'x1nqshwm' /* Grouping your tracks */,
                                            ),
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
                                      if (_model.sixtyFive == true)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'g8uj0cqy' /* Curating your Snaplist */,
                                            ),
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
                                      if (_model.eightyThree == true)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'bj78q3ro' /* hmmmm … let me think…. */,
                                            ),
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
                                                'textOnActionTriggerAnimation6']!,
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
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '836cob3t' /* Wrapping up... */,
                                            ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (FFAppState().isPremium == false)
                      FlutterFlowAdBanner(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 50.0,
                        showsTestAd: true,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
