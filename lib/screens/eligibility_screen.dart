import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/eligibility_provider.dart';
import '../utils/dummy_methods.dart';
import '../widgets/app_button.dart';
import '../widgets/meter_gauge.dart';

class EligibilityCheckerScreen extends ConsumerStatefulWidget {
  const EligibilityCheckerScreen({super.key});

  @override
  ConsumerState<EligibilityCheckerScreen> createState() =>
      _EligibilityCheckerScreenState();
}

class _EligibilityCheckerScreenState
    extends ConsumerState<EligibilityCheckerScreen> {
  final PageController _pageController = PageController();

  final _personalInfoKey = GlobalKey<FormState>();
  final _financialKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _emiController = TextEditingController();
  final TextEditingController _ccController = TextEditingController();

  LoanType? _loanType;
  IncomeSource? _incomeSource;

  @override
  void dispose() {
    _pageController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    _emiController.dispose();
    _ccController.dispose();
    super.dispose();
  }

  void _next() {
    final state = ref.read(eligibilityProvider);

    switch (state.currentStep) {
      case 0:
        if (!_personalInfoKey.currentState!.validate()) return;
        ref.read(eligibilityProvider.notifier).updatePersonalInfo(
              age: int.parse(_ageController.text),
              loanType: _loanType,
              incomeSource: _incomeSource,
            );
        break;

      case 1:
        if (!_financialKey.currentState!.validate()) return;
        ref.read(eligibilityProvider.notifier).updateFinancialProfile(
              salary: double.parse(_salaryController.text),
              emi: double.parse(_emiController.text),
              creditCardUsage: double.parse(_ccController.text),
            );
        break;

      case 3:
        Navigator.pop(context);
        return;
    }

    ref.read(eligibilityProvider.notifier).updateCurrentStep(
          state.currentStep + 1,
        );

    _pageController.animateToPage(
      state.currentStep + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _back() {
    final state = ref.read(eligibilityProvider);

    if (state.currentStep == 0) return Navigator.pop(context);

    ref.read(eligibilityProvider.notifier).updateCurrentStep(
          state.currentStep - 1,
        );

    _pageController.animateToPage(
      state.currentStep - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // --------------------------------------------------------------------------
  // MAIN ELIGIBILITY CALCULATION (BANK STANDARD)
  // --------------------------------------------------------------------------
  Map<String, dynamic> _calculate(EligibilityState state) {
    final form = state.formData;

    double salary = form.salary!;
    double emi = form.emi!;
    double ccUsage = form.creditCardUsage!;

    double ccEquivalent = ccUsage * 0.05;
    double obligations = emi + ccEquivalent;

    double dti = obligations / salary;

    // FOIR based on your enums
    double foir = switch (form.incomeSource!) {
      IncomeSource.salary => 0.45,
      IncomeSource.business => 0.60,
      IncomeSource.freelance => 0.55,
      _ => 0.50,
    };

    double permissibleEmi = (salary * foir) - obligations;
    if (permissibleEmi < 0) permissibleEmi = 0;

    // Interest and Tenure based on your enums
    double rate;
    int months;

    switch (form.loanType!) {
      case LoanType.personal:
        rate = 0.12;
        months = 60;
        break;
      case LoanType.home:
        rate = 0.08;
        months = 240;
        break;
      case LoanType.auto:
        rate = 0.09;
        months = 84;
        break;
      case LoanType.education:
        rate = 0.10;
        months = 84;
        break;
    }

    double r = rate / 12;

    double loan = permissibleEmi *
        ((1 - (1 / pow(1 + r, months))) / r);

    // Document check
    final missing = <String>[];
    if (!form.panChecked) missing.add("PAN Card");
    if (!form.aadhaarChecked) missing.add("Aadhaar Card");
    if (!form.payslipsChecked) missing.add("Payslips");

    bool approved =
        dti < 0.45 && permissibleEmi > 2000 && missing.isEmpty;

    return {
      "approved": approved,
      "loanAmount": loan,
      "loanMin": loan * 0.8,
      "loanMax": loan,
      "dti": dti,
      "foir": foir,
      "permissibleEmi": permissibleEmi,
      "rate": rate * 100,
      "months": months,
      "missing": missing,
    };
  }

  // --------------------------------------------------------------------------
  // UI PARTS
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final step = ref.watch(eligibilityProvider).currentStep;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Eligibility Checker"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _back,
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _stepPersonal(),
          _stepFinancial(),
          _stepDocs(),
          _stepResult(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: AppButton(
          label: step == 3 ? "Close" : "Next",
          onPressed: _next,
        ),
      ),
    );
  }

  // STEP 1 --------------------------------------------------------------------
  Widget _stepPersonal() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _personalInfoKey,
        child: ListView(
          children: [
            Text("Step 1: Personal Info",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) {
                int? age = int.tryParse(v ?? "");
                if (age == null || age < 18 || age > 70) {
                  return "Enter age between 18–70";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<LoanType>(
              decoration: const InputDecoration(
                labelText: "Loan Type",
                border: OutlineInputBorder(),
              ),
              items: LoanType.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _loanType = v),
              validator: (v) => v == null ? "Required" : null,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<IncomeSource>(
              decoration: const InputDecoration(
                labelText: "Income Source",
                border: OutlineInputBorder(),
              ),
              items: IncomeSource.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _incomeSource = v),
              validator: (v) => v == null ? "Required" : null,
            ),
          ],
        ),
      ),
    );
  }

  // STEP 2 --------------------------------------------------------------------
  Widget _stepFinancial() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _financialKey,
        child: ListView(
          children: [
            Text("Step 2: Financial Profile",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            TextFormField(
              controller: _salaryController,
              decoration: const InputDecoration(
                labelText: "Monthly Salary (₹)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) =>
                  double.tryParse(v ?? "") == null ? "Invalid" : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emiController,
              decoration: const InputDecoration(
                labelText: "Existing EMI (₹)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) =>
                  double.tryParse(v ?? "") == null ? "Invalid" : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ccController,
              decoration: const InputDecoration(
                labelText: "Monthly Credit Card Usage (₹)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) =>
                  double.tryParse(v ?? "") == null ? "Invalid" : null,
            ),
          ],
        ),
      ),
    );
  }

  // STEP 3 --------------------------------------------------------------------
  Widget _stepDocs() {
    final state = ref.watch(eligibilityProvider);
    final notifier = ref.read(eligibilityProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Text("Step 3: Documentation",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: const Text("PAN Card"),
            value: state.formData.panChecked,
            onChanged: (v) => notifier.updateDocuments(panChecked: v ?? false),
          ),
          CheckboxListTile(
            title: const Text("Aadhaar Card"),
            value: state.formData.aadhaarChecked,
            onChanged: (v) =>
                notifier.updateDocuments(aadhaarChecked: v ?? false),
          ),
          CheckboxListTile(
            title: const Text("Payslips"),
            value: state.formData.payslipsChecked,
            onChanged: (v) =>
                notifier.updateDocuments(payslipsChecked: v ?? false),
          ),
        ],
      ),
    );
  }

  // STEP 4 --------------------------------------------------------------------
  Widget _stepResult() {
     final state = ref.watch(eligibilityProvider);

  // Prevent calculation before user completes all steps
  if (state.currentStep < 3 ||
      state.formData.loanType == null ||
      state.formData.incomeSource == null ||
      state.formData.salary == null ||
      state.formData.emi == null ||
      state.formData.creditCardUsage == null) {
    return const Center(
      child: Text(
        "Please complete all previous steps to see results.",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  // SAFE: Now we can calculate
  final r = _calculate(state);

  bool approved = r["approved"];
  double loanMin = r["loanMin"];
  double loanMax = r["loanMax"];

  return Padding(
    padding: const EdgeInsets.all(20),
    child: ListView(
      children: [
        Text("Final Result",
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),

        MeterGauge(
          value: approved ? 1.0 : 0.0,
          minAmount: loanMin.toInt(),
          maxAmount: loanMax.toInt(),
        ),

        const SizedBox(height: 20),

        Center(
          child: Text(
            approved
                ? "Congratulations! You are eligible."
                : "You are not eligible.",
            style: TextStyle(
              color: approved ? Colors.green : Colors.red,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 20),

        _tile("Debt-to-Income Ratio (DTI)",
            "${(r["dti"] * 100).toStringAsFixed(1)}% (limit: 45%)"),
        _tile("FOIR Limit", "${(r["foir"] * 100).toStringAsFixed(0)}%"),
        _tile("Permissible EMI",
            "₹${r["permissibleEmi"].toStringAsFixed(0)}"),
        _tile("Interest Rate", "${r["rate"].toStringAsFixed(1)}%"),
        _tile("Loan Tenure", "${r["months"]} months"),
        _tile(
            "Estimated Loan Amount",
            "₹${r["loanAmount"].toStringAsFixed(0)}"
        ),

        const SizedBox(height: 20),

        if (r["missing"].isNotEmpty) ...[
          Text("Missing Documents:",
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          for (var m in r["missing"])
            Text("• $m", style: const TextStyle(fontSize: 16)),
        ] else
          const Text("All documents provided!",
              textAlign: TextAlign.center),

        const SizedBox(height: 30),

        AppButton(
          label: "Generate PDF Summary",
          onPressed: () {
            generatePDF();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("PDF summary generation (dummy)"),
            ));
          },
        ),
      ],
    ),
  );
  }

  Widget _tile(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
