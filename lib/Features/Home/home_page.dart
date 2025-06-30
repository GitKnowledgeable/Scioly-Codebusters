import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GameSetup.init(context);

    return Container(
      decoration: AppTheme.backgroundGradient,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Stack(
        children: [
          MatrixBackgroundWidget(),
          Scaffold(
            backgroundColor: AppTheme.appBarBackground,
            appBar: AppBar(
              title: const Text(
                "SYSTEM",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: Border(
                bottom: BorderSide(color: AppTheme.logoGreen, width: 1),
              ),
              actions: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppTheme.logoGreen, width: 2),
                  ),
                  child: IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Settings(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: screenW,
                  //height: screenH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      HomeLogo(),
                      const SizedBox(height: 50),
                      HomeButtonWidget(
                        btnText: "Aristocrat",
                        neonColor: Colors.pinkAccent,
                        num: "01",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GamePageSetup(
                                gameId: "Aristocrats",
                                language: Language.english,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      HomeButtonWidget(
                        btnText: "Patristocrat",
                        neonColor: Colors.yellowAccent,
                        num: "02",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GamePageSetup(
                                gameId: "Patristocrat",
                                language: Language.english,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      HomeButtonWidget(
                        btnText: "Xenocrypt",
                        neonColor: Colors.lightBlueAccent,
                        num: "03",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GamePageSetup(
                                gameId: "Xenocrypt",
                                language: Language.spanish,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      HomeButtonWidget(
                        btnText: "View Dictionary",
                        neonColor: AppTheme.logoGreen,
                        num: "04",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DictionaryPage(dictionaryId: "english"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
