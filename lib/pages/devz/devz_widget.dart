import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'devz_model.dart';
export 'devz_model.dart';

class DevzWidget extends StatefulWidget {
  const DevzWidget({
    super.key,
    String? playlistUrl,
  }) : playlistUrl = playlistUrl ?? '123';

  final String playlistUrl;

  @override
  State<DevzWidget> createState() => _DevzWidgetState();
}

class _DevzWidgetState extends State<DevzWidget> {
  late DevzModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DevzModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.tracks = await SpotifyMediaAPIGroup.recentlyPlayedTracksCall.call(
        accessToken: FFAppState().accessToken,
      );
      if ((_model.tracks?.succeeded ?? true)) {
        setState(() {
          FFAppState().tracks = getJsonField(
            (_model.tracks?.jsonBody ?? ''),
            r'''$.items''',
            true,
          )!
              .toList()
              .cast<dynamic>();
        });
        _model.lastPlayedTrack = await querySongsRecordOnce(
          queryBuilder: (songsRecord) => songsRecord
              .where(
                'userRef',
                isEqualTo: currentUserReference,
              )
              .orderBy('playedTime', descending: true),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        if (getCurrentTimestamp <= _model.lastPlayedTrack!.playedTime!) {
          await SongsRecord.collection.doc().set(createSongsRecordData(
                title: getJsonField(
                  (_model.tracks?.jsonBody ?? ''),
                  r'''$.items[0].track.name''',
                ).toString().toString(),
                userRef: currentUserReference,
              ));
        }
      } else {
        _model.spotifyDocDev = await actions.getDocUsingFilter(
          'userRef',
          FFAppState().accessToken,
          'spotify',
        );
        await querySpotifyRecordOnce(
          queryBuilder: (spotifyRecord) => spotifyRecord.where(
            'userRef',
            isEqualTo: currentUserReference,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.accessTokenResDev =
            await SpotifyAccountAPIGroup.accessTokenCall.call(
          base64: functions.toBase64(
              '677dd225a59040108d47d550c4e74cb4:521e2d39a8b04bab8fad584760b84d30'),
          refreshToken: _model.spotifyDocDev?.refreshToken,
        );
        if ((_model.accessTokenResDev?.succeeded ?? true)) {
          _model.tracks2 = await SpotifyMediaAPIGroup.getProfileCall.call(
            accessToken: SpotifyAccountAPIGroup.accessTokenCall.accessToken(
              (_model.accessTokenResDev?.jsonBody ?? ''),
            ),
          );
          if ((_model.tracks2?.succeeded ?? true)) {
            setState(() {
              FFAppState().Playlists =
                  (_model.tracks2?.jsonBody ?? '').toList().cast<dynamic>();
            });
            _model.lastPlayedTrack2 = await querySongsRecordOnce(
              queryBuilder: (songsRecord) => songsRecord
                  .where(
                    'userRef',
                    isEqualTo: currentUserReference,
                  )
                  .orderBy('playedTime', descending: true),
              singleRecord: true,
            ).then((s) => s.firstOrNull);
            if (getCurrentTimestamp <= _model.lastPlayedTrack!.playedTime!) {
              await SongsRecord.collection.doc().set(createSongsRecordData(
                    title: getJsonField(
                      (_model.tracks2?.jsonBody ?? ''),
                      r'''$.items[0].track.name''',
                    ).toString().toString(),
                    userRef: currentUserReference,
                  ));
            }
          }
        }
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Access Token: ',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          AutoSizeText(
                            FFAppState()
                                .accessToken
                                .maybeHandleOverflow(maxChars: 10),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Refresh Token: ',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          AutoSizeText(
                            FFAppState()
                                .refreshToken
                                .maybeHandleOverflow(maxChars: 10),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Playlist URL: ',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          AutoSizeText(
                            valueOrDefault<String>(
                              widget.playlistUrl,
                              '123',
                            ).maybeHandleOverflow(maxChars: 10),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Playlist URL: ',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          Text(
                            'test',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Username',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          AutoSizeText(
                            FFAppState()
                                .spotifyUsername
                                .maybeHandleOverflow(maxChars: 10),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  final track = FFAppState().tracks.toList().take(10).toList();
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: track.length,
                    itemBuilder: (context, trackIndex) {
                      final trackItem = track[trackIndex];
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            getJsonField(
                              trackItem,
                              r'''$.track.name''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          Text(
                            '-',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          Text(
                            getJsonField(
                              trackItem,
                              r'''$.track.artists[0].name''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          Text(
                            '-',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          Text(
                            getJsonField(
                              trackItem,
                              r'''$.track.popularity''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      _model.playlists =
                          await SpotifyMediaAPIGroup.getPlaylistsCall.call(
                        accessToken: FFAppState().accessToken,
                      );
                      if ((_model.playlists?.succeeded ?? true)) {
                        setState(() {
                          FFAppState().Playlists = getJsonField(
                            (_model.playlists?.jsonBody ?? ''),
                            r'''$.items''',
                            true,
                          )!
                              .toList()
                              .cast<dynamic>();
                        });
                      } else {
                        _model.spotifyDocDevCopy =
                            await actions.getDocUsingFilter(
                          'userRef',
                          FFAppState().accessToken,
                          'spotify',
                        );
                        await querySpotifyRecordOnce(
                          queryBuilder: (spotifyRecord) => spotifyRecord.where(
                            'userRef',
                            isEqualTo: currentUserReference,
                          ),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);
                        _model.accessTokenResDevCopy =
                            await SpotifyAccountAPIGroup.accessTokenCall.call(
                          base64: functions.toBase64(
                              '677dd225a59040108d47d550c4e74cb4:521e2d39a8b04bab8fad584760b84d30'),
                          refreshToken: _model.spotifyDocDev?.refreshToken,
                        );
                        if ((_model.accessTokenResDev?.succeeded ?? true)) {
                          _model.playlists2 =
                              await SpotifyMediaAPIGroup.getProfileCall.call(
                            accessToken: FFAppState().accessToken,
                          );
                          if ((_model.playlists2?.succeeded ?? true)) {
                            setState(() {
                              FFAppState().Playlists = getJsonField(
                                (_model.tracks2?.jsonBody ?? ''),
                                r'''$.items''',
                                true,
                              )!
                                  .toList()
                                  .cast<dynamic>();
                            });
                          }
                        }
                      }

                      setState(() {});
                    },
                    text: 'Button',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                              ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final playlist =
                            FFAppState().tracks.toList().take(10).toList();
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: playlist.length,
                          itemBuilder: (context, playlistIndex) {
                            final playlistItem = playlist[playlistIndex];
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                                Text(
                                  '-',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                                Text(
                                  '-',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
