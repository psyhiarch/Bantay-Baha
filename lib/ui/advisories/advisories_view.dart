import 'package:bantay_baha/domain/models/advisory.dart';
import 'package:bantay_baha/domain/models/location_pin.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:bantay_baha/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'advisories_view_components.dart';
part 'advisories_view_details.dart';

class AdvisoriesView extends StatefulWidget {
  const AdvisoriesView({super.key});

  @override
  State<AdvisoriesView> createState() => _AdvisoriesViewState();
}

class _AdvisoriesViewState extends State<AdvisoriesView> {
  String _filter = 'ALL';
  String _searchQuery = '';
  HomeViewModel? _homeViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final homeViewModel = context.read<HomeViewModel>();
    if (identical(_homeViewModel, homeViewModel)) return;

    _homeViewModel = homeViewModel;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && identical(_homeViewModel, homeViewModel)) {
        homeViewModel.loadAdvisories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Consumer<HomeViewModel>(
      builder: (context, model, _) {
        final advisories = model.advisories.where((advisory) {
          return _matchesFilter(advisory, _filter) &&
              _matchesSearch(advisory, _searchQuery);
        }).toList()..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
        final urgentCount = model.advisories.where(_isUrgent).length;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: RefreshIndicator(
            onRefresh: () => model.loadAdvisories(force: true),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: const Text('Official Advisory Wall'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      tooltip: 'Refresh advisories',
                      onPressed: model.isLoadingAdvisories
                          ? null
                          : () => model.loadAdvisories(force: true),
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                  ],
                  bottom: model.isLoadingAdvisories
                      ? const PreferredSize(
                          preferredSize: Size.fromHeight(2),
                          child: LinearProgressIndicator(minHeight: 2),
                        )
                      : null,
                ),
                if (model.isUsingCachedAdvisories)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.warningAmber.withValues(alpha: .12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.cloud_off_outlined,
                              color: AppTheme.warningAmber,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Offline snapshot · saved ${_savedAge(model.advisoriesCacheSavedAt)}. Reports may have changed.',
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
                  sliver: SliverToBoxAdapter(
                    child: _AdvisorySummary(
                      total: model.advisories.length,
                      urgent: urgentCount,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    child: Text(
                      'Real-time reports from MMDA, NDRRMC, PAGASA, and news outlets.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  sliver: SliverToBoxAdapter(
                    child: SearchBar(
                      hintText: 'Search reports, places, or sources',
                      leading: const Icon(Icons.search_rounded),
                      trailing: [
                        if (_searchQuery.isNotEmpty)
                          IconButton(
                            tooltip: 'Clear search',
                            onPressed: () => setState(() => _searchQuery = ''),
                            icon: const Icon(Icons.close_rounded),
                          ),
                      ],
                      onChanged: (value) =>
                          setState(() => _searchQuery = value),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 48,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (final filter in const [
                          'ALL',
                          'FLOOD',
                          'WEATHER',
                          'SUSPENSION',
                          'MMDA',
                          'PAGASA',
                          'NDRRMC',
                          'NEWS',
                        ])
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(_filterLabel(filter)),
                              selected: _filter == filter,
                              showCheckmark: false,
                              onSelected: (_) =>
                                  setState(() => _filter = filter),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (model.advisoriesError != null && model.advisories.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _AdvisoriesEmpty(
                      icon: Icons.cloud_off_outlined,
                      title: 'Advisories unavailable',
                      message: model.advisoriesError!,
                      action: 'Try again',
                      onAction: () => model.loadAdvisories(force: true),
                    ),
                  )
                else if (model.isLoadingAdvisories && model.advisories.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (advisories.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _AdvisoriesEmpty(
                      icon: Icons.campaign_outlined,
                      title: model.advisories.isEmpty
                          ? 'No reports yet'
                          : 'No matching reports',
                      message: model.advisories.isEmpty
                          ? 'Official flood, weather, and suspension reports will appear here when available.'
                          : 'Try a different filter or search term.',
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                    sliver: SliverList.separated(
                      itemCount: advisories.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => _AdvisoryCard(
                        advisory: advisories[index],
                        onTap: () => _showDetails(context, advisories[index]),
                      ),
                    ),
                  ),
                if (model.advisoriesError != null &&
                    model.advisories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Text(
                        'Showing the latest saved updates. Pull to refresh.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String _filterLabel(String filter) => switch (filter) {
  'ALL' => 'All reports',
  'FLOOD' => 'Floods',
  'WEATHER' => 'Weather',
  'SUSPENSION' => 'Walang Pasok',
  'NEWS' => 'News',
  _ => filter,
};

bool _matchesFilter(Advisory advisory, String filter) {
  final source = advisory.source.toUpperCase();
  final text = advisory.cleanedText.toLowerCase();
  return switch (filter) {
    'ALL' => true,
    'MMDA' || 'NDRRMC' || 'PAGASA' || 'NEWS' => source == filter,
    'FLOOD' => _isFloodReport(advisory, text),
    'WEATHER' => RegExp(
      r'\b(rain|rainfall|thunderstorm|weather|monsoon|typhoon|bagyo|wind|storm)\b',
    ).hasMatch(text),
    'SUSPENSION' => RegExp(
      r'\b(walang\s*pasok|class\s+suspension|suspended|suspension)\b',
    ).hasMatch(text),
    _ => true,
  };
}

bool _isFloodReport(Advisory advisory, String text) {
  final passability = advisory.passability.toLowerCase();
  final depth = advisory.depthCategory.toLowerCase();
  return advisory.depthInches > 0 ||
      (depth.isNotEmpty &&
          !depth.contains('unknown') &&
          !depth.contains('normal') &&
          !depth.contains('clear')) ||
      passability.contains('passable') ||
      passability.contains('subsided') ||
      RegExp(r'\b(flood|flooded|flooding|inundat|impassable)\b').hasMatch(text);
}

bool _matchesSearch(Advisory advisory, String query) {
  final normalized = query.trim().toLowerCase();
  if (normalized.isEmpty) return true;
  final searchable = [
    advisory.cleanedText,
    advisory.road,
    advisory.landmark,
    advisory.city,
    advisory.source,
    advisory.authorName,
    advisory.authorHandle,
    ...advisory.locationPins.expand(
      (pin) => [pin.road, pin.landmark],
    ),
  ];
  return searchable.any((value) => value.toLowerCase().contains(normalized));
}

String _savedAge(DateTime? date) {
  if (date == null) return 'time unavailable';
  final age = DateTime.now().difference(date);
  if (age.inMinutes < 1) return 'just now';
  if (age.inMinutes < 60) return '${age.inMinutes} min ago';
  if (age.inHours < 24) return '${age.inHours} h ago';
  return '${age.inDays} d ago';
}

bool _isUrgent(Advisory advisory) {
  final severity = advisory.severity.toLowerCase();
  return severity.contains('high') ||
      severity.contains('severe') ||
      severity.contains('critical') ||
      severity.contains('alarm');
}

Color _severityColor(BuildContext context, String severity) {
  final value = severity.toLowerCase();
  if (value.contains('high') ||
      value.contains('severe') ||
      value.contains('critical')) {
    return AppTheme.danger;
  }
  if (value.contains('moderate') ||
      value.contains('warning') ||
      value.contains('medium') ||
      value.contains('alarm')) {
    return AppTheme.warningAmber;
  }
  if (value.contains('alert')) return AppTheme.warningAmber;
  return AppTheme.success;
}

String _timeLabel(DateTime date) {
  final delta = DateTime.now().difference(date);
  if (delta.inMinutes < 1) return 'Just now';
  if (delta.inHours < 1) return '${delta.inMinutes} min ago';
  if (delta.inDays < 1) return '${delta.inHours} hr ago';
  if (delta.inDays < 7) return '${delta.inDays} days ago';
  final local = date.toLocal();
  return '${local.month}/${local.day}/${local.year}';
}
