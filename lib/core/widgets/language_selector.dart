import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  List<Locale> supportedLocale = ['en', 'ar'].map((e) => Locale(e)).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        txt('CHOOSE_LANGUAGE'.tr(), e: St.bold20),
        const Divider(),
        ...supportedLocale.map(
          (l) => LanguageCardWidget(
            lang: l,
            selectedLang: context.locale,
            onTap: () async {
              await context.setLocale(l);
              Navigator.of(context).pop();
            },
            isSelected: context.locale.languageCode == l.languageCode,
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class LanguageCardWidget extends StatelessWidget {
  const LanguageCardWidget({
    super.key,
    required this.lang,
    required this.selectedLang,
    required this.onTap,
    required this.isSelected,
  });
  final Locale selectedLang;
  final Locale lang;
  final Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? context.primaryColor : null,
      borderOnForeground: true,
      child: ListTile(
        tileColor: isSelected ? context.primaryColor : null,
        title: txt(
          lang.languageCode == 'en' ? 'English' : 'العربية',
          maxLines: 20,
          e: St.bold18,
          c: isSelected ? Colors.white : null,
        ),
        onTap: onTap,
      ),
    );
  }
}
