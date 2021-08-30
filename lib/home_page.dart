import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// margin
Widget marginBottom(double value) {
  return SizedBox(
    height: value,
  );
}

const Color primaryColor = Colors.white;
const Color secondaryColor = Colors.black;

class _BackgroundVideo extends StatefulWidget {
  @override
  _BackgroundVideoState createState() {
    return _BackgroundVideoState();
  }
}

class _BackgroundVideoState extends State<_BackgroundVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        VideoPlayerController.asset('assets/videos/home-background-cropped.mp4')
          ..initialize().then((_) {
            controller.play();
            controller.setLooping(true);
            // Ensure the first frame is shown after the video is initialized
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() {
    return _SignUpFormState();
  }
}

class _SignUpFormState extends State<_SignUpForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,

      child: Column(
        children: <Widget>[
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,

            decoration: const InputDecoration(
              icon: Icon(Icons.person, color: primaryColor),
              labelText: 'Full Name',
              focusColor: primaryColor,
            ),

            cursorColor: primaryColor,
            style: TextStyle(color: primaryColor),
            
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !RegExp(r'^([a-zA-Z]+(| ))*$').hasMatch(value)) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
          
          marginBottom(20),
          
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,

            decoration: const InputDecoration(
              icon: Icon(Icons.mail_outline, color: primaryColor),
              labelText: 'Email',
            ),

            cursorColor: primaryColor,
            style: TextStyle(color: primaryColor),

            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }

              return null;
            },
          ),

          marginBottom(20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },

              child: const Text('Sign me up!'),


              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: secondaryColor,
                textStyle: TextStyle(
                  fontSize: 20
                )
              )
            ),
          ),

          marginBottom(5),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },

              child: const Text('Already signed up? Login.'),

              style: ElevatedButton.styleFrom(
                primary: secondaryColor,
                onPrimary: primaryColor,
                textStyle: TextStyle(
                  fontSize: 20
                )
              )
            ),
          )
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Raleway',
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: const TextStyle(color: primaryColor),

            errorStyle: const TextStyle(color: primaryColor),

            border: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor)),
          )),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            // background video
            _BackgroundVideo(),

            Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                ), // overlay

                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: FractionallySizedBox(
                      widthFactor: .75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FractionallySizedBox(
                            widthFactor: .75,
                            child: Image.asset(
                                'assets/images/ActNowLogoWhite.png'),
                          ),
                          const Text(
                            'EVERY ACT MATTERS',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: primaryColor, fontSize: 20),
                          ),
                          marginBottom(30),
                          const _SignUpForm(),
                        ],
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
