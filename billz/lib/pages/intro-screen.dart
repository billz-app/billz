import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  void prompt(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontFamily: 'Cera Pro')),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkPermission() async {
    // Check if location permission is granted
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      // Request location permission
      var result = await Permission.camera.request();
      if (result.isGranted) {
        // Permission granted
        prompt('Location permission granted');
        Navigator.pushNamed(context, '/home');
      } else {
        // Permission denied
        prompt('Location permission denied');
      }
    } else {
      // Permission already granted
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: GestureDetector(
        onTap: _checkPermission,
        child: Text('click'),
      ),
    );
  }
}
