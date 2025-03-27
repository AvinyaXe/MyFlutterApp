import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/services/gemini_service.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({Key? key}) : super(key: key);

  @override
  _AIAssistantScreenState createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  late GeminiService _geminiService;
  bool _isTyping = false;
  bool _hasMessages = false;

  @override
  void initState() {
    super.initState();
    _geminiService = GeminiService("AIzaSyBHcypf8CrnyJt7Phe6XJfeVL5cyDPMonI");
  }

  void _sendMessage() async {
    String userMessage = _messageController.text.trim();
    if (userMessage.isNotEmpty) {
      setState(() {
        _messages.add({"sender": "user", "text": userMessage});
        _hasMessages = true;
      });

      _messageController.clear();

      setState(() {
        _isTyping = true;
      });

      await Future.delayed(Duration(seconds: 1));

      String aiResponse = await _geminiService.generateResponse(
        "You are a financial assistant. Respond only to finance-related queries professionally. Here is the user's question: $userMessage"
      );

      setState(() {
        _isTyping = false;
        _messages.add({"sender": "ai", "text": aiResponse});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DeepState AI'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          /// **Message List (Chat Area)**
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _hasMessages ? 0 : MediaQuery.of(context).size.height * 0.25,
            bottom: _hasMessages ? 70 : null,
            left: 0,
            right: 0,
            child: _messages.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (_isTyping && index == _messages.length) {
                        return _buildMessageBubble("AI is typing...", false, isTyping: true);
                      }
                      final message = _messages[index];
                      bool isUser = message["sender"] == "user";
                      return _buildMessageBubble(message["text"]!, isUser);
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 10),
                        Text(
                          "How can I assist you today?",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
                  ),
          ),

          /// **Text Input Field (Initially Centered, Moves to Bottom)**
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            bottom: _hasMessages ? 10 : MediaQuery.of(context).size.height * 0.3,
            left: 20,
            right: 20,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      cursorColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.send,
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        hintText: "Ask about investments, stocks, or finance...",
                        hintStyle: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey[700]),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.deepPurple),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **🔹 Builds a chat bubble with Markdown support**
  Widget _buildMessageBubble(String text, bool isUser, {bool isTyping = false}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepPurple : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[300]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: isTyping
            ? Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
            : MarkdownBody(
                data: text,
                styleSheet: MarkdownStyleSheet(
                  p: GoogleFonts.poppins(
                    fontSize: 16,
                    color: isUser 
                        ? Colors.white // Ensures user message text is always white
                        : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black), // AI response remains readable
                  ),
                  strong: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
                  h2: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
                  listBullet: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
      ).animate().fadeIn(duration: 400.ms).slideX(begin: isUser ? 0.3 : -0.3, end: 0).scaleXY(begin: 0.9, end: 1),
    );
  }
}
