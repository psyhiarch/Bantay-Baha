part of 'map_view.dart';

extension _MapViewStationDetailActions on _MapViewState {
  Future<void> _showStationDetails(Station station) async {
    final history = context.read<HomeViewModel>().historyFor(station.stationId);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _RiskDot(color: _riskColor(station.riskLevel), size: 12),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          station.stationName,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      _RiskChip(level: station.riskLevel),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _MetricRow(
                    label: 'Water level',
                    value: '${station.waterLevel.toStringAsFixed(1)} m',
                  ),
                  _MetricRow(
                    label: 'Water level change · 1h',
                    value: '${station.waterLevelDelta1h.toStringAsFixed(1)} m',
                  ),
                  _MetricRow(
                    label: 'Rainfall · 10 min',
                    value: '${station.rain10m.toStringAsFixed(1)} mm',
                  ),
                  _MetricRow(
                    label: 'Rainfall · 1 hour',
                    value: '${station.rain1h.toStringAsFixed(1)} mm',
                  ),
                  _MetricRow(
                    label: 'Rainfall · 24 hours',
                    value: '${station.rain24h.toStringAsFixed(1)} mm',
                  ),
                  _MetricRow(
                    label: 'Water risk',
                    value: station.waterRiskLevel,
                  ),
                  _MetricRow(label: 'Rain risk', value: station.rainRiskLevel),
                  _MetricRow(
                    label: 'Updated',
                    value: _dateLabel(station.lastUpdated),
                  ),
                  const SizedBox(height: 20),
                  _StationHistorySection(readings: history),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StationHistorySection extends StatelessWidget {
  const _StationHistorySection({required this.readings});

  final List<StationReading> readings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    if (readings.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          'History is collecting. Readings appear here as the app refreshes.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last 24 hours',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        _HistoryChart(
          title: 'Water level',
          unit: 'm',
          color: AppTheme.brandBlue,
          values: readings.map((reading) => reading.waterLevel).toList(),
          times: readings.map((reading) => reading.recordedAt).toList(),
        ),
        const SizedBox(height: 10),
        _HistoryChart(
          title: 'Rainfall · 1 hour',
          unit: 'mm',
          color: AppTheme.warningAmber,
          values: readings.map((reading) => reading.rain1h).toList(),
          times: readings.map((reading) => reading.recordedAt).toList(),
        ),
      ],
    );
  }
}

class _HistoryChart extends StatelessWidget {
  const _HistoryChart({
    required this.title,
    required this.unit,
    required this.color,
    required this.values,
    required this.times,
  });

  final String title;
  final String unit;
  final Color color;
  final List<double> values;
  final List<DateTime> times;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final latest = values.last;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                '${latest.toStringAsFixed(1)} $unit',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Text(
            'Range ${values.reduce((a, b) => a < b ? a : b).toStringAsFixed(1)}–${values.reduce((a, b) => a > b ? a : b).toStringAsFixed(1)} $unit',
            style: theme.textTheme.labelSmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 112,
            width: double.infinity,
            child: CustomPaint(
              painter: _HistoryChartPainter(
                values: values,
                times: times,
                color: color,
                gridColor: scheme.outlineVariant,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_timeLabel(times.first), style: theme.textTheme.labelSmall),
              Text(_timeLabel(times.last), style: theme.textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  String _timeLabel(DateTime time) {
    final local = time.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}

class _HistoryChartPainter extends CustomPainter {
  const _HistoryChartPainter({
    required this.values,
    required this.times,
    required this.color,
    required this.gridColor,
  });

  final List<double> values;
  final List<DateTime> times;
  final Color color;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    const inset = 5.0;
    final chart = Rect.fromLTWH(
      inset,
      inset,
      size.width - inset * 2,
      size.height - inset * 2,
    );
    final gridPaint = Paint()
      ..color = gridColor.withValues(alpha: .55)
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = chart.top + chart.height * i / 3;
      canvas.drawLine(Offset(chart.left, y), Offset(chart.right, y), gridPaint);
    }

    final minValue = values.reduce((a, b) => a < b ? a : b);
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final spread = maxValue - minValue;
    final padding = spread == 0
        ? (maxValue.abs() * .1).clamp(.1, 1.0).toDouble()
        : spread * .15;
    final low = minValue - padding;
    final high = maxValue + padding;
    final timeStart = times.first.millisecondsSinceEpoch.toDouble();
    final timeSpan =
        (times.last.millisecondsSinceEpoch - times.first.millisecondsSinceEpoch)
            .toDouble();

    Offset pointAt(int index) {
      final x = timeSpan == 0
          ? chart.left +
                (values.length == 1
                    ? chart.width / 2
                    : chart.width * index / (values.length - 1))
          : chart.left +
                (times[index].millisecondsSinceEpoch - timeStart) /
                    timeSpan *
                    chart.width;
      final y =
          chart.bottom - (values[index] - low) / (high - low) * chart.height;
      return Offset(x, y);
    }

    final line = Path()..moveTo(pointAt(0).dx, pointAt(0).dy);
    for (var i = 1; i < values.length; i++) {
      line.lineTo(pointAt(i).dx, pointAt(i).dy);
    }
    final fill = Path.from(line)
      ..lineTo(chart.right, chart.bottom)
      ..lineTo(chart.left, chart.bottom)
      ..close();
    canvas.drawPath(fill, Paint()..color = color.withValues(alpha: .12));
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.drawCircle(pointAt(values.length - 1), 4, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_HistoryChartPainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.times != times ||
      oldDelegate.color != color ||
      oldDelegate.gridColor != gridColor;
}
