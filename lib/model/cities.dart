class Coordinates{

  final double lat;
  final double long;

  Coordinates({  required this.lat, required this.long});
}

final Map<String, Coordinates> citiesMap = {
  'Lagos': Coordinates(lat: 6.455, long: 3.3841),
  'Abuja': Coordinates(lat: 9.0667, long: 7.4833),
  'Ibadan': Coordinates(lat: 7.3964, long: 3.9167),
  'Awka': Coordinates(lat: 6.2069, long: 7.0678),
  'Port Harcourt': Coordinates(lat: 4.8242, long: 7.0336),
  'Onitsha': Coordinates(lat: 6.1667, long: 6.7833),
  'Aba': Coordinates(lat: 5.1167, long: 7.3667),
  'Benin City': Coordinates(lat: 6.3333, long: 5.6222),
  'Mushin': Coordinates(lat: 6.5333, long: 3.35),
  'Owerri': Coordinates(lat: 5.485, long: 7.035),
  'Ikeja': Coordinates(lat: 6.6, long: 3.35),
  'Agege': Coordinates(lat: 6.6219, long: 3.3258),
  'Somolu': Coordinates(lat: 6.5408, long: 3.3872),
  'Minna': Coordinates(lat: 9.6139, long: 6.5569),
  'Apapa': Coordinates(lat: 6.45, long: 3.3667),
};
