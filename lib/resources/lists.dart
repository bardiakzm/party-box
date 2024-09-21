import 'package:party_box/games/Charades_game/charades.dart';
import 'package:party_box/games/pantomime_game/pantomime.dart';
import 'package:party_box/games/spy_game/spy.dart';
import 'package:party_box/games/wink_game/wink.dart';

List gamesList = [
  Spy(languageChosen: false).label,
  const Wink().label,
  Charades(languageChosen: false).label,
  Pantomime(languageChosen: false).label,
];
const List languageTags = ['en', 'fa'];
