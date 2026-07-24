import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme.dart';
import '../detail/object_detail_view_screen.dart';

class ResearchCollectionScreen extends StatelessWidget {
  const ResearchCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IRecognizeTheme.background,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Archive',
                    style: IRecognizeTheme.lightTheme.textTheme.displayMedium?.copyWith(
                      color: IRecognizeTheme.primary,
                      fontSize: 48,
                      height: 1.1,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '342 saved entries',
                    style: IRecognizeTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: IRecognizeTheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All Entries', true),
                        _buildFilterChip('Botany', false),
                        _buildFilterChip('Architecture', false),
                        _buildFilterChip('Sculpture', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 120), // Padding for nav bar
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24.0,
                crossAxisSpacing: 24.0,
                childAspectRatio: 0.65,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _ArchiveCard(
                    title: _mockData[index]['title']!,
                    category: _mockData[index]['category']!,
                    date: _mockData[index]['date']!,
                    imageUrl: _mockData[index]['imageUrl']!,
                  );
                },
                childCount: _mockData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? IRecognizeTheme.primary : Colors.transparent,
        border: Border.all(color: isSelected ? IRecognizeTheme.primary : IRecognizeTheme.outlineVariant),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: IRecognizeTheme.lightTheme.textTheme.labelMedium?.copyWith(
          color: isSelected ? IRecognizeTheme.onPrimary : IRecognizeTheme.onSurface,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      titleSpacing: 24,
      title: Row(
        children: [
          Icon(Symbols.menu_book, color: IRecognizeTheme.onSurface.withOpacity(0.8)),
          const SizedBox(width: 12),
          Text(
            'iRecognize',
            style: IRecognizeTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: IRecognizeTheme.primary,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Symbols.search, color: IRecognizeTheme.onSurface.withOpacity(0.8)),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Symbols.sort, color: IRecognizeTheme.onSurface.withOpacity(0.8)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _ArchiveCard extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final String imageUrl;

  const _ArchiveCard({
    required this.title,
    required this.category,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = category == 'BOTANY' ? IRecognizeTheme.secondary : 
                          category == 'ARCHITECTURE' ? IRecognizeTheme.primary : 
                          IRecognizeTheme.tertiary;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ObjectDetailViewScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: IRecognizeTheme.surfaceContainerHigh,
                    child: const Icon(Symbols.image, color: IRecognizeTheme.outlineVariant),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: categoryColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                category,
                style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: categoryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: IRecognizeTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: IRecognizeTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: IRecognizeTheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> _mockData = [
  {
    'title': 'Monstera Deliciosa (Variegated)',
    'category': 'BOTANY',
    'date': 'Oct 24, 2023',
    'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBE48TOC6jV6JPPomQrq0GMyFDvdoDRvUE-eIMKqK2Fc0Nz-I4X_RPkDNmO7j4LFN0mUkdbXqsJlnarRwxvvBCzyBNffuBM2OOxP_9ENiIyYyRx1Vt1n5JtebTg3rPCa_Oke8v3OAvexnsrtl8CEuxYbUNPGpL-BEc-SXazhF_s5CMx_2m-eKIAZD09vXoS0Okek6_9RPaT1b4CVquhCSxr_WdsQsi34reDubQug5xlq9pMCTbXxwUtnx0cZn9ocUMqXmQFxb0ITi_I',
  },
  {
    'title': 'Saint-Gervais Portal',
    'category': 'ARCHITECTURE',
    'date': 'Oct 22, 2023',
    'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCcUoZhyZymcq9Vj5iGYubyP0IZPAzdEUZyADTtcC0H5s0reuR4tIF602yaek02NoH-7lqb157GlpbCM78BwatJRatqJRfEg2M8C3lUHbUBAW7JmPC3bqikyWYgFta0lNYWDBgO9VLkLlbICPXMuXEUz8mBAcN7PNievhrI99poBoPPcSUOAwU8Uzem_jFhRquKaIMVLd_PclZC0NXvDl2zyZUQQoY-IiEfEyDP27qF0hiKrLn32fqJIKwMaCjPVG1RNOBW-m0pRirP',
  },
  {
    'title': 'Bronze Winged Victory',
    'category': 'SCULPTURE',
    'date': 'Oct 15, 2023',
    'imageUrl': 'invalid_url', // Will fallback to errorBuilder icon
  },
  {
    'title': 'Ficus Elastica',
    'category': 'BOTANY',
    'date': 'Oct 10, 2023',
    'imageUrl': 'invalid_url', // Will fallback to errorBuilder icon
  }
];
