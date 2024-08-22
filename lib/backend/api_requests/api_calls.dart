import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Spotify Account API Group Code

class SpotifyAccountAPIGroup {
  static String getBaseUrl() => 'https://accounts.spotify.com/';
  static Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  static AccessRefreshTokenCall accessRefreshTokenCall =
      AccessRefreshTokenCall();
  static AcqurireNewAccessTokenCall acqurireNewAccessTokenCall =
      AcqurireNewAccessTokenCall();
}

class AccessRefreshTokenCall {
  Future<ApiCallResponse> call({
    String? code = '',
    String? base64 = '',
    String? redirectUri = '',
  }) async {
    final baseUrl = SpotifyAccountAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Access Refresh Token',
      apiUrl: '${baseUrl}api/token',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic $base64',
      },
      params: {
        'grant_type': "authorization_code",
        'code': code,
        'redirect_uri': redirectUri,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic accessToken(dynamic response) => getJsonField(
        response,
        r'''$.access_token''',
      );
  dynamic refreshToken(dynamic response) => getJsonField(
        response,
        r'''$.refresh_token''',
      );
}

class AcqurireNewAccessTokenCall {
  Future<ApiCallResponse> call({
    String? refreshToken = '',
    String? base64 = '',
  }) async {
    final baseUrl = SpotifyAccountAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Acqurire New Access Token',
      apiUrl: '${baseUrl}api/token',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic $base64',
      },
      params: {
        'grant_type': "refresh_token",
        'refresh_token': refreshToken,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? accessToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.access_token''',
      ));
}

/// End Spotify Account API Group Code

/// Start Spotify Media API Group Code

class SpotifyMediaAPIGroup {
  static String getBaseUrl() => 'https://api.spotify.com/';
  static Map<String, String> headers = {};
  static RecentlyPlayedTracksCall recentlyPlayedTracksCall =
      RecentlyPlayedTracksCall();
  static GetPlaylistCall getPlaylistCall = GetPlaylistCall();
  static GetProfileCall getProfileCall = GetProfileCall();
  static GetPlaylistImagesCall getPlaylistImagesCall = GetPlaylistImagesCall();
  static GetDeviceIDCall getDeviceIDCall = GetDeviceIDCall();
  static StartPlayerCall startPlayerCall = StartPlayerCall();
  static ResumeMusicCall resumeMusicCall = ResumeMusicCall();
  static PauseMusicCall pauseMusicCall = PauseMusicCall();
}

class RecentlyPlayedTracksCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    final baseUrl = SpotifyMediaAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Recently played tracks',
      apiUrl: '${baseUrl}v1/me/player/recently-played',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetPlaylistCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    final baseUrl = SpotifyMediaAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Playlist',
      apiUrl: '${baseUrl}v1/me/playlists',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProfileCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    final baseUrl = SpotifyMediaAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Profile',
      apiUrl: '${baseUrl}v1/me/',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {
        'access_token': accessToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic username(dynamic response) => getJsonField(
        response,
        r'''$.display_name''',
      );
}

class GetPlaylistImagesCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? accessToken = '',
  }) async {
    final baseUrl = SpotifyMediaAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Playlist Images',
      apiUrl: '${baseUrl}v1/playlists/$id/images',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {
        'id': id,
        'accessToken': accessToken,
        'height': 300,
        'width': 300,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetDeviceIDCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    final baseUrl = SpotifyMediaAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Device ID',
      apiUrl: '${baseUrl}v1/me/player/devices',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? deviceID(dynamic response) => (getJsonField(
        response,
        r'''$.devices[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<bool>? isActive(dynamic response) => (getJsonField(
        response,
        r'''$.devices[:].is_active''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<String>? deviceType(dynamic response) => (getJsonField(
        response,
        r'''$.devices[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? volumePercent(dynamic response) => (getJsonField(
        response,
        r'''$.devices[:].volume_percent''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? deviceName(dynamic response) => (getJsonField(
        response,
        r'''$.devices[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<bool>? volumeAdjustable(dynamic response) => (getJsonField(
        response,
        r'''$.devices[:].supports_volume''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List? devices(dynamic response) => getJsonField(
        response,
        r'''$.devices''',
        true,
      ) as List?;
}

class StartPlayerCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
    String? contextUri = '',
  }) async {
    final baseUrl = SpotifyMediaAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "context_uri": "$contextUri"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'start Player',
      apiUrl: '${baseUrl}v1/me/player/play',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ResumeMusicCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    final baseUrl = SpotifyMediaAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Resume Music',
      apiUrl: '${baseUrl}v1/me/player/play',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PauseMusicCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    final baseUrl = SpotifyMediaAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Pause Music',
      apiUrl: '${baseUrl}v1/me/player/pause',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Spotify Media API Group Code

/// Start Datacenter API Group Code

class DatacenterAPIGroup {
  static String getBaseUrl() => 'https://api.datadude.dev';
  static Map<String, String> headers = {};
  static PostImageCall postImageCall = PostImageCall();
  static SendUploadedImageCopyCall sendUploadedImageCopyCall =
      SendUploadedImageCopyCall();
  static GetPlaylistURLCall getPlaylistURLCall = GetPlaylistURLCall();
  static GetPlaylistURLInputCall getPlaylistURLInputCall =
      GetPlaylistURLInputCall();
  static GetMoodsCall getMoodsCall = GetMoodsCall();
  static GetPlacesCall getPlacesCall = GetPlacesCall();
  static PostMoodCall postMoodCall = PostMoodCall();
  static PostInputCall postInputCall = PostInputCall();
  static PostVoiceCall postVoiceCall = PostVoiceCall();
}

class PostImageCall {
  Future<ApiCallResponse> call({
    String? imageBase64 = '123',
    String? userRef = '123',
    int? playlistLength,
  }) async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "image": "$imageBase64",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Post Image',
      apiUrl: '$baseUrl/v1/post_image',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? timestamp(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.timestamp''',
      ));
}

class SendUploadedImageCopyCall {
  Future<ApiCallResponse> call({
    String? imageUrl = '123',
    String? userRef = '123',
  }) async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "imageUrl": "$imageUrl",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Uploaded Image Copy',
      apiUrl: '$baseUrl/v1/post_image',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? timestamp(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.timestamp''',
      ));
}

class GetPlaylistURLCall {
  Future<ApiCallResponse> call({
    String? userRef = '',
    int? timestamp,
  }) async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Playlist URL',
      apiUrl: '$baseUrl/v1/get_playlist',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {
        'userRef': userRef,
        'timestamp': timestamp,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? playlistUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  String? imageUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.image_url''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  String? userRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.userRef''',
      ));
  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? contextUri(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.context_uri''',
      ));
}

class GetPlaylistURLInputCall {
  Future<ApiCallResponse> call({
    String? userRef = '',
    int? timestamp,
  }) async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Playlist URL Input',
      apiUrl: '$baseUrl/v1/get_playlist_input',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {
        'userRef': userRef,
        'timestamp': timestamp,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? playlistUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  String? imageUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.image_url''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  String? userRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.userRef''',
      ));
  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? imageBase64(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].image_base64''',
      ));
  dynamic contextUri(dynamic response) => getJsonField(
        response,
        r'''$.context_uri''',
      );
}

class GetMoodsCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Moods',
      apiUrl: '$baseUrl/v1/get_moods',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$.moods[:].Description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? mood(dynamic response) => (getJsonField(
        response,
        r'''$.moods[:].mood''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? url(dynamic response) => (getJsonField(
        response,
        r'''$.moods[:].url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? moodList(dynamic response) => getJsonField(
        response,
        r'''$.moods''',
        true,
      ) as List?;
}

class GetPlacesCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Places',
      apiUrl: '$baseUrl/v1/get_places',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.places[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? places(dynamic response) => getJsonField(
        response,
        r'''$.places''',
        true,
      ) as List?;
  List? gps(dynamic response) => getJsonField(
        response,
        r'''$.places[:].gps''',
        true,
      ) as List?;
}

class PostMoodCall {
  Future<ApiCallResponse> call({
    String? mood = '',
    String? userRef = '',
    int? playlistLength,
  }) async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "mood": "$mood",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Post Mood',
      apiUrl: '$baseUrl/v1/post_mood',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PostInputCall {
  Future<ApiCallResponse> call({
    String? input = '',
    String? userRef = '',
    int? playlistLength,
  }) async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "input": "$input",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Post Input',
      apiUrl: '$baseUrl/v1/post_input',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PostVoiceCall {
  Future<ApiCallResponse> call({
    String? voice = '',
    String? userRef = '',
    int? playlistLength,
  }) async {
    final baseUrl = DatacenterAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "voice": "$voice",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Post Voice',
      apiUrl: '$baseUrl/v1/post_voice',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? timestamp(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.timestamp''',
      ));
}

/// End Datacenter API Group Code

/// Start Datacenter API DEV Group Code

class DatacenterAPIDEVGroup {
  static String getBaseUrl() => 'https://api-dev.datadude.dev';
  static Map<String, String> headers = {};
  static PostPhotoDevCall postPhotoDevCall = PostPhotoDevCall();
  static GetPlaylistURLDevCall getPlaylistURLDevCall = GetPlaylistURLDevCall();
  static GetPlaylistInputDevCall getPlaylistInputDevCall =
      GetPlaylistInputDevCall();
  static GetMoodsDevCall getMoodsDevCall = GetMoodsDevCall();
  static GetPlacesDevCall getPlacesDevCall = GetPlacesDevCall();
  static PostMoodDevCall postMoodDevCall = PostMoodDevCall();
  static PostInputDevCall postInputDevCall = PostInputDevCall();
  static PostVoiceDevCall postVoiceDevCall = PostVoiceDevCall();
}

class PostPhotoDevCall {
  Future<ApiCallResponse> call({
    String? imageBase64 = '123',
    String? userRef = '123',
    int? playlistLength,
  }) async {
    final baseUrl = DatacenterAPIDEVGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "image": "$imageBase64",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Post Photo Dev',
      apiUrl: '$baseUrl/v1/post_image',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? timestamp(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.timestamp''',
      ));
}

class GetPlaylistURLDevCall {
  Future<ApiCallResponse> call({
    String? userRef = '',
    int? timestamp,
  }) async {
    final baseUrl = DatacenterAPIDEVGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Playlist URL Dev',
      apiUrl: '$baseUrl/v1/get_playlist',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {
        'userRef': userRef,
        'timestamp': timestamp,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? playlistUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  String? imageUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.image_url''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  String? userRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.userRef''',
      ));
  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? contextUri(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.context_uri''',
      ));
}

class GetPlaylistInputDevCall {
  Future<ApiCallResponse> call({
    String? userRef = '',
    int? timestamp,
  }) async {
    final baseUrl = DatacenterAPIDEVGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Playlist Input Dev',
      apiUrl: '$baseUrl/v1/get_playlist_input',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {
        'userRef': userRef,
        'timestamp': timestamp,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? playlistUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  String? imageUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.image_url''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  String? userRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.userRef''',
      ));
  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? imageBase64(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].image_base64''',
      ));
  dynamic contextUri(dynamic response) => getJsonField(
        response,
        r'''$.context_uri''',
      );
}

class GetMoodsDevCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = DatacenterAPIDEVGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Moods Dev',
      apiUrl: '$baseUrl/v1/get_moods',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$.moods[:].Description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? mood(dynamic response) => (getJsonField(
        response,
        r'''$.moods[:].mood''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? url(dynamic response) => (getJsonField(
        response,
        r'''$.moods[:].url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? moodList(dynamic response) => getJsonField(
        response,
        r'''$.moods''',
        true,
      ) as List?;
}

class GetPlacesDevCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = DatacenterAPIDEVGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Places Dev',
      apiUrl: '$baseUrl/v1/get_places',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.places[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? places(dynamic response) => getJsonField(
        response,
        r'''$.places''',
        true,
      ) as List?;
  List? gps(dynamic response) => getJsonField(
        response,
        r'''$.places[:].gps''',
        true,
      ) as List?;
}

class PostMoodDevCall {
  Future<ApiCallResponse> call({
    String? mood = '',
    String? userRef = '',
    int? playlistLength,
  }) async {
    final baseUrl = DatacenterAPIDEVGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "mood": "$mood",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Post Mood Dev',
      apiUrl: '$baseUrl/v1/post_mood',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PostInputDevCall {
  Future<ApiCallResponse> call({
    String? input = '',
    String? userRef = '',
    int? playlistLength,
  }) async {
    final baseUrl = DatacenterAPIDEVGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "input": "$input",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Post Input Dev',
      apiUrl: '$baseUrl/v1/post_input',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PostVoiceDevCall {
  Future<ApiCallResponse> call({
    String? voice = '',
    String? userRef = '',
    int? playlistLength,
  }) async {
    final baseUrl = DatacenterAPIDEVGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "voice": "$voice",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Post Voice Dev',
      apiUrl: '$baseUrl/v1/post_voice',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? timestamp(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.timestamp''',
      ));
}

/// End Datacenter API DEV Group Code

/// Start Datacenter API Two Group Code

class DatacenterAPITwoGroup {
  static String getBaseUrl() => 'https://api2.datadude.dev/';
  static Map<String, String> headers = {
    'Content-type': 'application/json',
  };
}

/// End Datacenter API Two Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
