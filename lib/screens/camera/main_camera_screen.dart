import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme.dart';
import 'dart:ui';

class MainCameraScreen extends StatelessWidget {
  const MainCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IRecognizeTheme.surfaceDim,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 96),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBL-54pczjLI7ixWuCq8ZZ2h7nqxsmUnee7CHoqY-jnIKawMGzeV_OLpOinviHVsAWlSOM85nf98dNaySiwMqw6b_3hc8g_S8Cajh4pFUk7kjR6l-4nwn9vqhHVrmprbBfaJSUZPDauE-ebe2WNI9PAs22l5DMpIJBgDxbnceMIquCPngpYNhigsVaOcxY4ZQZx8fCiowhW4wCu0sVnlCvfsh-bCmkEmfXwohTI5-xVQRV-eT4AhcMqFCC4-j1obYqBDavZ2z_k1SvA',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Colors.transparent, Color(0x1931332C)],
                    stops: [0.4, 1.0],
                    radius: 1.0,
                  ),
                ),
              ),
              const Center(
                child: TargetingReticle(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                right: MediaQuery.of(context).size.width * 0.15,
                child: const IdentificationTag(),
              ),
              const Positioned(
                bottom: 120,
                left: 20,
                child: ConfidenceMetadata(),
              ),
              const Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: CameraControls(),
              )
            ],
          ),
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
          icon: Icon(Symbols.flash_on, color: IRecognizeTheme.onSurface.withOpacity(0.8)),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Symbols.more_vert, color: IRecognizeTheme.onSurface.withOpacity(0.8)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class TargetingReticle extends StatelessWidget {
  const TargetingReticle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 192,
      height: 192,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: IRecognizeTheme.secondaryContainer.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          _buildCorner(Alignment.topLeft),
          _buildCorner(Alignment.topRight),
          _buildCorner(Alignment.bottomLeft),
          _buildCorner(Alignment.bottomRight),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, IRecognizeTheme.secondaryContainer, Colors.transparent],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          border: Border(
            top: alignment.y < 0 ? const BorderSide(color: IRecognizeTheme.secondaryContainer, width: 2) : BorderSide.none,
            bottom: alignment.y > 0 ? const BorderSide(color: IRecognizeTheme.secondaryContainer, width: 2) : BorderSide.none,
            left: alignment.x < 0 ? const BorderSide(color: IRecognizeTheme.secondaryContainer, width: 2) : BorderSide.none,
            right: alignment.x > 0 ? const BorderSide(color: IRecognizeTheme.secondaryContainer, width: 2) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class IdentificationTag extends StatelessWidget {
  const IdentificationTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          transform: Matrix4.rotationZ(0.785),
          alignment: Alignment.topCenter,
          child: Container(
            width: 1,
            height: 64,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [IRecognizeTheme.secondary, Colors.transparent],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: IRecognizeTheme.surfaceContainerLowest.withOpacity(0.8),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
            border: const Border(left: BorderSide(color: IRecognizeTheme.secondary, width: 2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AR NEURAL ENGINE',
                style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: IRecognizeTheme.secondary,
                  fontSize: 10,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
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
                    'Identifying...',
                    style: IRecognizeTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class ConfidenceMetadata extends StatelessWidget {
  const ConfidenceMetadata({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: IRecognizeTheme.secondaryContainer.withOpacity(0.9),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              const Icon(Symbols.cognition, size: 14, color: IRecognizeTheme.onSecondaryContainer, fill: 1),
              const SizedBox(width: 8),
              Text(
                'MATCH: MONSTERA 94.2%',
                style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  fontSize: 12,
                  color: IRecognizeTheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              color: IRecognizeTheme.onSurface.withOpacity(0.1),
              child: Text(
                'COORD: 34.0522° N, 118.2437° W',
                style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CameraControls extends StatelessWidget {
  const CameraControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
            image: const DecorationImage(
              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBE48TOC6jV6JPPomQrq0GMyFDvdoDRvUE-eIMKqK2Fc0Nz-I4X_RPkDNmO7j4LFN0mUkdbXqsJlnarRwxvvBCzyBNffuBM2OOxP_9ENiIyYyRx1Vt1n5JtebTg3rPCa_Oke8v3OAvexnsrtl8CEuxYbUNPGpL-BEc-SXazhF_s5CMx_2m-eKIAZD09vXoS0Okek6_9RPaT1b4CVquhCSxr_WdsQsi34reDubQug5xlq9pMCTbXxwUtnx0cZn9ocUMqXmQFxb0ITi_I'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
          ),
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              color: IRecognizeTheme.onSurface.withOpacity(0.1),
              child: Text(
                '1.0x',
                style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
