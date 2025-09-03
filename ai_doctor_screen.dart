import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:edoc_hub/core/constants.dart';

class AiDoctorScreen extends StatefulWidget {
  @override
  _AiDoctorScreenState createState() => _AiDoctorScreenState();
}

class _AiDoctorScreenState extends State<AiDoctorScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  final _aiDoctor = const types.User(id: 'ai_doctor');

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    // Simulate AI response
    Future.delayed(Duration(seconds: 1), () {
      final response = types.TextMessage(
        author: _aiDoctor,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().toString(),
        text: _getAiResponse(message.text),
      );

      setState(() {
        _messages.insert(0, response);
      });
    });
  }

  String _getAiResponse(String message) {
    // This would be replaced with actual AI integration
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('fever') || lowerMessage.contains('temperature')) {
      return 'I understand you\'re concerned about fever. Please monitor your temperature regularly and stay hydrated. If it persists above 102°F for more than 2 days, consult a doctor.';
    } else if (lowerMessage.contains('headache')) {
      return 'Headaches can have various causes. Ensure you\'re well-rested and hydrated. If the pain is severe or persistent, please consult a healthcare professional.';
    } else if (lowerMessage.contains('cough') || lowerMessage.contains('cold')) {
      return 'For cough and cold symptoms, I recommend rest, hydration, and over-the-counter remedies. If symptoms worsen or include difficulty breathing, seek medical attention.';
    } else {
      return 'Thank you for sharing your symptoms. I recommend consulting with a healthcare professional for personalized advice. Would you like me to help you book an appointment?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Doctor'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('AI Doctor'),
                  content: Text(
                    'This AI assistant provides general health information. '
                    'It is not a substitute for professional medical advice. '
                    'For emergencies, please contact emergency services immediately.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DefaultChatTheme(
          primaryColor: AppColors.primary,
          secondaryColor: AppColors.background,
          backgroundColor: AppColors.background,
        ),
      ),
    );
  }
}
