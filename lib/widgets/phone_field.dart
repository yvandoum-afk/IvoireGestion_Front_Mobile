import 'package:flutter/material.dart';

class PhoneField extends StatefulWidget {
  final TextEditingController phoneController;
  final String? labelText;
  final String? hintText;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onCountryChanged;
  final String? initialCountry;

  const PhoneField({
    super.key,
    required this.phoneController,
    this.labelText = 'Téléphone',
    this.hintText = 'XX XX XX XX XX',
    this.enabled = true,
    this.validator,
    this.onCountryChanged,
    this.initialCountry = '+225',
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late String _selectedCountry;

  // List of countries with their codes and flags
  final List<Map<String, String>> _countries = [
    {'code': '+225', 'name': 'Côte d\'Ivoire (CI)', 'flag': '🇨🇮'},
    {'code': '+233', 'name': 'Ghana (GH)', 'flag': '🇬🇭'},
    {'code': '+234', 'name': 'Nigeria (NG)', 'flag': '🇳🇬'},
    {'code': '+230', 'name': 'Mauritius (MU)', 'flag': '🇲🇺'},
    {'code': '+212', 'name': 'Morocco (MA)', 'flag': '🇲🇦'},
    {'code': '+216', 'name': 'Tunisia (TN)', 'flag': '🇹🇳'},
    {'code': '+256', 'name': 'Uganda (UG)', 'flag': '🇺🇬'},
    {'code': '+254', 'name': 'Kenya (KE)', 'flag': '🇰🇪'},
    {'code': '+27', 'name': 'South Africa (ZA)', 'flag': '🇿🇦'},
    {'code': '+1', 'name': 'United States (US)', 'flag': '🇺🇸'},
    {'code': '+44', 'name': 'United Kingdom (GB)', 'flag': '🇬🇧'},
    {'code': '+33', 'name': 'France (FR)', 'flag': '🇫🇷'},
    {'code': '+49', 'name': 'Germany (DE)', 'flag': '🇩🇪'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry ?? '+225';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        if (widget.labelText != null) const SizedBox(height: 8),
        Row(
          children: [
            // Country code dropdown
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: DropdownButton<String>(
                value: _selectedCountry,
                onChanged: widget.enabled
                    ? (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedCountry = newValue;
                          });
                          widget.onCountryChanged?.call(newValue);
                        }
                      }
                    : null,
                items: _countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['code'],
                    child: Text('${country['flag']} ${country['code']}'),
                  );
                }).toList(),
                underline: const SizedBox(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(width: 12),
            // Phone number input
            Expanded(
              child: TextFormField(
                controller: widget.phoneController,
                enabled: widget.enabled,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer votre numéro de téléphone';
                  }
                  if (widget.validator != null) {
                    return widget.validator!(value);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to get complete phone number with country code
  String getFullPhoneNumber() {
    return '$_selectedCountry ${widget.phoneController.text.trim()}';
  }

  // Helper method to get country code
  String getCountryCode() {
    return _selectedCountry;
  }
}
