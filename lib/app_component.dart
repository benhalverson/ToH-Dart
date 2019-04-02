import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'hero.dart';

@Component(selector: 'my-app', directives: [formDirectives], template: '''
  <div>
  <label>name: </label>
  <input [(ngModel)]="hero.name" placeholder="name">
</div>
  ''')
class AppComponent {
  final title = 'Twitch';
  Hero hero = Hero(1, 'Windstorm');
}
