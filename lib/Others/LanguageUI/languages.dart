import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mata3im_delivery/Components/custom_button.dart';
import 'package:mata3im_delivery/Locale/language_cubit.dart';
import 'package:mata3im_delivery/Locale/locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages extends StatefulWidget {
  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  LanguageCubit _languageCubit;
  int _languageValue;

  @override
  void initState() {
    super.initState();
    _languageValue = 0;
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    final List<String> languages = [
      locale.englishh,
      locale.arabicc,
      locale.frenchh,
      locale.portuguesee,
      locale.indonesiann,
      locale.spanishh,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorLight,
        title: Text(
          locale.language,
          style: theme.textTheme.subtitle1,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  locale.selectLanguage,
                  style: theme.textTheme.bodyText2
                      .copyWith(color: theme.hintColor),
                ),
              ),
              Container(
                color: theme.primaryColorLight,
                child: Theme(
                  data: ThemeData.dark(),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: languages.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => RadioListTile(
                      activeColor: theme.primaryColor,
                      value: index,
                      groupValue: _languageValue,
                      onChanged: (value) {
                        setState(() {
                          _languageValue = value;
                        });
                      },
                      title: Text(
                        languages[index],
                        style: theme.textTheme.subtitle1.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            child: GestureDetector(
              onTap: () async {
                var prefs = await SharedPreferences.getInstance();

                if (languages[_languageValue] == locale.englishh) {
                  prefs.setString('locale', 'en');
                  _languageCubit.selectEngLanguage();
                } else if (languages[_languageValue] == locale.arabicc) {
                  prefs.setString('locale', 'ar');
                  _languageCubit.selectArabicLanguage();
                } else if (languages[_languageValue] == locale.portuguesee) {
                  prefs.setString('locale', 'pt');
                  _languageCubit.selectPortugueseLanguage();
                } else if (languages[_languageValue] == locale.frenchh) {
                  prefs.setString('locale', 'fr');
                  _languageCubit.selectFrenchLanguage();
                } else if (languages[_languageValue] == locale.spanishh) {
                  prefs.setString('locale', 'es');
                  _languageCubit.selectSpanishLanguage();
                } else if (languages[_languageValue] == locale.indonesiann) {
                  prefs.setString('locale', 'in');
                  _languageCubit.selectIndonesianLanguage();
                }

                Navigator.pop(context);
              },
              child: CustomButton(
                label: locale.save,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              ),
            ),
          )
        ],
      ),
    );
  }
}
