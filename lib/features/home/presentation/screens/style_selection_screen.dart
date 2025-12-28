import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/style_card.dart';
import '../providers/style_providers.dart';

class StyleSelectionScreen extends ConsumerStatefulWidget {
  const StyleSelectionScreen({super.key});

  @override
  ConsumerState<StyleSelectionScreen> createState() =>
      _StyleSelectionScreenState();
}

class _StyleSelectionScreenState extends ConsumerState<StyleSelectionScreen> {
  // List of interior design styles with descriptions
  final List<Map<String, String>> styles = [
    {
      'title': 'Minimalist',
      'description':
          'Clean, simple, clutter-free spaces with focus on essentials',
      'image':
          'https://plus.unsplash.com/premium_photo-1670358808227-590942cd18cb?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bWluaW1hbGlzdCUyMHJvb218ZW58MHx8MHx8fDA%3D',
    },
    {
      'title': 'Cozy',
      'description':
          'Warm, comfortable, and inviting spaces with soft textures',
      'image':
          'https://images.unsplash.com/photo-1615873968403-89e068629265?w=600&auto=format&fit=crop',
    },
    {
      'title': 'Modern',
      'description': 'Sleek, contemporary design with geometric shapes',
      'image':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w-600&auto=format&fit=crop',
    },
    {
      'title': 'Industrial',
      'description': 'Raw, edgy aesthetic with exposed elements and urban vibe',
      'image':
          'https://images.unsplash.com/photo-1495433324511-bf8e92934d90?w=600&auto=format&fit=crop',
    },
    {
      'title': 'Scandinavian',
      'description': 'Light, natural, and functional with minimalist touch',
      'image':
          'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=600&auto=format&fit=crop',
    },
    {
      'title': 'Bohemian',
      'description': 'Colorful, eclectic, and artistic with global influences',
      'image':
          'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?w=600&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedStyle = ref.watch(selectedStyleProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Choose Your Style',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Instruction Text
                  Text(
                    'Select an interior design style',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your AI will transform your room based on this style',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Grid of Style Cards
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75, // Adjust for card proportions
                    ),
                    itemCount: styles.length,
                    itemBuilder: (context, index) {
                      final style = styles[index];
                      return StyleCard(
                        title: style['title']!,
                        description: style['description']!,
                        imageUrl: style['image']!,
                        isSelected: selectedStyle == style['title'],
                        onTap: () {
                          ref.read(selectedStyleProvider.notifier).setStyle(
                              style['title']);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Next Button (sticky at bottom)
          Container(
            padding: const EdgeInsets.all(24),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: selectedStyle != null
                    ? () {
                        // Navigate to upload screen
                        Navigator.pushNamed(
                          context,
                          '/upload',
                          arguments: selectedStyle,
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF333333),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Next →',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
