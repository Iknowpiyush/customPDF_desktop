import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/checkbox_state.dart';
import '../viewmodels/checkbox_state_notifier.dart';
import '../viewmodels/pdf_notifier.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final dropdownSelectionProvider = StateProvider<String?>((ref) => null);
final checkboxStateProvider = StateNotifierProvider<CheckboxStateNotifier, CheckboxState>((ref) {return CheckboxStateNotifier();});
final pdfProvider = StateNotifierProvider<PdfNotifier, AsyncValue<void>>((ref) => PdfNotifier());
