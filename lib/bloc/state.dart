abstract class MapStates{}
class MapInitailState extends MapStates{}
class LoadingcategoriesMapState extends MapStates{}
class SuccesscategoriesMapState extends MapStates{}
class ErrorcategoriesMapState extends MapStates{
  final String error;
  ErrorcategoriesMapState(this.error);
}
class LoadingItemcategoriesMapState extends MapStates{}
class SuccessItemcategoriesMapState extends MapStates{}
class ErrorItemcategoriesMapState extends MapStates{
  final String error;
  ErrorItemcategoriesMapState(this.error);
}
class LoadingItemDetailMapState extends MapStates{}
class SuccessItemDetailMapState extends MapStates{}
class ErrorItemDetailMapState extends MapStates{
  final String error;
  ErrorItemDetailMapState(this.error);
}


class SuccessPositionState extends MapStates{}
class checkEnternetState extends MapStates{}
class ErrorcheckEnternetState extends MapStates{}


class buttonCkeckState extends MapStates{}
class newPositionState extends MapStates{}
class ClearMarkerState extends MapStates{}
class SuccessPotinMarkerMapState extends MapStates{}