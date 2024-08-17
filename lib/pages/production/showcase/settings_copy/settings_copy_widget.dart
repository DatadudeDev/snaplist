import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/production/components/checkout/checkout_widget.dart';
import 'dart:async';
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_copy_model.dart';
export 'settings_copy_model.dart';

class SettingsCopyWidget extends StatefulWidget {
  const SettingsCopyWidget({super.key});

  @override
  State<SettingsCopyWidget> createState() => _SettingsCopyWidgetState();
}

class _SettingsCopyWidgetState extends State<SettingsCopyWidget> {
  late SettingsCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsCopyModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'settingsCopy'});
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 393.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5.0, 20.0, 0.0, 0.0),
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
                                    'SETTINGS_COPY_arrow_back_rounded_ICN_ON_');
                                logFirebaseEvent('IconButton_navigate_back');
                                context.pop();
                              },
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                '1e3j4deq' /* Settings */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Poppins',
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    22.0, 5.0, 44.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'cqfvr1l4' /* Select your account and notifi... */,
                                  ),
                                  maxLines: 2,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  decoration: const BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'q5fh4s4s' /* App Connect */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
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
                                                        0.5,
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
                                                          'qjomgbv8' /* Select your preferred music ap... */,
                                                        ),
                                                        maxLines: 2,
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
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 140.0,
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FlutterFlowDropDown<String>(
                                      controller:
                                          _model.dropDownValueController ??=
                                              FormFieldController<String>(
                                        _model.dropDownValue ??=
                                            FFAppState().musicApp != ''
                                                ? FFAppState().musicApp
                                                : 'Spotify',
                                      ),
                                      options: [
                                        FFLocalizations.of(context).getText(
                                          '1qc6jo95' /* Spotify */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '407l6qn7' /* YouTube Music */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'l2u8umcg' /* Apple Music */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '1jhq8fj1' /* Tidal */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          '26mseo8i' /* Amazon Music */,
                                        )
                                      ],
                                      onChanged: (val) async {
                                        setState(
                                            () => _model.dropDownValue = val);
                                        logFirebaseEvent(
                                            'SETTINGS_COPY_DropDown_ccmgni9j_ON_FORM_');
                                        logFirebaseEvent(
                                            'DropDown_update_app_state');
                                        FFAppState().musicApp =
                                            _model.dropDownValue!;
                                        setState(() {});
                                      },
                                      width: 300.0,
                                      height: 40.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        'sncn0r3o' /* Apps */,
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: FlutterFlowTheme.of(context)
                                          .secondary,
                                      borderWidth: 1.0,
                                      borderRadius: 12.0,
                                      margin: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 4.0, 16.0, 4.0),
                                      hidesUnderline: true,
                                      isOverButton: true,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                      labelText:
                                          FFAppState().musicApp != ''
                                              ? FFAppState().musicApp
                                              : 'Spotify',
                                      labelTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
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
                    Container(
                      decoration: const BoxDecoration(),
                    ),
                    SwitchListTile.adaptive(
                      value: _model.switchListTileValue1 ??=
                          FFAppState().isPushOK,
                      onChanged: (newValue) async {
                        setState(() => _model.switchListTileValue1 = newValue);
                        if (newValue) {
                          logFirebaseEvent(
                              'SETTINGS_COPY_SwitchListTile_dq3tph5j_ON');
                          logFirebaseEvent(
                              'SwitchListTile_request_permissions');
                          await requestPermission(notificationsPermission);
                          logFirebaseEvent('SwitchListTile_update_app_state');

                          setState(() {});
                        } else {
                          logFirebaseEvent(
                              'SETTINGS_COPY_SwitchListTile_dq3tph5j_ON');
                          logFirebaseEvent('SwitchListTile_update_app_state');

                          setState(() {});
                        }
                      },
                      title: Text(
                        FFLocalizations.of(context).getText(
                          'k0s4bgxm' /* Push Notifications */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                              lineHeight: 2.0,
                            ),
                      ),
                      subtitle: Text(
                        FFLocalizations.of(context).getText(
                          'g6lvhfph' /* Receive Push notifications fro... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      activeColor: FlutterFlowTheme.of(context).primaryText,
                      activeTrackColor: FlutterFlowTheme.of(context).secondary,
                      dense: false,
                      controlAffinity: ListTileControlAffinity.trailing,
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
                    ),
                    SwitchListTile.adaptive(
                      value: _model.switchListTileValue2 ??=
                          FFAppState().isEmailOK,
                      onChanged: (newValue) async {
                        setState(() => _model.switchListTileValue2 = newValue);

                        if (!newValue) {
                          logFirebaseEvent(
                              'SETTINGS_COPY_SwitchListTile_mvy8e5i1_ON');
                          logFirebaseEvent('SwitchListTile_update_app_state');

                          setState(() {});
                        }
                      },
                      title: Text(
                        FFLocalizations.of(context).getText(
                          'htegb90v' /* Email Notifications */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                              lineHeight: 2.0,
                            ),
                      ),
                      subtitle: Text(
                        FFLocalizations.of(context).getText(
                          'sxoe1i32' /* Receive email notifications fr... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      activeColor: FlutterFlowTheme.of(context).primaryText,
                      activeTrackColor: FlutterFlowTheme.of(context).secondary,
                      dense: false,
                      controlAffinity: ListTileControlAffinity.trailing,
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
                    ),
                    Stack(
                      children: [
                        SwitchListTile.adaptive(
                          value: _model.switchListTileValue3 ??=
                              FFAppState().isDataOK,
                          onChanged: (newValue) async {
                            setState(
                                () => _model.switchListTileValue3 = newValue);

                            if (!newValue) {
                              logFirebaseEvent(
                                  'SETTINGS_COPY_SwitchListTile_19vvxxse_ON');
                              logFirebaseEvent(
                                  'SwitchListTile_update_app_state');

                              setState(() {});
                            }
                          },
                          title: Text(
                            FFLocalizations.of(context).getText(
                              'pb5p4ryt' /* Data Collection */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                      lineHeight: 2.0,
                                    ),
                          ),
                          subtitle: Text(
                            FFLocalizations.of(context).getText(
                              'e7haftu4' /* Allow us to collect and store ... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          activeColor: FlutterFlowTheme.of(context).primaryText,
                          activeTrackColor:
                              FlutterFlowTheme.of(context).secondary,
                          dense: false,
                          controlAffinity: ListTileControlAffinity.trailing,
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 12.0, 24.0, 0.0),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(-0.9, -0.03),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'SETTINGS_COPY_Container_a2k8megc_ON_TAP');
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'SETTINGS_COPY_Container_n83pxuzn_ON_TAP');
                                await Future.wait([
                                  Future(() async {
                                    logFirebaseEvent('Container_backend_call');

                                    await PremiumRecord.collection
                                        .doc()
                                        .set(createPremiumRecordData(
                                          user: currentUserReference,
                                          isPremium: false,
                                          createdOn: getCurrentTimestamp,
                                        ));
                                  }),
                                  Future(() async {
                                    logFirebaseEvent('Container_navigate_to');

                                    context.pushNamed(
                                      'HomePage',
                                      queryParameters: {
                                        'upgraded': serializeParam(
                                          false,
                                          ParamType.bool,
                                        ),
                                      }.withoutNulls,
                                    );
                                  }),
                                ]);
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 80.0,
                                decoration: const BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'e1x31wu6' /* Downgrade Account 😭 */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
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
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.65,
                                                        decoration:
                                                            const BoxDecoration(),
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
                                                              '4k1msdz1' /* If you would like to downgrade... */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                        if (FFAppState().isPremium == false)
                          Builder(
                            builder: (context) => Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'SETTINGS_COPY_Container_52elpezx_ON_TAP');
                                  logFirebaseEvent('Container_alert_dialog');
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: const SizedBox(
                                          height: 550.0,
                                          width: 325.0,
                                          child: CheckoutWidget(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 80.0,
                                  decoration: const BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.65,
                                                          decoration:
                                                              const BoxDecoration(),
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
                            logFirebaseEvent(
                                'SETTINGS_COPY_Container_ko5avdip_ON_TAP');
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'SETTINGS_COPY_Container_50bcvk60_ON_TAP');
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 10.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '4boat7su' /* Delete Account */,
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
                                    24.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
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
                                                    'vqyq5kix' /* If you would like to delete yo... */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'SETTINGS_COPY_PAGE_Button-Login_ON_TAP');
                          await Future.wait([
                            Future(() async {
                              logFirebaseEvent('Button-Login_navigate_to');

                              context.goNamed('HomePage');
                            }),
                            Future(() async {
                              logFirebaseEvent('Button-Login_update_app_state');
                              FFAppState().isEmailOK =
                                  _model.switchListTileValue2!;
                              FFAppState().isPushOK =
                                  _model.switchListTileValue1!;
                              FFAppState().isDataOK =
                                  _model.switchListTileValue3!;
                              setState(() {});
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
                          'y0g5wvzj' /* Save Changes */,
                        ),
                        options: FFButtonOptions(
                          width: 190.0,
                          height: 50.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
