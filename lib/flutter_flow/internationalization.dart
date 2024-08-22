import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'fr', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? frText = '',
    String? esText = '',
  }) =>
      [enText, frText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // spotify
  {
    'cdjfp883': {
      'en': 'Discover Music \nwith AI',
      'es': '',
      'fr': 'Redécouvrir\nMusique',
    },
    'bsuits9i': {
      'en': 'Capture the sound of every moment. ',
      'es': '',
      'fr': 'Pour chaque beau moment, il y a une chanson.',
    },
    'ecshglqc': {
      'en': 'Soundtrack  \nyour life',
      'es': '',
      'fr': 'Mettez en musique votre vie',
    },
    'fqkm6bke': {
      'en': 'Add color to those greyscale moments',
      'es': '',
      'fr': 'Une playlist pour chaque instant, organisée par l\'IA.',
    },
    'oiabmdab': {
      'en': 'Personalized Music Discovery',
      'es': '',
      'fr': 'Découverte musicale personnalisée',
    },
    'mdc439nc': {
      'en': 'Your music. Your way. All day. ',
      'es': '',
      'fr':
          'Jouez sur des morceaux inédits qui correspondent totalement à votre ambiance !',
    },
    '1tezfutg': {
      'en': 'Select your preferred Music App',
      'es': '',
      'fr': '',
    },
    '9ms40imp': {
      'en': ' Listen on',
      'es': '',
      'fr': '',
    },
    'ebdyeqtz': {
      'en': 'TIDAL',
      'es': '',
      'fr': '',
    },
    'm69xs079': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // login
  {
    's8iqd11t': {
      'en': 'Snaplist',
      'es': '',
      'fr': '',
    },
    't0gj8kx2': {
      'en': 'Signup',
      'es': '',
      'fr': '',
    },
    'ykcm3egh': {
      'en': 'Email',
      'es': '',
      'fr': 'E-mail',
    },
    'bzz2dr8w': {
      'en': 'Password',
      'es': '',
      'fr': 'Mot de passe',
    },
    '43mwn9va': {
      'en': 'By signing up, you agree to Snaplist’s',
      'es': '',
      'fr': '',
    },
    'jpwx6kky': {
      'en': 'Terms',
      'es': '',
      'fr': '',
    },
    'lcphgp7l': {
      'en': 'and',
      'es': '',
      'fr': '',
    },
    '83t1o2gz': {
      'en': 'Privacy Policy',
      'es': '',
      'fr': '',
    },
    'oy7yglec': {
      'en': 'Sign Up',
      'es': '',
      'fr': 'S\'inscrire',
    },
    '9p2dodqe': {
      'en': 'Log In',
      'es': '',
      'fr': 'Se connecter',
    },
    'ncsyfapz': {
      'en': 'Forgot Password?',
      'es': '',
      'fr': 'Mot de passe oublié',
    },
    'zs17z8k6': {
      'en': 'Or, you can...',
      'es': '',
      'fr': 'Ou inscrivez-vous avec :',
    },
    'y3pv86ts': {
      'en': 'Log In',
      'es': '',
      'fr': '',
    },
    '66p2v299': {
      'en': 'Email',
      'es': '',
      'fr': 'E-mail',
    },
    'n722hfz0': {
      'en': 'Password',
      'es': '',
      'fr': 'Mot de passe',
    },
    'ekyw9wtq': {
      'en': 'By logging in, you agree to Snaplist’s',
      'es': '',
      'fr': '',
    },
    '0phtnb9i': {
      'en': 'Terms',
      'es': '',
      'fr': '',
    },
    'xjl72or8': {
      'en': 'and',
      'es': '',
      'fr': '',
    },
    '9s71a210': {
      'en': 'Privacy Policy',
      'es': '',
      'fr': '',
    },
    'qof2v5ht': {
      'en': 'Sign Up',
      'es': '',
      'fr': 'S\'inscrire',
    },
    'f3yc03ib': {
      'en': 'Log In',
      'es': '',
      'fr': 'Se connecter',
    },
    'm5x4mmb0': {
      'en': 'Forgot Password?',
      'es': '',
      'fr': 'Mot de passe oublié',
    },
    'ye287grq': {
      'en': 'Or, you can...',
      'es': '',
      'fr': 'Ou inscrivez-vous avec :',
    },
    'nxcwi81h': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // forgot
  {
    'm0e9fa7m': {
      'en': 'Back',
      'es': '',
      'fr': 'Retour',
    },
    'nejbxws5': {
      'en': 'Back',
      'es': '',
      'fr': 'Retour',
    },
    'alms53de': {
      'en': 'Forgot Password',
      'es': '',
      'fr': 'Mot de passe oublié',
    },
    '8jtjjl17': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'es': '',
      'fr':
          'Nous vous enverrons un e-mail avec un lien pour réinitialiser votre mot de passe, veuillez saisir l\'e-mail associé à votre compte ci-dessous.',
    },
    'idnkar54': {
      'en': 'Your email address...',
      'es': '',
      'fr': 'Votre adresse e-mail...',
    },
    'vxe2bu97': {
      'en': 'Enter your email...',
      'es': '',
      'fr': 'Entrer votre Email...',
    },
    '8nozurhg': {
      'en': 'Send Link',
      'es': '',
      'fr': 'Envoyer un lien',
    },
    'gy8axsje': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // onboarding
  {
    'kevxpuqx': {
      'en': 'Discover Music \nwith AI',
      'es': '',
      'fr': 'Redécouvrir\nMusique',
    },
    'cwncw0km': {
      'en': 'Start listening to unique playlists, custom made just for you. ',
      'es': '',
      'fr': 'Pour chaque beau moment, il y a une chanson.',
    },
    'jyq635mi': {
      'en': 'Soundtrack  \nyour life',
      'es': '',
      'fr': 'Mettez en musique votre vie',
    },
    '8u1vv5yv': {
      'en': 'Add color to those greyscale moments',
      'es': '',
      'fr': 'Une playlist pour chaque instant, organisée par l\'IA.',
    },
    'pm0fgtc7': {
      'en': 'Personalized Music Discovery',
      'es': '',
      'fr': 'Découverte musicale personnalisée',
    },
    '43ksomvv': {
      'en': 'Start listening to unique playlists, custom made just for you. ',
      'es': '',
      'fr':
          'Jouez sur des morceaux inédits qui correspondent totalement à votre ambiance !',
    },
    'zgj71rp4': {
      'en': 'Let\'s get snapping!',
      'es': '',
      'fr': 'C\'est parti pour prendre des photos !',
    },
    '5qlwyk8u': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // HomePage
  {
    'h34n2i95': {
      'en': 'Snaplist+',
      'es': '',
      'fr': 'Snaplist',
    },
    '2a958eat': {
      'en': 'Snaplist',
      'es': '',
      'fr': 'Snaplist',
    },
    'v3zt30gf': {
      'en': 'Profile',
      'es': '',
      'fr': 'Profil',
    },
    'mj3cs1s8': {
      'en': 'Themes',
      'es': '',
      'fr': 'Explorer',
    },
    'avja8n0b': {
      'en': 'Settings',
      'es': '',
      'fr': 'Paramètres',
    },
    '5dia9sm9': {
      'en': 'Moods',
      'es': '',
      'fr': '',
    },
    's5nuvh4d': {
      'en': 'Recents',
      'es': '',
      'fr': '',
    },
    '9mruy8zt': {
      'en': 'Nothing here yet 😲 ',
      'es': '',
      'fr': '',
    },
    'py41lyfo': {
      'en': 'Snap a vibe or select a mood to get started!  ',
      'es': '',
      'fr': '',
    },
    'wxj1dj0s': {
      'en': 'Feedback',
      'es': '',
      'fr': 'Retour',
    },
    '17muqkkw': {
      'en': 'Log out',
      'es': '',
      'fr': 'Dégager',
    },
    'f3f7xeag': {
      'en': 'Text',
      'es': '',
      'fr': '',
    },
    'okue7ar8': {
      'en': 'Voice',
      'es': '',
      'fr': '',
    },
    'v5ep4u5m': {
      'en': 'Snap',
      'es': '',
      'fr': '',
    },
    'fjb0ukr3': {
      'en': 'Upload',
      'es': '',
      'fr': '',
    },
    'h3xuk0o1': {
      'en': 'Explore',
      'es': '',
      'fr': '',
    },
    'tzctgcay': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // devz
  {
    'c2mtuk4h': {
      'en': 'Access Token: ',
      'es': '',
      'fr': 'Jeton d\'accès:',
    },
    'kecvy3tz': {
      'en': 'Refresh Token: ',
      'es': '',
      'fr': 'Jeton d\'actualisation :',
    },
    '190ume9j': {
      'en': 'Playlist URL: ',
      'es': '',
      'fr': 'URL de la liste de lecture :',
    },
    't1s7jdvs': {
      'en': 'Playlist URL: ',
      'es': '',
      'fr': 'URL de la liste de lecture :',
    },
    '3rhax3xq': {
      'en': 'test',
      'es': '',
      'fr': 'test',
    },
    'ydl76bh5': {
      'en': 'Username',
      'es': '',
      'fr': 'Nom d\'utilisateur',
    },
    '5hwk7koj': {
      'en': '-',
      'es': '',
      'fr': '-',
    },
    'so0h7kjj': {
      'en': '-',
      'es': '',
      'fr': '-',
    },
    'mq9cydh5': {
      'en': 'Button',
      'es': '',
      'fr': 'Bouton',
    },
    'amcbjt29': {
      'en': '-',
      'es': '',
      'fr': '-',
    },
    '4fcy37vn': {
      'en': '-',
      'es': '',
      'fr': '-',
    },
    'hetaqznp': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // loadingImage
  {
    'xt9s04a6': {
      'en': 'Analyzing Photo',
      'es': '',
      'fr': 'Analyser une photo',
    },
    'bh3wq3vm': {
      'en': 'Thinking about some music you\'ll like ',
      'es': '',
      'fr': 'Je pense à une musique que tu aimeras',
    },
    'a2id7jrh': {
      'en': 'Searching Spotify for some tracks',
      'es': '',
      'fr': 'Recherche de chansons sur Spotify',
    },
    'x1nqshwm': {
      'en': 'Grouping your tracks',
      'es': '',
      'fr': 'Regrouper vos chansons',
    },
    'g8uj0cqy': {
      'en': 'Curating your Snaplist',
      'es': '',
      'fr': 'Organiser votre Snaplist',
    },
    'bj78q3ro': {
      'en': 'hmmmm … let me think….',
      'es': '',
      'fr': 'hmmm… qu\'est-ce qu\'un bon nom et une bonne description ?',
    },
    '836cob3t': {
      'en': 'Wrapping up...',
      'es': '',
      'fr': 'Terminer…',
    },
    'gt46racp': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // loadingMood
  {
    'l3ouy6se': {
      'en': 'Feeling ',
      'es': '',
      'fr': 'Sentiment',
    },
    'r7nfmwkk': {
      'en': ', eh',
      'es': '',
      'fr': ', hein',
    },
    'knkpmsj7': {
      'en': 'oooh this one\'s bumpin\'',
      'es': '',
      'fr': 'oooh celui-là est top',
    },
    'onnfvutj': {
      'en': 'Searching Spotify for some tracks',
      'es': '',
      'fr': 'Recherche de chansons sur Spotify',
    },
    'bnrdcnqh': {
      'en': 'Curating your Snaplist',
      'es': '',
      'fr': 'Organiser votre Snaplist',
    },
    '7161kipw': {
      'en': 'Generating a snappy name',
      'es': '',
      'fr': 'Générer un nom',
    },
    'doag2hx1': {
      'en': 'Wrapping up...',
      'es': '',
      'fr': 'Terminer...',
    },
    'qz531v0l': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // fail
  {
    'l5ikwgls': {
      'en': 'OOPS!',
      'es': '',
      'fr': 'OOPS!',
    },
    'm6a0gff4': {
      'en': 'Something went wrong… Please restart Snaplist to continue. \n',
      'es': '',
      'fr':
          'Quelque chose s\'est mal passé… Veuillez redémarrer Snaplist pour continuer.',
    },
    '7vzhmv5p': {
      'en': 'Error Message: ',
      'es': '',
      'fr': 'Message d\'erreur:',
    },
    'a3bedysi': {
      'en': 'Submit Error',
      'es': '',
      'fr': 'Erreur de soumission',
    },
    'bg7qm1hu': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // loadingInput
  {
    'yrhby82r': {
      'en': 'hmmm let\'s see here...',
      'es': '',
      'fr': 'hmmm, voyons voir ici...',
    },
    '6ixt41xv': {
      'en': 'Thinking about some music you\'ll like ',
      'es': '',
      'fr': 'Je pense à une musique que tu aimeras',
    },
    '2fbbj6ao': {
      'en': 'Searching Spotify for some tracks',
      'es': '',
      'fr': 'Rechercher des chansons sur Spotify',
    },
    'ymcr3to0': {
      'en': 'Curating your Snaplist',
      'es': '',
      'fr': 'Organiser votre Snaplist',
    },
    'rgdl9rz1': {
      'en': 'Generating a snappy name',
      'es': '',
      'fr': 'Générer un nom',
    },
    'tte82xbv': {
      'en': 'Wrapping up...',
      'es': '',
      'fr': 'Terminer….',
    },
    '1lslwh80': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // loadingUpload
  {
    'effqgjc6': {
      'en': 'Analyzing your photo',
      'es': '',
      'fr': 'Analyser votre photo',
    },
    'dfb71cki': {
      'en': 'Thinking about some music you\'ll like ',
      'es': '',
      'fr': 'Je pense à une musique que tu aimeras',
    },
    'q7eb9y9n': {
      'en': 'Searching Spotify for some tracks',
      'es': '',
      'fr': 'Rechercher des chansons sur Spotify',
    },
    'mmpfslav': {
      'en': 'Grouping your tracks',
      'es': '',
      'fr': 'Regrouper vos chansons',
    },
    '8dduvi57': {
      'en': 'Curating your Snaplist',
      'es': '',
      'fr': 'Organiser votre Snaplist',
    },
    'c738erf3': {
      'en': 'Generating a snappy name',
      'es': '',
      'fr': 'Générer un nom',
    },
    'uwyzfxgw': {
      'en': 'Wrapping up...',
      'es': '',
      'fr': 'Terminer...',
    },
    '066zio6w': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // loadingVoice
  {
    'dv723umj': {
      'en': 'Listening...',
      'es': '',
      'fr': 'J’écoute...',
    },
    'hrwgh3rs': {
      'en': 'mmmkay I think I\'ve got something...',
      'es': '',
      'fr': 'mmmkay, je pense que j\'ai quelque chose...',
    },
    'onfvbd1m': {
      'en': 'Searching Spotify for some tracks',
      'es': '',
      'fr': 'Rechercher does chansons sur Spotify',
    },
    'ivvnd9kg': {
      'en': 'Searching Spotify for some tracks',
      'es': '',
      'fr': 'Rechercher does chansons sur Spotify',
    },
    'yzi4tlcq': {
      'en': 'Curating your Snaplist',
      'es': '',
      'fr': 'Organiser votre Snaplist',
    },
    '8vdf3u97': {
      'en': 'Generating a snappy name',
      'es': '',
      'fr': 'Générer un nom',
    },
    'skw14fr6': {
      'en': 'Wrapping up...',
      'es': '',
      'fr': 'Terminer...',
    },
    'wnu5jxt3': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // devzCopy
  {
    'ky3n3npp': {
      'en': 'Access Token: ',
      'es': '',
      'fr': 'Jeton d\'accès:',
    },
    '8d4fiob8': {
      'en': 'Refresh Token: ',
      'es': '',
      'fr': 'Jeton d\'actualisation :',
    },
    '4fbpl5j4': {
      'en': 'Playlist URL: ',
      'es': '',
      'fr': 'URL de la liste de lecture :',
    },
    '68rwt6b2': {
      'en': 'Playlist URL: ',
      'es': '',
      'fr': 'URL de la liste de lecture :',
    },
    'hgloppuv': {
      'en': 'test',
      'es': '',
      'fr': 'test',
    },
    '1g2h7ova': {
      'en': 'Username',
      'es': '',
      'fr': 'Nom d\'utilisateur',
    },
    'oipcpf3s': {
      'en': '-',
      'es': '',
      'fr': '-',
    },
    '2ryr5m1h': {
      'en': '-',
      'es': '',
      'fr': '-',
    },
    'rzpvrgsz': {
      'en': 'Button',
      'es': '',
      'fr': 'Bouton',
    },
    'o31z55mm': {
      'en': '-',
      'es': '',
      'fr': '-',
    },
    'wwpabfwm': {
      'en': '-',
      'es': '',
      'fr': '-',
    },
    'c6fhgmup': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // settings
  {
    'g1xihsaq': {
      'en': 'Settings',
      'es': '',
      'fr': 'Paramètres',
    },
    'oq7voatx': {
      'en': 'Your Music',
      'es': '',
      'fr': '',
    },
    'f7uwsilp': {
      'en': 'App Connect',
      'es': '',
      'fr': 'Supprimer le compte',
    },
    'rwv1vkr8': {
      'en': 'Select your preferred music\nstreaming service. ',
      'es': '',
      'fr':
          'Si vous souhaitez supprimer votre compte, veuillez visiter ce lien ↗',
    },
    '62mncfsy': {
      'en': 'Spotify',
      'es': '',
      'fr': '',
    },
    'o0jesudb': {
      'en': 'YouTube Music',
      'es': '',
      'fr': '',
    },
    'r4taif53': {
      'en': 'Apple Music',
      'es': '',
      'fr': '',
    },
    'elfz2aeg': {
      'en': 'Tidal',
      'es': '',
      'fr': '',
    },
    'ry886c01': {
      'en': 'Amazon Music',
      'es': '',
      'fr': '',
    },
    '67n76u4l': {
      'en': 'Apps',
      'es': '',
      'fr': '',
    },
    'dbil8u9c': {
      'en': 'Search for an item...',
      'es': '',
      'fr': '',
    },
    'cs45azzn': {
      'en': 'Snaplist Length',
      'es': '',
      'fr': '',
    },
    'o8wlmdr3': {
      'en': 'Set a default playlist track \nlength. Default  is 10. ',
      'es': '',
      'fr': '',
    },
    '9zc0u8zh': {
      'en': '5',
      'es': '',
      'fr': '',
    },
    'b4mer6y3': {
      'en': '10',
      'es': '',
      'fr': '',
    },
    'wldf2ye2': {
      'en': '15',
      'es': '',
      'fr': '',
    },
    'gldt1jv4': {
      'en': '20',
      'es': '',
      'fr': '',
    },
    'bmrt0vhr': {
      'en': '25',
      'es': '',
      'fr': '',
    },
    'w6ov65ny': {
      'en': '30',
      'es': '',
      'fr': '',
    },
    'dj27ccea': {
      'en': '35',
      'es': '',
      'fr': '',
    },
    'tueiowbv': {
      'en': '40',
      'es': '',
      'fr': '',
    },
    'nxdu9atv': {
      'en': '45',
      'es': '',
      'fr': '',
    },
    'kv28vtx0': {
      'en': '50',
      'es': '',
      'fr': '',
    },
    'd3dnn7j7': {
      'en': 'Playlist Length',
      'es': '',
      'fr': '',
    },
    '9g17jfdj': {
      'en': 'Search for an item...',
      'es': '',
      'fr': '',
    },
    'jv4pjzmf': {
      'en': '10',
      'es': '',
      'fr': '',
    },
    '5s05m97l': {
      'en': 'Your Data',
      'es': '',
      'fr': '',
    },
    'cfd5r2w2': {
      'en': 'Push Notifications',
      'es': '',
      'fr': 'Notifications push',
    },
    '5iidujf5': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'es': '',
      'fr':
          'Recevez des notifications Push de notre application de manière semi-régulière.',
    },
    'ppbn65lx': {
      'en': 'Email Notifications',
      'es': '',
      'fr': 'Notifications par email',
    },
    '8dowd9ak': {
      'en':
          'Receive email notifications from our marketing team about new features.',
      'es': '',
      'fr':
          'Recevez des notifications par e-mail de notre équipe marketing concernant les nouvelles fonctionnalités.',
    },
    'j9xe16op': {
      'en': 'Data Collection',
      'es': '',
      'fr': 'Collecte de données',
    },
    'mcc2iqvn': {
      'en': 'Allow us to collect and store data, per our Privacy Policy  ↗',
      'es': '',
      'fr':
          'Permettez-nous de collecter et de stocker des données, conformément à notre politique de confidentialité ↗',
    },
    'fzqood56': {
      'en': 'Your Account',
      'es': '',
      'fr': '',
    },
    'wuicjfox': {
      'en': 'Downgrade Account 😭',
      'es': '',
      'fr': '',
    },
    'b4el8jag': {
      'en':
          'If you would like to downgrade your account, please visit this link  ↗',
      'es': '',
      'fr': '',
    },
    'miekgma7': {
      'en': 'Upgrade Account 💎',
      'es': '',
      'fr': '',
    },
    'weogzulo': {
      'en':
          'If you would like to upgrade your account to Snaplist+, click here. ↗',
      'es': '',
      'fr': '',
    },
    'bwf78leh': {
      'en': 'Delete Account',
      'es': '',
      'fr': 'Supprimer le compte',
    },
    '2b0pbz2c': {
      'en':
          'If you would like to delete your account, please visit this link. ↗  \n\n**Note that account deletion automatically triggers data deletion withion 90 days ',
      'es': '',
      'fr': '',
    },
    'uonjlwrj': {
      'en': 'Save Changes',
      'es': '',
      'fr': '',
    },
    'mma6peny': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // themes
  {
    'kwklew3q': {
      'en': 'Themes',
      'es': '',
      'fr': 'Paramètres',
    },
    'pytxaprf': {
      'en': 'Dark/Light Mode',
      'es': '',
      'fr': '',
    },
    '3wfnw2rd': {
      'en': 'Snaplist was designed for use with Dark Mode',
      'es': '',
      'fr': '',
    },
    'o2oxrpea': {
      'en': 'Accent Color',
      'es': '',
      'fr': '',
    },
    'yb5d56b1': {
      'en': 'If you really hate our colors that much...',
      'es': '',
      'fr': '',
    },
    'k3xkkifg': {
      'en': 'Reset',
      'es': '',
      'fr': '',
    },
    '2s3qqr5u': {
      'en': 'Save Changes',
      'es': '',
      'fr': 'Sauvegarder les modifications',
    },
    '2zkef8vi': {
      'en': 'Home',
      'es': '',
      'fr': 'Maison',
    },
  },
  // feedbackModal
  {
    '3rtxmphj': {
      'en': 'Thanks for your Feedback! 😃',
      'es': '',
      'fr': 'Merci pour vos commentaires! 😃',
    },
    'zr0fm1db': {
      'en': '~ The Dev Team',
      'es': '',
      'fr': '~ L\'équipe de développement',
    },
  },
  // inputModal
  {
    'ma5l4iaj': {
      'en': 'Describe\nyour vibe',
      'es': '',
      'fr': '',
    },
    'rsve2g3d': {
      'en': 'Beach day, Road trip, Party…',
      'es': '',
      'fr': '',
    },
    '65ykvap9': {
      'en': 'Inspired by',
      'es': '',
      'fr': '',
    },
    '03n4ryjr': {
      'en': 'Beyoncé, Queen, Drake…',
      'es': '',
      'fr': '',
    },
    'uipezycc': {
      'en': 'Cancel',
      'es': '',
      'fr': '',
    },
    'yala83uc': {
      'en': 'Submit',
      'es': '',
      'fr': '',
    },
  },
  // voiceModal
  {
    'cpzpx5l2': {
      'en': '“Leg Day at the Gym  with Beyoncé 💪🏽💪🏽”',
      'es': '',
      'fr': '',
    },
    's5860ev8': {
      'en': '“Smooth Jazz with Miles Davis 🎺\"',
      'es': '',
      'fr': '',
    },
    'c8hj1xnr': {
      'en': 'Getting ready for a hot date 💋',
      'es': '',
      'fr': '',
    },
    '1rt36q2f': {
      'en': '“Nature sounds for sleeping 💤”',
      'es': '',
      'fr': '',
    },
    'vs47pkhv': {
      'en': 'Tap to Submit',
      'es': '',
      'fr': '',
    },
  },
  // Checkout
  {
    'dosdvvwr': {
      'en': 'Upgrade to',
      'es': '',
      'fr': 'Récapitulatif de la commande',
    },
    'b77u28rq': {
      'en': 'Snaplist +',
      'es': '',
      'fr': '',
    },
    'uyv81syp': {
      'en': 'Review your order below before checking out.',
      'es': '',
      'fr': 'Vérifiez votre commande ci-dessous avant de procéder au paiement.',
    },
    '84zlgc1o': {
      'en': 'Snaplist Premium',
      'es': '',
      'fr': 'Snaplist Premium',
    },
    'dlfxxrgv': {
      'en': 'Save 20%',
      'es': '',
      'fr': 'Économisez 20 %',
    },
    'bd142c4k': {
      'en': 'With an annual plan',
      'es': '',
      'fr': 'Avec un forfait annuel',
    },
    'eztryfqg': {
      'en': 'Price Breakdown',
      'es': '',
      'fr': 'Répartition des prix',
    },
    'ceg7lfc8': {
      'en': 'Base Price',
      'es': '',
      'fr': 'Prix ​​de base',
    },
    'w0p46tog': {
      'en': 'Annual Discount',
      'es': '',
      'fr': 'Remise annuelle',
    },
    'iuxrwm9t': {
      'en': 'Taxes',
      'es': '',
      'fr': 'Impôts',
    },
    '48wz2fb3': {
      'en': 'Total',
      'es': '',
      'fr': 'Total',
    },
    'ncykyxew': {
      'en': 'Proceed to Checkout',
      'es': '',
      'fr': 'Passer à la caisse',
    },
  },
  // congrats
  {
    'egbem50d': {
      'en': 'Congratulations!',
      'es': '',
      'fr': '',
    },
    '9xo4v3ew': {
      'en': 'Thank you for upgrading\nto Snaplist+ 🤑',
      'es': '',
      'fr': '',
    },
    '4ybtnlbj': {
      'en': 'Let\'s get Jammin\'',
      'es': '',
      'fr': '',
    },
  },
  // nonGrats
  {
    'asi2l03j': {
      'en': 'oh nooooooo!',
      'es': '',
      'fr': '',
    },
    'v4g9z4or': {
      'en':
          'We\'re devastated to see you go, and hope we\'ll get back together again soon. Real Soon. Like Now-ish please.',
      'es': '',
      'fr': '',
    },
    '6rcp71rn': {
      'en': 'Close',
      'es': '',
      'fr': '',
    },
  },
  // voiceModalCopy
  {
    'pu14wkqh': {
      'en': 'Godmode Portal',
      'es': '',
      'fr': '',
    },
    '9ws971ff': {
      'en': 'STATUS:',
      'es': '',
      'fr': '',
    },
    '0v3imf0e': {
      'en': '  ACTIVE',
      'es': '',
      'fr': '',
    },
    'es1tly3e': {
      'en': '  INACTIVE',
      'es': '',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    'sqfdaroh': {
      'en':
          'In order to generate a Snaplist, access to the camera is required by Snaplist to capture a photo',
      'es': '',
      'fr':
          'Afin de générer une Snaplist, l\'accès à l\'appareil photo est requis par Snaplist pour capturer une photo',
    },
    '7wub39s6': {
      'en': 'In order to upload data,  Snaplist needs access to your gallery',
      'es': '',
      'fr':
          'Afin de télécharger des données, Snaplist doit accéder à votre galerie',
    },
    'dalyo47d': {
      'en':
          'Snaplist requires permission to use the microphone to  record your voice for playlist generation',
      'es': '',
      'fr':
          'Snaplist nécessite l\'autorisation d\'utiliser le microphone pour enregistrer votre voix pour la génération de playlists',
    },
    'yai6hbo8': {
      'en':
          'Snaplist requires permission in order to send you notifications about promotions and updates',
      'es': '',
      'fr':
          'Snaplist nécessite une autorisation pour vous envoyer des notifications sur les promotions et les mises à jour',
    },
    'njerxsvh': {
      'en': 'Fauled to authenticate. Are you sus? ',
      'es': '',
      'fr': 'Échec de l\'authentification. Etes-vous Sus ?',
    },
    'g3q066ki': {
      'en': 'Password reset email has been sent! :) ',
      'es': '',
      'fr': 'L\'e-mail de réinitialisation du mot de passe a été envoyé ! :)',
    },
    'ql7wobav': {
      'en': 'Email is required!',
      'es': '',
      'fr': 'L\'e-mail est requis !',
    },
    'pjdm0u1m': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'h1qv1orn': {
      'en': 'Passwords do not match!',
      'es': '',
      'fr': 'Les mots de passe ne correspondent pas!',
    },
    'trqb084t': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '0eeeollk': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'rxrdj1wj': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'cohlcvbw': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'odnxxgor': {
      'en': 'Email is already in use. Reset your password, my G',
      'es': '',
      'fr': 'Cet email est déjà utilisé. Réinitialise ton mot de passe, mon G',
    },
    'izi08ih0': {
      'en': 'Invalid uesername or password',
      'es': '',
      'fr': 'Nom d\'utilisateur ou mot de passe invalide',
    },
    'gn2jqosq': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'w4on0rx6': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '0setja21': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'gw2cpism': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'nic8j9nh': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'rkhtd8g8': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'r983a5v2': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'lf5lhwtt': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'j8hn66x9': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '80f1h3ev': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'bl965mof': {
      'en': '',
      'es': '',
      'fr': '',
    },
    'uhykgt2t': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '0yd6rc55': {
      'en': '',
      'es': '',
      'fr': '',
    },
    '04t2v9x9': {
      'en': '',
      'es': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
