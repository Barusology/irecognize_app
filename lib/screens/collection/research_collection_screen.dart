import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme.dart';
import '../detail/object_detail_view_screen.dart';
import '../../models/identification.dart';
import '../../services/identification_service.dart';

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
                    'Your saved identifications',
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
          SliverToBoxAdapter(
            child: StreamBuilder<List<Identification>>(
              stream: IdentificationService().watchEntries(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(padding: const EdgeInsets.all(24), child: Text('Archive unavailable: ${snapshot.error}', style: TextStyle(color: IRecognizeTheme.outline)));
                }
                if (!snapshot.hasData) return const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()));
                final entries = snapshot.data!;
                if (entries.isEmpty) {
                  return Padding(padding: const EdgeInsets.fromLTRB(28, 48, 28, 140), child: Column(children: [
                    const Icon(Symbols.auto_awesome, size: 42, color: IRecognizeTheme.primary),
                    const SizedBox(height: 16),
                    Text('Your discoveries start here', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text('Identify an object and save it to build your private field archive.', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: IRecognizeTheme.outline)),
                  ]));
                }
                return Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 120), child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: entries.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: .65),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return _ArchiveCard(title: entry.title, category: entry.category, date: MaterialLocalizations.of(context).formatShortDate(entry.createdAt), imageUrl: entry.imageUrl, entry: entry);
                  },
                ));
              },
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
  final Identification entry;

  const _ArchiveCard({
    required this.title,
    required this.category,
    required this.date,
    required this.imageUrl,
    required this.entry,
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
            builder: (context) => ObjectDetailViewScreen(entry: entry),
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

