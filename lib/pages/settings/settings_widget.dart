import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/checkout/checkout_widget.dart';
import 'dart:async';
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_model.dart';
export 'settings_model.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late SettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'settings'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    buttonSize: 46.0,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      logFirebaseEvent(
                          'SETTINGS_arrow_back_rounded_ICN_ON_TAP');
                      logFirebaseEvent('IconButton_navigate_back');
                      context.pop();
                    },
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'g1xihsaq' /* Settings */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 40.0,
                    decoration: const BoxDecoration(),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(22.0, 5.0, 44.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'e7vwv7ka' /* Select your account and notifi... */,
                        ),
                        maxLines: 2,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SwitchListTile.adaptive(
            value: _model.switchListTileValue1 ??= FFAppState().isPushOK,
            onChanged: (newValue) async {
              setState(() => _model.switchListTileValue1 = newValue);
              if (newValue) {
                logFirebaseEvent('SETTINGS_SwitchListTile_e5ktl2vu_ON_TOGG');
                logFirebaseEvent('SwitchListTile_request_permissions');
                await requestPermission(notificationsPermission);
                logFirebaseEvent('SwitchListTile_update_app_state');
                setState(() {});
              } else {
                logFirebaseEvent('SETTINGS_SwitchListTile_e5ktl2vu_ON_TOGG');
                logFirebaseEvent('SwitchListTile_update_app_state');
                setState(() {});
              }
            },
            title: Text(
              FFLocalizations.of(context).getText(
                'cfd5r2w2' /* Push Notifications */,
              ),
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                    lineHeight: 2.0,
                  ),
            ),
            subtitle: Text(
              FFLocalizations.of(context).getText(
                '5iidujf5' /* Receive Push notifications fro... */,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: const Color(0xFF8B97A2),
                    letterSpacing: 0.0,
                  ),
            ),
            tileColor: FlutterFlowTheme.of(context).secondaryBackground,
            activeColor: FlutterFlowTheme.of(context).primary,
            activeTrackColor: FlutterFlowTheme.of(context).accent1,
            dense: false,
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
          ),
          SwitchListTile.adaptive(
            value: _model.switchListTileValue2 ??= FFAppState().isEmailOK,
            onChanged: (newValue) async {
              setState(() => _model.switchListTileValue2 = newValue);

              if (!newValue) {
                logFirebaseEvent('SETTINGS_SwitchListTile_zfqdkozg_ON_TOGG');
                logFirebaseEvent('SwitchListTile_update_app_state');
                setState(() {});
              }
            },
            title: Text(
              FFLocalizations.of(context).getText(
                'ppbn65lx' /* Email Notifications */,
              ),
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                    lineHeight: 2.0,
                  ),
            ),
            subtitle: Text(
              FFLocalizations.of(context).getText(
                '8dowd9ak' /* Receive email notifications fr... */,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: const Color(0xFF8B97A2),
                    letterSpacing: 0.0,
                  ),
            ),
            tileColor: FlutterFlowTheme.of(context).secondaryBackground,
            activeColor: FlutterFlowTheme.of(context).primary,
            activeTrackColor: FlutterFlowTheme.of(context).accent1,
            dense: false,
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
          ),
          Stack(
            children: [
              SwitchListTile.adaptive(
                value: _model.switchListTileValue3 ??= FFAppState().isDataOK,
                onChanged: (newValue) async {
                  setState(() => _model.switchListTileValue3 = newValue);

                  if (!newValue) {
                    logFirebaseEvent(
                        'SETTINGS_SwitchListTile_hjffeg8o_ON_TOGG');
                    logFirebaseEvent('SwitchListTile_update_app_state');
                    setState(() {});
                  }
                },
                title: Text(
                  FFLocalizations.of(context).getText(
                    'j9xe16op' /* Data Collection */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                        lineHeight: 2.0,
                      ),
                ),
                subtitle: Text(
                  FFLocalizations.of(context).getText(
                    'mcc2iqvn' /* Allow us to collect and store ... */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: const Color(0xFF8B97A2),
                        letterSpacing: 0.0,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                activeTrackColor: FlutterFlowTheme.of(context).accent1,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
              ),
              Align(
                alignment: const AlignmentDirectional(-0.9, -0.03),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('SETTINGS_PAGE_Container_y4azwdaf_ON_TAP');
                    logFirebaseEvent('Container_launch_u_r_l');
                    await launchURL('https://snapli.st/privacy');
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    height: 100.0,
                    decoration: const BoxDecoration(),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              if (FFAppState().isPremium == true)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'SETTINGS_PAGE_Container_pezip8ai_ON_TAP');
                      logFirebaseEvent('Container_launch_u_r_l');
                      await launchURL('https://snapli.st/downgrade');
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 80.0,
                      decoration: const BoxDecoration(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent('SETTINGS_PAGE_Row_75r4dv31_ON_TAP');
                          await Future.wait([
                            Future(() async {
                              logFirebaseEvent('Row_backend_call');

                              await PremiumRecord.collection
                                  .doc()
                                  .set(createPremiumRecordData(
                                    user: currentUserReference,
                                    isPremium: false,
                                    createdOn: getCurrentTimestamp,
                                  ));
                            }),
                            Future(() async {
                              logFirebaseEvent('Row_alert_dialog');
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Sorry-ish to see you go'),
                                    content: const Text(
                                        'Your account has been downgraded to the Basic plan, which was designed for the poors not for your Starbucks sippin’ a\$\$.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('I’m awful'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              logFirebaseEvent('Row_navigate_to');

                              context.goNamed('HomePage');
                            }),
                          ]);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      22.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '2nqjyneu' /* Downgrade Account */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      22.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.65,
                                                decoration: const BoxDecoration(),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 7.5, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'piy7lm9a' /* If you would like to downgrade... */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (FFAppState().isPremium == false)
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('SETTINGS_PAGE_Stack_z2veuj48_ON_TAP');
                    logFirebaseEvent('Stack_bottom_sheet');
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: const SizedBox(
                            height: 600.0,
                            child: CheckoutWidget(),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 80.0,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'SETTINGS_PAGE_Row_e2g9twxu_ON_TAP');
                              await Future.wait([
                                Future(() async {
                                  logFirebaseEvent('Row_backend_call');

                                  await PremiumRecord.collection
                                      .doc()
                                      .set(createPremiumRecordData(
                                        user: currentUserReference,
                                        isPremium: false,
                                        createdOn: getCurrentTimestamp,
                                      ));
                                }),
                                Future(() async {
                                  logFirebaseEvent('Row_alert_dialog');
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text('Sorry-ish to see you go'),
                                        content: const Text(
                                            'Your account has been downgraded to the Basic plan, which was designed for the poors not for your Starbucks sippin’ a\$\$.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: const Text('I’m awful'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  logFirebaseEvent('Row_navigate_to');

                                  context.goNamed('HomePage');
                                }),
                              ]);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          22.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'yc9i1lvn' /* Upgrade Account 💎 */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          22.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.65,
                                                    decoration: const BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  7.5,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'gdritdpk' /* If you would like to upgrade y... */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Stack(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('SETTINGS_PAGE_Container_1zosseup_ON_TAP');
                  logFirebaseEvent('Container_launch_u_r_l');
                  unawaited(
                    () async {
                      await launchURL('https://snapli.st/privacy');
                    }(),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('SETTINGS_PAGE_Container_5ytqdt29_ON_TAP');
                logFirebaseEvent('Container_launch_u_r_l');
                await launchURL('https://snapli.st/delete-account');
              },
              child: Container(
                height: 100.0,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(22.0, 10.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'bwf78leh' /* Delete Account */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(22.0, 0.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.65,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 7.5, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'sfzmns3r' /* If you would like to delete yo... */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
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
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('SETTINGS_PAGE_Button-Login_ON_TAP');
                await Future.wait([
                  Future(() async {
                    logFirebaseEvent('Button-Login_navigate_to');

                    context.goNamed('HomePage');
                  }),
                  Future(() async {
                    logFirebaseEvent('Button-Login_update_app_state');
                    setState(() {
                      FFAppState().isEmailOK = _model.switchListTileValue2!;
                      FFAppState().isPushOK = _model.switchListTileValue1!;
                      FFAppState().isDataOK = _model.switchListTileValue3!;
                    });
                    logFirebaseEvent('Button-Login_backend_call');

                    await SettingsRecord.collection
                        .doc()
                        .set(createSettingsRecordData(
                          user: currentUserReference,
                          isEmailOK: FFAppState().isEmailOK,
                          isNotifyOK: FFAppState().isPushOK,
                          isDataOK: FFAppState().isDataOK,
                          createdOn: getCurrentTimestamp,
                        ));
                  }),
                ]);
              },
              text: FFLocalizations.of(context).getText(
                'rwe9odea' /* Save Changes */,
              ),
              options: FFButtonOptions(
                width: 190.0,
                height: 50.0,
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
                elevation: 3.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
