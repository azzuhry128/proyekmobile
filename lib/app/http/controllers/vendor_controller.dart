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
    final vendorAddress = request.input('vendorAddress');
    final vendorKota = request.input('vendorKota');
    final vendorState = request.input('vendorState');
    final vendZip = request.input('vendZip');
    final vendCountry = request.input('vendCountry');

    final randomID = (Random().nextInt(90000) + 10000).toString();

    final result = await Vendor().query().insert({
      'vend_id': randomID,
      'vend_name': vendorName,
      'vend_address': vendorAddress,
      'vend_kota': vendorKota,
      'vend_state': vendorState,
      'vend_zip': vendZip,
      'vend_country': vendCountry
    });
    return Response.json({
      'message': "success creating vendor",
      "created vendor": {
        "vendor id": randomID,
        "vendor name": request.input('vendorName'),
        "vendor address": request.input('vendorAddress'),
        "vendor kota": request.input('vendorKota'),
        "vendor state": request.input('vendorState'),
        "vendor zip": request.input('vendZip'),
        "vendor country": request.input('vendCountry'),
      },
      "data": result
    });
  }

  Future<Response> updateVendorController(Request request, vendID) async {
    final Map<String, dynamic> updateData = {};

    final converted = vendID.toString();

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
        .where('vend_id', '=', converted)
        .update(updateData);
    return Response.json(
        {'message': "success updating vendor", "updated vendor": {
          "vendor id": converted,
          "vendor name": request.input('vendName'),
          "vendor address": request.input('vendAddress'),
          "vendor kota": request.input('vendKota'),
        }, "data": result});
  }

  Future<Response> deleteVendorController(Request request, vendID) async {
    final converted = vendID.toString();

    final result =
        await Vendor().query().where('vend_id', '=', converted).delete();
    return Response.json(
        {'message': "vendor deleted", "vendor id": vendID, "data": result});
  }
}
