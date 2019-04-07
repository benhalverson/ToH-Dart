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

  void main() {
    final testBed =
        NgTestBed.forComponent<AppComponent>(ng.AppComponentNgFactory);

    setUp(() async {
      fixture = await testBed.create();
      final context =
          HtmlPageLoaderElement.createFromElement(fixture.rootElement);

      appPO = AppPO.create(context);
    });

    tearDown(disposeAnyRunningTest);

    void basicTests() {
      test('page title', () async {
        expect(await appPO.pageTitle, 'Tour of Heros');
      });

      test('tab title', () async {
        expect(await appPO.tabTitle, 'Heroes');
      });

      test('hero count', () {
        expect(appPO.heroes.length, 10);
      });

      test('no selected heroes', () async {
        expect(await appPO.selected, null);
      });
    }

    void selectHeroTests() {
      const targetHero = {'id': 16, 'name': 'Rubberman'};

      setUp(() async {
        await appPO.selectedHero(5);
      });

      test('is selected', () async {
        expect(await appPO.selected, targetHero);
      });

      test('show hero details', () async {
        expect(await appPO.heroFromDetails, targetHero);
      });

      group('Update Hero:', () {
        const nameSuffix = 'X';
        final updatedHero = Map.from(targetHero);
        updatedHero['name'] = "${targetHero['name']}$nameSuffix";

        setUp(() async {
          await appPO.type(nameSuffix);
        });

        tearDown(() async {
          // restore hero name
          await appPO.clear();
          await appPO.type(targetHero['name']);
        });

        test('name in list is update', () async {
          expect(await appPO.selected, updatedHero);
        });

        test('name in details view is updated', () async {
          expect(await appPO.heroFromDetails, updatedHero);
        });
      });
    }

    group('Basics', basicTests);
    group('Select hero', selectHeroTests);
  }
}
