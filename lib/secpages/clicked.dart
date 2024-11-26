import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:readally/secpages/edit.dart';

class LoginSecurityPage extends StatefulWidget {
  const LoginSecurityPage({super.key});

  @override
  State<LoginSecurityPage> createState() => _LoginSecurityPageState();
}

class _LoginSecurityPageState extends State<LoginSecurityPage> {
  bool _isTicked = true;
  bool _isSwitched = false;

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
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Login & Security',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF385723),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Your account details are used to verify your account and remain private.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 18,
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
            // Username and Email Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Username: Username\nEmail: email@email.com\nPassword: *********',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the EditProfileScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          currentName: 'Ellie',    // Pass the current profile data
                          currentEmail: 'ellie@email.com',
                          currentBio: 'I am an avid reader, passionate about literature and technology. Enjoying discovering new books every day!',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF385723),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    fontSize: 23,
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
    // Removed shared preferences loading logic
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
    // Removed shared preferences loading logic
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
    // Removed shared preferences loading logic
  }

  void _toggleZoomState() {
    setState(() {
      _zoomState = _zoomState == 'ON' ? 'OFF' : 'ON';
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
