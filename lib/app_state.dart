import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _spotifyAuth =
          await secureStorage.getBool('ff_spotifyAuth') ?? _spotifyAuth;
    });
    await _safeInitAsync(() async {
      _accessToken =
          await secureStorage.getString('ff_accessToken') ?? _accessToken;
    });
    await _safeInitAsync(() async {
      _refreshToken =
          await secureStorage.getString('ff_refreshToken') ?? _refreshToken;
    });
    await _safeInitAsync(() async {
      _Playlists =
          (await secureStorage.getStringList('ff_Playlists'))?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _Playlists;
    });
    await _safeInitAsync(() async {
      _spotifyUsername = await secureStorage.getString('ff_spotifyUsername') ??
          _spotifyUsername;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  bool _makePhoto = false;
  bool get makePhoto => _makePhoto;
  set makePhoto(bool _value) {
    _makePhoto = _value;
  }

  String _fileBase64 = '';
  String get fileBase64 => _fileBase64;
  set fileBase64(String _value) {
    _fileBase64 = _value;
  }

  bool _spotifyAuth = false;
  bool get spotifyAuth => _spotifyAuth;
  set spotifyAuth(bool _value) {
    _spotifyAuth = _value;
    secureStorage.setBool('ff_spotifyAuth', _value);
  }

  void deleteSpotifyAuth() {
    secureStorage.delete(key: 'ff_spotifyAuth');
  }

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String _value) {
    _accessToken = _value;
    secureStorage.setString('ff_accessToken', _value);
  }

  void deleteAccessToken() {
    secureStorage.delete(key: 'ff_accessToken');
  }

  String _refreshToken = '';
  String get refreshToken => _refreshToken;
  set refreshToken(String _value) {
    _refreshToken = _value;
    secureStorage.setString('ff_refreshToken', _value);
  }

  void deleteRefreshToken() {
    secureStorage.delete(key: 'ff_refreshToken');
  }

  List<dynamic> _tracks = [];
  List<dynamic> get tracks => _tracks;
  set tracks(List<dynamic> _value) {
    _tracks = _value;
  }

  void addToTracks(dynamic _value) {
    _tracks.add(_value);
  }

  void removeFromTracks(dynamic _value) {
    _tracks.remove(_value);
  }

  void removeAtIndexFromTracks(int _index) {
    _tracks.removeAt(_index);
  }

  void updateTracksAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _tracks[_index] = updateFn(_tracks[_index]);
  }

  void insertAtIndexInTracks(int _index, dynamic _value) {
    _tracks.insert(_index, _value);
  }

  List<dynamic> _Playlists = [];
  List<dynamic> get Playlists => _Playlists;
  set Playlists(List<dynamic> _value) {
    _Playlists = _value;
    secureStorage.setStringList(
        'ff_Playlists', _value.map((x) => jsonEncode(x)).toList());
  }

  void deletePlaylists() {
    secureStorage.delete(key: 'ff_Playlists');
  }

  void addToPlaylists(dynamic _value) {
    _Playlists.add(_value);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPlaylists(dynamic _value) {
    _Playlists.remove(_value);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPlaylists(int _index) {
    _Playlists.removeAt(_index);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void updatePlaylistsAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _Playlists[_index] = updateFn(_Playlists[_index]);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPlaylists(int _index, dynamic _value) {
    _Playlists.insert(_index, _value);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  String _playlistUrl = '';
  String get playlistUrl => _playlistUrl;
  set playlistUrl(String _value) {
    _playlistUrl = _value;
  }

  String _spotifyUsername = '';
  String get spotifyUsername => _spotifyUsername;
  set spotifyUsername(String _value) {
    _spotifyUsername = _value;
    secureStorage.setString('ff_spotifyUsername', _value);
  }

  void deleteSpotifyUsername() {
    secureStorage.delete(key: 'ff_spotifyUsername');
  }

  String _ticketTime = '';
  String get ticketTime => _ticketTime;
  set ticketTime(String _value) {
    _ticketTime = _value;
  }

  List<dynamic> _moods = [];
  List<dynamic> get moods => _moods;
  set moods(List<dynamic> _value) {
    _moods = _value;
  }

  void addToMoods(dynamic _value) {
    _moods.add(_value);
  }

  void removeFromMoods(dynamic _value) {
    _moods.remove(_value);
  }

  void removeAtIndexFromMoods(int _index) {
    _moods.removeAt(_index);
  }

  void updateMoodsAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _moods[_index] = updateFn(_moods[_index]);
  }

  void insertAtIndexInMoods(int _index, dynamic _value) {
    _moods.insert(_index, _value);
  }

  List<dynamic> _moodDescription = [];
  List<dynamic> get moodDescription => _moodDescription;
  set moodDescription(List<dynamic> _value) {
    _moodDescription = _value;
  }

  void addToMoodDescription(dynamic _value) {
    _moodDescription.add(_value);
  }

  void removeFromMoodDescription(dynamic _value) {
    _moodDescription.remove(_value);
  }

  void removeAtIndexFromMoodDescription(int _index) {
    _moodDescription.removeAt(_index);
  }

  void updateMoodDescriptionAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _moodDescription[_index] = updateFn(_moodDescription[_index]);
  }

  void insertAtIndexInMoodDescription(int _index, dynamic _value) {
    _moodDescription.insert(_index, _value);
  }

  List<dynamic> _moodUrl = [];
  List<dynamic> get moodUrl => _moodUrl;
  set moodUrl(List<dynamic> _value) {
    _moodUrl = _value;
  }

  void addToMoodUrl(dynamic _value) {
    _moodUrl.add(_value);
  }

  void removeFromMoodUrl(dynamic _value) {
    _moodUrl.remove(_value);
  }

  void removeAtIndexFromMoodUrl(int _index) {
    _moodUrl.removeAt(_index);
  }

  void updateMoodUrlAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _moodUrl[_index] = updateFn(_moodUrl[_index]);
  }

  void insertAtIndexInMoodUrl(int _index, dynamic _value) {
    _moodUrl.insert(_index, _value);
  }

  String _imageURL = '';
  String get imageURL => _imageURL;
  set imageURL(String _value) {
    _imageURL = _value;
  }

  int _timestamp = 0;
  int get timestamp => _timestamp;
  set timestamp(int _value) {
    _timestamp = _value;
  }

  String _mood = '';
  String get mood => _mood;
  set mood(String _value) {
    _mood = _value;
  }

  bool _cameraOn = false;
  bool get cameraOn => _cameraOn;
  set cameraOn(bool _value) {
    _cameraOn = _value;
  }

  bool _wakelock = false;
  bool get wakelock => _wakelock;
  set wakelock(bool _value) {
    _wakelock = _value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
