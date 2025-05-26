import 'package:flutter/material.dart';

class NewsForu extends StatelessWidget {
  final String imageUrl;
  final String author;
  final String title;
  final String time;
  final VoidCallback onTap;

  const NewsForu({
    super.key,
    required this.imageUrl,
    required this.author,
    required this.title,
    required this.time, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // News Image
            // News Image
            SizedBox(
              width: 100, // Set a fixed width
              height: 100, // Set a fixed height
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      "https://webz.io/wp-content/uploads/2023/01/Competitive-Intelligence-3.jpg", // Fallback image
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 12),
            // News Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author Row
                  Row(
                    children: [
                      const Icon(Icons.person, size: 28, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          author,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // News Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // News Time
                  Text(
                    time,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
