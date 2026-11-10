part of 'home_view.dart';

class _StatsHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _StatsHeaderDelegate({
    required this.background,
    required this.totalStations,
    required this.highRisk,
    required this.peakLevel,
  });

  final Color background;
  final int totalStations;
  final int highRisk;
  final double peakLevel;

  @override
  double get maxExtent => 84;

  @override
  double get minExtent => 68;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final divider = VerticalDivider(
      width: 1,
      thickness: 1,
      indent: 4,
      endIndent: 4,
      color: scheme.outlineVariant,
    );

    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          border: Border(
            top: BorderSide(color: scheme.outlineVariant),
            bottom: BorderSide(
              color: overlapsContent
                  ? scheme.outlineVariant
                  : Colors.transparent,
            ),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _Stat(label: 'Stations', value: '$totalStations'),
              ),
              divider,
              Expanded(
                child: _Stat(
                  label: 'At risk',
                  value: '$highRisk',
                  valueColor: highRisk > 0 ? AppTheme.warningAmber : null,
                ),
              ),
              divider,
              Expanded(
                child: _Stat(
                  label: 'Peak level',
                  value: peakLevel.toStringAsFixed(1),
                  unit: 'm',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StatsHeaderDelegate old) =>
      old.background != background ||
      old.totalStations != totalStations ||
      old.highRisk != highRisk ||
      old.peakLevel != peakLevel;
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    this.unit,
    this.valueColor,
  });

  final String label;
  final String value;
  final String? unit;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                text: value,
                children: [
                  if (unit != null)
                    TextSpan(
                      text: ' $unit',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              maxLines: 1,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: valueColor,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.selected,
    required this.hasAttention,
    required this.onChanged,
  });

  final String selected;
  final bool hasAttention;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget chip(String label, bool enabled) => ChoiceChip(
      label: Text(label),
      selected: selected == label,
      showCheckmark: false,
      shape: const StadiumBorder(),
      visualDensity: VisualDensity.compact,
      onSelected: enabled ? (_) => onChanged(label) : null,
    );

    return Material(
      type: MaterialType.transparency,
      child: Wrap(
        spacing: 8,
        children: [chip('All', true), chip('Needs attention', hasAttention)],
      ),
    );
  }
}
