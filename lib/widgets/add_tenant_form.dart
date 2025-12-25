import 'package:flutter/material.dart';

class AddTenantForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const AddTenantForm({
    super.key,
    required this.onSuccess,
  });

  @override
  State<AddTenantForm> createState() => _AddTenantFormState();
}

class _AddTenantFormState extends State<AddTenantForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedLogement;
  bool _isLoading = false;

  // Mock list of logements - replace with actual data from API
  final List<Map<String, dynamic>> _logements = [
    {'id': '1', 'name': 'Appartement - Rue de la Paix'},
    {'id': '2', 'name': 'Villa - Cocody'},
    {'id': '3', 'name': 'Studio - Plateau'},
  ];

  @override
  void dispose() {
    _fullnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final fullname = _fullnameController.text.trim();
        final phone = _phoneController.text.trim();
        final email = _emailController.text.trim();
        final logement = _selectedLogement;

        // TODO: Call your API to create the tenant
        // await tenantService.createTenant(fullname, phone, email, logement);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Locataire créé avec succès'),
              backgroundColor: Colors.green,
            ),
          );
          widget.onSuccess();
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _clearForm() {
    _fullnameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _selectedLogement = null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nom complet
            _buildFormField(
              controller: _fullnameController,
              labelText: 'Nom complet',
              hintText: 'Ex: Jean Kouassi',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer le nom complet';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Téléphone
            _buildFormField(
              controller: _phoneController,
              labelText: 'Téléphone',
              hintText: '+225 XX XX XX XX XX',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer le numéro de téléphone';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Email (optionnel)
            _buildFormField(
              controller: _emailController,
              labelText: 'Email (optionnel)',
              hintText: 'Ex: jean@example.com',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value != null && value.trim().isNotEmpty) {
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Veuillez entrer une adresse email valide';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Logement à associer
            DropdownButtonFormField<String>(
              value: _selectedLogement,
              decoration: InputDecoration(
                labelText: 'Logement à associer',
                hintText: 'Sélectionnez un logement',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _logements.map((logement) {
                return DropdownMenuItem<String>(
                  value: logement['id'],
                  child: Text(logement['name']),
                );
              }).toList(),
              onChanged: _isLoading
                  ? null
                  : (value) {
                      setState(() {
                        _selectedLogement = value;
                      });
                    },
              validator: (value) {
                if (value == null) {
                  return 'Veuillez sélectionner un logement';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            _clearForm();
                            Navigator.pop(context);
                          },
                    child: const Text('Annuler'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97316),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Créer le locataire'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required FormFieldValidator<String> validator,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      enabled: !_isLoading,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }
}
