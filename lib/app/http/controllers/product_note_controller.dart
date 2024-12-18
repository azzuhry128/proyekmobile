import 'dart:math';

import 'package:proyekmobile/app/models/productnote.dart';
import 'package:vania/vania.dart';

class ProductNoteController extends Controller {
  Future<Response> getProductNoteController(Request request) async {
    final productNotes = await Productnote().query().get();
    return Response.json({'message': productNotes});
  }

  Future<Response> createProductNoteController(Request request) async {
    final prodId = request.input('prodID');
    final noteDate = request.input('noteDate');
    final noteText = request.input('noteText');

    final randomID = (Random().nextInt(90000) + 10000).toString();

    final result = await Productnote().query().insert({
      'note_id': randomID,
      'prod_id': prodId,
      'note_date': noteDate,
      'note_text': noteText
    });

    return Response.json({
      'message': result,
      'create product note': {
        'note id': randomID,
        'product id': prodId,
        'note date': noteDate,
        'note text': noteText
      },
      'data': result
      });
  }

  Future<Response> updateProductNoteController(Request request, noteID) async {
    final Map<String, dynamic> updateData = {};

    final converted = noteID.toString();

    final inputFields = [
      ['prod_id', request.input('prodID')],
      ['note_date', request.input('noteDate')],
      ['note_text', request.input('noteText')],
    ];

    for (var input in inputFields) {
      final fieldName = input[0];
      final fieldValue = input[1];

      if (fieldValue != null) {
        updateData[fieldName] = fieldValue;
      }
    }

    final result = await Productnote()
        .query()
        .where('prod_id', '=', converted)
        .update(updateData);
    return Response.json({
      'message': "success updating product note",
      "updated product note": {
        'note id': noteID,
        'product id': request.input('prodID'),
        'note date': request.input('noteDate'),
        'note text': request.input('noteText')
      },
      "data": result
      });
  }

  Future<Response> deleteProductNoteController(Request request, noteID) async {
    final converted = noteID.toString();
    final result =
        await Productnote().query().where('prod_id', '=', converted).delete();
    return Response.json({'message': "product note deleted", "product note id": noteID, "data": result});
  }
}
