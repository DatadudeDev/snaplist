import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'fr'];

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
  }) =>
      [enText, frText][languageIndex] ?? '';

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
    '4n8bflm0': {
      'en': 'Rediscover\nMusic',
      'fr': 'Redécouvrir\nMusique',
    },
    'omcr2g1s': {
      'en': 'For every beautiful moment, there\'s a soundtrack.',
      'fr': 'Pour chaque beau moment, il y a une chanson.',
    },
    'ecshglqc': {
      'en': 'Soundtrack  your life',
      'fr': 'Mettez en musique votre vie',
    },
    'fqkm6bke': {
      'en': 'A playlist for every moment,  curated by AI. ',
      'fr': 'Une playlist pour chaque instant, organisée par l\'IA.',
    },
    'g3t72lxv': {
      'en': 'Personalized Music Discovery',
      'fr': 'Découverte musicale personnalisée',
    },
    '9zkxb3yn': {
      'en': 'Jam out to previously unheard tracks that are totally your vibe!',
      'fr':
          'Jouez sur des morceaux inédits qui correspondent totalement à votre ambiance !',
    },
    '5542kelh': {
      'en': 'Connect with Spotify',
      'fr': 'Connectez-vous avec Spotify',
    },
    'm69xs079': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // login
  {
    't0gj8kx2': {
      'en': 'Signup',
      'fr': '',
    },
    'ykcm3egh': {
      'en': 'Email',
      'fr': 'E-mail',
    },
    'bzz2dr8w': {
      'en': 'Password',
      'fr': 'Mot de passe',
    },
    '43mwn9va': {
      'en': 'By signing up, you agree to Snaplist’s',
      'fr': '',
    },
    'jpwx6kky': {
      'en': 'Terms',
      'fr': '',
    },
    'lcphgp7l': {
      'en': 'and',
      'fr': '',
    },
    '83t1o2gz': {
      'en': 'Privacy Policy',
      'fr': '',
    },
    'oy7yglec': {
      'en': 'Sign Up',
      'fr': 'S\'inscrire',
    },
    '9p2dodqe': {
      'en': 'Log In',
      'fr': 'Se connecter',
    },
    'ncsyfapz': {
      'en': 'Forgot Password',
      'fr': 'Mot de passe oublié',
    },
    'zs17z8k6': {
      'en': 'Or Sign up with: ',
      'fr': 'Ou inscrivez-vous avec :',
    },
    'hk8yodjp': {
      'en': ' Listen on',
      'fr': '',
    },
    '9mwtdkqb': {
      'en': 'TIDAL',
      'fr': '',
    },
    'y3pv86ts': {
      'en': 'Log In',
      'fr': '',
    },
    '66p2v299': {
      'en': 'Email',
      'fr': 'E-mail',
    },
    'n722hfz0': {
      'en': 'Password',
      'fr': 'Mot de passe',
    },
    'ekyw9wtq': {
      'en': 'By logging in, you agree to Snaplist’s',
      'fr': '',
    },
    '0phtnb9i': {
      'en': 'Terms',
      'fr': '',
    },
    'xjl72or8': {
      'en': 'and',
      'fr': '',
    },
    '9s71a210': {
      'en': 'Privacy Policy',
      'fr': '',
    },
    '81bsa10n': {
      'en': 'Log In',
      'fr': 'Se connecter',
    },
    'm5x4mmb0': {
      'en': 'Forgot Password',
      'fr': 'Mot de passe oublié',
    },
    'mz27k56k': {
      'en': 'Or log in with: ',
      'fr': 'Ou inscrivez-vous avec :',
    },
    'uuiguxud': {
      'en': ' Listen on',
      'fr': '',
    },
    'rw08sty2': {
      'en': 'TIDAL',
      'fr': '',
    },
    'nxcwi81h': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // forgot
  {
    'm0e9fa7m': {
      'en': 'Back',
      'fr': 'Retour',
    },
    'nejbxws5': {
      'en': 'Back',
      'fr': 'Retour',
    },
    'alms53de': {
      'en': 'Forgot Password',
      'fr': 'Mot de passe oublié',
    },
    '8jtjjl17': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'fr':
          'Nous vous enverrons un e-mail avec un lien pour réinitialiser votre mot de passe, veuillez saisir l\'e-mail associé à votre compte ci-dessous.',
    },
    'idnkar54': {
      'en': 'Your email address...',
      'fr': 'Votre adresse e-mail...',
    },
    'vxe2bu97': {
      'en': 'Enter your email...',
      'fr': 'Entrer votre Email...',
    },
    '8nozurhg': {
      'en': 'Send Link',
      'fr': 'Envoyer un lien',
    },
    'gy8axsje': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // onboarding
  {
    'kevxpuqx': {
      'en': 'Rediscover\nMusic',
      'fr': 'Redécouvrir\nMusique',
    },
    'cwncw0km': {
      'en': 'For every beautiful moment, there\'s a soundtrack.',
      'fr': 'Pour chaque beau moment, il y a une chanson.',
    },
    'jyq635mi': {
      'en': 'Soundtrack  your life',
      'fr': 'Mettez en musique votre vie',
    },
    '8u1vv5yv': {
      'en': 'A playlist for every moment,  curated by AI. ',
      'fr': 'Une playlist pour chaque instant, organisée par l\'IA.',
    },
    'pm0fgtc7': {
      'en': 'Personalized Music Discovery',
      'fr': 'Découverte musicale personnalisée',
    },
    '43ksomvv': {
      'en': 'Jam out to previously unheard tracks that are totally your vibe!',
      'fr':
          'Jouez sur des morceaux inédits qui correspondent totalement à votre ambiance !',
    },
    'zgj71rp4': {
      'en': 'Let\'s get snapping!',
      'fr': 'C\'est parti pour prendre des photos !',
    },
    '5qlwyk8u': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // HomePage
  {
    'h34n2i95': {
      'en': 'Snaplist+',
      'fr': 'Snaplist',
    },
    '2a958eat': {
      'en': 'Snaplist',
      'fr': 'Snaplist',
    },
    'v3zt30gf': {
      'en': 'Profile',
      'fr': 'Profil',
    },
    'yugs08t2': {
      'en': '(coming soon)',
      'fr': '(à venir)',
    },
    'mj3cs1s8': {
      'en': 'Preferences',
      'fr': 'Explorer',
    },
    'lkk1fqkt': {
      'en': '(coming soon)',
      'fr': '(à venir)',
    },
    'avja8n0b': {
      'en': 'Settings',
      'fr': 'Paramètres',
    },
    'v5dj6jcx': {
      'en': 'Moods',
      'fr': '',
    },
    '4zmkjckh': {
      'en': 'Recents',
      'fr': '',
    },
    '6rn1igup': {
      'en': 'Nothing here yet 😲 ',
      'fr': '',
    },
    'pjku8rtr': {
      'en': 'Snap a vibe or select a mood to get started!  ',
      'fr': '',
    },
    'wxj1dj0s': {
      'en': 'Feedback',
      'fr': 'Retour',
    },
    '17muqkkw': {
      'en': 'Log out',
      'fr': 'Dégager',
    },
    'fv7hvey9': {
      'en': 'Text',
      'fr': '',
    },
    'sbtjsm2p': {
      'en': 'Voice',
      'fr': '',
    },
    'xa85xl3g': {
      'en': 'Snap',
      'fr': '',
    },
    'onapfzje': {
      'en': 'Upload',
      'fr': '',
    },
    'yn3vo78e': {
      'en': 'Explore',
      'fr': '',
    },
    'tzctgcay': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // devz
  {
    'c2mtuk4h': {
      'en': 'Access Token: ',
      'fr': 'Jeton d\'accès:',
    },
    'kecvy3tz': {
      'en': 'Refresh Token: ',
      'fr': 'Jeton d\'actualisation :',
    },
    '190ume9j': {
      'en': 'Playlist URL: ',
      'fr': 'URL de la liste de lecture :',
    },
    't1s7jdvs': {
      'en': 'Playlist URL: ',
      'fr': 'URL de la liste de lecture :',
    },
    '3rhax3xq': {
      'en': 'test',
      'fr': 'test',
    },
    'ydl76bh5': {
      'en': 'Username',
      'fr': 'Nom d\'utilisateur',
    },
    '5hwk7koj': {
      'en': '-',
      'fr': '-',
    },
    'so0h7kjj': {
      'en': '-',
      'fr': '-',
    },
    'mq9cydh5': {
      'en': 'Button',
      'fr': 'Bouton',
    },
    'amcbjt29': {
      'en': '-',
      'fr': '-',
    },
    '4fcy37vn': {
      'en': '-',
      'fr': '-',
    },
    'hetaqznp': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // loadingImage
  {
    'igwbarva': {
      'en': 'Analyzing Photo',
      'fr': 'Analyser une photo',
    },
    'nf85wo1g': {
      'en': 'Thinking about some music you\'ll like ',
      'fr': 'Je pense à une musique que tu aimeras',
    },
    'k3pxewtr': {
      'en': 'Searching Spotify for some tracks',
      'fr': 'Recherche de chansons sur Spotify',
    },
    'n04ja3i8': {
      'en': 'Grouping your tracks',
      'fr': 'Regrouper vos chansons',
    },
    'hz81hvda': {
      'en': 'Curating your Snaplist',
      'fr': 'Organiser votre Snaplist',
    },
    'rgxp6lc8': {
      'en': 'hmmm… what’s a good name and description? ',
      'fr': 'hmmm… qu\'est-ce qu\'un bon nom et une bonne description ?',
    },
    'aszm6cq7': {
      'en': 'Wrapping up...',
      'fr': 'Terminer…',
    },
    'gt46racp': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // loadingMood
  {
    'l3ouy6se': {
      'en': 'Feeling ',
      'fr': 'Sentiment',
    },
    'r7nfmwkk': {
      'en': ', eh',
      'fr': ', hein',
    },
    'knkpmsj7': {
      'en': 'oooh this one\'s bumpin\'',
      'fr': 'oooh celui-là est top',
    },
    'onnfvutj': {
      'en': 'Searching Spotify for some tracks',
      'fr': 'Recherche de chansons sur Spotify',
    },
    'bnrdcnqh': {
      'en': 'Curating your Snaplist',
      'fr': 'Organiser votre Snaplist',
    },
    '7161kipw': {
      'en': 'Generating a snappy name',
      'fr': 'Générer un nom',
    },
    'doag2hx1': {
      'en': 'Wrapping up...',
      'fr': 'Terminer...',
    },
    'qz531v0l': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // fail
  {
    'l5ikwgls': {
      'en': 'OOPS!',
      'fr': 'OOPS!',
    },
    'm6a0gff4': {
      'en': 'Something went wrong… Please restart Snaplist to continue. \n',
      'fr':
          'Quelque chose s\'est mal passé… Veuillez redémarrer Snaplist pour continuer.',
    },
    '7vzhmv5p': {
      'en': 'Error Message: ',
      'fr': 'Message d\'erreur:',
    },
    'a3bedysi': {
      'en': 'Submit Error',
      'fr': 'Erreur de soumission',
    },
    'bg7qm1hu': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // loadingInput
  {
    'yrhby82r': {
      'en': 'hmmm let\'s see here...',
      'fr': 'hmmm, voyons voir ici...',
    },
    '6ixt41xv': {
      'en': 'Thinking about some music you\'ll like ',
      'fr': 'Je pense à une musique que tu aimeras',
    },
    '2fbbj6ao': {
      'en': 'Searching Spotify for some tracks',
      'fr': 'Rechercher des chansons sur Spotify',
    },
    'ymcr3to0': {
      'en': 'Curating your Snaplist',
      'fr': 'Organiser votre Snaplist',
    },
    'rgdl9rz1': {
      'en': 'Generating a snappy name',
      'fr': 'Générer un nom',
    },
    'tte82xbv': {
      'en': 'Wrapping up...',
      'fr': 'Terminer….',
    },
    '1lslwh80': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // loadingUpload
  {
    'effqgjc6': {
      'en': 'Analyzing your photo',
      'fr': 'Analyser votre photo',
    },
    'dfb71cki': {
      'en': 'Thinking about some music you\'ll like ',
      'fr': 'Je pense à une musique que tu aimeras',
    },
    'q7eb9y9n': {
      'en': 'Searching Spotify for some tracks',
      'fr': 'Rechercher des chansons sur Spotify',
    },
    'mmpfslav': {
      'en': 'Grouping your tracks',
      'fr': 'Regrouper vos chansons',
    },
    '8dduvi57': {
      'en': 'Curating your Snaplist',
      'fr': 'Organiser votre Snaplist',
    },
    'c738erf3': {
      'en': 'Generating a snappy name',
      'fr': 'Générer un nom',
    },
    'uwyzfxgw': {
      'en': 'Wrapping up...',
      'fr': 'Terminer...',
    },
    '066zio6w': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // loadingVoice
  {
    'f2tap13x': {
      'en': 'Listening...',
      'fr': 'J’écoute...',
    },
    'nr8px4dd': {
      'en': 'mmmkay I think I\'ve got something...',
      'fr': 'mmmkay, je pense que j\'ai quelque chose...',
    },
    'dbdy2q5n': {
      'en': 'Searching Spotify for some tracks',
      'fr': 'Rechercher does chansons sur Spotify',
    },
    'hr62k2m2': {
      'en': 'Searching Spotify for some tracks',
      'fr': 'Rechercher does chansons sur Spotify',
    },
    '8o7ouw6l': {
      'en': 'Curating your Snaplist',
      'fr': 'Organiser votre Snaplist',
    },
    'tm6wpkbd': {
      'en': 'Generating a snappy name',
      'fr': 'Générer un nom',
    },
    'yc3f5r4d': {
      'en': 'Wrapping up...',
      'fr': 'Terminer...',
    },
    'wnu5jxt3': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // devzCopy
  {
    'ky3n3npp': {
      'en': 'Access Token: ',
      'fr': 'Jeton d\'accès:',
    },
    '8d4fiob8': {
      'en': 'Refresh Token: ',
      'fr': 'Jeton d\'actualisation :',
    },
    '4fbpl5j4': {
      'en': 'Playlist URL: ',
      'fr': 'URL de la liste de lecture :',
    },
    '68rwt6b2': {
      'en': 'Playlist URL: ',
      'fr': 'URL de la liste de lecture :',
    },
    'hgloppuv': {
      'en': 'test',
      'fr': 'test',
    },
    '1g2h7ova': {
      'en': 'Username',
      'fr': 'Nom d\'utilisateur',
    },
    'oipcpf3s': {
      'en': '-',
      'fr': '-',
    },
    '2ryr5m1h': {
      'en': '-',
      'fr': '-',
    },
    'rzpvrgsz': {
      'en': 'Button',
      'fr': 'Bouton',
    },
    'o31z55mm': {
      'en': '-',
      'fr': '-',
    },
    'wwpabfwm': {
      'en': '-',
      'fr': '-',
    },
    'c6fhgmup': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // settings
  {
    'g1xihsaq': {
      'en': 'Settings',
      'fr': 'Paramètres',
    },
    'e7vwv7ka': {
      'en': 'Select your account and notification preferences below: ',
      'fr':
          'Sélectionnez votre compte et vos préférences de notification ci-dessous :',
    },
    'f7uwsilp': {
      'en': 'App Connect',
      'fr': 'Supprimer le compte',
    },
    'rwv1vkr8': {
      'en': 'Select your preferred music app',
      'fr':
          'Si vous souhaitez supprimer votre compte, veuillez visiter ce lien ↗',
    },
    '62mncfsy': {
      'en': 'Spotify',
      'fr': '',
    },
    'o0jesudb': {
      'en': 'YouTube Music',
      'fr': '',
    },
    'r4taif53': {
      'en': 'Apple Music',
      'fr': '',
    },
    'elfz2aeg': {
      'en': 'Tidal',
      'fr': '',
    },
    'ry886c01': {
      'en': 'Amazon Music',
      'fr': '',
    },
    '67n76u4l': {
      'en': 'Apps',
      'fr': '',
    },
    'dbil8u9c': {
      'en': 'Search for an item...',
      'fr': '',
    },
    'cfd5r2w2': {
      'en': 'Push Notifications',
      'fr': 'Notifications push',
    },
    '5iidujf5': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'fr':
          'Recevez des notifications Push de notre application de manière semi-régulière.',
    },
    'ppbn65lx': {
      'en': 'Email Notifications',
      'fr': 'Notifications par email',
    },
    '8dowd9ak': {
      'en':
          'Receive email notifications from our marketing team about new features.',
      'fr':
          'Recevez des notifications par e-mail de notre équipe marketing concernant les nouvelles fonctionnalités.',
    },
    'j9xe16op': {
      'en': 'Data Collection',
      'fr': 'Collecte de données',
    },
    'mcc2iqvn': {
      'en': 'Allow us to collect and store data, per our Privacy Policy  ↗',
      'fr':
          'Permettez-nous de collecter et de stocker des données, conformément à notre politique de confidentialité ↗',
    },
    '2nqjyneu': {
      'en': 'Downgrade Account 😭',
      'fr': 'Rétrograder le compte',
    },
    'piy7lm9a': {
      'en':
          'If you would like to downgrade your account, please visit this link  ↗',
      'fr':
          'Si vous souhaitez rétrograder votre compte, veuillez visiter ce lien ↗',
    },
    'u7kb2xxc': {
      'en': 'Upgrade Account 💎',
      'fr': 'Rétrograder le compte',
    },
    'vxlbn3m6': {
      'en':
          'If you would like to upgrade your account to Snaplist+, click here. ↗',
      'fr':
          'Si vous souhaitez rétrograder votre compte, veuillez visiter ce lien ↗',
    },
    'bwf78leh': {
      'en': 'Delete Account',
      'fr': 'Supprimer le compte',
    },
    'sfzmns3r': {
      'en':
          'If you would like to delete your account, please visit this link  ↗',
      'fr':
          'Si vous souhaitez supprimer votre compte, veuillez visiter ce lien ↗',
    },
    'rwe9odea': {
      'en': 'Save Changes',
      'fr': 'Sauvegarder les modifications',
    },
    'mma6peny': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // feedbackModal
  {
    '3rtxmphj': {
      'en': 'Thanks for your Feedback! 😃',
      'fr': 'Merci pour vos commentaires! 😃',
    },
    'zr0fm1db': {
      'en': '~ The Dev Team',
      'fr': '~ L\'équipe de développement',
    },
  },
  // inputModal
  {
    'ma5l4iaj': {
      'en': 'Describe\nyour vibe',
      'fr': '',
    },
    'rsve2g3d': {
      'en': 'Beach day, Road trip, Party…',
      'fr': '',
    },
    '65ykvap9': {
      'en': 'Inspired by',
      'fr': '',
    },
    '03n4ryjr': {
      'en': 'Beyoncé, Queen, Drake…',
      'fr': '',
    },
    'uipezycc': {
      'en': 'Cancel',
      'fr': '',
    },
    'yala83uc': {
      'en': 'Submit',
      'fr': '',
    },
  },
  // voiceModal
  {
    'ddpcyqmt': {
      'en': '“Gym Leg Day with Beyoncé”',
      'fr': '',
    },
    'lpm53zms': {
      'en': '“Play me some jazz”',
      'fr': '',
    },
    'bp7wqybq': {
      'en': 'Getting ready for a date 💋',
      'fr': '',
    },
    '95eyiwrc': {
      'en': '“Nature sounds for sleeping”',
      'fr': '',
    },
    'mcamtn37': {
      'en': 'Tap to submit',
      'fr': '',
    },
  },
  // Checkout
  {
    'dosdvvwr': {
      'en': 'Order Summary',
      'fr': 'Récapitulatif de la commande',
    },
    'uyv81syp': {
      'en': 'Review your order below before checking out.',
      'fr': 'Vérifiez votre commande ci-dessous avant de procéder au paiement.',
    },
    '84zlgc1o': {
      'en': 'Snaplist Premium',
      'fr': 'Snaplist Premium',
    },
    'dlfxxrgv': {
      'en': 'Save 20%',
      'fr': 'Économisez 20 %',
    },
    'bd142c4k': {
      'en': 'With an annual plan',
      'fr': 'Avec un forfait annuel',
    },
    'eztryfqg': {
      'en': 'Price Breakdown',
      'fr': 'Répartition des prix',
    },
    'ceg7lfc8': {
      'en': 'Base Price',
      'fr': 'Prix ​​de base',
    },
    'w0p46tog': {
      'en': 'Annual Discount',
      'fr': 'Remise annuelle',
    },
    'iuxrwm9t': {
      'en': 'Taxes',
      'fr': 'Impôts',
    },
    '48wz2fb3': {
      'en': 'Total',
      'fr': 'Total',
    },
    'ncykyxew': {
      'en': 'Proceed to Checkout',
      'fr': 'Passer à la caisse',
    },
  },
  // congrats
  {
    'egbem50d': {
      'en': 'Congratulations!',
      'fr': '',
    },
    '9xo4v3ew': {
      'en': 'You have successfully upgraded your account to Snaplist Premium',
      'fr': '',
    },
    '4ybtnlbj': {
      'en': 'Close',
      'fr': '',
    },
  },
  // nonGrats
  {
    'asi2l03j': {
      'en': 'oh nooooooo!',
      'fr': '',
    },
    'v4g9z4or': {
      'en': 'We’ll be here if you change your mind, you bastard. ',
      'fr': '',
    },
    '6rcp71rn': {
      'en': 'Close',
      'fr': '',
    },
  },
  // places
  {
    'i362tvoj': {
      'en': 'Hello World',
      'fr': '',
    },
    'sk37gq54': {
      'en': 'Search',
      'fr': '',
    },
    '58xtg9cz': {
      'en': 'Submit',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    'sqfdaroh': {
      'en':
          'In order to generate a Snaplist, access to the camera is required by Snaplist to capture a photo',
      'fr':
          'Afin de générer une Snaplist, l\'accès à l\'appareil photo est requis par Snaplist pour capturer une photo',
    },
    '7wub39s6': {
      'en': 'In order to upload data,  Snaplist needs access to your gallery',
      'fr':
          'Afin de télécharger des données, Snaplist doit accéder à votre galerie',
    },
    'dalyo47d': {
      'en':
          'Snaplist requires permission to use the microphone to  record your voice for playlist generation',
      'fr':
          'Snaplist nécessite l\'autorisation d\'utiliser le microphone pour enregistrer votre voix pour la génération de playlists',
    },
    'yai6hbo8': {
      'en':
          'Snaplist requires permission in order to send you notifications about promotions and updates',
      'fr':
          'Snaplist nécessite une autorisation pour vous envoyer des notifications sur les promotions et les mises à jour',
    },
    'njerxsvh': {
      'en': 'Fauled to authenticate. Are you sus? ',
      'fr': 'Échec de l\'authentification. Etes-vous Sus ?',
    },
    'g3q066ki': {
      'en': 'Password reset email has been sent! :) ',
      'fr': 'L\'e-mail de réinitialisation du mot de passe a été envoyé ! :)',
    },
    'ql7wobav': {
      'en': 'Email is required!',
      'fr': 'L\'e-mail est requis !',
    },
    'pjdm0u1m': {
      'en': '',
      'fr': '',
    },
    'h1qv1orn': {
      'en': 'Passwords do not match!',
      'fr': 'Les mots de passe ne correspondent pas!',
    },
    'trqb084t': {
      'en': '',
      'fr': '',
    },
    '0eeeollk': {
      'en': '',
      'fr': '',
    },
    'rxrdj1wj': {
      'en': '',
      'fr': '',
    },
    'cohlcvbw': {
      'en': '',
      'fr': '',
    },
    'odnxxgor': {
      'en': 'Email is already in use. Reset your password, my G',
      'fr': 'Cet email est déjà utilisé. Réinitialise ton mot de passe, mon G',
    },
    'izi08ih0': {
      'en': 'Invalid uesername or password',
      'fr': 'Nom d\'utilisateur ou mot de passe invalide',
    },
    'gn2jqosq': {
      'en': '',
      'fr': '',
    },
    'w4on0rx6': {
      'en': '',
      'fr': '',
    },
    '0setja21': {
      'en': '',
      'fr': '',
    },
    'gw2cpism': {
      'en': '',
      'fr': '',
    },
    'nic8j9nh': {
      'en': '',
      'fr': '',
    },
    'rkhtd8g8': {
      'en': '',
      'fr': '',
    },
    'r983a5v2': {
      'en': '',
      'fr': '',
    },
    'lf5lhwtt': {
      'en': '',
      'fr': '',
    },
    'j8hn66x9': {
      'en': '',
      'fr': '',
    },
    '80f1h3ev': {
      'en': '',
      'fr': '',
    },
    'bl965mof': {
      'en': '',
      'fr': '',
    },
    'uhykgt2t': {
      'en': '',
      'fr': '',
    },
    '0yd6rc55': {
      'en': '',
      'fr': '',
    },
    '04t2v9x9': {
      'en': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
