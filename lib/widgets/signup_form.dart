import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/signup_viewmodel.dart';
import '../views/login_screen.dart';
import 'phone_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _verificationMethod = 'email';
  String _selectedCountryCode = '+225';

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(SignupViewModel viewModel) async {
    if (_formKey.currentState?.validate() ?? false) {
      final fullname = _fullnameController.text.trim();
      final email = _emailController.text.trim();
      final phone = '$_selectedCountryCode ${_phoneController.text.trim()}';
      final password = _passwordController.text;

      final success = await viewModel.signup(fullname, email, phone, password);

      if (success && mounted) {
        // Navigate to main app after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      // Error will be shown automatically through the ViewModel
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),
      child: Consumer<SignupViewModel>(
        builder: (context, viewModel, child) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                // Show error message if any
                if (viewModel.errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade600),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            viewModel.errorMessage!,
                            style: TextStyle(color: Colors.red.shade600),
                          ),
                        ),
                        IconButton(
                          onPressed: viewModel.clearError,
                          icon: Icon(
                            Icons.close,
                            color: Colors.red.shade600,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                // fullname complet field
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nom complet',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _fullnameController,
                  enabled: !viewModel.isLoading,
                  decoration: InputDecoration(
                    hintText: 'Jean Kouassi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer votre fullname complet';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Email field
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  enabled: !viewModel.isLoading,
                  decoration: InputDecoration(
                    hintText: 'exemple@email.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer une adresse email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Veuillez entrer une adresse email valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Téléphone field
                PhoneField(
                  phoneController: _phoneController,
                  labelText: 'Téléphone',
                  hintText: 'XX XX XX XX XX',
                  enabled: !viewModel.isLoading,
                  initialCountry: '+225',
                  onCountryChanged: (countryCode) {
                    setState(() {
                      _selectedCountryCode = countryCode ?? '+225';
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Password field
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mot de passe',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  enabled: !viewModel.isLoading,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Méthode de vérification field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Méthode de vérification',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Choisissez comment vous souhaitez recevoir votre code de vérification',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      // Email option
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _verificationMethod == 'email'
                                ? const Color(0xFFF97316)
                                : Colors.grey.shade300,
                            width: _verificationMethod == 'email' ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          leading: Icon(
                            Icons.mail_outline,
                            color: _verificationMethod == 'email'
                                ? const Color(0xFFF97316)
                                : Colors.grey,
                          ),
                          title: const Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text('Recevoir le code par email'),
                          onTap: () {
                            setState(() {
                              _verificationMethod = 'email';
                            });
                          },
                          trailing: Radio<String>(
                            value: 'email',
                            groupValue: _verificationMethod,
                            onChanged: (value) {
                              setState(() {
                                _verificationMethod = value!;
                              });
                            },
                            activeColor: const Color(0xFFF97316),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // SMS option
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _verificationMethod == 'sms'
                                ? const Color(0xFFF97316)
                                : Colors.grey.shade300,
                            width: _verificationMethod == 'sms' ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          leading: Icon(
                            Icons.call_outlined,
                            color: _verificationMethod == 'sms'
                                ? const Color(0xFFF97316)
                                : Colors.grey,
                          ),
                          title: const Text(
                            'SMS',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text('Recevoir le code par SMS'),
                          onTap: () {
                            setState(() {
                              _verificationMethod = 'sms';
                            });
                          },
                          trailing: Radio<String>(
                            value: 'sms',
                            groupValue: _verificationMethod,
                            onChanged: (value) {
                              setState(() {
                                _verificationMethod = value!;
                              });
                            },
                            activeColor: const Color(0xFFF97316),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Signup button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () => _submitForm(viewModel),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97316),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: viewModel.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Créer un compte',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
