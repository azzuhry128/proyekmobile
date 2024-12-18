import 'package:proyekmobile/app/http/controllers/customer_controller.dart';
import 'package:proyekmobile/app/http/controllers/order_controller.dart';
import 'package:proyekmobile/app/http/controllers/order_item_controller.dart';
import 'package:proyekmobile/app/http/controllers/product_controller.dart';
import 'package:proyekmobile/app/http/controllers/product_note_controller.dart';
import 'package:proyekmobile/app/http/controllers/vendor_controller.dart';
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

    Router.delete("/customer/delete/{id}", CustomerController().deleteCustomer);

    // orders
    Router.get("/orders", OrderController().getOrderController);
    Router.post("/orders/create", OrderController().createOrderController);
    Router.put(
        "/orders/update/{orderNum}", OrderController().updateOrderController);
    Router.delete(
        "/orders/delete/{orderNum}", OrderController().deleteOrderController);

    // orderitems
    Router.get("/orderitems", OrderItemController().getOrderItemController);
    Router.post("/orderitems/create", OrderItemController().createOrderItemController);
    Router.put("/orderitems/update/{orderItem}",
        OrderItemController().updateorderItemController);
    Router.delete("/orderitems/delete/{orderItem}",
        OrderItemController().deleteOrderItemController);

    // products
    Router.get("/products", ProductController().getProductController);
    Router.post("/products/create/{vendID}", ProductController().createProductController);
    Router.put("/products/update/{prodID}", ProductController().updateProductController);
    Router.delete("/products/delete/{prodID}", ProductController().deleteProductController);

    // productnotes
    Router.get("/productnotes", ProductNoteController().getProductNoteController);

    Router.post("/productnotes/create", ProductNoteController().createProductNoteController);

    Router.put("/productnotes/update/{noteID}", ProductNoteController().updateProductNoteController);

    Router.delete("/productnotes/delete/{noteID}", ProductNoteController().deleteProductNoteController);

    // vendors
    Router.get("/vendors", VendorController().getVendorController);
    Router.post("/vendors/create", VendorController().createVendorController);
    Router.put("/vendors/update/{vendID}", VendorController().updateVendorController);
    Router.delete("/vendors/delete/{vendID}", VendorController().deleteVendorController);
  }
}
