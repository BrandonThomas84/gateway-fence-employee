/// Reverses the order of a map
reverseMap(Map map) {
  Map newmap = {};
  for (String k in map.keys.toList().reversed) {
    newmap[k] = map[k];
  }
  return newmap;
}
