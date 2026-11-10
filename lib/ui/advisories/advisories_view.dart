import 'package:bantay_baha/domain/models/advisory.dart';
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
  String _filter = 'All';
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
          return _filter == 'All' ||
              advisory.severity.toLowerCase().contains(_filter.toLowerCase());
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
                  title: const Text('Advisories'),
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
                  child: Material(
                    type: MaterialType.transparency,
                    child: SizedBox(
                      height: 48,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (final filter in const [
                            'All',
                            'High',
                            'Moderate',
                            'Low',
                          ]) ...[
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(
                                  filter == 'All' ? 'All updates' : filter,
                                ),
                                selected: _filter == filter,
                                showCheckmark: false,
                                onSelected: (_) =>
                                    setState(() => _filter = filter),
                              ),
                            ),
                          ],
                        ],
                      ),
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
                          ? 'No advisories yet'
                          : 'No matching advisories',
                      message: model.advisories.isEmpty
                          ? 'Flood and road updates will appear here when reported.'
                          : 'Try another severity filter to see more updates.',
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
      severity.contains('critical');
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
      value.contains('medium')) {
    return AppTheme.warningAmber;
  }
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
