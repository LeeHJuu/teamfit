/// 필터 아이템 모델
class FilterItem<T> {
  /// 표시할 라벨 텍스트
  final String label;

  /// 필터 값 (null이면 전체 선택을 의미)
  final T? value;

  FilterItem(this.label, this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterItem<T> &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          value == other.value;

  @override
  int get hashCode => label.hashCode ^ value.hashCode;
}
