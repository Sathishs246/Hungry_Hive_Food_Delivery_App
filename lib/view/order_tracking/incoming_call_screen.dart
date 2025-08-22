import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class IncomingCallScreen extends StatefulWidget {
  const IncomingCallScreen({super.key});

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playRingtone();
  }

  Future<void> _playRingtone() async {
    await _audioPlayer.play(AssetSource('sounds/iphone_ring.mp4'), volume: 100);
  }

  @override
  void dispose() {
    _audioPlayer.stop(); // Stop ringtone when screen closes
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/images/delivery_boy.png", // Use any photo
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Delivery Boy',
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                ),
                const SizedBox(height: 8),
                const Text(
                  '+91 98765 43210',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("assets/images/delivery_boy.png"),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _bottomButton(Icons.access_time, "Remind Me", Colors.white),
                    _bottomButton(Icons.message, "Message", Colors.white),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _actionButton(Icons.call_end, "Decline", Colors.red, () {
                      _audioPlayer.stop();
                      Navigator.of(context).pop(); // Dismiss screen
                    }),
                    _actionButton(Icons.call, "Accept", Colors.green, () {
                      _audioPlayer.stop();
                      Navigator.of(context).pop(); // Accept -> maybe go to chat
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, size: 30, color: color),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }

  Widget _actionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        RawMaterialButton(
          onPressed: onTap,
          shape: const CircleBorder(),
          fillColor: color,
          padding: const EdgeInsets.all(18),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
