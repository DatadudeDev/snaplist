import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'voice_modal_model.dart';
export 'voice_modal_model.dart';

class VoiceModalWidget extends StatefulWidget {
  const VoiceModalWidget({super.key});

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
      _model.audioRecorder ??= AudioRecorder();
      if (await _model.audioRecorder!.hasPermission()) {
        final String path;
        final AudioEncoder encoder;
        if (kIsWeb) {
          path = '';
          encoder = AudioEncoder.opus;
        } else {
          final dir = await getApplicationDocumentsDirectory();
          path =
              '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
          encoder = AudioEncoder.aacLc;
        }
        await _model.audioRecorder!.start(
          RecordConfig(encoder: encoder),
          path: path,
        );
      } else {
        showSnackbar(
          context,
          'You have not provided permission to record audio.',
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        _model.audio = await _model.audioRecorder?.stop();
        if (_model.audio != null) {
          _model.recordedFileBytes = FFUploadedFile(
            name: 'recordedFileBytes.mp3',
            bytes: await XFile(_model.audio!).readAsBytes(),
          );
        }

        {
          setState(() => _model.isDataUploading = true);
          var selectedUploadedFiles = <FFUploadedFile>[];
          var selectedMedia = <SelectedFile>[];
          var downloadUrls = <String>[];
          try {
            selectedUploadedFiles = _model.recordedFileBytes.bytes!.isNotEmpty
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

        context.goNamed(
          'loadingVoice',
          queryParameters: {
            'url': serializeParam(
              _model.uploadedFileUrl,
              ParamType.String,
            ),
          }.withoutNulls,
        );

        setState(() {});
      },
      child: Container(
        width: double.infinity,
        height: 370.0,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/IMG_0242.gif',
                    width: 200.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Text(
              'Tap to Submit',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 13.0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
