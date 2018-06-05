String hash2url(String hash) {
  //https://fuss10.elemecdn.com/9/21/60ac33f023d9074e13cd78f9b5964jpeg.jpeg%3FimageMogr/format/webp/thumbnail/!90x90r/gravity/Center/crop/90x90/

  String part0 = hash.substring(0, 1);
  String part1 = hash.substring(1, 3);
  String part2 = hash.substring(3);

  String img =
      'https://fuss10.elemecdn.com/$part0/$part1/${part2}.jpeg%3FimageMogr/format/webp/thumbnail/!90x90r/gravity/Center/crop/90x90';

  print(img);

  return img;
}

String formatDistance(int metre) {
  if (metre < 1000) {
    return '${metre}m';
  }

  return (metre.toDouble() / 1000).toStringAsFixed(1) + "km";
}
