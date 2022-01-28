import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Dancingscript'
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var textController = TextEditingController();

  @override
  void initState() {
    _retrieveText().then((value) => {
      if (value != null) {
        textController.text = value
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomPaint(
          foregroundPainter: PagePainter(),
          child: SizedBox.expand(
            child: TextField(
              controller: textController,
              onChanged: (value){
                 _saveText(value);
              },
              style: const TextStyle(
                fontSize: 28,
                height: 1.43,
                fontWeight: FontWeight.w700
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width * 0.15),
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }

  void _saveText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("NOTE_KEY", text);
  }

  Future<String?> _retrieveText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("NOTE_KEY");
  }

}

class PagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 1.0;

    for (var x = 0.0; x <= size.height; x = x + 40) {
      canvas.drawLine(Offset(0, x), Offset(size.width, x), paintLine);
    }

    final paintPink = Paint()
      ..color = Colors.pinkAccent
      ..strokeWidth = 2.5;

    canvas.drawLine(Offset(size.width * 0.1, 0), Offset(size.width * 0.1, size.height), paintPink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
