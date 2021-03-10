import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  // Log into database
  final db = await Db.create(
      'mongodb+srv://saksham:saksham@cluster0.ayj3r.mongodb.net/contactsapp?retryWrites=true&w=majority');
  await db.open();

  final collection = db.collection('contacts');

  // Create server
  const port = 4049;
  final server = Sevr();

  server.get('/', [
    (ServRequest req, ServResponse res) async {
      final contacts = await collection.find().toList();
      return res.status(200).json({'contacts': contacts});
    }
  ]);

  server.post('/register', [
    (ServRequest req, ServResponse res) async {
      await collection.save(req.body);
      return res.json(
        await collection.findOne(where.eq('name', req.body['name'])),
      );
    }
  ]);

  server.delete('/delete/:id', [
    (ServRequest req, ServResponse res) async {
      await collection
          .remove(where.eq('_id', ObjectId.fromHexString(req.params['id'])));
      return res.status(200).json({'nDeleted': 1});
    }
  ]);

  // Listen for connections
  server.listen(port, callback: () {
    print('Listening at localhost:$port');
  });
}
