import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart' as dummy;

enum LoanType { personal, home, auto, education }

enum IncomeSource { salary, business, freelance, other }

class EligibilityFormData {
  int? age;
  LoanType? loanType;
  IncomeSource? incomeSource;

  double? salary;
  double? emi;
  double? creditCardUsage;

  bool panChecked;
  bool aadhaarChecked;
  bool payslipsChecked;

  EligibilityFormData({
    this.age,
    this.loanType,
    this.incomeSource,
    this.salary,
    this.emi,
    this.creditCardUsage,
    this.panChecked = false,
    this.aadhaarChecked = false,
    this.payslipsChecked = false,
  });
}

class EligibilityResult {
  final bool approved;
  final int eligibleAmountMin;
  final int eligibleAmountMax;
  final List<String> missingDocuments;

  EligibilityResult({
    required this.approved,
    required this.eligibleAmountMin,
    required this.eligibleAmountMax,
    required this.missingDocuments,
  });
}

class EligibilityState {
  final int currentStep;
  final EligibilityFormData formData;
  final EligibilityResult? result;

  EligibilityState({
    required this.currentStep,
    required this.formData,
    required this.result,
  });

  EligibilityState copyWith({
    int? currentStep,
    EligibilityFormData? formData,
    EligibilityResult? result,
  }) {
    return EligibilityState(
      currentStep: currentStep ?? this.currentStep,
      formData: formData ?? this.formData,
      result: result ?? this.result,
    );
  }
}

final eligibilityProvider =
    StateNotifierProvider<EligibilityNotifier, EligibilityState>((ref) {
      return EligibilityNotifier();
    });

class EligibilityNotifier extends StateNotifier<EligibilityState> {
  EligibilityNotifier()
    : super(
        EligibilityState(
          currentStep: 0,
          formData: EligibilityFormData(),
          result: null,
        ),
      );

  void updateCurrentStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void updatePersonalInfo({
    int? age,
    LoanType? loanType,
    IncomeSource? incomeSource,
  }) {
    final newData = state.formData;
    if (age != null) newData.age = age;
    if (loanType != null) newData.loanType = loanType;
    if (incomeSource != null) newData.incomeSource = incomeSource;
    state = state.copyWith(formData: newData);
  }

  void updateFinancialProfile({
    double? salary,
    double? emi,
    double? creditCardUsage,
  }) {
    final newData = state.formData;
    if (salary != null) newData.salary = salary;
    if (emi != null) newData.emi = emi;
    if (creditCardUsage != null) newData.creditCardUsage = creditCardUsage;
    state = state.copyWith(formData: newData);
  }

  void updateDocuments({
    bool? panChecked,
    bool? aadhaarChecked,
    bool? payslipsChecked,
  }) {
    final newData = state.formData;
    if (panChecked != null) newData.panChecked = panChecked;
    if (aadhaarChecked != null) newData.aadhaarChecked = aadhaarChecked;
    if (payslipsChecked != null) newData.payslipsChecked = payslipsChecked;
    state = state.copyWith(formData: newData);
  }

  Future<void> runEligibilityCheck() async {
    final dataMap = {
      'age': state.formData.age,
      'loanType': state.formData.loanType?.name,
      'incomeSource': state.formData.incomeSource?.name,
      'salary': state.formData.salary,
      'emi': state.formData.emi,
      'creditCardUsage': state.formData.creditCardUsage,
      'panChecked': state.formData.panChecked,
      'aadhaarChecked': state.formData.aadhaarChecked,
      'payslipsChecked': state.formData.payslipsChecked,
    };
    final resultMap = await dummy.runEligibilityCheck(dataMap);
    final missingDocs = <String>[];
    if (!(state.formData.panChecked)) missingDocs.add('PAN Card');
    if (!(state.formData.aadhaarChecked)) missingDocs.add('Aadhaar Card');
    if (!(state.formData.payslipsChecked)) missingDocs.add('Payslips');
    final result = EligibilityResult(
      approved: resultMap['approved'] as bool? ?? false,
      eligibleAmountMin: resultMap['eligibleAmountMin'] as int? ?? 0,
      eligibleAmountMax: resultMap['eligibleAmountMax'] as int? ?? 0,
      missingDocuments: missingDocs,
    );
    state = state.copyWith(result: result);
  }

  void reset() {
    state = EligibilityState(
      currentStep: 0,
      formData: EligibilityFormData(),
      result: null,
    );
  }
}
