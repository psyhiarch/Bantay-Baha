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
                    'Official flood & hazard advisory',
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                _SeverityBadge(label: advisory.severity, color: color),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${_advisorySourceLabel(advisory)} · ${_timeLabel(advisory.publishedAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (advisory.authorHandle.trim().isNotEmpty) ...[
              const SizedBox(height: 3),
              Text(
                '@${advisory.authorHandle.trim().replaceFirst(RegExp(r'^@'), '')}',
                style: Theme.of(context).textTheme.labelMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
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
            _DetailRow(
              label: 'Passability',
              value: _passabilityLabel(advisory.passability),
            ),
            _DetailRow(
              label: 'Water depth',
              value:
                  '${advisory.depthCategory}${advisory.depthInches > 0 ? ' · ${advisory.depthInches} in' : ''}',
            ),
            _DetailRow(label: 'Reporting source', value: advisory.source),
            if (advisory.locationPins.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Flood locations',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              for (final pin in advisory.locationPins)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.location_on_outlined),
                  trailing: _SeverityBadge(
                    label: pin.severity.toString(),
                    color: _severityColor(context, pin.severity.toString()),
                  ),
                  title: Text(_locationPinLabel(pin)),
                  subtitle: Text(
                    '${_passabilityLabel(pin.passability)} · ${pin.depthCategory}',
                  ),
                ),
            ],
          ],
        ),
      ),
    ),
  );
}

String _advisorySourceLabel(Advisory advisory) {
  final author = advisory.authorName.trim();
  if (author.isNotEmpty && author.toLowerCase() != 'unknown') return author;
  return advisory.source.toUpperCase() == 'NEWS'
      ? 'News report'
      : '${advisory.source} official';
}

String _locationPinLabel(LocationPin pin) {
  final location = [
    pin.road,
    pin.landmark,
  ].where((part) => part.trim().isNotEmpty).toSet().join(' · ');
  return location.isEmpty ? 'Flood location' : location;
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
