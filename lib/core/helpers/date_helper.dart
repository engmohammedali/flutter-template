class DateHelper {
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 5) {
      return 'الآن';
    } else if (difference.inSeconds < 60) {
      return difference.inSeconds == 1
          ? 'منذ ثانية واحدة'
          : difference.inSeconds == 2
              ? 'منذ ثانيتين'
              : 'منذ ${difference.inSeconds} ثواني';
    } else if (difference.inMinutes < 60) {
      return difference.inMinutes == 1
          ? 'منذ دقيقة واحدة'
          : difference.inMinutes == 2
              ? 'منذ دقيقتين'
              : 'منذ ${difference.inMinutes} دقائق';
    } else if (difference.inHours < 24) {
      return difference.inHours == 1
          ? 'منذ ساعة واحدة'
          : difference.inHours == 2
              ? 'منذ ساعتين'
              : 'منذ ${difference.inHours} ساعات';
    } else if (difference.inDays < 7) {
      return difference.inDays == 1
          ? 'منذ يوم واحد'
          : difference.inDays == 2
              ? 'منذ يومين'
              : 'منذ ${difference.inDays} أيام';
    } else if (difference.inDays < 30) {
      final weeks = difference.inDays ~/ 7;
      return weeks == 1
          ? 'منذ أسبوع واحد'
          : weeks == 2
              ? 'منذ أسبوعين'
              : 'منذ $weeks أسابيع';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return months == 1
          ? 'منذ شهر واحد'
          : months == 2
              ? 'منذ شهرين'
              : 'منذ $months أشهر';
    } else {
      final years = difference.inDays ~/ 365;
      return years == 1
          ? 'منذ سنة واحدة'
          : years == 2
              ? 'منذ سنتين'
              : 'منذ $years سنوات';
    }
  }
}
