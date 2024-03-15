import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currytabetaiappnihonbashi/src/screens/post/viewmodel/make_post_viewmodel.dart';

class PostService {
  final postsReference =
      FirebaseFirestore.instance.collection('posts').withConverter<Post>(
            fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
            toFirestore: ((post, _) => post.toMap()),
          );

  Stream<QuerySnapshot<Post>> getPostsStream() {
    return postsReference.snapshots();
  }

  Future<void> addPost(Post post) {
    return postsReference.add(post.toMap() as Post);
  }
}
