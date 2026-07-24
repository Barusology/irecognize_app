import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme.dart';
import '../detail/object_detail_view_screen.dart';
import 'dart:ui';

class GeographicArchiveMapScreen extends StatelessWidget {
  const GeographicArchiveMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IRecognizeTheme.surfaceContainerLow,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _DotGridPainter(),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBefu8ZhwQhId292-0g1iKaF4MK8kxwRHShUj20m9qLcuw8WnUcDwAxwFBQYfHo16pLHkf_Z8uWPI1MzHIObUj2ttpuuIdbzKvdghShUAqR7VjKkNRht2iWzEF2R5-QVHxyg1hU8FEuarCdyNF2__0qUYTwuvtltWEQ7svN5lWTHJNqoLUqjiDWalAtP2py91Bvh7xDJjpZAzXGiOdJxlRwiEqodwheZRIn1ee2M33sqH4U5yJMWJeEnqGd2ejCNroas5Qaehk2LGDM',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            top: 24,
            left: 16,
            right: 16,
            child: _SearchOverlay(),
          ),
          Positioned(
            top: 96,
            right: 24,
            child: Column(
              children: [
                _FloatingIconButton(icon: Symbols.layers),
                const SizedBox(height: 12),
                _FloatingIconButton(icon: Symbols.my_location),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.33,
            child: const _MapPin(
              icon: Symbols.eco,
              color: IRecognizeTheme.secondary,
              isActive: false,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: MediaQuery.of(context).size.width * 0.66,
            child: const _MapPin(
              icon: Symbols.account_balance,
              color: IRecognizeTheme.primary,
              isActive: true,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.66,
            left: MediaQuery.of(context).size.width * 0.4,
            child: const _MapPin(
              icon: Symbols.palette,
              color: IRecognizeTheme.tertiary,
              isActive: false,
            ),
          ),
          const Positioned(
            bottom: 120,
            left: 24,
            right: 24,
            child: _SelectionDetailCard(),
          ),
        ],
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
          icon: Icon(Symbols.more_vert, color: IRecognizeTheme.onSurface.withOpacity(0.8)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _SearchOverlay extends StatelessWidget {
  const _SearchOverlay();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: IRecognizeTheme.surfaceContainerLowest.withOpacity(0.9),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F31332C),
                blurRadius: 40,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Symbols.search, color: IRecognizeTheme.outline),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search archive locations...',
                    hintStyle: IRecognizeTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: IRecognizeTheme.outlineVariant,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const Icon(Symbols.tune, color: IRecognizeTheme.outlineVariant, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingIconButton extends StatelessWidget {
  final IconData icon;
  const _FloatingIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: IRecognizeTheme.surfaceContainerLowest,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: IRecognizeTheme.primary),
    );
  }
}

class _MapPin extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isActive;

  const _MapPin({
    required this.icon,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(isActive ? 12.0 : 8.0),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: isActive ? Border.all(color: Colors.white.withOpacity(0.5), width: 4) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: isActive ? 24 : 20,
            fill: isActive ? 1 : 0,
          ),
        ),
        Container(
          width: 4,
          height: isActive ? 16 : 12,
          color: color,
        ),
      ],
    );
  }
}

class _SelectionDetailCard extends StatelessWidget {
  const _SelectionDetailCard();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: IRecognizeTheme.surfaceContainerLowest.withOpacity(0.95),
              border: Border.all(color: IRecognizeTheme.outlineVariant.withOpacity(0.1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 128,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCcUoZhyZymcq9Vj5iGYubyP0IZPAzdEUZyADTtcC0H5s0reuR4tIF602yaek02NoH-7lqb157GlpbCM78BwatJRatqJRfEg2M8C3lUHbUBAW7JmPC3bqikyWYgFta0lNYWDBgO9VLkLlbICPXMuXEUz8mBAcN7PNievhrI99poBoPPcSUOAwU8Uzem_jFhRquKaIMVLd_PclZC0NXvDl2zyZUQQoY-IiEfEyDP27qF0hiKrLn32fqJIKwMaCjPVG1RNOBW-m0pRirP',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ARCHITECTURE',
                                  style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                                    color: IRecognizeTheme.secondary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const Icon(Symbols.close, size: 20, color: IRecognizeTheme.outlineVariant),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Saint-Gervais Portal',
                              style: IRecognizeTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'CAPTURED: OCT 24, 2023',
                              style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                                fontSize: 11,
                                color: IRecognizeTheme.outline,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ObjectDetailViewScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: IRecognizeTheme.primary,
                                foregroundColor: IRecognizeTheme.onPrimary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                minimumSize: const Size(0, 32),
                              ),
                              child: Text(
                                'View Details',
                                style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                                  color: IRecognizeTheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: IRecognizeTheme.surfaceContainerHigh,
                                foregroundColor: IRecognizeTheme.onSurface,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                minimumSize: const Size(0, 32),
                              ),
                              child: Text(
                                'Directions',
                                style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                                  color: IRecognizeTheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = IRecognizeTheme.outlineVariant
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    const double spacing = 24.0;
    
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
