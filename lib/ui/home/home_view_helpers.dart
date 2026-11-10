part of 'home_view.dart';

bool _isNormal(Station s) => s.riskLevel.toUpperCase() == 'NORMAL';

String _updatedLabel(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inMinutes < 1) return 'Updated just now';
  if (diff.inMinutes < 60) return 'Updated ${diff.inMinutes} min ago';
  if (diff.inHours < 24) return 'Updated ${diff.inHours} h ago';
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final l = date.toLocal();
  final h = l.hour.toString().padLeft(2, '0');
  final m = l.minute.toString().padLeft(2, '0');
  return 'Updated ${months[l.month - 1]} ${l.day}, $h:$m';
}

String _savedAtLabel(DateTime? date) => date == null
    ? 'save time unavailable'
    : _updatedLabel(date).replaceFirst('Updated ', 'saved ');

String _sentenceCase(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();

Color _riskColor(String level) {
  final risk = level.toUpperCase();
  if (risk.contains('CRITICAL') ||
      risk.contains('ALARM') ||
      risk.contains('SEVERE') ||
      risk.contains('HIGH')) {
    return AppTheme.danger;
  }
  if (risk.contains('WARNING') ||
      risk.contains('ALERT') ||
      risk.contains('WATCH')) {
    return AppTheme.warningAmber;
  }
  if (risk.contains('NORMAL')) return AppTheme.success;
  return AppTheme.brandBlue;
}

int _riskRank(String level) {
  final c = _riskColor(level);
  if (c == AppTheme.danger) return 0;
  if (c == AppTheme.warningAmber) return 1;
  if (c == AppTheme.success) return 3;
  return 2;
}
