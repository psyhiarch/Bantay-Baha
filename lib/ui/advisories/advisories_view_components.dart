part of 'advisories_view.dart';

class _AdvisorySummary extends StatelessWidget {
  const _AdvisorySummary({required this.total, required this.urgent});
  final int total;
  final int urgent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = urgent > 0 ? AppTheme.danger : AppTheme.brandBlue;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: .13),
              shape: BoxShape.circle,
            ),
            child: Icon(
              urgent > 0
                  ? Icons.warning_amber_rounded
                  : Icons.campaign_outlined,
              color: tone,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  urgent > 0
                      ? '$urgent urgent report${urgent == 1 ? '' : 's'}'
                      : 'Official reports',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(
                  '$total reports from official agencies and news outlets',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvisoryCard extends StatelessWidget {
  const _AdvisoryCard({required this.advisory, required this.onTap});
  final Advisory advisory;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = _severityColor(context, advisory.severity);
    final location = [
      advisory.road,
      advisory.landmark,
      advisory.city,
    ].where((part) => part.trim().isNotEmpty).toSet().join(' · ');
    final author = advisory.authorName.trim();
    final handle = advisory.authorHandle.trim();
    final source = advisory.source.trim().isEmpty
        ? 'Official report'
        : advisory.source.toUpperCase() == 'NEWS'
        ? 'News report'
        : '${advisory.source} official';
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      author.isEmpty || author.toLowerCase() == 'unknown'
                          ? source
                          : author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _timeLabel(advisory.publishedAt),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              if (handle.isNotEmpty &&
                  !{'unknown', 'search', 'feed', 'undefined', 'null'}
                      .contains(handle.toLowerCase().replaceFirst('@', ''))) ...[
                const SizedBox(height: 3),
                Text(
                  '@${handle.replaceFirst(RegExp(r'^@'), '')}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.primary,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _SeverityBadge(label: advisory.severity, color: color),
                  _PassabilityBadge(advisory.passability),
                ],
              ),
              if (advisory.locationPins.length > 1) ...[
                const SizedBox(height: 10),
                Chip(
                  avatar: const Icon(Icons.map_outlined, size: 16),
                  label: Text(
                    '${advisory.locationPins.length} flood locations on map',
                  ),
                  visualDensity: VisualDensity.compact,
                  side: BorderSide.none,
                  backgroundColor: scheme.secondaryContainer,
                ),
              ],
              const SizedBox(height: 14),
              Text(
                advisory.cleanedText,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
              ),
              const SizedBox(height: 14),
              if (location.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 17,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.water_drop_outlined, size: 16, color: color),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      advisory.depthInches > 0
                          ? '${advisory.depthCategory} · ${advisory.depthInches} in'
                          : advisory.depthCategory,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Details',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: scheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PassabilityBadge extends StatelessWidget {
  const _PassabilityBadge(this.passability);

  final String passability;

  @override
  Widget build(BuildContext context) {
    final normalized = passability.toUpperCase();
    final isClosed =
        normalized.contains('NOT_PASSABLE') ||
        normalized.contains('IMPASSABLE') ||
        normalized.contains('CLOSED');
    final isSubsided = normalized.contains('SUBSIDED');
    final isPassable = normalized.contains('PASSABLE') && !isClosed;
    final color = isClosed
        ? AppTheme.danger
        : isSubsided || isPassable
        ? AppTheme.success
        : normalized.isEmpty
        ? Theme.of(context).colorScheme.onSurfaceVariant
        : AppTheme.warningAmber;
    return _SeverityBadge(
      label: _passabilityLabel(passability),
      color: color,
    );
  }
}

String _passabilityLabel(String passability) {
  final normalized = passability.toUpperCase();
  return switch (normalized) {
    'NOT_PASSABLE_ALL' => 'Not passable · all vehicles',
    'NOT_PASSABLE_LIGHT' => 'Not passable · light vehicles',
    'PASSABLE_ALL' => 'Passable · all vehicles',
    'SUBSIDED' => 'Flood subsided',
    '' => 'Passability not reported',
    _ => passability
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' '),
  };
}

class _SeverityBadge extends StatelessWidget {
  const _SeverityBadge({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .12),
      borderRadius: BorderRadius.circular(99),
    ),
    child: Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall
          ?.copyWith(color: color, fontWeight: FontWeight.w800),
    ),
  );
}

class _AdvisoriesEmpty extends StatelessWidget {
  const _AdvisoriesEmpty({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
    this.onAction,
  });
  final IconData icon;
  final String title;
  final String message;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 42,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (action != null) ...[
            const SizedBox(height: 16),
            FilledButton(onPressed: onAction, child: Text(action!)),
          ],
        ],
      ),
    ),
  );
}
