import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'loading_mood_model.dart';
export 'loading_mood_model.dart';

class LoadingMoodWidget extends StatefulWidget {
  const LoadingMoodWidget({
    super.key,
    required this.mood,
  });

  final String? mood;

  @override
  State<LoadingMoodWidget> createState() => _LoadingMoodWidgetState();
}

class _LoadingMoodWidgetState extends State<LoadingMoodWidget> {
  late LoadingMoodModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingMoodModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().cameraOn = false;
      });
      _model.sendPhotoURLLoading = await DatacenterAPIGroup.postMooodCall.call(
        mood: widget.mood,
        userRef: valueOrDefault<String>(
          currentUserReference?.id,
          'gabe2091',
        ),
      );
      if ((_model.sendPhotoURLLoading?.succeeded ?? true)) {
        setState(() {
          _model.ten = true;
        });
        await Future.delayed(const Duration(milliseconds: 4000));
        setState(() {
          _model.ten = false;
          _model.twentyNine = true;
        });
        await Future.delayed(const Duration(milliseconds: 4000));
        setState(() {
          _model.twentyNine = false;
          _model.thirtySeven = true;
        });
        await Future.delayed(const Duration(milliseconds: 4000));
        setState(() {
          _model.thirtySeven = false;
          _model.sixtyFive = true;
        });
        await Future.delayed(const Duration(milliseconds: 4500));
        setState(() {
          _model.sixtyFive = false;
          _model.eightyThree = true;
        });
        await Future.delayed(const Duration(milliseconds: 4000));
        setState(() {
          _model.eightyThree = false;
          _model.oneHundred = true;
        });
        _model.getPlaylist = await DatacenterAPIGroup.getPlaylistURLCall.call(
          timestamp: getJsonField(
            (_model.sendPhotoURLLoading?.jsonBody ?? ''),
            r'''$.timestamp''',
          ),
          userRef: currentUserReference?.id,
        );
        if ((_model.getPlaylist?.succeeded ?? true)) {
          await launchURL(DatacenterAPIGroup.getPlaylistURLCall.playlistUrl(
            (_model.getPlaylist?.jsonBody ?? ''),
          )!);

          await SnaplistsRecord.collection.doc().set(createSnaplistsRecordData(
                userRef: currentUserReference,
                name: DatacenterAPIGroup.getPlaylistURLCall.name(
                  (_model.getPlaylist?.jsonBody ?? ''),
                ),
                description: DatacenterAPIGroup.getPlaylistURLCall.description(
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
              ));
          setState(() {
            FFAppState().makePhoto = false;
            FFAppState().fileBase64 = '';
            FFAppState().playlistUrl = '';
          });

          context.goNamed(
            'HomePage',
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );

          return;
        } else {
          setState(() {
            FFAppState().makePhoto = false;
            FFAppState().fileBase64 = '';
            FFAppState().playlistUrl = '';
          });

          context.goNamed(
            'HomePage',
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
        setState(() {
          FFAppState().makePhoto = false;
          FFAppState().fileBase64 = '';
          FFAppState().playlistUrl = '';
        });

        context.goNamed(
          'HomePage',
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
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
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
                                height: 320.0,
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
                                  } else {
                                    return 0.0;
                                  }
                                }(),
                                radius: 180.0,
                                lineWidth: 3.0,
                                animation: true,
                                animateFromLastPercent: true,
                                progressColor: const Color(0xFFE01E7B),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).info,
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
