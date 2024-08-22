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
    await _safeInitAsync(() async {
      _accentColor =
          _colorFromIntValue(await secureStorage.getInt('ff_accentColor')) ??
              _accentColor;
    });
    await _safeInitAsync(() async {
      _comfortZone =
          await secureStorage.getDouble('ff_comfortZone') ?? _comfortZone;
    });
    await _safeInitAsync(() async {
      _genrePreferences =
          (await secureStorage.getStringList('ff_genrePreferences'))?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _genrePreferences;
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
    tracks.add(value);
  }

  void removeFromTracks(dynamic value) {
    tracks.remove(value);
  }

  void removeAtIndexFromTracks(int index) {
    tracks.removeAt(index);
  }

  void updateTracksAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    tracks[index] = updateFn(_tracks[index]);
  }

  void insertAtIndexInTracks(int index, dynamic value) {
    tracks.insert(index, value);
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
    Playlists.add(value);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPlaylists(dynamic value) {
    Playlists.remove(value);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPlaylists(int index) {
    Playlists.removeAt(index);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void updatePlaylistsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    Playlists[index] = updateFn(_Playlists[index]);
    secureStorage.setStringList(
        'ff_Playlists', _Playlists.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPlaylists(int index, dynamic value) {
    Playlists.insert(index, value);
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

  List<dynamic> _moods = [
    jsonDecode(
        '{\"mood\":\"Party\",\"Description\":\"NO RAEGRETS\",\"url\":\"https://imgur.com/57hN3R5.png\"}'),
    jsonDecode(
        '{\"mood\":\"Stoned\",\"Description\":\"Don\'t munchie in silence, friend\",\"url\":\"https://imgur.com/WGsrbJG.png\"}'),
    jsonDecode(
        '{\"mood\":\"Heartbroken\",\"Description\":\"😘\",\"url\":\"https://imgur.com/aTnFhBf.png\"}'),
    jsonDecode(
        '{\"mood\":\"Romantic\",\"Description\":\"get you some\",\"url\":\"https://imgur.com/ODpQ8gE.png\"}'),
    jsonDecode(
        '{\"mood\":\"Confident\",\"Description\":\"Winning at max volume\",\"url\":\"https://imgur.com/r7L6COw.png\"}'),
    jsonDecode(
        '{\"mood\":\"Euphoric\",\"Description\":\"Cloud Nine, eh?\",\"url\":\"https://imgur.com/HyGABDA.png\"}'),
    jsonDecode(
        '{\"mood\":\"Boozy\",\"Description\":\"Auto Jukebox: Bangers only\",\"url\":\"https://imgur.com/SBeHzPp.png\"}'),
    jsonDecode(
        '{\"mood\":\"Chill\",\"Description\":\"Relax, unwind, enjoy.\",\"url\":\"https://imgur.com/NAW38Mp.png\"}'),
    jsonDecode(
        '{\"mood\":\"Anxious\",\"Description\":\"Calm tracks to relax with\",\"url\":\"https://imgur.com/pPCetLu.png\"}'),
    jsonDecode(
        '{\"mood\":\"Sad\",\"Description\":\"Let \'em flow\",\"url\":\"https://imgur.com/r5ic93s.png\"}'),
    jsonDecode(
        '{\"mood\":\"Sleepy\",\"Description\":\"Better make this one longer...\",\"url\":\"https://imgur.com/RFNdgSU.png\"}'),
    jsonDecode(
        '{\"mood\":\"Angry\",\"Description\":\"For those pillow screaming moments\",\"url\":\"https://imgur.com/l5u4Fh7.png\"}'),
    jsonDecode(
        '{\"mood\":\"Silly\",\"Description\":\"For when no one\'s looking\",\"url\":\"https://imgur.com/aPKiSID.png\"}'),
    jsonDecode(
        '{\"mood\":\"Smart\",\"Description\":\"Only the Classics, my dear Watson\",\"url\":\"https://imgur.com/IdHhcdY.png\"}'),
    jsonDecode(
        '{\"mood\":\"Depressed\",\"Description\":\"Lowkey Jams for lowkey Fams \",\"url\":\"https://imgur.com/ziv3jg1.png\"}')
  ];
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
    moods.add(value);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  void removeFromMoods(dynamic value) {
    moods.remove(value);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromMoods(int index) {
    moods.removeAt(index);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  void updateMoodsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    moods[index] = updateFn(_moods[index]);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInMoods(int index, dynamic value) {
    moods.insert(index, value);
    secureStorage.setStringList(
        'ff_moods', _moods.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _moodDescription = [];
  List<dynamic> get moodDescription => _moodDescription;
  set moodDescription(List<dynamic> value) {
    _moodDescription = value;
  }

  void addToMoodDescription(dynamic value) {
    moodDescription.add(value);
  }

  void removeFromMoodDescription(dynamic value) {
    moodDescription.remove(value);
  }

  void removeAtIndexFromMoodDescription(int index) {
    moodDescription.removeAt(index);
  }

  void updateMoodDescriptionAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    moodDescription[index] = updateFn(_moodDescription[index]);
  }

  void insertAtIndexInMoodDescription(int index, dynamic value) {
    moodDescription.insert(index, value);
  }

  List<dynamic> _moodUrl = [];
  List<dynamic> get moodUrl => _moodUrl;
  set moodUrl(List<dynamic> value) {
    _moodUrl = value;
  }

  void addToMoodUrl(dynamic value) {
    moodUrl.add(value);
  }

  void removeFromMoodUrl(dynamic value) {
    moodUrl.remove(value);
  }

  void removeAtIndexFromMoodUrl(int index) {
    moodUrl.removeAt(index);
  }

  void updateMoodUrlAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    moodUrl[index] = updateFn(_moodUrl[index]);
  }

  void insertAtIndexInMoodUrl(int index, dynamic value) {
    moodUrl.insert(index, value);
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
    places.add(value);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPlaces(dynamic value) {
    places.remove(value);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPlaces(int index) {
    places.removeAt(index);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  void updatePlacesAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    places[index] = updateFn(_places[index]);
    secureStorage.setStringList(
        'ff_places', _places.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPlaces(int index, dynamic value) {
    places.insert(index, value);
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

  Color _accentColor = const Color(0xffe61c5d);
  Color get accentColor => _accentColor;
  set accentColor(Color value) {
    _accentColor = value;
    secureStorage.setInt('ff_accentColor', value.value);
  }

  void deleteAccentColor() {
    secureStorage.delete(key: 'ff_accentColor');
  }

  bool _godmode = false;
  bool get godmode => _godmode;
  set godmode(bool value) {
    _godmode = value;
  }

  String _defaultPlaylistLength = '';
  String get defaultPlaylistLength => _defaultPlaylistLength;
  set defaultPlaylistLength(String value) {
    _defaultPlaylistLength = value;
  }

  double _comfortZone = 0.0;
  double get comfortZone => _comfortZone;
  set comfortZone(double value) {
    _comfortZone = value;
    secureStorage.setDouble('ff_comfortZone', value);
  }

  void deleteComfortZone() {
    secureStorage.delete(key: 'ff_comfortZone');
  }

  List<dynamic> _genrePreferences = [];
  List<dynamic> get genrePreferences => _genrePreferences;
  set genrePreferences(List<dynamic> value) {
    _genrePreferences = value;
    secureStorage.setStringList(
        'ff_genrePreferences', value.map((x) => jsonEncode(x)).toList());
  }

  void deleteGenrePreferences() {
    secureStorage.delete(key: 'ff_genrePreferences');
  }

  void addToGenrePreferences(dynamic value) {
    genrePreferences.add(value);
    secureStorage.setStringList('ff_genrePreferences',
        _genrePreferences.map((x) => jsonEncode(x)).toList());
  }

  void removeFromGenrePreferences(dynamic value) {
    genrePreferences.remove(value);
    secureStorage.setStringList('ff_genrePreferences',
        _genrePreferences.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromGenrePreferences(int index) {
    genrePreferences.removeAt(index);
    secureStorage.setStringList('ff_genrePreferences',
        _genrePreferences.map((x) => jsonEncode(x)).toList());
  }

  void updateGenrePreferencesAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    genrePreferences[index] = updateFn(_genrePreferences[index]);
    secureStorage.setStringList('ff_genrePreferences',
        _genrePreferences.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInGenrePreferences(int index, dynamic value) {
    genrePreferences.insert(index, value);
    secureStorage.setStringList('ff_genrePreferences',
        _genrePreferences.map((x) => jsonEncode(x)).toList());
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

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
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
