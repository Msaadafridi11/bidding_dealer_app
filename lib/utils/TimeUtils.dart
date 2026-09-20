// String formatRemainingTime(DateTime endTime) {
//   final now = DateTime.now();
//   final diff = endTime.difference(now);
//
//   if (diff.isNegative) {
//     return 'Expired';
//   }
//
//   final hours = diff.inHours;
//   final minutes = diff.inMinutes % 60;
//
//   if (hours > 0) {
//     return '${hours}h ${minutes}m left';
//   } else {
//     return '${minutes}m left';
//   }
// }

String formatRemainingTime(DateTime endTime) {
  final now = DateTime.now();
  final diff = endTime.difference(now);

  if (diff.isNegative) {
    return 'Expired';
  }

  final hours = diff.inHours;
  final minutes = diff.inMinutes % 60;
  final seconds = diff.inSeconds % 60;

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  return "${twoDigits(hours)}:"
      "${twoDigits(minutes)}:"
      "${twoDigits(seconds)}";
}