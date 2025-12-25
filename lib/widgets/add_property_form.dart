import 'package:flutter/material.dart';

class AddPropertyForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const AddPropertyForm({
    super.key,
    required this.onSuccess,
  });

  @override
  State<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends State<AddPropertyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final name = _nameController.text.trim();
        final address = _addressController.text.trim();
        final city = _cityController.text.trim();
        final description = _descriptionController.text.trim();

        // TODO: Call your API to create the property
        // await propertyService.createProperty(name, address, city, description);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bien créé avec succès'),
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
    _nameController.clear();
    _addressController.clear();
    _cityController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nom du bien
            _buildFormField(
              controller: _nameController,
              labelText: 'Nom du bien',
              hintText: 'Ex: Appartement 2 chambres',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer le nom du bien';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Adresse
            _buildFormField(
              controller: _addressController,
              labelText: 'Adresse',
              hintText: 'Ex: Rue de la Paix, N°123',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer l\'adresse';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Ville
            _buildFormField(
              controller: _cityController,
              labelText: 'Ville',
              hintText: 'Ex: Abidjan',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer la ville';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Description (optionnel)
            _buildFormField(
              controller: _descriptionController,
              labelText: 'Description (optionnel)',
              hintText: 'Décrivez votre bien...',
              maxLines: 3,
              validator: (value) => null,
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
                        : const Text('Créer'),
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
  }) {
    return TextFormField(
      controller: controller,
      enabled: !_isLoading,
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
