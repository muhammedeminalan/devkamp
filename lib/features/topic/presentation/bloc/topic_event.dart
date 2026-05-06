sealed class TopicEvent {
  const TopicEvent();
}

// TopicView açıldığında ilgili kategorinin konularını yüklemek için tetiklenir.
class TopicDataLoaded extends TopicEvent {
  const TopicDataLoaded({required this.categoryId});
  final String categoryId;
}
