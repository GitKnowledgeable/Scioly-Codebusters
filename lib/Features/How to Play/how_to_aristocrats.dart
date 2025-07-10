import 'package:flutter/material.dart';
import 'package:scioly_codebusters/library.dart';

class AristocratInstructionsPage extends StatefulWidget {
  const AristocratInstructionsPage({super.key});

  @override
  State<AristocratInstructionsPage> createState() =>
      _AristocratInstructionsPage();
}

class _AristocratInstructionsPage extends State<AristocratInstructionsPage> {
  @override
  Widget build(BuildContext context) {
    final accentColor = Colors.lightGreenAccent.shade400;

    return Container(
      decoration: AppTheme.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'How to Play: Aristocrats',
            style: TextStyle(
              color: accentColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle('What is an Aristocrat?'),
              Paragraph(
                'An aristocrat, also known as a cryptogram, is a puzzle where a message has been written in code — called the ciphertext — by replacing each letter with a different letter.\n'
                'For example, every ‘A’ might become ‘M’, every ‘B’ might become ‘Z’, and so on. No letter can decode to itself.',
              ),
              Paragraph(
                'Your goal is to figure out the original message by guessing which letters map to which.',
              ),
              ExampleBlock(
                ciphertext: 'SCU FPYHR NXZVQ BZO APTLUD ZEUX SCU MWIJ XYEUX',
                solution: 'THE QUICK BROWN FOX JUMPED OVER THE LAZY RIVER',
              ),
              SectionTitle('Tips to Solve'),
              SubsectionTitle('1. Look for Word Patterns'),
              Paragraph(
                'Words like “XBCX” might be “that” because of the repeating letters. If “XDFGV” has X = A and V = T, you might guess “ABOUT”.',
              ),
              Paragraph(
                'Tap the dictionary icon when playing to see suggestions that match the word pattern. Words on the left are the most common.',
              ),
              Container(
                padding: EdgeInsets.all(insetPadding),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withAlpha(50),
                  border: Border.all(color: Colors.blueAccent, width: 1),
                ),
                child: Icon(Icons.menu_book_sharp, color: Colors.blueAccent),
              ),
              Paragraph(
                'Want to dive deeper? Tap the button below to explore word patterns for 5,000 common English words. For each pattern, the most frequently used words appear first.',
              ),
              HomeButtonWidget(
                btnText: "View Dictionary",
                neonColor: AppTheme.logoGreen,
                num: "",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DictionaryPage()),
                  );
                },
              ),
              SubsectionTitle('2. Use Letter Frequencies'),
              Paragraph(
                'Below each box shows how often a letter appears in the quote. High frequency letters are likely to be E, T, A, I, O, or N.',
              ),
              Paragraph(
                'Use frequencies to confirm word patterns.\nFor example, if “DGC” could be “the” or “and”, check how frequent D, G, and C are. If D and G are common, it\'s likely "and," and if D and C are common, it\'s likely "the."',
              ),
              SubsectionTitle('3. Pay Attention to Letter Positions'),
              Paragraph(
                'Letters like “Y” usually appear at the end or start, but rarely in the middle. Some letters pair frequently, like "ll" or "tt", while others don\'t, like "uu" or "hh".',
              ),
              Paragraph(
                'Vowels and consonants usually alternate in words, so if you solve for a vowel, the letters immediately before or after it might be a consonant, and vice versa.',
              ),
              Paragraph('Look for endings like “tion”, “ing”, “ed”.'),
              SubsectionTitle('4. Use Context'),
              Paragraph('Assume the ciphertext contains "...BVG DLU..."'),
              Paragraph(
                'If “BVG” = “you”, then “DLU” might be “are” or “can”. Consider grammar and sentence flow.',
              ),
              Paragraph(
                'Plurals often lead into words like “are” or “have”. After commas, expect “and”, “but”, etc.',
              ),
              SectionTitle('Need Help?'),
              BulletPoints([
                '✅ Show Correct — Highlights which letters are correct.',
                '📖 Dictionary — Suggests words for a selected pattern.',
                '💬 Hint — Reveals the correct letter at a selected spot.',
              ]),
              SectionTitle('Star Solves'),
              BulletPoints([
                '⭐ One stars: Solve with any hints (dictionary, show correct, or hint button).',
                '⭐⭐ Two stars: Solve with no hints.',
                '⭐⭐⭐ Three stars: Solve with no hints and no undo/delete.',
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
