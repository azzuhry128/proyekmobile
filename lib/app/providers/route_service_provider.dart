import 'package:vania/vania.dart';
import 'package:proyekmobile/route/api_route.dart';
import 'package:proyekmobile/route/web.dart';
import 'package:proyekmobile/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
    WebSocketRoute().register();
  }
}
