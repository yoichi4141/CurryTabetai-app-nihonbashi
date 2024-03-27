const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// 投稿が追加されたときに全ユーザーの共有タイムラインに追加する関数
exports.addPostToTimeline = functions.firestore
    .document("posts/{shopId}/{userId}/{postId}")
    .onCreate((snap, context) => {
      // 新たに追加された投稿のデータを取得
      const newPostData = snap.data();
      const {shopId, userId, postId} = context.params;

      // 全ユーザー共有のタイムラインコレクションに追加
      const timelineRef = admin.firestore().collection("timeline").doc(postId);

      return timelineRef.set({
        ...newPostData,
        shopId,
        userId,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      })
          .catch((error) => {
            console.error("Error writing document to timeline:", error);
            throw new functions.https.HttpsError(
                "unknown",
                "Unable to add post to timeline",
                error,
            );
          });
    });
