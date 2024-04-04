import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/feedback_modal/feedback_modal_widget.dart';
import '/pages/input_modal/input_modal_widget.dart';
import '/pages/voice_modal/voice_modal_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    super.key,
    this.mood,
  });

  final String? mood;

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
          duration: 300.ms,
          begin: Offset(-30.0, 0.0),
          end: Offset(0.0, 0.0),
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
          if (FFAppState().refreshToken != null &&
              FFAppState().refreshToken != '') {
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
            }
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

    return GestureDetector(
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
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(28.0, 20.0, 14.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/output-onlinepngtools_(15).png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Snaplist',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Roboto Mono',
                                  fontSize: 30.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 10.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('HOME_PAGE_PAGE_contentView_1_ON_TAP');
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
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Profile',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    '(coming soon)',
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
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 10.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('HOME_PAGE_PAGE_contentView_1_ON_TAP');
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
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Explore',
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    '(coming soon)',
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
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 10.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('HOME_PAGE_PAGE_contentView_1_ON_TAP');
                        logFirebaseEvent('contentView_1_update_page_state');
                        setState(() {
                          _model.isExplore = false;
                          _model.isMenu = false;
                          _model.isSettings = true;
                          _model.isProfile = false;
                          _model.isRecents = false;
                          _model.isFeedback = false;
                        });
                        logFirebaseEvent('contentView_1_wait__delay');
                        await Future.delayed(
                            const Duration(milliseconds: 2000));
                        logFirebaseEvent('contentView_1_update_page_state');
                        setState(() {
                          _model.isSettings = false;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
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
                              Icon(
                                Icons.settings_rounded,
                                color: _model.isSettings == true
                                    ? FlutterFlowTheme.of(context).primaryText
                                    : FlutterFlowTheme.of(context)
                                        .secondaryText,
                                size: 28.0,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Settings',
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
                              if (_model.isSettings == true)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    '(coming soon)',
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
                  Expanded(
                    child: Container(
                      height: 600.0,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(0.0, 0),
                            child: TabBar(
                              labelColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              unselectedLabelColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                              unselectedLabelStyle: TextStyle(),
                              indicatorColor:
                                  FlutterFlowTheme.of(context).primary,
                              padding: EdgeInsets.all(4.0),
                              tabs: [
                                Tab(
                                  text: 'Moods',
                                ),
                                Tab(
                                  text: 'Recents',
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
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        height: 440.0,
                                        decoration: BoxDecoration(),
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 5.0),
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
                                                          'HOME_PAGE_PAGE_Row_cz1wgk14_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Row_update_app_state');
                                                      setState(() {
                                                        FFAppState().mood =
                                                            getJsonField(
                                                          moodItem,
                                                          r'''$.mood''',
                                                        ).toString();
                                                      });
                                                      logFirebaseEvent(
                                                          'Row_navigate_to');

                                                      context.goNamed(
                                                        'loadingMood',
                                                        queryParameters: {
                                                          'mood':
                                                              serializeParam(
                                                            FFAppState().mood,
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
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      40.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 100.0,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child:
                                                                Image.network(
                                                              getJsonField(
                                                                moodItem,
                                                                r'''$.url''',
                                                              ).toString(),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 150.0,
                                                          height: 60.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          AutoSizeText(
                                                                        getJsonField(
                                                                          moodItem,
                                                                          r'''$.mood''',
                                                                        ).toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            1,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            130.0,
                                                                        height:
                                                                            40.0,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              5.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            getJsonField(
                                                                              moodItem,
                                                                              r'''$.Description''',
                                                                            ).toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            maxLines:
                                                                                2,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                    ],
                                  ),
                                ),
                                KeepAliveWidgetWrapper(
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
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
                                            height: 440.0,
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                if (containerSnaplistsRecordList
                                                        .length ==
                                                    0)
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
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        20.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Nothing here yet 😲 ',
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
                                                                BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'Snap a vibe or select a mood to get started!  ',
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
                                                                EdgeInsetsDirectional
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
                                                if (containerSnaplistsRecordList
                                                        .length >=
                                                    1)
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
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
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
                                                              onTap: () async {
                                                                logFirebaseEvent(
                                                                    'HOME_PAGE_PAGE_Row_ginmx8r2_ON_TAP');
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
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        260.0,
                                                                    height:
                                                                        200.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        ClipRect(
                                                                          child:
                                                                              ImageFiltered(
                                                                            imageFilter:
                                                                                ImageFilter.blur(
                                                                              sigmaX: 3.0,
                                                                              sigmaY: 3.0,
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                              child: Image.network(
                                                                                '${recentsItem.imageUrl}',
                                                                                width: 260.0,
                                                                                height: 200.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              260.0,
                                                                          height:
                                                                              200.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                      height: 65.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xAD000000),
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
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 200.0,
                                                                                                decoration: BoxDecoration(),
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
                                                                                                          decoration: BoxDecoration(),
                                                                                                          child: Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
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
                                                                                            ],
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 200.0,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            width: 200.0,
                                                                                                            decoration: BoxDecoration(),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
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
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Builder(
                                                                                  builder: (context) => Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 15.0, 0.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        logFirebaseEvent('HOME_PAGE_PAGE_Icon_daous6li_ON_TAP');
                                                                                        logFirebaseEvent('Icon_share');
                                                                                        await Share.share(
                                                                                          recentsItem.url,
                                                                                          sharePositionOrigin: getWidgetBoundingBox(context),
                                                                                        );
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.share,
                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                        size: 30.0,
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
                                                                ],
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 62.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Divider(
                            height: 12.0,
                            thickness: 2.0,
                            color: Color(0xFFE5E7EB),
                          ),
                          Container(
                            height: 50.0,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
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
                                          color: Color(0xFFE0E3E7),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.9, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        6.0, 0.0, 0.0, 0.0),
                                                child: Icon(
                                                  Icons.wb_sunny_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 18.0,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 6.0, 0.0),
                                                child: Icon(
                                                  Icons.mode_night_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 18.0,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Container(
                                                width: 25.0,
                                                height: 25.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(0x430B0D0F),
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
                                        scaffoldKey
                                            .currentState!.isEndDrawerOpen) {
                                      Navigator.pop(context);
                                    }

                                    logFirebaseEvent('Button_bottom_sheet');
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () => _model
                                                  .unfocusNode.canRequestFocus
                                              ? FocusScope.of(context)
                                                  .requestFocus(
                                                      _model.unfocusNode)
                                              : FocusScope.of(context)
                                                  .unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: FeedbackModalWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  text: 'Feedback',
                                  options: FFButtonOptions(
                                    width: 80.0,
                                    height: 30.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6.0, 0.0, 6.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'HOME_PAGE_PAGE_LOG_OUT_BTN_ON_TAP');
                                    logFirebaseEvent('Button_update_app_state');
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
                                  text: 'Log out',
                                  options: FFButtonOptions(
                                    width: 80.0,
                                    height: 30.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6.0, 0.0, 6.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
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
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: custom_widgets.CameraPhoto(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.dark) ==
                            true
                        ? Colors.black
                        : FlutterFlowTheme.of(context).secondaryBackground,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 180.0,
                    child: CarouselSlider(
                      items: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              borderRadius: 50.0,
                              borderWidth: 1.0,
                              buttonSize: 70.0,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              icon: FaIcon(
                                FontAwesomeIcons.microphoneAlt,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark) ==
                                        true
                                    ? FlutterFlowTheme.of(context).warning
                                    : Color(0xFFD8AE2E),
                                size: 50.0,
                              ),
                              onPressed: () async {
                                logFirebaseEvent(
                                    'HOME_PAGE_PAGE_microphoneAlt_ICN_ON_TAP');
                                var _shouldSetState = false;
                                logFirebaseEvent('IconButton_backend_call');
                                _model.pauseMusic = await SpotifyMediaAPIGroup
                                    .pauseMusicCall
                                    .call(
                                  accessToken: FFAppState().accessToken,
                                );
                                _shouldSetState = true;
                                if ((_model.pauseMusic?.succeeded ?? true)) {
                                  logFirebaseEvent('IconButton_bottom_sheet');
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: VoiceModalWidget(
                                            isPaused: true,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));

                                  if (_shouldSetState) setState(() {});
                                  return;
                                } else {
                                  logFirebaseEvent('IconButton_bottom_sheet');
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: VoiceModalWidget(
                                            isPaused: false,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));

                                  if (_shouldSetState) setState(() {});
                                  return;
                                }

                                if (_shouldSetState) setState(() {});
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              borderRadius: 50.0,
                              borderWidth: 1.0,
                              buttonSize: 70.0,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              icon: Icon(
                                Icons.keyboard_hide,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark) ==
                                        true
                                    ? Color(0xFF3DD1A9)
                                    : Color(0xFF46BBAF),
                                size: 50.0,
                              ),
                              onPressed: () async {
                                logFirebaseEvent(
                                    'HOME_PAGE_PAGE_keyboard_hide_ICN_ON_TAP');
                                logFirebaseEvent('IconButton_bottom_sheet');
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () => _model
                                              .unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                              .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: InputModalWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 82.0,
                                      height: 82.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'HOME_PAGE_PAGE_Image_1vk3caxn_ON_TAP');
                                    logFirebaseEvent(
                                        'Image_upload_media_to_firebase');
                                    final selectedMedia = await selectMedia(
                                      maxWidth: 600.00,
                                      maxHeight: 600.00,
                                      imageQuality: 50,
                                      multiImage: false,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading1 = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading1 = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile1 =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl1 =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        setState(() {});
                                        return;
                                      }
                                    }

                                    logFirebaseEvent('Image_navigate_to');

                                    context.goNamed(
                                      'loadingImage',
                                      queryParameters: {
                                        'imageUrl': serializeParam(
                                          _model.uploadedFileUrl1,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  onLongPress: () async {
                                    logFirebaseEvent(
                                        'HOME_Image_1vk3caxn_ON_LONG_PRESS');
                                    logFirebaseEvent('Image_drawer');
                                    scaffoldKey.currentState!.openDrawer();
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? 'assets/images/output-onlinepngtools_(15).png'
                                          : 'assets/images/output-onlinepngtools_(15).png',
                                      width: 80.0,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              borderRadius: 50.0,
                              borderWidth: 1.0,
                              buttonSize: 70.0,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              icon: Icon(
                                Icons.upload_file,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark) ==
                                        true
                                    ? Color(0xFFD78CFF)
                                    : Color(0xFFC45AFF),
                                size: 50.0,
                              ),
                              onPressed: () async {
                                logFirebaseEvent(
                                    'HOME_PAGE_PAGE_upload_file_ICN_ON_TAP');
                                logFirebaseEvent(
                                    'IconButton_upload_media_to_firebase');
                                final selectedMedia = await selectMedia(
                                  maxWidth: 600.00,
                                  maxHeight: 600.00,
                                  imageQuality: 50,
                                  mediaSource: MediaSource.photoGallery,
                                  multiImage: false,
                                );
                                if (selectedMedia != null &&
                                    selectedMedia.every((m) =>
                                        validateFileFormat(
                                            m.storagePath, context))) {
                                  setState(
                                      () => _model.isDataUploading2 = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];

                                  var downloadUrls = <String>[];
                                  try {
                                    selectedUploadedFiles = selectedMedia
                                        .map((m) => FFUploadedFile(
                                              name:
                                                  m.storagePath.split('/').last,
                                              bytes: m.bytes,
                                              height: m.dimensions?.height,
                                              width: m.dimensions?.width,
                                              blurHash: m.blurHash,
                                            ))
                                        .toList();

                                    downloadUrls = (await Future.wait(
                                      selectedMedia.map(
                                        (m) async => await uploadData(
                                            m.storagePath, m.bytes),
                                      ),
                                    ))
                                        .where((u) => u != null)
                                        .map((u) => u!)
                                        .toList();
                                  } finally {
                                    _model.isDataUploading2 = false;
                                  }
                                  if (selectedUploadedFiles.length ==
                                          selectedMedia.length &&
                                      downloadUrls.length ==
                                          selectedMedia.length) {
                                    setState(() {
                                      _model.uploadedLocalFile2 =
                                          selectedUploadedFiles.first;
                                      _model.uploadedFileUrl2 =
                                          downloadUrls.first;
                                    });
                                  } else {
                                    setState(() {});
                                    return;
                                  }
                                }

                                if (_model.uploadedFileUrl2 != null &&
                                    _model.uploadedFileUrl2 != '') {
                                  logFirebaseEvent('IconButton_navigate_to');

                                  context.goNamed(
                                    'loadingUpload',
                                    queryParameters: {
                                      'url': serializeParam(
                                        _model.uploadedFileUrl2,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                } else {
                                  logFirebaseEvent('IconButton_navigate_back');
                                  context.safePop();
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              borderRadius: 50.0,
                              borderWidth: 1.0,
                              buttonSize: 70.0,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              icon: FaIcon(
                                FontAwesomeIcons.userAstronaut,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark) ==
                                        true
                                    ? Color(0xFF75CEF1)
                                    : Color(0xFF47B1F5),
                                size: 50.0,
                              ),
                              onPressed: () async {
                                logFirebaseEvent(
                                    'HOME_PAGE_PAGE_userAstronaut_ICN_ON_TAP');
                                logFirebaseEvent('IconButton_alert_dialog');
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Coming Soon'),
                                      content: Text(
                                          'Full “Moods” Panel is coming soon :)'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                      carouselController: _model.carouselController ??=
                          CarouselController(),
                      options: CarouselOptions(
                        initialPage: 2,
                        viewportFraction: 0.21,
                        disableCenter: false,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.25,
                        enableInfiniteScroll: false,
                        scrollDirection: Axis.horizontal,
                        autoPlay: false,
                        onPageChanged: (index, _) =>
                            _model.carouselCurrentIndex = index,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
