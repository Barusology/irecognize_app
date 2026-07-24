import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme.dart';
import 'dart:ui';

import '../detail/object_detail_view_screen.dart'; // Just to show it exists near usage

void showSocialShareExportModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: IRecognizeTheme.surfaceContainerLowest.withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.all(32),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Export Research',
                      style: IRecognizeTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                        fontFamily: 'Newsreader',
                        fontStyle: FontStyle.italic,
                        color: IRecognizeTheme.primary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Symbols.close, color: IRecognizeTheme.outline),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: IRecognizeTheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBE48TOC6jV6JPPomQrq0GMyFDvdoDRvUE-eIMKqK2Fc0Nz-I4X_RPkDNmO7j4LFN0mUkdbXqsJlnarRwxvvBCzyBNffuBM2OOxP_9ENiIyYyRx1Vt1n5JtebTg3rPCa_Oke8v3OAvexnsrtl8CEuxYbUNPGpL-BEc-SXazhF_s5CMx_2m-eKIAZD09vXoS0Okek6_9RPaT1b4CVquhCSxr_WdsQsi34reDubQug5xlq9pMCTbXxwUtnx0cZn9ocUMqXmQFxb0ITi_I',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Monstera Deliciosa',
                              style: IRecognizeTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'BOTANY • Oct 24, 2023',
                              style: IRecognizeTheme.lightTheme.textTheme.labelSmall?.copyWith(
                                color: IRecognizeTheme.outline,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                _buildActionRow(Symbols.download, 'Save Image to Device', 'High-res export with metadata overlay'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: IRecognizeTheme.outlineVariant, height: 1),
                ),
                _buildActionRow(Symbols.format_quote, 'Generate Citation', 'APA, MLA, and Chicago formats'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: IRecognizeTheme.outlineVariant, height: 1),
                ),
                _buildActionRow(Symbols.ios_share, 'Share to Network', 'Send to colleagues or social media'),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildActionRow(IconData icon, String title, String subtitle) {
  return InkWell(
    onTap: () {},
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: IRecognizeTheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: IRecognizeTheme.onPrimaryContainer),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: IRecognizeTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: IRecognizeTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: IRecognizeTheme.outline,
                ),
              ),
            ],
          ),
        ),
        const Icon(Symbols.chevron_right, color: IRecognizeTheme.outlineVariant),
      ],
    ),
  );
}
