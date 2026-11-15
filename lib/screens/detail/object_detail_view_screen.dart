import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme.dart';
import '../components/social_share_export_modal.dart';
import 'dart:ui';
import '../../models/identification.dart';
import '../../services/identification_service.dart';

class ObjectDetailViewScreen extends StatefulWidget {
  const ObjectDetailViewScreen({super.key, this.entry});
  final Identification? entry;

  @override
  State<ObjectDetailViewScreen> createState() => _ObjectDetailViewScreenState();
}

class _ObjectDetailViewScreenState extends State<ObjectDetailViewScreen> {
  bool _saving = false;
  bool _saved = false;
  late final Identification _entry = widget.entry ?? Identification(
    id: '',
    title: 'Monstera Deliciosa',
    category: 'BOTANY',
    description: 'A flowering plant native to tropical forests from southern Mexico to Panama. Its distinctive split leaves help it thrive in low light beneath the forest canopy.',
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBE48TOC6jV6JPPomQrq0GMyFDvdoDRvUE-eIMKqK2Fc0Nz-I4X_RPkDNmO7j4LFN0mUkdbXqsJlnarRwxvvBCzyBNffuBM2OOxP_9ENiIyYyRx1Vt1n5JtebTg3rPCa_Oke8v3OAvexnsrtl8CEuxYbUNPGpL-BEc-SXazhF_s5CMx_2m-eKIAZD09vXoS0Okek6_9RPaT1b4CVquhCSxr_WdsQsi34reDubQug5xlq9pMCTbXxwUtnx0cZn9ocUMqXmQFxb0ITi_I',
    createdAt: DateTime.now(),
    location: 'Los Angeles, CA',
  );

  Future<void> _saveEntry() async {
    setState(() => _saving = true);
    try {
      await IdentificationService().save(_entry);
      if (mounted) setState(() { _saved = true; _saving = false; });
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to your cloud archive.')));
    } catch (error) {
      if (mounted) setState(() => _saving = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not save this entry: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IRecognizeTheme.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Symbols.arrow_back, color: Colors.white, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Symbols.ios_share, color: Colors.white, size: 20),
            ),
            onPressed: () {
              showSocialShareExportModal(context, _entry);
            },
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Symbols.more_vert, color: Colors.white, size: 20),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: Image.network(
                    _entry.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: ClipPath(
                    clipper: _SlantClipper(),
                    child: Container(
                      color: IRecognizeTheme.background,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 64, 24, 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: IRecognizeTheme.secondary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _entry.category.toUpperCase(),
                                style: IRecognizeTheme.lightTheme.textTheme.labelMedium?.copyWith(
                                  color: IRecognizeTheme.secondary,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _entry.title,
                            style: IRecognizeTheme.lightTheme.textTheme.displayMedium?.copyWith(
                              fontSize: 56,
                              height: 1.0,
                              letterSpacing: -1.5,
                              color: IRecognizeTheme.primary,
                            ),
                          ),
                          if (_entry.title == 'Monstera Deliciosa') const Text(
                            '(Field identification)',
                            style: TextStyle(
                              fontFamily: 'Newsreader',
                              fontStyle: FontStyle.italic,
                              fontSize: 40,
                              height: 1.1,
                              fontWeight: FontWeight.w400,
                              color: IRecognizeTheme.tertiary,
                            ),
                          ),
                          const SizedBox(height: 48),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildMetaBlock('LOCATION', _entry.location),
                                    const SizedBox(height: 24),
                                    _buildMetaBlock('METHOD', 'AR Neural\nVision Engine'),
                                    const SizedBox(height: 24),
                                    _buildMetaBlock('DATE', 'Oct 24, 2023\n14:32 PST'),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Species Description',
                                      style: IRecognizeTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                    _entry.description,
                                      style: IRecognizeTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                        height: 1.6,
                                        color: IRecognizeTheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    Text(
                                      'Geographical Origin',
                                      style: IRecognizeTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'While native to Central America, this specimen was identified in an urban cultivation context. Historical records from the 19th century note its introduction to European conservatories.',
                                      style: IRecognizeTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                        height: 1.6,
                                        color: IRecognizeTheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: ElevatedButton(
              onPressed: _saving || _saved ? null : _saveEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: IRecognizeTheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                elevation: 10,
                shadowColor: IRecognizeTheme.primary.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_saved ? Symbols.check : Symbols.bookmark_add, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(
                    _saving ? 'SAVING TO ARCHIVE…' : _saved ? 'SAVED TO ARCHIVE' : 'SAVE TO MY ARCHIVE',
                    style: IRecognizeTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetaBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
            color: IRecognizeTheme.outline,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(width: 24, height: 1, color: IRecognizeTheme.outlineVariant.withOpacity(0.5), margin: const EdgeInsets.only(bottom: 8)),
        Text(
          value,
          style: IRecognizeTheme.lightTheme.textTheme.bodySmall?.copyWith(
            height: 1.5,
            color: IRecognizeTheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _SlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 40);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
