String formatRuntime(int minutes) {
  final hours = minutes ~/ 60;
  final mins = minutes % 60;
  return "${hours}h ${mins}m";
}
