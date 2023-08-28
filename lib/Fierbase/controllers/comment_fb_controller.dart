import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Models/fb/comment_model.dart';

class CommentFbController{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = "comments";

  Future<bool> addComment(CommentModel comment) async {
    await _firestore
        .collection(_collection)
        .doc(comment.id)
        .set(comment.toJson()).then((value) => true)
        .catchError((exception) => false);
    return true;
  }

  Stream<QuerySnapshot<CommentModel>> readComments(String id) async* {
    yield* _firestore
        .collection(_collection)
        .where('product.id', isEqualTo:  id)
        .withConverter<CommentModel>(
      fromFirestore: (snapshot, options) =>
          CommentModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

}