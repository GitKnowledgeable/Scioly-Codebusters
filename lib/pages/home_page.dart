import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutConfig.init(context);
    double screenH = LayoutConfig.height;
    double screenW = LayoutConfig.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: <Widget>[
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.backgroundGradient,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: screenW,
              height: screenH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Image(
                  //   image: AssetImage("../../codebusters-logo.png"),
                  //   fit: BoxFit.fitWidth,
                  // ),
                  const SizedBox(height: 50),
                  HomeLogo(),
                  const SizedBox(height: 50),
                  HomeButtonWidget(
                    btnText: "Cryptograms",
                    neonColor: Colors.pinkAccent,
                    num: "01",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GamePageSetup(
                            gameId: "Aristocrat",
                            language: Language.english,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Aristocrats",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  child: ElevatedButton(
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
                ),
                const SizedBox(height: 25),
                SizedBox(
                  child: ElevatedButton(
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
                    child: const Text(
                      "Xenocrypts",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DictionaryWidget(),
                        ),
                      );
                    },
                    child: const Text(
                      "View Dictionary",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
