/// Reverses the order of a map
Map<dynamic, dynamic> reverseMap(Map<dynamic, dynamic> map) {
  final Map<dynamic, dynamic> newmap = <dynamic, dynamic>{};
  for (String k in map.keys.toList().reversed) {
    newmap[k] = map[k];
  }
  return newmap;
}
