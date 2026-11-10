part of 'map_view.dart';

class _RoutePlannerControls extends StatelessWidget {
  const _RoutePlannerControls({
    required this.step,
    required this.start,
    required this.destination,
    required this.startLabel,
    required this.destinationLabel,
    required this.route,
    required this.error,
    required this.locationError,
    required this.isFetchingLocation,
    required this.routePlanningService,
    required this.onStartSelected,
    required this.onDestinationSelected,
    required this.onStartTextChanged,
    required this.onDestinationTextChanged,
    required this.onUseMyLocation,
    required this.onPickOnMap,
    required this.onPickStartOnMap,
    required this.onPickDestinationOnMap,
    required this.onPlanRoute,
    required this.onToggle,
    required this.onCancel,
  });

  final int step;
  final LatLng? start;
  final LatLng? destination;
  final String? startLabel;
  final String? destinationLabel;
  final _SafeRoute? route;
  final String? error;
  final String? locationError;
  final bool isFetchingLocation;
  final RoutePlanningService routePlanningService;
  final ValueChanged<RoutePlace> onStartSelected;
  final ValueChanged<RoutePlace> onDestinationSelected;
  final ValueChanged<String> onStartTextChanged;
  final ValueChanged<String> onDestinationTextChanged;
  final VoidCallback onUseMyLocation;
  final VoidCallback onPickOnMap;
  final VoidCallback onPickStartOnMap;
  final VoidCallback onPickDestinationOnMap;
  final VoidCallback onPlanRoute;
  final VoidCallback onToggle;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.alt_route_rounded,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plan a safer route',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Routes are checked against flood reports',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (route != null)
                  IconButton(
                    tooltip: 'Clear planned route',
                    onPressed: onCancel,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                IconButton(
                  tooltip: 'Close route planner',
                  onPressed: onToggle,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _placeField(
              context,
              label: 'Start',
              icon: Icons.trip_origin_rounded,
              selectedLabel: startLabel,
              onSelected: onStartSelected,
              onTextChanged: onStartTextChanged,
              onPickOnMap: onPickStartOnMap,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: isFetchingLocation ? null : onUseMyLocation,
                icon: isFetchingLocation
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location_rounded, size: 17),
                label: const Text('Use my location'),
              ),
            ),
            const SizedBox(height: 8),
            _placeField(
              context,
              label: 'Destination',
              icon: Icons.location_on_outlined,
              selectedLabel: destinationLabel,
              onSelected: onDestinationSelected,
              onTextChanged: onDestinationTextChanged,
              onPickOnMap: onPickDestinationOnMap,
            ),
            if (locationError != null) ...[
              const SizedBox(height: 6),
              Text(
                locationError!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            if (error != null) ...[
              const SizedBox(height: 6),
              Text(
                error!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            if (step == 1 || step == 2) ...[
              const SizedBox(height: 8),
              Text(
                step == 1
                    ? 'Tap the map to set your starting point.'
                    : 'Tap the map to set your destination.',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (step == 3) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(minHeight: 2),
              const SizedBox(height: 7),
              Text(
                'Finding a route and checking flood reports…',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (route != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(
                    alpha: .55,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_distanceLabel(route!.distanceMeters)}  ·  ${_durationLabel(route!.durationSeconds)}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      route!.riskPenaltyMinutes > 0
                          ? 'Bahaba travel-time estimate · +${_durationLabel(route!.riskPenaltyMinutes * 60)} in safety ranking for nearby hazards.'
                          : 'No matching hazards found along this route.',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (route!.via.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        'Via ${route!.via.join(' · ')}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: step == 3 ? null : onPickOnMap,
                    icon: const Icon(Icons.touch_app_outlined),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    label: const Text(
                      'Pick on map',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: step == 3 || start == null || destination == null
                        ? null
                        : onPlanRoute,
                    icon: const Icon(Icons.alt_route_rounded),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    label: Text(
                      route == null ? 'Find route' : 'Recalculate',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            if (route?.instructions.isNotEmpty ?? false) ...[
              const SizedBox(height: 4),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                title: const Text('Directions'),
                subtitle: Text('${route!.instructions.length} steps'),
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 220),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final instruction in route!.instructions)
                          _routeInstructionTile(context, instruction),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _routeInstructionIcon(RouteInstruction instruction) {
    final maneuver = instruction.maneuver.toLowerCase();
    final modifier = instruction.modifier.toLowerCase();
    if (maneuver == 'arrive') return Icons.location_on_outlined;
    if (maneuver == 'depart') return Icons.trip_origin_rounded;
    if (maneuver.contains('uturn')) {
      return modifier == 'right' ? Icons.u_turn_right : Icons.u_turn_left;
    }
    if (modifier.contains('left')) return Icons.turn_left_rounded;
    if (modifier.contains('right')) return Icons.turn_right_rounded;
    if (maneuver == 'turn') return Icons.turn_slight_right_rounded;
    return Icons.straight_rounded;
  }

  Widget _routeInstructionTile(
    BuildContext context,
    RouteInstruction instruction,
  ) {
    final street = instruction.street;
    final subtitle =
        street.isNotEmpty &&
            !instruction.instruction.toLowerCase().contains(
              street.toLowerCase(),
            )
        ? street
        : null;
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 24,
      horizontalTitleGap: 8,
      leading: Icon(_routeInstructionIcon(instruction), size: 19),
      title: Text(instruction.instruction),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: instruction.distanceMeters > 0
          ? Text(
              _distanceLabel(instruction.distanceMeters),
              style: Theme.of(context).textTheme.labelSmall,
            )
          : null,
    );
  }

  Widget _placeField(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String? selectedLabel,
    required ValueChanged<RoutePlace> onSelected,
    required ValueChanged<String> onTextChanged,
    required VoidCallback onPickOnMap,
  }) => Autocomplete<RoutePlace>(
    key: ValueKey('$label:${selectedLabel ?? ''}'),
    initialValue: TextEditingValue(text: selectedLabel ?? ''),
    displayStringForOption: (place) => place.label,
    optionsBuilder: (value) => routePlanningService.searchPlaces(value.text),
    onSelected: onSelected,
    optionsViewBuilder: (context, select, options) => Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 210),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              for (final place in options)
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.place_outlined),
                  title: Text(
                    place.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: place.detail.isEmpty
                      ? null
                      : Text(
                          place.detail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                  onTap: () => select(place),
                ),
            ],
          ),
        ),
      ),
    ),
    fieldViewBuilder: (context, controller, focusNode, onSubmitted) =>
        TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onTextChanged,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => onSubmitted(),
          decoration: InputDecoration(
            labelText: label,
            hintText: 'Search an address or landmark',
            prefixIcon: Icon(icon),
            suffixIcon: IconButton(
              tooltip: 'Choose $label on map',
              onPressed: onPickOnMap,
              icon: const Icon(Icons.map_outlined),
            ),
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
  );
}
