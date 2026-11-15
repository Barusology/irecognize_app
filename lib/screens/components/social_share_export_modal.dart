import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme.dart';
import '../../models/identification.dart';

Future<void> showSocialShareExportModal(BuildContext context, Identification entry) async {
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => _ShareSheet(entry: entry),
  );
}

class _ShareSheet extends StatelessWidget {
  const _ShareSheet({required this.entry});
  final Identification entry;

  String get _caption => '${entry.title} · ${entry.category}\n\n${entry.description}\n\n'
      'Identified with iRecognize · ${(entry.confidence * 100).toStringAsFixed(1)}% match'
      '${entry.location == 'Location not added' ? '' : '\nObserved at ${entry.location}'}';

  Future<void> _share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(ShareParams(
      text: _caption,
      subject: 'Field note: ${entry.title}',
      sharePositionOrigin: box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    ));
  }

  @override
  Widget build(BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: IRecognizeTheme.surfaceContainerLow.withValues(alpha: .97),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: Colors.white12),
          ),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: SafeArea(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(5)))),
            const SizedBox(height: 20),
            Row(children: [Expanded(child: Text('Share this discovery', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: IRecognizeTheme.primary))), IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Symbols.close))]),
            Text(entry.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(_caption, maxLines: 5, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: IRecognizeTheme.onSurfaceVariant, height: 1.45)),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: () => _share(context), icon: const Icon(Symbols.ios_share), label: const Text('CHOOSE A SOCIAL APP'), style: FilledButton.styleFrom(backgroundColor: IRecognizeTheme.primary, foregroundColor: IRecognizeTheme.onPrimary, padding: const EdgeInsets.symmetric(vertical: 16)))),
            const SizedBox(height: 8),
            Text('Opens your device share menu for Facebook, Instagram, X, TikTok, Pinterest, and other installed apps.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: IRecognizeTheme.outline)),
          ])),
        ),
      );
}
