/*import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/cloud-platform'],
  );

  Future<auth.AuthClient?> getAuthClient() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      print("⚠️ User canceled sign-in.");
      return null;
    }

    final authHeaders = await googleUser.authHeaders;
    final accessToken = authHeaders['Authorization']?.split(' ').last;

    if (accessToken == null) {
      print("❌ Error: Unable to retrieve access token.");
      return null;
    }

    final credentials = auth.AccessCredentials(
      auth.AccessToken('Bearer', accessToken, DateTime.now().add(Duration(hours: 1))),
      null, // No refresh token needed
      ['https://www.googleapis.com/auth/cloud-platform'],
    );

    final client = auth.authenticatedClient(http.Client(), credentials);

    print("✅ Authentication successful!");
    return client;
  }
}*/
