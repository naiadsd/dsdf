import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const allowLikesTitle = 'Allow likes';
  static const allowLikesDescription =
      'By allowing likes, users will be able to press the like button on your post.';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'By allowing comments, users will be able to comment on your post.';
  static const allowCommentsStorageKey = 'allow_comments';

  static const comment = 'comment';

  static const loading = 'Loading...';

  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';
  static const refreshItems = 'Please wait while we refresh items for you';
  static const delete = 'Delete';
  static const areYouSureYouWantToDeleteThis =
      'Are you sure you want to delete this';

  // log out
  static const logOut = 'Log out';
  static const areYouSureThatYouWantToLogOutOfTheApp =
      'Are you sure that you want to log out of the app?';
  static const cancel = 'Cancel';

  static const refreshCustomers =
      'Local data will be refreshed based on your selection please wait';
  static const refreshPromos = 'Promos will be refreshed ';
  static const generateInvoice =
      'Please wait while we are generating your invoice...';

  const Strings._();
}
