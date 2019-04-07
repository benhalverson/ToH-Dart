@TestOn('browser')

import 'package:angular_app/app_component.dart';
import 'package:angular_app/app_component.template.dart' as ng;
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:pageloader/html.dart';
import 'app_po.dart';

void main() {
  final testBed =
      NgTestBed.forComponent<AppComponent>(ng.AppComponentNgFactory);
  NgTestFixture<AppComponent> fixture;
  AppPO appPO;

  setUp(() async {
    fixture = await testBed.create();
    final context =
        HtmlPageLoaderElement.createFromElement(fixture.rootElement);
    appPO = AppPO.create(context);
  });

  tearDown(disposeAnyRunningTest);

  const windstormData = <String, dynamic>{'id': 1, 'name': 'Windstorm'};

  test('initial hero properties', () {
    expect(appPO.heroId, windstormData['id']);
    expect(appPO.heroName, windstormData['name']);
  });
}
