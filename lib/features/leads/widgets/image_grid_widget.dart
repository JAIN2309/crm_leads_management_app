// lib/features/leads/widgets/image_grid_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/lead_model.dart';
import '../providers/lead_provider.dart';

class ImageGridWidget extends StatelessWidget {
  final Lead lead;

  const ImageGridWidget({super.key, required this.lead});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && context.mounted) {
      context.read<LeadProvider>().addCustomerImage(lead.id, pickedFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image added successfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _viewImage(BuildContext context, String imageUrl, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _ImageViewScreen(
          imageUrl: imageUrl,
          tag: 'image_${lead.id}_$index',
          onDelete: () {
            context.read<LeadProvider>().deleteCustomerImage(lead.id, imageUrl);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image deleted'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.photo_library, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  l10n.customerImages,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () => _pickImage(context),
              icon: const Icon(Icons.add_photo_alternate),
              label: Text(l10n.addImage),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (lead.customerImages.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.noImages,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      onPressed: () => _pickImage(context),
                      icon: const Icon(Icons.add),
                      label: Text(l10n.addImage),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: lead.customerImages.length,
            itemBuilder: (context, index) {
              final imageUrl = lead.customerImages[index];
              final isLocalFile = imageUrl.startsWith('/');

              return Hero(
                tag: 'image_${lead.id}_$index',
                child: GestureDetector(
                  onTap: () => _viewImage(context, imageUrl, index),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: isLocalFile
                        ? Image.file(
                            File(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              );
                            },
                          ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class _ImageViewScreen extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final VoidCallback onDelete;

  const _ImageViewScreen({
    required this.imageUrl,
    required this.tag,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isLocalFile = imageUrl.startsWith('/');
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n.deleteImage),
                  content: Text(l10n.deleteImageConfirm),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.cancel),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete();
                      },
                      child: Text(l10n.delete),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: isLocalFile
                ? Image.file(File(imageUrl))
                : Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}
