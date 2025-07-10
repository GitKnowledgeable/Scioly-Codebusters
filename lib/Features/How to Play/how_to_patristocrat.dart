import 'package:flutter/material.dart';
import 'package:scioly_codebusters/library.dart';

class PatristocratInstructionsPage extends StatelessWidget {
  const PatristocratInstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accentColor = Colors.lightGreenAccent.shade400;

    return Container(
      decoration: AppTheme.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'How to Play: Patristocrats',
            style: TextStyle(
              color: accentColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SectionTitle('What is a Patristocrat?'),
              Paragraph(
                'A Patristocrat is a type of cryptogram puzzle, just like an Aristocrat. It uses a substitution cipher — where each letter in the message is replaced by a different letter — and your job is to figure out the original message.',
              ),
              Paragraph(
                'The twist? In a Patristocrat, the message is written without spaces or punctuation. This makes it harder to read and solve.',
              ),
              ExampleBlock(
                ciphertext: 'SCUFPYHRNXZVQBZOAPTLUDZEUXSCUMWIJXYEUX',
                solution: 'THEQUICKBROWNFOXJUMPEDOVERTHELAZYRIVER',
              ),
              SectionTitle('Tips to Solve'),
              BulletPoints([
                'Look for short, common words like “THE”, “AND”, or “TO”.',
                'Use your knowledge of word patterns — even without spaces.',
                'Try visually splitting the string into words that make sense.',
                'Watch for letter frequency patterns, just like in Aristocrats.',
              ]),
              SectionTitle('Don’t Panic!'),
              Paragraph(
                'At first, Patristocrats can feel overwhelming. But as you get better at spotting word patterns and decoding letters, you’ll start to see where words begin and end — even without spaces.',
              ),
              SectionTitle('Need Help?'),
              BulletPoints([
                '✅ Show Correct — Highlights which letters are correct.',
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
