import 'package:proyekmobile/app/http/controllers/customer_controller.dart';
import 'package:vania/vania.dart';
import 'package:proyekmobile/app/http/controllers/home_controller.dart';
import 'package:proyekmobile/app/http/middleware/authenticate.dart';
import 'package:proyekmobile/app/http/middleware/home_middleware.dart';
import 'package:proyekmobile/app/http/middleware/error_response_middleware.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.get("/home", homeController.index);

    Router.get("/hello-world", () {
      return Response.html('Hello World');
    }).middleware([HomeMiddleware()]);

    // Return error code 400
    Router.get('wrong-request',
            () => Response.json({'message': 'Hi wrong request'}))
        .middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);

    // customers
    Router.get("/customer", CustomerController().getAllCustomer);

    Router.post("/customer/create", CustomerController().createCustomer);

    Router.put("/customer/update/{id}", CustomerController().updateCustomer);

    Router.delete("/customers/{cust_id}", () {
      return Response.html('deleted customers');
    });

    // orders
    Router.get("/orders", () {
      return Response.html('orders');
    });

    Router.post("/orders", () {
      return Response.html('created orders');
    });

    Router.put("/orders/{order_num}", () {
      return Response.html('updated orders');
    });

    Router.delete("/orders/{order_num}", () {
      return Response.html('deleted orders');
    });

    // orderitems
    Router.get("/orderitems", () {
      return Response.html('orderitems');
    });

    Router.post("/orderitems", () {
      return Response.html('created orderitems');
    });

    Router.put("/orderitems/{order_item}", () {
      return Response.html('updated orders');
    });

    Router.delete("/orderitems/{order_item}", () {
      return Response.html('deleted orderitems');
    });

    // products
    Router.get("/products", () {
      return Response.html('products');
    });

    Router.post("/products", () {
      return Response.html('created products');
    });

    Router.put("/products/{prod_id}", () {
      return Response.html('updated orders');
    });

    Router.delete("/products/{prod_id}", () {
      return Response.html('deleted products');
    });

    // productnotes
    Router.get("/productnotes", () {
      return Response.html('productnotes');
    });

    Router.post("/productnotes", () {
      return Response.html('created productnotes');
    });

    Router.put("/productnotes/{note_id}", () {
      return Response.html('updated productnotes');
    });

    Router.delete("/productnotes/{note_id}", () {
      return Response.html('deleted productnotes');
    });

    // vendors
    Router.get("/vendor", () {
      return Response.html('vendor');
    });

    Router.post("/vendor", () {
      return Response.html('created vendor');
    });

    Router.put("/vendor/{vend_id}", () {
      return Response.html('updated vendor');
    });

    Router.delete("/vendor/{vend_id}", () {
      return Response.html('deleted vendor');
    });
  }
}
