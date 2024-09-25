

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'forgetpass_model.dart';  // Import your model

class ForgetpassWidget extends StatefulWidget {
  const ForgetpassWidget({Key? key}) : super(key: key);

  @override
  _ForgetpassWidgetState createState() => _ForgetpassWidgetState();
}

class _ForgetpassWidgetState extends State<ForgetpassWidget> {
  late ForgetpassModel model;

  @override
  void initState() {
    super.initState();
    model = ForgetpassModel();
    model.initState(context); // Initialize model
  }

  @override
  void dispose() {
    model.dispose(); // Dispose of model when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: model.emailAddressTextController,
              focusNode: model.emailAddressFocusNode,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email',
              ),
              validator: model.emailAddressTextControllerValidator,
            ),
            SizedBox(height: 20),
            FFButtonWidget(
              onPressed: () async {
                if (model.emailAddressTextController?.text.isEmpty ?? true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter an email address')),
                  );
                  return;
                }

                // Call Firebase function to send password reset email
                await FirebaseAuth.instance.sendPasswordResetEmail(
                  email: model.emailAddressTextController!.text,
                );

                // Show confirmation message to the user
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password reset email sent!')),
                );

                Navigator.pop(context); // Optionally go back to the previous screen
              },
              text: 'Send Reset Link',
              options: FFButtonOptions(
                width: double.infinity,
                height: 50,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
