import 'dart:convert';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Spotify Account API Group Code

class SpotifyAccountAPIGroup {
  static String baseUrl = 'https://accounts.spotify.com/';
  static Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  static AccessRefreshTokenCall accessRefreshTokenCall =
      AccessRefreshTokenCall();
  static AccessTokenCall accessTokenCall = AccessTokenCall();
}

class AccessRefreshTokenCall {
  Future<ApiCallResponse> call({
    String? code = '',
    String? base64 = '',
    String? redirectUri = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Access Refresh Token',
      apiUrl: '${SpotifyAccountAPIGroup.baseUrl}api/token',
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

class AccessTokenCall {
  Future<ApiCallResponse> call({
    String? refreshToken = '',
    String? base64 = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Access Token',
      apiUrl: '${SpotifyAccountAPIGroup.baseUrl}api/token',
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
  static String baseUrl = 'https://api.spotify.com/';
  static Map<String, String> headers = {};
  static RecentlyPlayedTracksCall recentlyPlayedTracksCall =
      RecentlyPlayedTracksCall();
  static GetPlaylistsCall getPlaylistsCall = GetPlaylistsCall();
  static GetProfileCall getProfileCall = GetProfileCall();
  static GetPlaylistImagesCall getPlaylistImagesCall = GetPlaylistImagesCall();
}

class RecentlyPlayedTracksCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Recently played tracks',
      apiUrl: '${SpotifyMediaAPIGroup.baseUrl}v1/me/player/recently-played',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetPlaylistsCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Playlists',
      apiUrl: '${SpotifyMediaAPIGroup.baseUrl}v1/me/playlists',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProfileCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Profile',
      apiUrl: '${SpotifyMediaAPIGroup.baseUrl}v1/me/',
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
    return ApiManager.instance.makeApiCall(
      callName: 'get Playlist Images',
      apiUrl: '${SpotifyMediaAPIGroup.baseUrl}v1/playlists/$id/images',
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
      alwaysAllowBody: false,
    );
  }
}

/// End Spotify Media API Group Code

/// Start Datacenter API Group Code

class DatacenterAPIGroup {
  static String baseUrl = 'https://api.datadude.dev';
  static Map<String, String> headers = {};
  static SendUploadedImageCall sendUploadedImageCall = SendUploadedImageCall();
  static SendUploadedImageCopyCall sendUploadedImageCopyCall =
      SendUploadedImageCopyCall();
  static GetPlaylistURLCall getPlaylistURLCall = GetPlaylistURLCall();
  static GetMoodsCall getMoodsCall = GetMoodsCall();
  static PostMooodCall postMooodCall = PostMooodCall();
}

class SendUploadedImageCall {
  Future<ApiCallResponse> call({
    String? imageBase64 = '123',
    String? userRef = '123',
  }) async {
    final ffApiRequestBody = '''
{
  "image": "$imageBase64",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Uploaded Image',
      apiUrl: '${DatacenterAPIGroup.baseUrl}/v1/post_image',
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
    final ffApiRequestBody = '''
{
  "image": "$imageUrl",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Uploaded Image Copy',
      apiUrl: '${DatacenterAPIGroup.baseUrl}/v1/post_image',
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
    return ApiManager.instance.makeApiCall(
      callName: 'get Playlist URL',
      apiUrl: '${DatacenterAPIGroup.baseUrl}/v1/get_playlist',
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
}

class GetMoodsCall {
  Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'get Moods',
      apiUrl: '${DatacenterAPIGroup.baseUrl}/v1/get_moods',
      callType: ApiCallType.GET,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
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

class PostMooodCall {
  Future<ApiCallResponse> call({
    String? mood = '',
    String? userRef = '',
  }) async {
    final ffApiRequestBody = '''
{
  "mood": "$mood",
  "userRef": "$userRef"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'post moood',
      apiUrl: '${DatacenterAPIGroup.baseUrl}/v1/post_mood',
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
      alwaysAllowBody: false,
    );
  }
}

/// End Datacenter API Group Code

/// Start Datacenter API Two Group Code

class DatacenterAPITwoGroup {
  static String baseUrl = 'https://api2.datadude.dev/';
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

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
