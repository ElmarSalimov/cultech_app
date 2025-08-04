import 'package:cultech_app/core/l10n/localization_cubit.dart';
import 'package:cultech_app/core/l10n/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // User data
  final String firstName = 'Elmar';
  final String lastName = 'Salimov';
  final String phoneNumber = '+994 50 123 45 67';

  // Current language selection
  String _selectedLanguage = 'Azerbaijani';

  // Simplified languages list with language codes
  final List<Map<String, String>> _languages = [
    {'name': 'Azerbaijani', 'native': 'Azərbaycan', 'code': 'az'},
    {'name': 'Russian', 'native': 'Русский', 'code': 'ru'},
    {'name': 'English', 'native': 'English', 'code': 'en'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          context.localizations.settings,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Section with Avatar
            _buildProfileSection(),
            const SizedBox(height: 32),

            // Language Selection
            _buildSimpleLanguageSelector(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    String initials =
        '${firstName.isNotEmpty ? firstName[0].toUpperCase() : ''}${lastName.isNotEmpty ? lastName[0].toUpperCase() : ''}';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade50,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // First Name
          _buildInfoRow(
            label: context.localizations.firstName,
            value: firstName,
          ),

          const SizedBox(height: 16),

          // Last Name
          _buildInfoRow(label: context.localizations.lastName, value: lastName),

          const SizedBox(height: 16),

          // Phone Number
          _buildInfoRow(label: context.localizations.phone, value: phoneNumber),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.blue.shade100, width: 1),
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleLanguageSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade50,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.language, color: Colors.blue.shade300, size: 20),
                const SizedBox(width: 8),
                Text(
                  context.localizations.language,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children:
                  _languages.map((language) {
                    bool isSelected = _selectedLanguage == language['name'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language['name']!;
                        });
                        // Change locale using the language code
                        context.read<LocalizationCubit>().changeLocale(
                          Locale(language['code']!),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.blue.shade50
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color:
                                  isSelected
                                      ? Colors.blue.shade300
                                      : Colors.grey.shade400,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                language['native']!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      isSelected
                                          ? Colors.grey.shade800
                                          : Colors.grey.shade600,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                            // Language code indicator
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.blue.shade100
                                        : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                language['code']!.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected
                                          ? Colors.blue.shade700
                                          : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
