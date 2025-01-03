import 'package:flutter/material.dart';

class ContactUsSection extends StatefulWidget {
  final bool isPolish; // Dodanie obsługi języka

  const ContactUsSection({
    Key? key,
    required this.isPolish,
  }) : super(key: key);

  @override
  _ContactUsSectionState createState() => _ContactUsSectionState();
}

class _ContactUsSectionState extends State<ContactUsSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      // Simulacja wysyłania e-maila (prosta implementacja)
      try {
        await Future.delayed(const Duration(seconds: 1));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(widget.isPolish
                  ? 'Wiadomość wysłana pomyślnie!'
                  : 'Message sent successfully!')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(widget.isPolish
                  ? 'Nie udało się wysłać wiadomości.'
                  : 'Failed to send message.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final containerPadding = screenWidth * 0.1;

        return Center(
          child: Container(
            padding: EdgeInsets.all(containerPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5.0,
                  blurRadius: 10.0,
                  offset: const Offset(4, 4),
                ),
              ],
              border: Border.all(
                color: Colors.blueAccent,
                width: 2.0,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isPolish ? 'Napisz do nas!' : 'Contact Us!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      labelText:
                          widget.isPolish ? 'Twój nick' : 'Your nickname',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return widget.isPolish
                            ? 'Proszę podać nick'
                            : 'Please enter a nickname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText:
                          widget.isPolish ? 'Twoja wiadomość' : 'Your message',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return widget.isPolish
                            ? 'Proszę wpisać wiadomość'
                            : 'Please enter a message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 30.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      widget.isPolish ? 'Wyślij wiadomość' : 'Send Message',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
