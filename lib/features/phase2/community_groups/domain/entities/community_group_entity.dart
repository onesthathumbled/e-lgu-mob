import 'package:equatable/equatable.dart';

/// Community group entity
class CommunityGroupEntity extends Equatable {
  const CommunityGroupEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.creatorId,
    required this.createdAt,
    required this.memberCount,
    required this.isPublic,
    required this.isActive,
    this.coverImage,
    this.rules,
    this.tags,
    this.location,
    this.contactInfo,
    this.website,
    this.socialMedia,
    this.moderators,
    this.pinnedPosts,
  });

  final String id;
  final String name;
  final String description;
  final GroupCategory category;
  final String creatorId;
  final DateTime createdAt;
  final int memberCount;
  final bool isPublic;
  final bool isActive;
  final String? coverImage;
  final List<String>? rules;
  final List<String>? tags;
  final String? location;
  final String? contactInfo;
  final String? website;
  final Map<String, String>? socialMedia;
  final List<String>? moderators;
  final List<String>? pinnedPosts;

  /// Is group moderated
  bool get isModerated => moderators != null && moderators!.isNotEmpty;

  /// Is group popular (more than 100 members)
  bool get isPopular => memberCount > 100;

  /// Is group new (created within last 30 days)
  bool get isNew {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return createdAt.isAfter(thirtyDaysAgo);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        creatorId,
        createdAt,
        memberCount,
        isPublic,
        isActive,
        coverImage,
        rules,
        tags,
        location,
        contactInfo,
        website,
        socialMedia,
        moderators,
        pinnedPosts,
      ];

  @override
  String toString() {
    return 'CommunityGroupEntity(id: $id, name: $name, memberCount: $memberCount)';
  }
}

/// Group post entity
class GroupPostEntity extends Equatable {
  const GroupPostEntity({
    required this.id,
    required this.groupId,
    required this.authorId,
    required this.authorName,
    required this.content,
    required this.postType,
    required this.createdAt,
    required this.isPinned,
    required this.isLocked,
    this.attachments,
    required this.likes,
    required this.comments,
    required this.shares,
    this.tags,
    this.location,
    this.editedAt,
    this.deletedAt,
  });

  final String id;
  final String groupId;
  final String authorId;
  final String authorName;
  final String content;
  final PostType postType;
  final DateTime createdAt;
  final bool isPinned;
  final bool isLocked;
  final List<String>? attachments;
  final int likes;
  final int comments;
  final int shares;
  final List<String>? tags;
  final String? location;
  final DateTime? editedAt;
  final DateTime? deletedAt;

  /// Is post deleted
  bool get isDeleted => deletedAt != null;

  /// Is post edited
  bool get isEdited => editedAt != null;

  /// Is post popular (more than 10 likes)
  bool get isPopular => likes > 10;

  /// Is post recent (created within last 24 hours)
  bool get isRecent {
    final twentyFourHoursAgo = DateTime.now().subtract(const Duration(hours: 24));
    return createdAt.isAfter(twentyFourHoursAgo);
  }

  @override
  List<Object?> get props => [
        id,
        groupId,
        authorId,
        authorName,
        content,
        postType,
        createdAt,
        isPinned,
        isLocked,
        attachments,
        likes,
        comments,
        shares,
        tags,
        location,
        editedAt,
        deletedAt,
      ];

  @override
  String toString() {
    return 'GroupPostEntity(id: $id, authorName: $authorName, postType: $postType)';
  }
}

/// Group comment entity
class GroupCommentEntity extends Equatable {
  const GroupCommentEntity({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.authorName,
    required this.content,
    required this.createdAt,
    this.parentCommentId,
    required this.likes,
    required this.replies,
    this.editedAt,
    this.deletedAt,
  });

  final String id;
  final String postId;
  final String authorId;
  final String authorName;
  final String content;
  final DateTime createdAt;
  final String? parentCommentId;
  final int likes;
  final int replies;
  final DateTime? editedAt;
  final DateTime? deletedAt;

  /// Is comment deleted
  bool get isDeleted => deletedAt != null;

  /// Is comment edited
  bool get isEdited => editedAt != null;

  /// Is comment a reply
  bool get isReply => parentCommentId != null;

  @override
  List<Object?> get props => [
        id,
        postId,
        authorId,
        authorName,
        content,
        createdAt,
        parentCommentId,
        likes,
        replies,
        editedAt,
        deletedAt,
      ];

  @override
  String toString() {
    return 'GroupCommentEntity(id: $id, authorName: $authorName)';
  }
}

/// Group poll entity
class GroupPollEntity extends Equatable {
  const GroupPollEntity({
    required this.id,
    required this.groupId,
    required this.creatorId,
    required this.creatorName,
    required this.question,
    required this.options,
    required this.createdAt,
    required this.expiresAt,
    required this.isActive,
    this.allowMultipleVotes,
    this.isAnonymous,
    this.totalVotes,
    this.voterIds,
  });

  final String id;
  final String groupId;
  final String creatorId;
  final String creatorName;
  final String question;
  final List<PollOptionEntity> options;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isActive;
  final bool? allowMultipleVotes;
  final bool? isAnonymous;
  final int? totalVotes;
  final List<String>? voterIds;

  /// Is poll expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Is poll active
  bool get isCurrentlyActive => isActive && !isExpired;

  /// Days until expiry
  int get daysUntilExpiry => expiresAt.difference(DateTime.now()).inDays;

  @override
  List<Object?> get props => [
        id,
        groupId,
        creatorId,
        creatorName,
        question,
        options,
        createdAt,
        expiresAt,
        isActive,
        allowMultipleVotes,
        isAnonymous,
        totalVotes,
        voterIds,
      ];

  @override
  String toString() {
    return 'GroupPollEntity(id: $id, question: $question, isActive: $isActive)';
  }
}

/// Poll option entity
class PollOptionEntity extends Equatable {
  const PollOptionEntity({
    required this.id,
    required this.text,
    required this.voteCount,
    this.voterIds,
  });

  final String id;
  final String text;
  final int voteCount;
  final List<String>? voterIds;

  /// Vote percentage
  double get votePercentage {
    if (voterIds == null || voterIds!.isEmpty) return 0.0;
    return (voteCount / voterIds!.length) * 100;
  }

  @override
  List<Object?> get props => [
        id,
        text,
        voteCount,
        voterIds,
      ];

  @override
  String toString() {
    return 'PollOptionEntity(id: $id, text: $text, voteCount: $voteCount)';
  }
}

/// Group category enum
enum GroupCategory {
  neighborhood,
  hobby,
  professional,
  religious,
  educational,
  sports,
  cultural,
  environmental,
  health,
  business,
  other,
}

/// Post type enum
enum PostType {
  text,
  image,
  video,
  link,
  poll,
  announcement,
  event,
  question,
}
