import 'dart:math';

import 'package:proyekmobile/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> getProductController(Request request) async {
    final products = await Product().query().get();
    return Response.json({'message': products});
  }

  Future<Response> createProductController(Request request, vendID) async {
    final prodName = request.input('prodName');
    final prodDesc = request.input('prodDesc');
    final prodPrice = request.input('prodPrice');

    final randomID = (Random().nextInt(800000000) + 100000000).toString();

    final result = await Product().query().insert({
      'vend_id': vendID,
      'prod_id': randomID,
      'prod_name': prodName,
      'prod_desc': prodDesc,
      'prod_price': prodPrice,
    });
    return Response.json({'message': "success creating product","product id": randomID, "data": result});
  }

  Future<Response> updateProductController(Request request, prodID) async {
    final Map<String, dynamic> updateData = {};

    final inputFields = [
      ['prod_name', request.input('prodName')],
      ['prod_desc', request.input('prodDesc')],
      ['prod_price', request.input('prodPrice')],
      ['prod_image', request.input('prodImage')],
    ];

    for (var input in inputFields) {
      final fieldName = input[0];
      final fieldValue = input[1];

      if (fieldValue != null) {
        updateData[fieldName] = fieldValue;
      }
    }

    final result =
        await Product().query().where('prod_id', '=', prodID).update(updateData);
    return Response.json({'message': "success updating product", "updated product": {
      "product id": prodID,
      "product name": request.input('prodName'),
      "product description": request.input('prodDesc'),
    },"data": result});
  }

  Future<Response> deleteProductController(Request request, prodID) async {
    final result = await Product().query().where('prod_id', '=', prodID).delete();
    return Response.json({'message': "product deleted", "product id": prodID, "data": result});
  }
}
