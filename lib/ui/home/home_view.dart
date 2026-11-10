import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:bantay_baha/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'home_view_helpers.dart';
part 'home_view_statistics.dart';
part 'home_view_station_cards.dart';
part 'home_view_status.dart';

const double _hPad = 20;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _stationFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bg = theme.scaffoldBackgroundColor;

    return Consumer<HomeViewModel>(
      builder: (context, model, _) {
        final stations = model.stations;

        // Most severe first, then alphabetical.
        final sorted = List<Station>.of(stations)
          ..sort((a, b) {
            final byRisk = _riskRank(a.riskLevel)
                .compareTo(_riskRank(b.riskLevel));
            return byRisk != 0
                ? byRisk
                : a.stationName.compareTo(b.stationName);
          });

        final attentionCount = sorted.where((s) => !_isNormal(s)).length;
        final highRisk = model.metrics?.highRiskStationsCount ?? attentionCount;
        final peakLevel = model.metrics?.peakWaterLevel ?? 0.0;
        final totalStations = model.metrics?.totalStations ?? stations.length;
        final calculatedAt = model.flood?.calculatedAt;
        final readingsAreStale =
            model.isUsingCachedFloodData ||
            (calculatedAt != null &&
                DateTime.now().difference(calculatedAt) >
                    const Duration(minutes: 15));

        final visible = sorted.where((station) {
          switch (_stationFilter) {
            case 'Needs attention':
              return !_isNormal(station);
            default:
              return true;
          }
        }).toList();

        final hasData = stations.isNotEmpty;
        final statusColor = model.hasFloodError
            ? scheme.onSurfaceVariant
            : (readingsAreStale || highRisk > 0
                  ? AppTheme.warningAmber
                  : AppTheme.success);

        final headline = !hasData
            ? 'Flood overview'
            : highRisk > 0
            ? '$highRisk station${highRisk == 1 ? ' needs' : 's need'} attention'
            : 'All stations normal';

        final support = !hasData
            ? 'Live conditions across monitored stations'
            : (highRisk > 0 && attentionCount > 0)
            ? 'Most severe at ${sorted.first.stationName}'
            : highRisk > 0
            ? 'Peak water level is ${peakLevel.toStringAsFixed(1)} m'
            : 'Water levels are normal across the network';

        return Scaffold(
          backgroundColor: bg,
          body: RefreshIndicator(
            onRefresh: model.refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  centerTitle: false,
                  backgroundColor: bg,
                  surfaceTintColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  titleSpacing: _hPad,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.flood_rounded,
                        size: 22,
                        color: AppTheme.brandBlue,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Bantay Baha',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: model.isLoading ? null : model.refresh,
                      tooltip: 'Refresh data',
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                    const SizedBox(width: 8),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: model.isLoading
                        ? const LinearProgressIndicator(minHeight: 2)
                        : const SizedBox(height: 2),
                  ),
                ),

                if (model.hasFloodError)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(_hPad, 8, _hPad, 0),
                      child: _ErrorBanner(
                        message:
                            model.floodError ??
                            'Check your connection and try again.',
                        onRetry: model.refresh,
                      ),
                    ),
                  ),

                if (model.isUsingCachedFloodData)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(_hPad, 8, _hPad, 0),
                      child: _OfflineSnapshotBanner(
                        savedAt: model.floodCacheSavedAt,
                      ),
                    ),
                  ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(_hPad, 24, _hPad, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                model.flood == null
                                    ? 'Live monitoring'
                                    : model.isUsingCachedFloodData
                                    ? 'Offline snapshot · ${_savedAtLabel(model.floodCacheSavedAt)}'
                                    : readingsAreStale
                                    ? 'Data may be stale · ${_updatedLabel(calculatedAt!)}'
                                    : _updatedLabel(calculatedAt!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          headline,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                            letterSpacing: -0.6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          support,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StatsHeaderDelegate(
                    background: bg,
                    totalStations: totalStations,
                    highRisk: highRisk,
                    peakLevel: peakLevel,
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(_hPad, 24, _hPad, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Expanded(
                              child: Text(
                                'Stations',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              '${stations.length} monitored',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Stations are ordered by risk level.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        if (stations.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _FilterBar(
                            selected: _stationFilter,
                            hasAttention: attentionCount > 0,
                            onChanged: (filter) =>
                                setState(() => _stationFilter = filter),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                if (stations.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _StationListEmpty(
                      isLoading: model.isLoading,
                      hasError: model.hasFloodError,
                      onRetry: model.refresh,
                    ),
                  )
                else if (visible.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text('No stations match this filter'),
                      ),
                    ),
                  )
                else
                  SliverSafeArea(
                    top: false,
                    sliver: SliverPadding(
                      padding: const EdgeInsets.fromLTRB(_hPad, 0, _hPad, 24),
                      sliver: SliverList.separated(
                        itemCount: visible.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) =>
                            _StationCard(station: visible[index]),
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
