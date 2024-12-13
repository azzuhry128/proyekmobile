import 'dart:math';

import 'package:proyekmobile/app/models/vendor.dart';
import 'package:vania/vania.dart';

class VendorController extends Controller {
  Future<Response> getVendorController(Request request) async {
    final vendors = await Vendor().query().get();
    return Response.json({'message': vendors});
  }

  Future<Response> createVendorController(Request request) async {
    final vendorName = request.input('vendorName');
    final vendorDesc = request.input('vendorDesc');
    final vendorImage = request.input('vendorImage');

    final randomID = (Random().nextInt(90000) + 10000).toString();

    final result = await Vendor().query().insert({
      'vend_id': randomID,
      'vend_name': vendorName,
      'vend_desc': vendorDesc,
      'vend_image': vendorImage,
    });
    return Response.json({'message': result});
  }

  Future<Response> updateVendorController(Request request, vendID) async {
    final Map<String, dynamic> updateData = {};

    final inputFields = [
      ['vend_name', request.input('vendName')],
      ['vend_address', request.input('vendAddress')],
      ['vend_kota', request.input('vendKota')],
      ['vend_state', request.input('vendState')],
      ['vend_zip', request.input('vendZip')],
      ['vend_country', request.input('vendCountry')],
    ];

    for (var input in inputFields) {
      final fieldName = input[0];
      final fieldValue = input[1];

      if (fieldValue != null) {
        updateData[fieldName] = fieldValue;
      }
    }

    final result = await Vendor()
        .query()
        .where('vendor_id', '=', vendID)
        .update(updateData);
    return Response.json({'message': result});
  }

  Future<Response> deleteVendorController(Request request, vendID) async {
    final result =
        await Vendor().query().where('vendor_id', '=', vendID).delete();
    return Response.json({'message': result});
  }
}
