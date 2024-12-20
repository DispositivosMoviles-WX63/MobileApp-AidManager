import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/comment_card.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/dialog/successfully_post_submit_saved_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/dialog/sucessfull_post_rating_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/new_comment_bottom_modal.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/no_comments_yet.dart';
import 'package:aidmanager_mobile/features/posts/shared/widgets/custom_error_posts_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  final bool isFavorite;
  static const String name = "posts_detail_screen";

  const PostDetailScreen({
    super.key,
    required this.postId,
    required this.isFavorite,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  // esto es para simular el efecto de pintado del corazon solo es superficial su efecto
  bool clickedFavorite = false;

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadThreadInformation();
  }

  Future<void> _loadThreadInformation() async {
    final postId = int.parse(widget.postId);
    await context.read<PostProvider>().loadThreadByPost(postId);
  }

  Future<void> onSubmitSaved(int postId) async {
    final postProvider = context.read<PostProvider>();

    postProvider.addPostAsSaved(postId);
  }

  Future<void> onSubmitnewComment() async {
    final comment = _commentController.text;

    if (comment.isEmpty) {
      showCustomizeDialog(context, IsEmptyDialog());
      return;
    }

    final postProvider = context.read<PostProvider>();

    try {
      await postProvider.createNewCommentInPost(
          int.parse(widget.postId), comment);
    } catch (e) {
      if (!mounted) return;
      // mostrar un dialog perzonalizado para cada exception
      final dialog = getPostErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  Future<void> onSubmitRating(int postId) async {
    final postProvider = context.read<PostProvider>();

    try {
      postProvider.updateRating(postId);

      showCustomizeDialog(context, SucessfullPostRatingDialog());
    } catch (e) {
      throw Exception('Error to update rating for post with id: $postId');
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: true);
    final post = postProvider.selectedPost;

    String formattedDate = post?.postTime != null
        ? DateFormat('dd MMM yyyy').format(post!.postTime!)
        : 'Unknown date';

    return RefreshIndicator(
      onRefresh: _loadThreadInformation,
      child: postProvider.isLoading
          ? Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    color: CustomColors.darkGreen,
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: 70.0,
                automaticallyImplyLeading: false,
                backgroundColor: CustomColors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go('/posts');
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 32.0,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            clickedFavorite ||
                                    post!.isFavorite ||
                                    widget.isFavorite
                                ? Icons.bookmark
                                : Icons.bookmark_border_outlined,
                            color: clickedFavorite ||
                                    post!.isFavorite ||
                                    widget.isFavorite
                                ? Colors.black87
                                : Colors.black87,
                            size: 32.0,
                          ),
                          onPressed: clickedFavorite ||
                                  post!.isFavorite ||
                                  widget.isFavorite
                              ? null
                              : () {
                                  setState(() {
                                    clickedFavorite = true;
                                  });
                                  onSubmitSaved(post.id!);
                                  if (!mounted) return;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SuccessfullyPostSubmitSavedDialog();
                                    },
                                  );
                                },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            post!.hasLiked
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            size: 32.0,
                            color: post.hasLiked ? Colors.red : Colors.black,
                          ),
                          onPressed: () async {
                            await onSubmitRating(int.parse(widget.postId));
                            setState(() {
                              post.hasLiked = !post.hasLiked;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: const Color.fromARGB(255, 189, 189, 189),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 30.0,
                          top: 5.0,
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 28.0,
                                      child: ClipOval(
                                        child: FadeInImage.assetNetwork(
                                          width: double.infinity,
                                          placeholder:
                                              'assets/images/profile-placeholder.jpg',
                                          image: post?.userImage ??
                                              'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                                          fit: BoxFit.cover,
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/profile-placeholder.jpg',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              post?.userName ?? 'No name',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 14,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 22.0,
                                                  color: CustomColors.darkGreen,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'Autor',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          post?.email ?? '',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 18),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    post?.title ?? 'No title',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      height: 1.65,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    post?.description ?? 'no desc',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      height: 1.65,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    post!.images[0],
                                    width: double.infinity,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/placeholder-image.webp',
                                        width: double.infinity,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.comment,
                                                size: 20.0,
                                                color: const Color.fromARGB(
                                                    255, 114, 114, 114)),
                                            SizedBox(width: 5),
                                            Text(
                                              '${post.commentsList?.length.toString() ?? ''} reviews',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color: const Color.fromARGB(
                                                    255, 75, 75, 75),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.thumb_up_rounded,
                                                size: 20.0,
                                                color: const Color.fromARGB(
                                                    255, 114, 114, 114)),
                                            SizedBox(width: 5),
                                            Text(
                                              '${post.rating.toString()} likes',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color: const Color.fromARGB(
                                                    255, 75, 75, 75),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month,
                                            size: 20.0,
                                            color: const Color.fromARGB(
                                              255,
                                              114,
                                              114,
                                              114,
                                            )),
                                        SizedBox(width: 6),
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: const Color.fromARGB(
                                                255, 75, 75, 75),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    post.commentsList?.isEmpty ?? true
                        ? NoCommentsYet(
                            onAddComment: () => showBottomModalComment(context),
                          )
                        : Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: CustomColors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Comentarios:',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          showBottomModalComment(context);
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add_rounded,
                                              color: CustomColors.darkGreen,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Add new comment',
                                              style: TextStyle(
                                                color: CustomColors.darkGreen,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: post.commentsList?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final comment = post.commentsList![index];
                                  return CommentCard(
                                    userImage: comment.userImage!,
                                    userEmail: comment.userEmail!,
                                    userName: comment.userName!,
                                    comment: comment.comment,
                                    postId: comment.postId!,
                                    timeOfComment: comment.commentTime!,
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  void showBottomModalComment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return NewCommentBottomModal(
          onSubmitComment: onSubmitnewComment,
          commentController: _commentController,
        );
      },
    );
  }
}
