import 'package:flutter/material.dart';
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
    secureStorage = const FlutterSecureStorage();
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
    await _safeInitAsync(() async {
      _moods = (await secureStorage.getStringList('ff_moods'))?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _moods;
    });
    await _safeInitAsync(() async {
      _isPremium = await secureStorage.getBool('ff_isPremium') ?? _isPremium;
    });
    await _safeInitAsync(() async {
      _isEmailOK = await secureStorage.getBool('ff_isEmailOK') ?? _isEmailOK;
    });
    await _safeInitAsync(() async {
      _isPushOK = await secureStorage.getBool('ff_isPushOK') ?? _isPushOK;
    });
    await _safeInitAsync(() async {
      _isDataOK = await secureStorage.getBool('ff_isDataOK') ?? _isDataOK;
    });
    await _safeInitAsync(() async {
      _places = (await secureStorage.getStringList('ff_places'))?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _places;
    });
    await _safeInitAsync(() async {
      _musicApp = await secureStorage.getString('ff_musicApp') ?? _musicApp;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  bool _makePhoto = false;
  bool get makePhoto => _makePhoto;
  set makePhoto(bool value) {
    _makePhoto = value;
  }

  String _fileBase64 = '';
  String get fileBase64 => _fileBase64;
  set fileBase64(String value) {
    _fileBase64 = value;
  }

  bool _spotifyAuth = false;
  bool get spotifyAuth => _spotifyAuth;
  set spotifyAuth(bool value) {
    _spotifyAuth = value;
    secureStorage.setBool('ff_spotifyAuth', value);
  }

  void deleteSpotifyAuth() {
    secureStorage.delete(key: 'ff_spotifyAuth');
  }

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String value) {
    _accessToken = value;
    secureStorage.setString('ff_accessToken', value);
  }

  void deleteAccessToken() {
    secureStorage.delete(key: 'ff_accessToken');
  }

  String _refreshToken = '';
  String get refreshToken => _refreshToken;
  set refreshToken(String value) {
    _refreshToken = value;
    secureStorage.setString('ff_refreshToken', value);
  }

  void deleteRefreshToken() {
    secureStorage.delete(key: 'ff_refreshToken');
  }

  List<dynamic> _tracks = [];
  List<dynamic> get tracks => _tracks;
  set tracks(List<dynamic> value) {
    _tracks = value;
  }

  void addToTracks(dynamic value) {
    _tracks.add(value);
  }

  void removeFromTracks(dynamic value) {
    _tracks.remove(value);
  }

  void removeAtIndexFromTracks(int index) {
    _tracks.removeAt(index);
  }

  void updateTracksAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _tracks[index] = updateFn(_tracks[index]);
  }

  void insertAtIndexInTracks(int index, dynamic value) {
    _tracks.insert(index, value);
  }

  List<dynamic> _Playlists = [];
  List<dynamic> get Playlists => _Playlists;
  set Playlists(List<dynamic> value) {
    _Playlists = value;
    secureStorage.setStringList(
        'ff_Playlists', value.map((x) => jsonEncode(x)).toList());
  }

  void deletePlaylists() {
    secureStorage.delete(key: 'ff_Playlists');
  }

  void addToPlaylists(dynamic value) {
    _Playlists.add(value);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPlaylists(dynamic value) {
    _Playlists.remove(value);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPlaylists(int index) {
    _Playlists.removeAt(index);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void updatePlaylistsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _Playlists[index] = updateFn(_Playlists[index]);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPlaylists(int index, dynamic value) {
    _Playlists.insert(index, value);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  String _playlistUrl = '';
  String get playlistUrl => _playlistUrl;
  set playlistUrl(String value) {
    _playlistUrl = value;
  }

  String _spotifyUsername = '';
  String get spotifyUsername => _spotifyUsername;
  set spotifyUsername(String value) {
    _spotifyUsername = value;
    secureStorage.setString('ff_spotifyUsername', value);
  }

  void deleteSpotifyUsername() {
    secureStorage.delete(key: 'ff_spotifyUsername');
  }

  String _ticketTime = '';
  String get ticketTime => _ticketTime;
  set ticketTime(String value) {
    _ticketTime = value;
  }

  List<dynamic> _moods = [];
  List<dynamic> get moods => _moods;
  set moods(List<dynamic> value) {
    _moods = value;
    secureStorage.setStringList(
        'ff_moods', value.map((x) => jsonEncode(x)).toList());
  }

  void deleteMoods() {
    secureStorage.delete(key: 'ff_moods');
  }

  void addToMoods(dynamic value) {
    _moods.add(value);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  void removeFromMoods(dynamic value) {
    _moods.remove(value);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromMoods(int index) {
    _moods.removeAt(index);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  void updateMoodsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _moods[index] = updateFn(_moods[index]);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInMoods(int index, dynamic value) {
    _moods.insert(index, value);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _moodDescription = [];
  List<dynamic> get moodDescription => _moodDescription;
  set moodDescription(List<dynamic> value) {
    _moodDescription = value;
  }

  void addToMoodDescription(dynamic value) {
    _moodDescription.add(value);
  }

  void removeFromMoodDescription(dynamic value) {
    _moodDescription.remove(value);
  }

  void removeAtIndexFromMoodDescription(int index) {
    _moodDescription.removeAt(index);
  }

  void updateMoodDescriptionAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _moodDescription[index] = updateFn(_moodDescription[index]);
  }

  void insertAtIndexInMoodDescription(int index, dynamic value) {
    _moodDescription.insert(index, value);
  }

  List<dynamic> _moodUrl = [];
  List<dynamic> get moodUrl => _moodUrl;
  set moodUrl(List<dynamic> value) {
    _moodUrl = value;
  }

  void addToMoodUrl(dynamic value) {
    _moodUrl.add(value);
  }

  void removeFromMoodUrl(dynamic value) {
    _moodUrl.remove(value);
  }

  void removeAtIndexFromMoodUrl(int index) {
    _moodUrl.removeAt(index);
  }

  void updateMoodUrlAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _moodUrl[index] = updateFn(_moodUrl[index]);
  }

  void insertAtIndexInMoodUrl(int index, dynamic value) {
    _moodUrl.insert(index, value);
  }

  String _imageURL = '';
  String get imageURL => _imageURL;
  set imageURL(String value) {
    _imageURL = value;
  }

  int _timestamp = 0;
  int get timestamp => _timestamp;
  set timestamp(int value) {
    _timestamp = value;
  }

  String _mood = '';
  String get mood => _mood;
  set mood(String value) {
    _mood = value;
  }

  bool _cameraOn = false;
  bool get cameraOn => _cameraOn;
  set cameraOn(bool value) {
    _cameraOn = value;
  }

  bool _wakelock = false;
  bool get wakelock => _wakelock;
  set wakelock(bool value) {
    _wakelock = value;
  }

  bool _isPremium = false;
  bool get isPremium => _isPremium;
  set isPremium(bool value) {
    _isPremium = value;
    secureStorage.setBool('ff_isPremium', value);
  }

  void deleteIsPremium() {
    secureStorage.delete(key: 'ff_isPremium');
  }

  bool _isEmailOK = false;
  bool get isEmailOK => _isEmailOK;
  set isEmailOK(bool value) {
    _isEmailOK = value;
    secureStorage.setBool('ff_isEmailOK', value);
  }

  void deleteIsEmailOK() {
    secureStorage.delete(key: 'ff_isEmailOK');
  }

  bool _isPushOK = false;
  bool get isPushOK => _isPushOK;
  set isPushOK(bool value) {
    _isPushOK = value;
    secureStorage.setBool('ff_isPushOK', value);
  }

  void deleteIsPushOK() {
    secureStorage.delete(key: 'ff_isPushOK');
  }

  bool _isDataOK = false;
  bool get isDataOK => _isDataOK;
  set isDataOK(bool value) {
    _isDataOK = value;
    secureStorage.setBool('ff_isDataOK', value);
  }

  void deleteIsDataOK() {
    secureStorage.delete(key: 'ff_isDataOK');
  }

  bool _justUpgraded = false;
  bool get justUpgraded => _justUpgraded;
  set justUpgraded(bool value) {
    _justUpgraded = value;
  }

  List<dynamic> _places = [];
  List<dynamic> get places => _places;
  set places(List<dynamic> value) {
    _places = value;
    secureStorage.setStringList(
        'ff_places', value.map((x) => jsonEncode(x)).toList());
  }

  void deletePlaces() {
    secureStorage.delete(key: 'ff_places');
  }

  void addToPlaces(dynamic value) {
    _places.add(value);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPlaces(dynamic value) {
    _places.remove(value);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPlaces(int index) {
    _places.removeAt(index);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  void updatePlacesAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _places[index] = updateFn(_places[index]);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPlaces(int index, dynamic value) {
    _places.insert(index, value);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  String _musicApp = '';
  String get musicApp => _musicApp;
  set musicApp(String value) {
    _musicApp = value;
    secureStorage.setString('ff_musicApp', value);
  }

  void deleteMusicApp() {
    secureStorage.delete(key: 'ff_musicApp');
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
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}
