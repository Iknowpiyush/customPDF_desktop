import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/checkbox_state.dart';

class CheckboxStateNotifier extends StateNotifier<CheckboxState> {
  CheckboxStateNotifier() : super(CheckboxState());

  void toggleEmail(bool value) {
    state = state.copyWith(isEmailChecked: value);
  }

  void toggleWebsite(bool value) {
    state = state.copyWith(isWebsiteChecked: value);
  }

  void toggleShowValue(bool value) {
    state = state.copyWith(isShowValueChecked: value);
  }

  void toggleTerms(bool value) {
    state = state.copyWith(isTermsChecked: value);
  }

}