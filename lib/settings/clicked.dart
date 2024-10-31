import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSecurityPage extends StatefulWidget {
  const LoginSecurityPage({super.key});

  @override
  State<LoginSecurityPage> createState() => _LoginSecurityPageState();
}

class _LoginSecurityPageState extends State<LoginSecurityPage> {
  bool _isTicked = true;
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isTicked = prefs.getBool('isTicked') ?? true;
      _isSwitched = prefs.getBool('isSwitched') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isTicked', _isTicked);
    await prefs.setBool('isSwitched', _isSwitched);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFFFFFAf5),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: const Color(0xFFFFFAf5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Login & Security ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF385723),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 450,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Your account details are used to verify your account and remain private.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 18,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color(0xFF385723),
              thickness: 2,
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Username: Username Email: email@email.com                    Password: *********',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                Text(
                  'Edit',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF385723),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Tap to change your password.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Tap to change your email.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Account Activity',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text(
                  'Suspicious Activity Alert',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: _isTicked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isTicked = value!;
                        _saveSettings();
                      });
                    },
                    shape: const CircleBorder(),
                    activeColor: const Color(0xFF385723),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color(0xFF385723),
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Stay Logged In',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: _isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitched = value;
                      _saveSettings();
                    });
                  },
                  activeColor: const Color(0xFF94AB71),
                  activeTrackColor: const Color(0xFFC7D9B5),
                  inactiveThumbColor: const Color(0xFFC7D9B5),
                  inactiveTrackColor: const Color(0xFF94AB71),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Σελίδα για Notifications
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _isPushSwitched = false;
  bool _isMuteSwitched = true;
  bool _isTicked = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPushSwitched = prefs.getBool('isPushSwitched') ?? false;
      _isMuteSwitched = prefs.getBool('isMuteSwitched') ?? true;
      _isTicked = prefs.getBool('isTicked') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPushSwitched', _isPushSwitched);
    await prefs.setBool('isMuteSwitched', _isMuteSwitched);
    await prefs.setBool('isTicked', _isTicked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFFFFFAF5),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFFAF5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF385723),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Push Notifications',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Pause All',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Switch(
                  value: _isPushSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      _isPushSwitched = value;
                      _saveSettings();
                    });
                  },
                  activeColor: const Color(0xFF94AB71),
                  activeTrackColor: const Color(0xFFC7D9B5),
                  inactiveThumbColor: const Color(0xFFC7D9B5),
                  inactiveTrackColor: const Color(0xFF94AB71),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mute State',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Mute Notifications',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Switch(
                  value: _isMuteSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      _isMuteSwitched = value;
                      _saveSettings();
                    });
                  },
                  activeColor: const Color(0xFF94AB71),
                  activeTrackColor: const Color(0xFFC7D9B5),
                  inactiveThumbColor: const Color(0xFFC7D9B5),
                  inactiveTrackColor: const Color(0xFF94AB71),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(
              color: Color(0xFF385723),
              thickness: 2,
            ),
            const SizedBox(height: 20),
            const Text(
              'OTHERS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Notifications through email',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: _isTicked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isTicked = value!;
                        _saveSettings();
                      });
                    },
                    shape: const CircleBorder(),
                    activeColor: const Color(0xFF385723),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Σελίδα για Interest Based-Ads
class InterestBasedAdsPage extends StatefulWidget {
  const InterestBasedAdsPage({super.key});

  @override
  State<InterestBasedAdsPage> createState() => _InterestBasedAdsPageState();
}

class _InterestBasedAdsPageState extends State<InterestBasedAdsPage> {
  bool _isInterestBasedAdsEnabled = false;
  bool _isPersonalizedAdsOptOut = true;
  bool _isAdDataCollectionOptOut = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isInterestBasedAdsEnabled =
          prefs.getBool('isInterestBasedAdsEnabled') ?? false;
      _isPersonalizedAdsOptOut =
          prefs.getBool('isPersonalizedAdsOptOut') ?? true;
      _isAdDataCollectionOptOut =
          prefs.getBool('isAdDataCollectionOptOut') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isInterestBasedAdsEnabled', _isInterestBasedAdsEnabled);
    await prefs.setBool('isPersonalizedAdsOptOut', _isPersonalizedAdsOptOut);
    await prefs.setBool('isAdDataCollectionOptOut', _isAdDataCollectionOptOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFFFFFAF5),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: const Color(0xFFFFFAF5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Interest Based-Ads',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF385723),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Enable Interest - Based Ads',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _isInterestBasedAdsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isInterestBasedAdsEnabled = value;
                        _saveSettings();
                      });
                    },
                    activeColor: const Color(0xFF94AB71),
                    activeTrackColor: const Color(0xFFC7D9B5),
                    inactiveThumbColor: const Color(0xFFC7D9B5),
                    inactiveTrackColor: const Color(0xFF94AB71),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'READALLY offers you choices about receiving interest-based ads from us. You can choose not to receive interest-based ads.',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Opt-out of Personalized Ads',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _isPersonalizedAdsOptOut,
                    onChanged: (bool value) {
                      setState(() {
                        _isPersonalizedAdsOptOut = value;
                        _saveSettings();
                      });
                    },
                    activeColor: const Color(0xFF94AB71),
                    activeTrackColor: const Color(0xFFC7D9B5),
                    inactiveThumbColor: const Color(0xFFC7D9B5),
                    inactiveTrackColor: const Color(0xFF94AB71),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Choose not to receive ads based on your interests.',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Opt-out of Ad Data Collection',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _isAdDataCollectionOptOut,
                    onChanged: (bool value) {
                      setState(() {
                        _isAdDataCollectionOptOut = value;
                        _saveSettings();
                      });
                    },
                    activeColor: const Color(0xFF94AB71),
                    activeTrackColor: const Color(0xFFC7D9B5),
                    inactiveThumbColor: const Color(0xFFC7D9B5),
                    inactiveTrackColor: const Color(0xFF94AB71),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Disable data collection that is used for interest-based advertising',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Learn More',
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 55, 109, 75),
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Add URL in the future
                      print('Learn More tapped');
                    },
                  children: const <TextSpan>[
                    TextSpan(
                      text: ' about how we use your data to show relevant ads.',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Σελίδα για Accessibility
class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  bool _isSwitch1Enabled = false;
  bool _isSwitch2Enabled = true;
  bool _isSwitch5Enabled = false;

  String _zoomState = 'ON';
  String _cursorSize = 'DEFAULT';

  @override
  void initState() {
    super.initState();
    _loadSwitchStates();
  }

  Future<void> _loadSwitchStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSwitch1Enabled = prefs.getBool('switch1') ?? false;
      _isSwitch2Enabled = prefs.getBool('switch2') ?? true;
      _isSwitch5Enabled = prefs.getBool('switch5') ?? false;
      _zoomState = prefs.getString('zoomState') ?? 'ON';
      _cursorSize = prefs.getString('cursorSize') ?? 'DEFAULT';
    });
  }

  Future<void> _saveSwitchState(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    }
  }

  void _toggleZoomState() {
    setState(() {
      _zoomState = _zoomState == 'ON' ? 'OFF' : 'ON';
      _saveSwitchState('zoomState', _zoomState);
    });
  }

  void _cycleCursorSize() {
    setState(() {
      switch (_cursorSize) {
        case 'DEFAULT':
          _cursorSize = '20%';
          break;
        case '20%':
          _cursorSize = '40%';
          break;
        case '40%':
          _cursorSize = '60%';
          break;
        case '60%':
          _cursorSize = '80%';
          break;
        case '80%':
          _cursorSize = '100%';
          break;
        case '100%':
        default:
          _cursorSize = 'DEFAULT';
          break;
      }
      _saveSwitchState('cursorSize', _cursorSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFFFFFAF5),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: const Color(0xFFFFFAF5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Accessibility',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF385723),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'High Contrast',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _isSwitch1Enabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isSwitch1Enabled = value;
                        _saveSwitchState('switch1', value);
                      });
                    },
                    activeColor: const Color(0xFF94AB71),
                    activeTrackColor: const Color(0xFFC7D9B5),
                    inactiveThumbColor: const Color(0xFFC7D9B5),
                    inactiveTrackColor: const Color(0xFF94AB71),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Color(0xFF385723),
                thickness: 2,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Large Text',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _isSwitch2Enabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isSwitch2Enabled = value;
                        _saveSwitchState('switch2', value);
                      });
                    },
                    activeColor: const Color(0xFF94AB71),
                    activeTrackColor: const Color(0xFFC7D9B5),
                    inactiveThumbColor: const Color(0xFFC7D9B5),
                    inactiveTrackColor: const Color(0xFF94AB71),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Color(0xFF385723),
                thickness: 2,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Cursor Size',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _cycleCursorSize,
                    child: Text(
                      _cursorSize,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 122, 125, 123),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Color(0xFF385723),
                thickness: 2,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Zoom',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _toggleZoomState,
                    child: Text(
                      _zoomState,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 122, 125, 123),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Color(0xFF385723),
                thickness: 2,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Dark Theme',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _isSwitch5Enabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isSwitch5Enabled = value;
                        _saveSwitchState('switch5', value);
                      });
                    },
                    activeColor: const Color(0xFF94AB71),
                    activeTrackColor: const Color(0xFFC7D9B5),
                    inactiveThumbColor: const Color(0xFFC7D9B5),
                    inactiveTrackColor: const Color(0xFF94AB71),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}