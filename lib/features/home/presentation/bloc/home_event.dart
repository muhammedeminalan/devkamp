sealed class HomeEvent {
  const HomeEvent();
}

// Home ekranı açıldığında kategori ve ilerleme verisini birlikte yüklemek için tetiklenir.
class HomeDataLoaded extends HomeEvent {
  const HomeDataLoaded();
}
