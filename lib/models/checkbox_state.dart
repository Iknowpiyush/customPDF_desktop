class CheckboxState {
  final bool isEmailChecked;
  final bool isWebsiteChecked;
  final bool isShowValueChecked;
  final bool isTermsChecked;

  CheckboxState({
    this.isEmailChecked = true,
    this.isWebsiteChecked = false,
    this.isShowValueChecked = true,
    this.isTermsChecked = true,
  });

  CheckboxState copyWith({
    bool? isEmailChecked,
    bool? isWebsiteChecked,
    bool? isShowValueChecked,
    bool? isTermsChecked,
  }) {
    return CheckboxState(
      isEmailChecked: isEmailChecked ?? this.isEmailChecked,
      isWebsiteChecked: isWebsiteChecked ?? this.isWebsiteChecked,
      isShowValueChecked: isShowValueChecked ?? this.isShowValueChecked,
      isTermsChecked: isTermsChecked ?? this.isTermsChecked,
    );
  }
}