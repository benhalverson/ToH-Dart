import 'dart:async';
import 'package:pageloader/pageloader.dart';

part 'app_po.g.dart';

@PageObject()
abstract class AppPO {
  AppPO();
  factory AppPO.create(PageLoaderElement content) = $AppPO.create;

  @First(ByCss('div'))
  PageLoaderElement get _id;

  int get heroId {
    final idAsString = _id.visibleText.split(':')[1];
    return int.tryParse(idAsString) ?? -1;
  }

  @ByTagName('h2')
  PageLoaderElement get _heroName;

  @ByTagName('li')
  List<PageLoaderElement> get _heroes;

  Iterable<Map> get heroes =>
      _heroes.map((el) => _heroDataFromLi(el.visibleText));

  Map<String, dynamic> _heroDataFromLi(String liText) {
    final matches = RegExp((r'^(\d+) (.*)$')).firstMatch(liText);
    return _heroData(matches[1], matches[2]);
  }

  String get heroName => _heroName.visibleText;
}
