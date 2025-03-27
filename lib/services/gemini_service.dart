import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService(String apiKey)
      : _model = GenerativeModel(
          model: 'gemini-1.5-pro-latest', // Corrected model name
          apiKey: apiKey,
          generationConfig: GenerationConfig(
            temperature: 0.7, // Lowered for more stable responses
            topK: 40,
            topP: 0.9,
            maxOutputTokens: 2048, // Prevents excessive token usage
            responseMimeType: 'text/plain',
          ),
        );

  Future<String> generateResponse(String prompt) async {
    try {
      final chat = _model.startChat(history: []);
      final content = Content.text(prompt);
      final response = await chat.sendMessage(content);
      return response.text ?? "No response from AI.";
    } catch (e) {
      return "Error: ${e.toString()}"; // Improved error handling
    }
  }
}
