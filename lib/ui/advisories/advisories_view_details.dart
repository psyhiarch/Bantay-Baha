part of 'advisories_view.dart';

Future<void> _showDetails(BuildContext context, Advisory advisory) async {
  final color = _severityColor(context, advisory.severity);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Flood report',
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                _SeverityBadge(label: advisory.severity, color: color),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${advisory.authorName} · ${_timeLabel(advisory.publishedAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            Text(
              advisory.cleanedText,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),
            _DetailRow(label: 'Road', value: advisory.road),
            _DetailRow(label: 'Nearby landmark', value: advisory.landmark),
            _DetailRow(label: 'City', value: advisory.city),
            _DetailRow(label: 'Passability', value: advisory.passability),
            _DetailRow(
              label: 'Water depth',
              value:
                  '${advisory.depthCategory}${advisory.depthInches > 0 ? ' · ${advisory.depthInches} in' : ''}',
            ),
            _DetailRow(label: 'Source', value: advisory.source),
          ],
        ),
      ),
    ),
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? 'Not provided' : value,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
