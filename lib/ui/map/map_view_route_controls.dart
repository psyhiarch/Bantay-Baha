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
    required this.onViewRouteDetails,
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
  final VoidCallback onViewRouteDetails;
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
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onViewRouteDetails,
                  icon: const Icon(Icons.directions_outlined, size: 18),
                  label: const Text('View directions'),
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
          ],
        ),
      ),
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

class _RouteDetailsPage extends StatelessWidget {
  const _RouteDetailsPage({
    required this.route,
    required this.startLabel,
    required this.destinationLabel,
  });

  final _SafeRoute route;
  final String? startLabel;
  final String? destinationLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Route directions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_distanceLabel(route.distanceMeters)} · ${_durationLabel(route.durationSeconds)}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _endpoint(
                    context,
                    Icons.trip_origin_rounded,
                    'Start',
                    startLabel ?? 'Map selection',
                  ),
                  const SizedBox(height: 12),
                  _endpoint(
                    context,
                    Icons.location_on_outlined,
                    'Destination',
                    destinationLabel ?? 'Map selection',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Icon(
                route.riskPenaltyMinutes > 0
                    ? Icons.warning_amber_rounded
                    : Icons.verified_outlined,
                color: route.riskPenaltyMinutes > 0
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
              ),
              title: const Text('Flood safety check'),
              subtitle: Text(
                route.riskPenaltyMinutes > 0
                    ? 'Nearby flood hazards add a ${_durationLabel(route.riskPenaltyMinutes * 60)} penalty to this route’s safety ranking.'
                    : 'No matching flood hazards were found along this route.',
              ),
            ),
          ),
          if (route.via.isNotEmpty) ...[
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.alt_route_rounded),
                title: const Text('Via'),
                subtitle: Text(route.via.join(' · ')),
              ),
            ),
          ],
          const SizedBox(height: 20),
          Text('Turn-by-turn directions', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          if (route.instructions.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.info_outline_rounded),
                title: Text('Turn-by-turn directions are unavailable.'),
              ),
            )
          else
            for (var index = 0; index < route.instructions.length; index++)
              _instructionTile(context, index + 1, route.instructions[index]),
        ],
      ),
    );
  }

  Widget _endpoint(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 20),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    ],
  );

  Widget _instructionTile(
    BuildContext context,
    int step,
    RouteInstruction instruction,
  ) {
    final maneuver = instruction.maneuver.toLowerCase();
    final modifier = instruction.modifier.toLowerCase();
    final icon = maneuver == 'arrive'
        ? Icons.location_on_outlined
        : maneuver == 'depart'
        ? Icons.trip_origin_rounded
        : maneuver.contains('uturn')
        ? modifier == 'right'
              ? Icons.u_turn_right
              : Icons.u_turn_left
        : modifier.contains('left')
        ? Icons.turn_left_rounded
        : modifier.contains('right')
        ? Icons.turn_right_rounded
        : maneuver == 'turn'
        ? Icons.turn_slight_right_rounded
        : Icons.straight_rounded;
    final street = instruction.street;
    final subtitle =
        street.isNotEmpty &&
            !instruction.instruction.toLowerCase().contains(
              street.toLowerCase(),
            )
        ? street
        : null;

    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon, size: 19)),
        title: Text('$step. ${instruction.instruction}'),
        subtitle: subtitle == null ? null : Text(subtitle),
        trailing: instruction.distanceMeters > 0
            ? Text(
                _distanceLabel(instruction.distanceMeters),
                style: Theme.of(context).textTheme.labelSmall,
              )
            : null,
      ),
    );
  }
}
