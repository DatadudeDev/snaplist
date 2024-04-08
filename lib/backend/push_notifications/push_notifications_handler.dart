import 'dart:async';

import 'serialization_util.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({super.key, required this.child});

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          child: Center(
            child: Image.asset(
              'assets/images/IMG_0258.gif',
              width: 200.0,
              fit: BoxFit.cover,
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => const ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'spotify': ParameterData.none(),
  'login': ParameterData.none(),
  'forgot': ParameterData.none(),
  'onboarding': (data) async => ParameterData(
        allParams: {
          'code': getParameter<String>(data, 'code'),
        },
      ),
  'HomePage': (data) async => ParameterData(
        allParams: {
          'mood': getParameter<String>(data, 'mood'),
          'upgraded': getParameter<bool>(data, 'upgraded'),
        },
      ),
  'devz': (data) async => ParameterData(
        allParams: {
          'playlistUrl': getParameter<String>(data, 'playlistUrl'),
        },
      ),
  'loadingImage': (data) async => ParameterData(
        allParams: {
          'imageUrl': getParameter<String>(data, 'imageUrl'),
        },
      ),
  'loadingMood': (data) async => ParameterData(
        allParams: {
          'mood': getParameter<String>(data, 'mood'),
        },
      ),
  'fail': (data) async => ParameterData(
        allParams: {
          'failReason': getParameter<String>(data, 'failReason'),
          'contextUri': getParameter<String>(data, 'contextUri'),
          'raw': getParameter<String>(data, 'raw'),
        },
      ),
  'loadingInput': (data) async => ParameterData(
        allParams: {
          'input': getParameter<String>(data, 'input'),
        },
      ),
  'loadingUpload': (data) async => ParameterData(
        allParams: {
          'url': getParameter<String>(data, 'url'),
        },
      ),
  'loadingVoice': (data) async => ParameterData(
        allParams: {
          'url': getParameter<String>(data, 'url'),
        },
      ),
  'devzCopy': (data) async => ParameterData(
        allParams: {
          'playlistUrl': getParameter<String>(data, 'playlistUrl'),
        },
      ),
  'settings': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
