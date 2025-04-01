import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class VertexAIService {
  final String projectId = 'stately-equinox-454916-d9';
  final String endpoint = 'https://us-central1-aiplatform.googleapis.com/v1/projects/your-gcp-project-id/locations/us-central1/publishers/google/models/gemini-pro:predict';

  Future<String> getPrediction(String input) async {
    try {
      // Load service account credentials
      final jsonString = await rootBundle.loadString('assets/keys/vertex_ai_key.json');
      final credentials = json.decode(jsonString);

      // Get access token
      final authToken = await _getAccessToken(credentials);

      // Send AI request
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'instances': [
            {'content': input}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['predictions'][0]['content']; // AI Prediction
      } else {
        return 'Error: ${response.body}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> _getAccessToken(Map credentials) async {
    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': credentials['private_key'], // Authenticate with GCP
      },
    );

    final data = jsonDecode(response.body);
    return data['access_token'];
  }
}
