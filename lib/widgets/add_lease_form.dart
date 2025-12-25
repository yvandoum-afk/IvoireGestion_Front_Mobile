import 'package:flutter/material.dart';

class AddLeaseForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const AddLeaseForm({
    super.key,
    required this.onSuccess,
  });

  @override
  State<AddLeaseForm> createState() => _AddLeaseFormState();
}

class _AddLeaseFormState extends State<AddLeaseForm> {
  final _formKey = GlobalKey<FormState>();
  final _loyerController = TextEditingController();
  final _chargesController = TextEditingController();
  final _jourEcheanceController = TextEditingController();

  String? _selectedLocataire;
  DateTime? _dateDebut;
  DateTime? _dateFin;
  bool _isLoading = false;

  // Mock list of locataires - replace with actual data from API
  final List<Map<String, dynamic>> _locataires = [
    {'id': '1', 'name': 'Jean Kouassi'},
    {'id': '2', 'name': 'Marie Dupont'},
    {'id': '3', 'name': 'Paul Martin'},
  ];

  @override
  void dispose() {
    _loyerController.dispose();
    _chargesController.dispose();
    _jourEcheanceController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? _dateDebut ?? DateTime.now()
          : _dateFin ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _dateDebut = picked;
        } else {
          _dateFin = picked;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final locataire = _selectedLocataire;
        final dateDebut = _dateDebut;
        final dateFin = _dateFin;
        final loyer = int.parse(_loyerController.text.trim());
        final charges = int.parse(_chargesController.text.trim());
        final jourEcheance = int.parse(_jourEcheanceController.text.trim());

        // TODO: Call your API to create the lease
        // await leaseService.createLease(locataire, dateDebut, dateFin, loyer, charges, jourEcheance);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bail créé avec succès'),
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
    _selectedLocataire = null;
    _dateDebut = null;
    _dateFin = null;
    _loyerController.clear();
    _chargesController.clear();
    _jourEcheanceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sélectionner locataire
            DropdownButtonFormField<String>(
              value: _selectedLocataire,
              decoration: InputDecoration(
                labelText: 'Locataire',
                hintText: 'Sélectionnez un locataire',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _locataires.map((locataire) {
                return DropdownMenuItem<String>(
                  value: locataire['id'],
                  child: Text(locataire['name']),
                );
              }).toList(),
              onChanged: _isLoading
                  ? null
                  : (value) {
                      setState(() {
                        _selectedLocataire = value;
                      });
                    },
              validator: (value) {
                if (value == null) {
                  return 'Veuillez sélectionner un locataire';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                'Note: Le logement est automatiquement attribué en fonction du locataire sélectionné. Assurez-vous d\'avoir assigné un logement au locataire avant de créer le bail.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Date de début
            InkWell(
              onTap: _isLoading ? null : () => _selectDate(context, true),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date de début',
                  hintText: 'Sélectionnez une date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  _dateDebut != null
                      ? '${_dateDebut!.day}/${_dateDebut!.month}/${_dateDebut!.year}'
                      : 'Sélectionnez une date',
                  style: TextStyle(
                    color: _dateDebut != null
                        ? Colors.black
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            if (_dateDebut == null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  'Veuillez sélectionner une date de début',
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            // Date de fin (optionnel)
            InkWell(
              onTap: _isLoading ? null : () => _selectDate(context, false),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date de fin (optionnel)',
                  hintText: 'Sélectionnez une date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  _dateFin != null
                      ? '${_dateFin!.day}/${_dateFin!.month}/${_dateFin!.year}'
                      : 'Sélectionnez une date',
                  style: TextStyle(
                    color:
                        _dateFin != null ? Colors.black : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Loyer mensuel (XOF)
            _buildFormField(
              controller: _loyerController,
              labelText: 'Loyer mensuel (XOF)',
              hintText: 'Ex: 150000',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer le loyer mensuel';
                }
                if (int.tryParse(value) == null) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Charges mensuelles (XOF)
            _buildFormField(
              controller: _chargesController,
              labelText: 'Charges mensuelles (XOF)',
              hintText: 'Ex: 25000',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer les charges mensuelles';
                }
                if (int.tryParse(value) == null) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Jour d'échéance (1-31)
            _buildFormField(
              controller: _jourEcheanceController,
              labelText: 'Jour d\'échéance (1-31)',
              hintText: 'Ex: 1',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer le jour d\'échéance';
                }
                final day = int.tryParse(value);
                if (day == null || day < 1 || day > 31) {
                  return 'Veuillez entrer un jour entre 1 et 31';
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
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_dateDebut != null &&
                                (_formKey.currentState?.validate() ?? false)) {
                              _submitForm();
                            } else if (_dateDebut == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Veuillez sélectionner une date de début'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
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
                        : const Text('Créer le bail'),
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
