import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edoc_hub/services/auth_service.dart';
import 'package:edoc_hub/core/constants.dart';
import 'package:edoc_hub/widgets/animated_button.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isGoogleLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Animation
                  Lottie.asset(
                    AppAnimations.welcome,
                    height: 250,
                    fit: BoxFit.contain,
                  ).animate().scale(duration: 600.ms),
                  
                  SizedBox(height: 20),
                  
                  Text(
                    'Welcome to ${AppStrings.appName}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  
                  SizedBox(height: 10),
                  
                  Text(
                    AppStrings.slogan,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                  
                  SizedBox(height: 30),
                  
                  // Phone Number Input
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixText: '+91 ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length != 10) {
                        return 'Please enter a valid 10-digit number';
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 600.ms),
                  
                  SizedBox(height: 20),
                  
                  // Send OTP Button
                  AnimatedButton(
                    text: 'Send OTP',
                    isLoading: authService.isLoading,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String phoneNumber = '+91${_phoneController.text}';
                        try {
                          await authService.signInWithPhone(phoneNumber);
                          Navigator.pushNamed(context, '/otp');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                  ).animate().fadeIn(delay: 800.ms),
                  
                  SizedBox(height: 20),
                  
                  // Or divider
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('OR'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ).animate().fadeIn(delay: 1000.ms),
                  
                  SizedBox(height: 20),
                  
                  // Google Sign In Button
                  ElevatedButton.icon(
                    icon: _isGoogleLoading 
                        ? CircularProgressIndicator(color: Colors.white)
                        : Image.asset('assets/images/google.png', height: 24),
                    label: Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: _isGoogleLoading ? null : () async {
                      setState(() => _isGoogleLoading = true);
                      try {
                        await authService.signInWithGoogle();
                        Navigator.pushReplacementNamed(context, '/home');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                      setState(() => _isGoogleLoading = false);
                    },
                  ).animate().fadeIn(delay: 1200.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
