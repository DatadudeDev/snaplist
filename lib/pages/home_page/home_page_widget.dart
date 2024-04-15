import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/congrats/congrats_widget.dart';
import '/pages/feedback_modal/feedback_modal_widget.dart';
import '/pages/input_modal/input_modal_widget.dart';
import '/pages/non_grats/non_grats_widget.dart';
import '/pages/voice_modal/voice_modal_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    super.key,
    this.mood,
    this.upgraded,
    bool? downgraded,
  }) : downgraded = downgraded ?? false;

  final String? mood;
  final bool? upgraded;
  final bool downgraded;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 0.ms,
          begin: const Offset(-30.0, 0.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'HomePage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_PAGE_PAGE_HomePage_ON_INIT_STATE');
      await Future.wait([
        Future(() async {
          logFirebaseEvent('HomePage_backend_call');
          _model.getMoods = await DatacenterAPIGroup.getMoodsCall.call();
          if ((_model.getMoods?.succeeded ?? true)) {
            logFirebaseEvent('HomePage_update_app_state');
            setState(() {
              FFAppState().moods = DatacenterAPIGroup.getMoodsCall
                  .moodList(
                    (_model.getMoods?.jsonBody ?? ''),
                  )!
                  .toList()
                  .cast<dynamic>();
            });
            logFirebaseEvent('HomePage_update_app_state');
            setState(() {
              FFAppState().makePhoto = false;
              FFAppState().fileBase64 = '';
            });
            return;
          } else {
            logFirebaseEvent('HomePage_navigate_to');

            context.goNamed(
              'fail',
              queryParameters: {
                'failReason': serializeParam(
                  'failed to acquire Moods.json',
                  ParamType.String,
                ),
              }.withoutNulls,
            );

            return;
          }
        }),
        Future(() async {
          if (FFAppState().refreshToken != '') {
            logFirebaseEvent('HomePage_backend_call');
            _model.refreshAccessToken1 =
                await SpotifyAccountAPIGroup.acqurireNewAccessTokenCall.call(
              refreshToken: FFAppState().refreshToken,
              base64: functions.toBase64(
                  '66735975625f4a9cbd385f15504e4ee8:eb2113c63dfe496e88fd346e9694b6c1'),
            );
            if (SpotifyAccountAPIGroup.acqurireNewAccessTokenCall.accessToken(
                      (_model.refreshAccessToken1?.jsonBody ?? ''),
                    ) !=
                    null &&
                SpotifyAccountAPIGroup.acqurireNewAccessTokenCall.accessToken(
                      (_model.refreshAccessToken1?.jsonBody ?? ''),
                    ) !=
                    '') {
              logFirebaseEvent('HomePage_update_app_state');
              setState(() {
                FFAppState().accessToken = SpotifyAccountAPIGroup
                    .acqurireNewAccessTokenCall
                    .accessToken(
                  (_model.refreshAccessToken1?.jsonBody ?? ''),
                )!;
              });
              return;
            } else {
              logFirebaseEvent('HomePage_navigate_to');

              context.pushNamed(
                'fail',
                queryParameters: {
                  'failReason': serializeParam(
                    'failed to acquire refresh token',
                    ParamType.String,
                  ),
                }.withoutNulls,
              );

              return;
            }
          } else {
            logFirebaseEvent('HomePage_firestore_query');
            _model.getRefreshTokenFromFirebase = await queryAuthRecordOnce(
              queryBuilder: (authRecord) => authRecord
                  .where(
                    'user',
                    isEqualTo: currentUserReference,
                  )
                  .orderBy('timeCreated', descending: true),
              singleRecord: true,
            ).then((s) => s.firstOrNull);
            if (_model.getRefreshTokenFromFirebase?.refreshToken != null &&
                _model.getRefreshTokenFromFirebase?.refreshToken != '') {
              logFirebaseEvent('HomePage_update_app_state');
              setState(() {
                FFAppState().refreshToken =
                    _model.getRefreshTokenFromFirebase!.refreshToken;
              });
              logFirebaseEvent('HomePage_backend_call');
              _model.refreshAccessToken2 =
                  await SpotifyAccountAPIGroup.acqurireNewAccessTokenCall.call(
                refreshToken: FFAppState().refreshToken,
                base64: functions.toBase64(
                    '66735975625f4a9cbd385f15504e4ee8:eb2113c63dfe496e88fd346e9694b6c1'),
              );
              logFirebaseEvent('HomePage_update_app_state');
              setState(() {
                FFAppState().accessToken = SpotifyAccountAPIGroup
                    .acqurireNewAccessTokenCall
                    .accessToken(
                  (_model.refreshAccessToken2?.jsonBody ?? ''),
                )!;
              });
              return;
            } else {
              logFirebaseEvent('HomePage_navigate_to');

              context.pushNamed('spotify');

              return;
            }
          }
        }),
        Future(() async {
          logFirebaseEvent('HomePage_firestore_query');
          _model.checkPremium = await queryPremiumRecordOnce(
            queryBuilder: (premiumRecord) => premiumRecord
                .where(
                  'user',
                  isEqualTo: currentUserReference,
                )
                .orderBy('createdOn', descending: true),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          if (_model.checkPremium!.isPremium) {
            logFirebaseEvent('HomePage_update_app_state');
            setState(() {
              FFAppState().isPremium = true;
            });
            return;
          } else {
            logFirebaseEvent('HomePage_update_app_state');
            setState(() {
              FFAppState().isPremium = false;
            });
            return;
          }
        }),
        Future(() async {
          if (widget.upgraded!) {
            logFirebaseEvent('HomePage_alert_dialog');
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 0,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: const AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: GestureDetector(
                    onTap: () => _model.unfocusNode.canRequestFocus
                        ? FocusScope.of(context)
                            .requestFocus(_model.unfocusNode)
                        : FocusScope.of(context).unfocus(),
                    child: SizedBox(
                      height: 500.0,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: const CongratsWidget(),
                    ),
                  ),
                );
              },
            ).then((value) => setState(() {}));

            return;
          } else {
            return;
          }
        }),
        Future(() async {
          if (widget.downgraded) {
            logFirebaseEvent('HomePage_alert_dialog');
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 0,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: const AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: GestureDetector(
                    onTap: () => _model.unfocusNode.canRequestFocus
                        ? FocusScope.of(context)
                            .requestFocus(_model.unfocusNode)
                        : FocusScope.of(context).unfocus(),
                    child: SizedBox(
                      height: 500.0,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: const NonGratsWidget(),
                    ),
                  ),
                );
              },
            ).then((value) => setState(() {}));

            return;
          } else {
            return;
          }
        }),
      ]);
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
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

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          drawer: Drawer(
            elevation: 16.0,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 14.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: Image.asset(
                                      'assets/images/IMG_0445-1713210096620.png',
                                    ).image,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              if (FFAppState().isPremium == true)
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'h34n2i95' /* Snaplist+ */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 40.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              if (FFAppState().isPremium == false)
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '2a958eat' /* Snaplist */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 40.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 20.0, 16.0, 10.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'HOME_PAGE_PAGE_contentView_1_ON_TAP');
                          logFirebaseEvent('contentView_1_update_page_state');
                          setState(() {
                            _model.isExplore = false;
                            _model.isMenu = false;
                            _model.isSettings = false;
                            _model.isProfile = true;
                            _model.isRecents = false;
                            _model.isFeedback = false;
                          });
                          logFirebaseEvent('contentView_1_wait__delay');
                          await Future.delayed(
                              const Duration(milliseconds: 2000));
                          logFirebaseEvent('contentView_1_update_page_state');
                          setState(() {
                            _model.isProfile = false;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 12.0, 12.0),
                                  child: Container(
                                    width: 4.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: _model.isProfile == true
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.account_circle,
                                  color: _model.isProfile == true
                                      ? FlutterFlowTheme.of(context).primaryText
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  size: 28.0,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'v3zt30gf' /* Profile */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: _model.isProfile == true
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          fontSize: _model.isProfile == true
                                              ? 16.0
                                              : 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                if (_model.isProfile == true)
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        40.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'yugs08t2' /* (coming soon) */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 10.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'HOME_PAGE_PAGE_contentView_1_ON_TAP');
                          logFirebaseEvent('contentView_1_update_page_state');
                          setState(() {
                            _model.isExplore = true;
                            _model.isMenu = false;
                            _model.isSettings = false;
                            _model.isProfile = false;
                            _model.isRecents = false;
                            _model.isFeedback = false;
                          });
                          logFirebaseEvent('contentView_1_wait__delay');
                          await Future.delayed(
                              const Duration(milliseconds: 2000));
                          logFirebaseEvent('contentView_1_update_page_state');
                          setState(() {
                            _model.isExplore = false;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 12.0, 12.0),
                                  child: Container(
                                    width: 4.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: _model.isExplore == true
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.explore_outlined,
                                  color: _model.isExplore == true
                                      ? FlutterFlowTheme.of(context).primaryText
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  size: 28.0,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'mj3cs1s8' /* Preferences */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: _model.isExplore == true
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          fontSize: _model.isExplore == true
                                              ? 16.0
                                              : 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                if (_model.isExplore == true)
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'lkk1fqkt' /* (coming soon) */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 10.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'HOME_PAGE_PAGE_contentView_1_ON_TAP');
                          await Future.wait([
                            Future(() async {
                              logFirebaseEvent(
                                  'contentView_1_update_page_state');
                              setState(() {
                                _model.isSettings = true;
                              });
                            }),
                            Future(() async {
                              logFirebaseEvent('contentView_1_navigate_to');

                              context.pushNamed('settings');

                              logFirebaseEvent(
                                  'contentView_1_update_page_state');
                              setState(() {
                                _model.isSettings = false;
                              });
                            }),
                          ]);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 12.0, 12.0),
                                  child: Container(
                                    width: 4.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: _model.isSettings == true
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Icon(
                                      Icons.settings_rounded,
                                      color: _model.isSettings == true
                                          ? FlutterFlowTheme.of(context)
                                              .primaryText
                                          : FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      size: 28.0,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'avja8n0b' /* Settings */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: _model.isSettings == true
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          fontSize: _model.isSettings == true
                                              ? 16.0
                                              : 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              width: 0.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: const Alignment(0.0, 0),
                                child: TabBar(
                                  labelColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  unselectedLabelColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                  unselectedLabelStyle: const TextStyle(),
                                  indicatorColor:
                                      FlutterFlowTheme.of(context).primary,
                                  padding: const EdgeInsets.all(4.0),
                                  tabs: [
                                    Tab(
                                      text: FFLocalizations.of(context).getText(
                                        'v5dj6jcx' /* Moods */,
                                      ),
                                    ),
                                    Tab(
                                      text: FFLocalizations.of(context).getText(
                                        '4zmkjckh' /* Recents */,
                                      ),
                                    ),
                                  ],
                                  controller: _model.tabBarController,
                                  onTap: (i) async {
                                    [() async {}, () async {}][i]();
                                  },
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _model.tabBarController,
                                  children: [
                                    KeepAliveWidgetWrapper(
                                      builder: (context) => Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1.0,
                                        decoration: const BoxDecoration(),
                                        child: Builder(
                                          builder: (context) {
                                            final mood =
                                                FFAppState().moods.toList();
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: mood.length,
                                              itemBuilder:
                                                  (context, moodIndex) {
                                                final moodItem =
                                                    mood[moodIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      logFirebaseEvent(
                                                          'HOME_PAGE_PAGE_Row_d92ut47m_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Row_navigate_to');

                                                      context.goNamed(
                                                        'loadingMood',
                                                        queryParameters: {
                                                          'mood':
                                                              serializeParam(
                                                            getJsonField(
                                                              moodItem,
                                                              r'''$.mood''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            getJsonField(
                                                              moodItem,
                                                              r'''$.url''',
                                                            ).toString(),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        150.0,
                                                                    decoration:
                                                                        const BoxDecoration(),
                                                                    child: Text(
                                                                      getJsonField(
                                                                        moodItem,
                                                                        r'''$.mood''',
                                                                      ).toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          1,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Readex Pro',
                                                                            fontSize:
                                                                                18.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: 150.0,
                                                                  decoration:
                                                                      const BoxDecoration(),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      getJsonField(
                                                                        moodItem,
                                                                        r'''$.Description''',
                                                                      ).toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Readex Pro',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
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
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    KeepAliveWidgetWrapper(
                                      builder: (context) =>
                                          StreamBuilder<List<SnaplistsRecord>>(
                                        stream: querySnaplistsRecord(
                                          queryBuilder: (snaplistsRecord) =>
                                              snaplistsRecord
                                                  .where(
                                                    'userRef',
                                                    isEqualTo:
                                                        currentUserReference,
                                                  )
                                                  .orderBy('createdTime',
                                                      descending: true),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child: SpinKitFoldingCube(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .warning,
                                                  size: 50.0,
                                                ),
                                              ),
                                            );
                                          }
                                          List<SnaplistsRecord>
                                              containerSnaplistsRecordList =
                                              snapshot.data!;
                                          return Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                1.0,
                                            decoration: const BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                if (containerSnaplistsRecordList.isEmpty)
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        20.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '6rn1igup' /* Nothing here yet 😲  */,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    fontSize:
                                                                        18.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 200.0,
                                                            decoration:
                                                                const BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'pjku8rtr' /* Snap a vibe or select a mood t... */,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 2,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        15.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/output-onlinegiftools_(1).gif',
                                                                width: 120.0,
                                                                height: 200.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                if (containerSnaplistsRecordList.isNotEmpty)
                                                  Builder(
                                                    builder: (context) {
                                                      final recents =
                                                          containerSnaplistsRecordList
                                                              .toList();
                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            recents.length,
                                                        itemBuilder: (context,
                                                            recentsIndex) {
                                                          final recentsItem =
                                                              recents[
                                                                  recentsIndex];
                                                          return Builder(
                                                            builder:
                                                                (context) =>
                                                                    Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          5.0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'HOME_PAGE_PAGE_Row_9ym3ucw2_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Row_launch_u_r_l');
                                                                  await launchURL(
                                                                      recentsItem
                                                                          .url);
                                                                  logFirebaseEvent(
                                                                      'Row_drawer');
                                                                  if (scaffoldKey
                                                                          .currentState!
                                                                          .isDrawerOpen ||
                                                                      scaffoldKey
                                                                          .currentState!
                                                                          .isEndDrawerOpen) {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                onLongPress:
                                                                    () async {
                                                                  logFirebaseEvent(
                                                                      'HOME_Row_9ym3ucw2_ON_LONG_PRESS');
                                                                  logFirebaseEvent(
                                                                      'Row_share');
                                                                  await Share
                                                                      .share(
                                                                    recentsItem
                                                                        .url,
                                                                    sharePositionOrigin:
                                                                        getWidgetBoundingBox(
                                                                            context),
                                                                  );
                                                                },
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            260.0,
                                                                        height:
                                                                            200.0,
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            ClipRect(
                                                                              child: ImageFiltered(
                                                                                imageFilter: ImageFilter.blur(
                                                                                  sigmaX: 3.0,
                                                                                  sigmaY: 3.0,
                                                                                ),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                  child: Image.network(
                                                                                    recentsItem.imageUrl,
                                                                                    width: 260.0,
                                                                                    height: 200.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 260.0,
                                                                              height: 200.0,
                                                                              decoration: const BoxDecoration(),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                        child: Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                          height: 65.0,
                                                                                          decoration: const BoxDecoration(
                                                                                            color: Color(0xCA000000),
                                                                                            borderRadius: BorderRadius.only(
                                                                                              bottomLeft: Radius.circular(12.0),
                                                                                              bottomRight: Radius.circular(12.0),
                                                                                              topLeft: Radius.circular(12.0),
                                                                                              topRight: Radius.circular(12.0),
                                                                                            ),
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                decoration: const BoxDecoration(),
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          width: 200.0,
                                                                                                          height: 30.0,
                                                                                                          decoration: const BoxDecoration(),
                                                                                                          child: Align(
                                                                                                            alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                            child: AutoSizeText(
                                                                                                              recentsItem.name,
                                                                                                              textAlign: TextAlign.center,
                                                                                                              maxLines: 1,
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    fontFamily: 'Readex Pro',
                                                                                                                    color: Colors.white,
                                                                                                                    fontSize: 20.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                                child: Container(
                                                                                                  width: 200.0,
                                                                                                  decoration: const BoxDecoration(),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            width: 200.0,
                                                                                                            decoration: const BoxDecoration(),
                                                                                                            child: Align(
                                                                                                              alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                              child: AutoSizeText(
                                                                                                                recentsItem.description,
                                                                                                                textAlign: TextAlign.center,
                                                                                                                maxLines: 1,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      fontFamily: 'Readex Pro',
                                                                                                                      color: Colors.white,
                                                                                                                      fontSize: 14.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                    ),
                                                                                                                minFontSize: 10.0,
                                                                                                              ),
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
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Container(
                        width: double.infinity,
                        height: 62.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Divider(
                                height: 12.0,
                                thickness: 2.0,
                                color: Color(0xFFE5E7EB),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 50.0,
                                decoration: const BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'HOME_PAGE_PAGE_lightDark_small_ON_TAP');
                                          if ((Theme.of(context).brightness ==
                                                  Brightness.light) ==
                                              true) {
                                            logFirebaseEvent(
                                                'lightDark_small_set_dark_mode_settings');
                                            setDarkModeSetting(
                                                context, ThemeMode.dark);
                                            logFirebaseEvent(
                                                'lightDark_small_widget_animation');
                                            if (animationsMap[
                                                    'containerOnActionTriggerAnimation'] !=
                                                null) {
                                              animationsMap[
                                                      'containerOnActionTriggerAnimation']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                          } else {
                                            logFirebaseEvent(
                                                'lightDark_small_set_dark_mode_settings');
                                            setDarkModeSetting(
                                                context, ThemeMode.light);
                                            logFirebaseEvent(
                                                'lightDark_small_widget_animation');
                                            if (animationsMap[
                                                    'containerOnActionTriggerAnimation'] !=
                                                null) {
                                              animationsMap[
                                                      'containerOnActionTriggerAnimation']!
                                                  .controller
                                                  .reverse();
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: 60.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            border: Border.all(
                                              color: const Color(0xFFE0E3E7),
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Stack(
                                              alignment: const AlignmentDirectional(
                                                  0.0, 0.0),
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -0.9, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(6.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Icon(
                                                      Icons.wb_sunny_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 18.0,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                6.0, 0.0),
                                                    child: Icon(
                                                      Icons.mode_night_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 18.0,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Container(
                                                    width: 25.0,
                                                    height: 25.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x430B0D0F),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                  ).animateOnActionTrigger(
                                                    animationsMap[
                                                        'containerOnActionTriggerAnimation']!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'HOME_PAGE_PAGE_FEEDBACK_BTN_ON_TAP');
                                        logFirebaseEvent('Button_drawer');
                                        if (scaffoldKey
                                                .currentState!.isDrawerOpen ||
                                            scaffoldKey.currentState!
                                                .isEndDrawerOpen) {
                                          Navigator.pop(context);
                                        }

                                        logFirebaseEvent('Button_bottom_sheet');
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () => _model.unfocusNode
                                                      .canRequestFocus
                                                  ? FocusScope.of(context)
                                                      .requestFocus(
                                                          _model.unfocusNode)
                                                  : FocusScope.of(context)
                                                      .unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: const FeedbackModalWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'wxj1dj0s' /* Feedback */,
                                      ),
                                      options: FFButtonOptions(
                                        width: 80.0,
                                        height: 30.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            6.0, 0.0, 6.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'HOME_PAGE_PAGE_LOG_OUT_BTN_ON_TAP');
                                        logFirebaseEvent(
                                            'Button_update_app_state');
                                        setState(() {
                                          FFAppState().makePhoto = false;
                                          FFAppState().fileBase64 = '';
                                          FFAppState().deleteSpotifyAuth();
                                          FFAppState().spotifyAuth = false;

                                          FFAppState().deleteAccessToken();
                                          FFAppState().accessToken = '';

                                          FFAppState().deleteRefreshToken();
                                          FFAppState().refreshToken = '';

                                          FFAppState().tracks = [];
                                          FFAppState().deletePlaylists();
                                          FFAppState().Playlists = [];

                                          FFAppState().playlistUrl = '';
                                          FFAppState().deleteSpotifyUsername();
                                          FFAppState().spotifyUsername = '';

                                          FFAppState().ticketTime = '';
                                          FFAppState().deleteMoods();
                                          FFAppState().moods = [];

                                          FFAppState().moodDescription = [];
                                          FFAppState().moodUrl = [];
                                        });
                                        logFirebaseEvent('Button_auth');
                                        GoRouter.of(context).prepareAuthEvent();
                                        await authManager.signOut();
                                        GoRouter.of(context)
                                            .clearRedirectLocation();

                                        context.goNamedAuth(
                                            'login', context.mounted);
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        '17muqkkw' /* Log out */,
                                      ),
                                      options: FFButtonOptions(
                                        width: 80.0,
                                        height: 30.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            6.0, 0.0, 6.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SafeArea(
            top: true,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.64,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: custom_widgets.CameraPhoto(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          decoration: const BoxDecoration(),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.25,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StreamBuilder<List<SnaplistsRecord>>(
                                  stream: querySnaplistsRecord(
                                    queryBuilder: (snaplistsRecord) =>
                                        snaplistsRecord
                                            .where(
                                              'userRef',
                                              isEqualTo: currentUserReference,
                                            )
                                            .where(
                                              'userImage',
                                              isEqualTo: true,
                                            )
                                            .orderBy('createdTime',
                                                descending: true),
                                    singleRecord: true,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: SpinKitFoldingCube(
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            size: 50.0,
                                          ),
                                        ),
                                      );
                                    }
                                    List<SnaplistsRecord>
                                        containerSnaplistsRecordList =
                                        snapshot.data!;
                                    // Return an empty Container when the item does not exist.
                                    if (snapshot.data!.isEmpty) {
                                      return Container();
                                    }
                                    final containerSnaplistsRecord =
                                        containerSnaplistsRecordList.isNotEmpty
                                            ? containerSnaplistsRecordList.first
                                            : null;
                                    return Container(
                                      width: 54.0,
                                      height: 54.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  if ((containerSnaplistsRecord !=
                                                          null) ==
                                                      true)
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'HOME_CircleImage_u8a2tvge_ON_TAP');
                                                        logFirebaseEvent(
                                                            'CircleImage_expand_image');
                                                        await Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                FlutterFlowExpandedImageView(
                                                              image:
                                                                  CachedNetworkImage(
                                                                fadeInDuration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                fadeOutDuration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                imageUrl:
                                                                    '${containerSnaplistsRecord?.imageUrl}',
                                                                fit: BoxFit
                                                                    .contain,
                                                                errorWidget: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Image.asset(
                                                                  'assets/images/error_image.png',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                              allowRotation:
                                                                  false,
                                                              tag:
                                                                  '${containerSnaplistsRecord?.imageUrl}',
                                                              useHeroAnimation:
                                                                  true,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Hero(
                                                        tag:
                                                            '${containerSnaplistsRecord?.imageUrl}',
                                                        transitionOnUserGestures:
                                                            true,
                                                        child: Container(
                                                          width: 48.0,
                                                          height: 48.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            fadeInDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            fadeOutDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            imageUrl:
                                                                '${containerSnaplistsRecord?.imageUrl}',
                                                            fit: BoxFit.cover,
                                                            errorWidget: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                Image.asset(
                                                              'assets/images/error_image.png',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if ((containerSnaplistsRecord !=
                                                          null) ==
                                                      false)
                                                    Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    borderRadius: BorderRadius.circular(120.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 75.0,
                                            height: 75.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(120.0),
                                                bottomRight:
                                                    Radius.circular(120.0),
                                                topLeft: Radius.circular(120.0),
                                                topRight:
                                                    Radius.circular(120.0),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 60.0,
                                                      height: 60.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        borderRadius:
                                                            const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  120.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  120.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  120.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  120.0),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    const BoxDecoration(),
                                                                child:
                                                                    SizedBox(
                                                                  width: 40.0,
                                                                  height: 40.0,
                                                                  child: Stack(
                                                                    children: [
                                                                      if (_model
                                                                              .navCarouselCurrentIndex ==
                                                                          0)
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            logFirebaseEvent('HOME_PAGE_PAGE_Column_3yzok4s2_ON_TAP');
                                                                            logFirebaseEvent('Column_bottom_sheet');
                                                                            await showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return GestureDetector(
                                                                                  onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
                                                                                  child: Padding(
                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                    child: const SizedBox(
                                                                                      height: 500.0,
                                                                                      child: InputModalWidget(),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ).then((value) =>
                                                                                safeSetState(() {}));
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.chat_sharp,
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    size: 35.0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      if (_model
                                                                              .navCarouselCurrentIndex ==
                                                                          1)
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            logFirebaseEvent('HOME_PAGE_PAGE_Column_xikq0mrd_ON_TAP');
                                                                            var shouldSetState =
                                                                                false;
                                                                            logFirebaseEvent('Column_backend_call');
                                                                            _model.pauseMusic2 =
                                                                                await SpotifyMediaAPIGroup.pauseMusicCall.call();
                                                                            shouldSetState =
                                                                                true;
                                                                            if ((_model.pauseMusic2?.succeeded ??
                                                                                true)) {
                                                                              logFirebaseEvent('Column_bottom_sheet');
                                                                              await showModalBottomSheet(
                                                                                isScrollControlled: true,
                                                                                backgroundColor: Colors.transparent,
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return GestureDetector(
                                                                                    onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
                                                                                    child: Padding(
                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                      child: const SizedBox(
                                                                                        height: 250.0,
                                                                                        child: VoiceModalWidget(
                                                                                          isPaused: true,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ).then((value) => safeSetState(() {}));

                                                                              if (shouldSetState) {
                                                                                setState(() {});
                                                                              }
                                                                              return;
                                                                            } else {
                                                                              logFirebaseEvent('Column_bottom_sheet');
                                                                              await showModalBottomSheet(
                                                                                isScrollControlled: true,
                                                                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return GestureDetector(
                                                                                    onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
                                                                                    child: Padding(
                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                      child: const SizedBox(
                                                                                        height: 275.0,
                                                                                        child: VoiceModalWidget(
                                                                                          isPaused: false,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ).then((value) => safeSetState(() {}));

                                                                              if (shouldSetState) {
                                                                                setState(() {});
                                                                              }
                                                                              return;
                                                                            }

                                                                            if (shouldSetState) {
                                                                              setState(() {});
                                                                            }
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  FaIcon(
                                                                                    FontAwesomeIcons.microphoneAlt,
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    size: 35.0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      if (_model
                                                                              .navCarouselCurrentIndex ==
                                                                          2)
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            logFirebaseEvent('HOME_PAGE_PAGE_Column_cd4m4z3g_ON_TAP');
                                                                            logFirebaseEvent('Column_upload_media_to_firebase');
                                                                            final selectedMedia =
                                                                                await selectMedia(
                                                                              maxWidth: 600.00,
                                                                              maxHeight: 600.00,
                                                                              imageQuality: 25,
                                                                              multiImage: false,
                                                                            );
                                                                            if (selectedMedia != null &&
                                                                                selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                              setState(() => _model.isDataUploading1 = true);
                                                                              var selectedUploadedFiles = <FFUploadedFile>[];

                                                                              var downloadUrls = <String>[];
                                                                              try {
                                                                                selectedUploadedFiles = selectedMedia
                                                                                    .map((m) => FFUploadedFile(
                                                                                          name: m.storagePath.split('/').last,
                                                                                          bytes: m.bytes,
                                                                                          height: m.dimensions?.height,
                                                                                          width: m.dimensions?.width,
                                                                                          blurHash: m.blurHash,
                                                                                        ))
                                                                                    .toList();

                                                                                downloadUrls = (await Future.wait(
                                                                                  selectedMedia.map(
                                                                                    (m) async => await uploadData(m.storagePath, m.bytes),
                                                                                  ),
                                                                                ))
                                                                                    .where((u) => u != null)
                                                                                    .map((u) => u!)
                                                                                    .toList();
                                                                              } finally {
                                                                                _model.isDataUploading1 = false;
                                                                              }
                                                                              if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                setState(() {
                                                                                  _model.uploadedLocalFile1 = selectedUploadedFiles.first;
                                                                                  _model.uploadedFileUrl1 = downloadUrls.first;
                                                                                });
                                                                              } else {
                                                                                setState(() {});
                                                                                return;
                                                                              }
                                                                            }

                                                                            if (_model.uploadedFileUrl3 != '') {
                                                                              logFirebaseEvent('Column_navigate_to');

                                                                              context.pushNamed(
                                                                                'loadingImage',
                                                                                queryParameters: {
                                                                                  'imageUrl': serializeParam(
                                                                                    _model.uploadedFileUrl3,
                                                                                    ParamType.String,
                                                                                  ),
                                                                                }.withoutNulls,
                                                                              );

                                                                              return;
                                                                            } else {
                                                                              logFirebaseEvent('Column_navigate_to');

                                                                              context.goNamed('HomePage');

                                                                              return;
                                                                            }
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.camera_alt,
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    size: 35.0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      if (_model
                                                                              .navCarouselCurrentIndex ==
                                                                          3)
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            logFirebaseEvent('HOME_PAGE_PAGE_Column_9jiyu2oe_ON_TAP');
                                                                            logFirebaseEvent('Column_upload_media_to_firebase');
                                                                            final selectedMedia =
                                                                                await selectMedia(
                                                                              maxWidth: 600.00,
                                                                              maxHeight: 600.00,
                                                                              imageQuality: 25,
                                                                              mediaSource: MediaSource.photoGallery,
                                                                              multiImage: false,
                                                                            );
                                                                            if (selectedMedia != null &&
                                                                                selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                              setState(() => _model.isDataUploading2 = true);
                                                                              var selectedUploadedFiles = <FFUploadedFile>[];

                                                                              var downloadUrls = <String>[];
                                                                              try {
                                                                                selectedUploadedFiles = selectedMedia
                                                                                    .map((m) => FFUploadedFile(
                                                                                          name: m.storagePath.split('/').last,
                                                                                          bytes: m.bytes,
                                                                                          height: m.dimensions?.height,
                                                                                          width: m.dimensions?.width,
                                                                                          blurHash: m.blurHash,
                                                                                        ))
                                                                                    .toList();

                                                                                downloadUrls = (await Future.wait(
                                                                                  selectedMedia.map(
                                                                                    (m) async => await uploadData(m.storagePath, m.bytes),
                                                                                  ),
                                                                                ))
                                                                                    .where((u) => u != null)
                                                                                    .map((u) => u!)
                                                                                    .toList();
                                                                              } finally {
                                                                                _model.isDataUploading2 = false;
                                                                              }
                                                                              if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                setState(() {
                                                                                  _model.uploadedLocalFile2 = selectedUploadedFiles.first;
                                                                                  _model.uploadedFileUrl2 = downloadUrls.first;
                                                                                });
                                                                              } else {
                                                                                setState(() {});
                                                                                return;
                                                                              }
                                                                            }

                                                                            if (_model.uploadedFileUrl4 != '') {
                                                                              logFirebaseEvent('Column_navigate_to');

                                                                              context.pushNamed(
                                                                                'loadingImage',
                                                                                queryParameters: {
                                                                                  'imageUrl': serializeParam(
                                                                                    _model.uploadedFileUrl4,
                                                                                    ParamType.String,
                                                                                  ),
                                                                                }.withoutNulls,
                                                                              );

                                                                              return;
                                                                            } else {
                                                                              logFirebaseEvent('Column_navigate_to');

                                                                              context.goNamed('HomePage');

                                                                              return;
                                                                            }
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  FaIcon(
                                                                                    FontAwesomeIcons.fileUpload,
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    size: 35.0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      if (_model
                                                                              .navCarouselCurrentIndex ==
                                                                          4)
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            logFirebaseEvent('HOME_PAGE_PAGE_Column_hbp805n8_ON_TAP');
                                                                            logFirebaseEvent('Column_show_snack_bar');
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  'Coming soon!',
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                ),
                                                                                duration: const Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  FaIcon(
                                                                                    FontAwesomeIcons.globeAmericas,
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    size: 35.0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                    ],
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0.0, -1.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  1.0, -1.0),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'HOME_PAGE_PAGE_Icon_9fj47cay_ON_TAP');
                                                    logFirebaseEvent(
                                                        'Icon_navigate_to');

                                                    context
                                                        .pushNamed('settings');
                                                  },
                                                  child: Icon(
                                                    Icons.settings_suggest,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    size: 40.0,
                                                  ),
                                                ),
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 30.0,
                                    decoration: const BoxDecoration(),
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 180.0,
                                      child: CarouselSlider(
                                        items: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'HOME_PAGE_PAGE_Container_089m4xin_ON_TAP');
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_carousel');
                                                            await _model
                                                                .navCarouselController
                                                                ?.animateToPage(
                                                              0,
                                                              duration: const Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_bottom_sheet');
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return GestureDetector(
                                                                  onTap: () => _model
                                                                          .unfocusNode
                                                                          .canRequestFocus
                                                                      ? FocusScope.of(
                                                                              context)
                                                                          .requestFocus(_model
                                                                              .unfocusNode)
                                                                      : FocusScope.of(
                                                                              context)
                                                                          .unfocus(),
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        const SizedBox(
                                                                      height:
                                                                          500.0,
                                                                      child:
                                                                          InputModalWidget(),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          }),
                                                        ]);
                                                      },
                                                      child: Container(
                                                        width: 55.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .navCarouselCurrentIndex ==
                                                                  0
                                                              ? const Color(
                                                                  0xFFFCE8EF)
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    24.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    24.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'fv7hvey9' /* Text */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: _model.navCarouselCurrentIndex ==
                                                                                0
                                                                            ? FlutterFlowTheme.of(context).secondaryBackground
                                                                            : FlutterFlowTheme.of(context).primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
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
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'HOME_PAGE_PAGE_Container_3bovbqts_ON_TAP');
                                                        var shouldSetState =
                                                            false;
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_carousel');
                                                            await _model
                                                                .navCarouselController
                                                                ?.animateToPage(
                                                              1,
                                                              duration: const Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_backend_call');
                                                            _model.apiResultpso =
                                                                await SpotifyMediaAPIGroup
                                                                    .pauseMusicCall
                                                                    .call();
                                                            shouldSetState =
                                                                true;
                                                            if ((_model
                                                                    .apiResultpso
                                                                    ?.succeeded ??
                                                                true)) {
                                                              logFirebaseEvent(
                                                                  'Container_bottom_sheet');
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () => _model
                                                                            .unfocusNode
                                                                            .canRequestFocus
                                                                        ? FocusScope.of(context).requestFocus(_model
                                                                            .unfocusNode)
                                                                        : FocusScope.of(context)
                                                                            .unfocus(),
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          const SizedBox(
                                                                        height:
                                                                            250.0,
                                                                        child:
                                                                            VoiceModalWidget(
                                                                          isPaused:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));

                                                              if (shouldSetState) {
                                                                setState(() {});
                                                              }
                                                              return;
                                                            } else {
                                                              logFirebaseEvent(
                                                                  'Container_bottom_sheet');
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () => _model
                                                                            .unfocusNode
                                                                            .canRequestFocus
                                                                        ? FocusScope.of(context).requestFocus(_model
                                                                            .unfocusNode)
                                                                        : FocusScope.of(context)
                                                                            .unfocus(),
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          const SizedBox(
                                                                        height:
                                                                            250.0,
                                                                        child:
                                                                            VoiceModalWidget(
                                                                          isPaused:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));

                                                              if (shouldSetState) {
                                                                setState(() {});
                                                              }
                                                              return;
                                                            }
                                                          }),
                                                        ]);
                                                        if (shouldSetState) {
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 55.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .navCarouselCurrentIndex ==
                                                                  1
                                                              ? const Color(
                                                                  0xFFFCE8EF)
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    24.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    24.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'sbtjsm2p' /* Voice */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: _model.navCarouselCurrentIndex ==
                                                                                1
                                                                            ? FlutterFlowTheme.of(context).secondaryBackground
                                                                            : FlutterFlowTheme.of(context).primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
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
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'HOME_PAGE_PAGE_Container_iw87e3y7_ON_TAP');
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_carousel');
                                                            await _model
                                                                .navCarouselController
                                                                ?.animateToPage(
                                                              2,
                                                              duration: const Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_upload_media_to_firebase');
                                                            final selectedMedia =
                                                                await selectMedia(
                                                              maxWidth: 600.00,
                                                              maxHeight: 600.00,
                                                              imageQuality: 25,
                                                              multiImage: false,
                                                            );
                                                            if (selectedMedia !=
                                                                    null &&
                                                                selectedMedia.every((m) =>
                                                                    validateFileFormat(
                                                                        m.storagePath,
                                                                        context))) {
                                                              setState(() =>
                                                                  _model.isDataUploading3 =
                                                                      true);
                                                              var selectedUploadedFiles =
                                                                  <FFUploadedFile>[];

                                                              var downloadUrls =
                                                                  <String>[];
                                                              try {
                                                                selectedUploadedFiles =
                                                                    selectedMedia
                                                                        .map((m) =>
                                                                            FFUploadedFile(
                                                                              name: m.storagePath.split('/').last,
                                                                              bytes: m.bytes,
                                                                              height: m.dimensions?.height,
                                                                              width: m.dimensions?.width,
                                                                              blurHash: m.blurHash,
                                                                            ))
                                                                        .toList();

                                                                downloadUrls = (await Future
                                                                        .wait(
                                                                  selectedMedia
                                                                      .map(
                                                                    (m) async =>
                                                                        await uploadData(
                                                                            m.storagePath,
                                                                            m.bytes),
                                                                  ),
                                                                ))
                                                                    .where((u) =>
                                                                        u !=
                                                                        null)
                                                                    .map((u) =>
                                                                        u!)
                                                                    .toList();
                                                              } finally {
                                                                _model.isDataUploading3 =
                                                                    false;
                                                              }
                                                              if (selectedUploadedFiles
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length &&
                                                                  downloadUrls
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length) {
                                                                setState(() {
                                                                  _model.uploadedLocalFile3 =
                                                                      selectedUploadedFiles
                                                                          .first;
                                                                  _model.uploadedFileUrl3 =
                                                                      downloadUrls
                                                                          .first;
                                                                });
                                                              } else {
                                                                setState(() {});
                                                                return;
                                                              }
                                                            }

                                                            if (_model.uploadedFileUrl3 !=
                                                                    '') {
                                                              logFirebaseEvent(
                                                                  'Container_navigate_to');

                                                              context.pushNamed(
                                                                'loadingImage',
                                                                queryParameters:
                                                                    {
                                                                  'imageUrl':
                                                                      serializeParam(
                                                                    _model
                                                                        .uploadedFileUrl3,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );

                                                              return;
                                                            } else {
                                                              logFirebaseEvent(
                                                                  'Container_navigate_to');

                                                              context.goNamed(
                                                                  'HomePage');

                                                              return;
                                                            }
                                                          }),
                                                        ]);
                                                      },
                                                      child: Container(
                                                        width: 60.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .navCarouselCurrentIndex ==
                                                                  2
                                                              ? const Color(
                                                                  0xFFFCE8EF)
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    24.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    24.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'xa85xl3g' /* Snap */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: _model.navCarouselCurrentIndex ==
                                                                                2
                                                                            ? FlutterFlowTheme.of(context).secondaryBackground
                                                                            : FlutterFlowTheme.of(context).primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
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
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'HOME_PAGE_PAGE_Container_pue6lsz2_ON_TAP');
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_carousel');
                                                            await _model
                                                                .navCarouselController
                                                                ?.animateToPage(
                                                              3,
                                                              duration: const Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_upload_media_to_firebase');
                                                            final selectedMedia =
                                                                await selectMedia(
                                                              maxWidth: 600.00,
                                                              maxHeight: 600.00,
                                                              imageQuality: 25,
                                                              mediaSource:
                                                                  MediaSource
                                                                      .photoGallery,
                                                              multiImage: false,
                                                            );
                                                            if (selectedMedia !=
                                                                    null &&
                                                                selectedMedia.every((m) =>
                                                                    validateFileFormat(
                                                                        m.storagePath,
                                                                        context))) {
                                                              setState(() =>
                                                                  _model.isDataUploading4 =
                                                                      true);
                                                              var selectedUploadedFiles =
                                                                  <FFUploadedFile>[];

                                                              var downloadUrls =
                                                                  <String>[];
                                                              try {
                                                                selectedUploadedFiles =
                                                                    selectedMedia
                                                                        .map((m) =>
                                                                            FFUploadedFile(
                                                                              name: m.storagePath.split('/').last,
                                                                              bytes: m.bytes,
                                                                              height: m.dimensions?.height,
                                                                              width: m.dimensions?.width,
                                                                              blurHash: m.blurHash,
                                                                            ))
                                                                        .toList();

                                                                downloadUrls = (await Future
                                                                        .wait(
                                                                  selectedMedia
                                                                      .map(
                                                                    (m) async =>
                                                                        await uploadData(
                                                                            m.storagePath,
                                                                            m.bytes),
                                                                  ),
                                                                ))
                                                                    .where((u) =>
                                                                        u !=
                                                                        null)
                                                                    .map((u) =>
                                                                        u!)
                                                                    .toList();
                                                              } finally {
                                                                _model.isDataUploading4 =
                                                                    false;
                                                              }
                                                              if (selectedUploadedFiles
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length &&
                                                                  downloadUrls
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length) {
                                                                setState(() {
                                                                  _model.uploadedLocalFile4 =
                                                                      selectedUploadedFiles
                                                                          .first;
                                                                  _model.uploadedFileUrl4 =
                                                                      downloadUrls
                                                                          .first;
                                                                });
                                                              } else {
                                                                setState(() {});
                                                                return;
                                                              }
                                                            }

                                                            if (_model.uploadedFileUrl4 !=
                                                                    '') {
                                                              logFirebaseEvent(
                                                                  'Container_navigate_to');

                                                              context.pushNamed(
                                                                'loadingImage',
                                                                queryParameters:
                                                                    {
                                                                  'imageUrl':
                                                                      serializeParam(
                                                                    _model
                                                                        .uploadedFileUrl4,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );

                                                              return;
                                                            } else {
                                                              logFirebaseEvent(
                                                                  'Container_navigate_to');

                                                              context.goNamed(
                                                                  'HomePage');

                                                              return;
                                                            }
                                                          }),
                                                        ]);
                                                      },
                                                      child: Container(
                                                        width: 70.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .navCarouselCurrentIndex ==
                                                                  3
                                                              ? const Color(
                                                                  0xFFFCE8EF)
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    24.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    24.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'onapfzje' /* Upload */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: _model.navCarouselCurrentIndex ==
                                                                                3
                                                                            ? FlutterFlowTheme.of(context).secondaryBackground
                                                                            : FlutterFlowTheme.of(context).primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
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
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'HOME_PAGE_PAGE_Container_w43b61ip_ON_TAP');
                                                        await Future.wait([
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_carousel');
                                                            await _model
                                                                .navCarouselController
                                                                ?.animateToPage(
                                                              4,
                                                              duration: const Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          }),
                                                          Future(() async {
                                                            logFirebaseEvent(
                                                                'Container_show_snack_bar');
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Coming soon!',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: const Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                          }),
                                                        ]);
                                                      },
                                                      child: Container(
                                                        width: 80.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _model
                                                                      .navCarouselCurrentIndex ==
                                                                  4
                                                              ? const Color(
                                                                  0xFFFCE8EF)
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    24.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    24.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'yn3vo78e' /* Explore */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: _model.navCarouselCurrentIndex ==
                                                                                4
                                                                            ? FlutterFlowTheme.of(context).secondaryBackground
                                                                            : FlutterFlowTheme.of(context).primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
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
                                              ],
                                            ),
                                          ),
                                        ],
                                        carouselController:
                                            _model.navCarouselController ??=
                                                CarouselController(),
                                        options: CarouselOptions(
                                          initialPage: 2,
                                          viewportFraction: 0.23,
                                          disableCenter: false,
                                          enlargeCenterPage: false,
                                          enlargeFactor: 0.0,
                                          enableInfiniteScroll: false,
                                          scrollDirection: Axis.horizontal,
                                          autoPlay: false,
                                          onPageChanged: (index, _) async {
                                            _model.navCarouselCurrentIndex =
                                                index;
                                            logFirebaseEvent(
                                                'HOME_navCarousel_ON_WIDGET_SWIPE');
                                            await Future.wait([
                                              Future(() async {
                                                logFirebaseEvent(
                                                    'navCarousel_update_page_state');
                                                setState(() {
                                                  _model.currentIndex =
                                                      _model.currentIndex;
                                                });
                                              }),
                                              Future(() async {
                                                logFirebaseEvent(
                                                    'navCarousel_wait__delay');
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 2000));
                                                logFirebaseEvent(
                                                    'navCarousel_carousel');
                                                await _model
                                                    .navCarouselController
                                                    ?.animateToPage(
                                                  2,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                              }),
                                            ]);
                                          },
                                        ),
                                      ),
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
        ),
      ),
    );
  }
}
