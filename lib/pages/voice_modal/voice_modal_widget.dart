import '/backend/api_requests/api_calls.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'voice_modal_model.dart';
export 'voice_modal_model.dart';

class VoiceModalWidget extends StatefulWidget {
  const VoiceModalWidget({
    super.key,
    required this.isPaused,
  });

  final bool? isPaused;

  @override
  State<VoiceModalWidget> createState() => _VoiceModalWidgetState();
}

class _VoiceModalWidgetState extends State<VoiceModalWidget> {
  late VoiceModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoiceModalModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('VOICE_MODAL_voiceModal_ON_INIT_STATE');
      logFirebaseEvent('voiceModal_play_sound');
      _model.soundPlayer1 ??= AudioPlayer();
      if (_model.soundPlayer1!.playing) {
        await _model.soundPlayer1!.stop();
      }
      _model.soundPlayer1!.setVolume(0.25);
      _model.soundPlayer1!
          .setAsset('assets/audios/beep-07a.wav')
          .then((_) => _model.soundPlayer1!.play());

      logFirebaseEvent('voiceModal_start_audio_recording');
      await startAudioRecording(
        context,
        audioRecorder: _model.audioRecorder ??= AudioRecorder(),
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: double.infinity,
            height: 25.0,
            child: CarouselSlider(
              items: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          '5pzdz67r' /* “Gym Leg Day with Beyoncé” */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'qqbh71x8' /* “Play me some jazz” */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'qnzwaroi' /* Getting ready for a date 💋 */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'bbjtbzw7' /* “Nature sounds for sleeping” */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
              carouselController: _model.carouselController ??=
                  CarouselController(),
              options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 0.8,
                disableCenter: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.25,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayInterval: const Duration(milliseconds: (800 + 800)),
                autoPlayCurve: Curves.linear,
                pauseAutoPlayInFiniteScroll: true,
                onPageChanged: (index, _) =>
                    _model.carouselCurrentIndex = index,
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('VOICE_MODAL_COMP_Image_glxzgsl9_ON_TAP');
              var shouldSetState = false;
              logFirebaseEvent('Image_play_sound');
              _model.soundPlayer2 ??= AudioPlayer();
              if (_model.soundPlayer2!.playing) {
                await _model.soundPlayer2!.stop();
              }
              _model.soundPlayer2!.setVolume(0.25);
              _model.soundPlayer2!
                  .setAsset('assets/audios/beep-07a.wav')
                  .then((_) => _model.soundPlayer2!.play());

              logFirebaseEvent('Image_stop_audio_recording');
              await stopAudioRecording(
                audioRecorder: _model.audioRecorder,
                audioName: 'recordedFileBytes.mp3',
                onRecordingComplete: (audioFilePath, audioBytes) {
                  _model.audio = audioFilePath;
                  _model.recordedFileBytes = audioBytes;
                },
              );

              shouldSetState = true;
              logFirebaseEvent('Image_upload_media_to_firebase');
              {
                setState(() => _model.isDataUploading = true);
                var selectedUploadedFiles = <FFUploadedFile>[];
                var selectedMedia = <SelectedFile>[];
                var downloadUrls = <String>[];
                try {
                  selectedUploadedFiles =
                      _model.recordedFileBytes.bytes!.isNotEmpty
                          ? [_model.recordedFileBytes]
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

              if (widget.isPaused == true) {
                logFirebaseEvent('Image_backend_call');
                unawaited(
                  () async {
                    _model.apiResult2c4 =
                        await SpotifyMediaAPIGroup.resumeMusicCall.call(
                      accessToken: FFAppState().accessToken,
                    );
                  }(),
                );
                shouldSetState = true;
                logFirebaseEvent('Image_navigate_to');

                context.goNamed(
                  'loadingVoice',
                  queryParameters: {
                    'url': serializeParam(
                      _model.uploadedFileUrl,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );

                if (shouldSetState) setState(() {});
                return;
              } else {
                logFirebaseEvent('Image_navigate_to');

                context.goNamed(
                  'loadingVoice',
                  queryParameters: {
                    'url': serializeParam(
                      _model.uploadedFileUrl,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );

                if (shouldSetState) setState(() {});
                return;
              }

              if (shouldSetState) setState(() {});
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/IMG_0242.gif',
                width: 300.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    'mcamtn37' /* Tap to submit */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
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
    );
  }
}
