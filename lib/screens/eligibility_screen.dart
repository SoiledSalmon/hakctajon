import 'package:ai_loan_buddy/models/document_item.dart';
import 'package:ai_loan_buddy/providers/eligibility_provider.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:ai_loan_buddy/widgets/app_button.dart';
import 'package:ai_loan_buddy/widgets/meter_gauge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EligibilityCheckerScreen extends ConsumerStatefulWidget {
  const EligibilityCheckerScreen({super.key});

  @override
  ConsumerState<EligibilityCheckerScreen> createState() => _EligibilityCheckerScreenState();
}

class _EligibilityCheckerScreenState extends ConsumerState<EligibilityCheckerScreen> {
  final PageController _pageController = PageController();

  final _personalInfoFormKey = GlobalKey<FormState>();
  final _financialProfileFormKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  LoanType? _selectedLoanType;
  IncomeSource? _selectedIncomeSource;

  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _emiController = TextEditingController();
  final TextEditingController _ccUsageController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    _emiController.dispose();
    _ccUsageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    final state = ref.read(eligibilityProvider);

    switch (state.currentStep) {
      case 0:
        if (!_personalInfoFormKey.currentState!.validate()) return;
        ref.read(eligibilityProvider.notifier).updatePersonalInfo(
              age: int.tryParse(_ageController.text),
              loanType: _selectedLoanType,
              incomeSource: _selectedIncomeSource,
            );
        break;
      case 1:
        if (!_financialProfileFormKey.currentState!.validate()) return;
        ref.read(eligibilityProvider.notifier).updateFinancialProfile(
              salary: double.tryParse(_salaryController.text),
              emi: double.tryParse(_emiController.text),
              creditCardUsage: double.tryParse(_ccUsageController.text),
            );
        break;
      case 2:
        // Documentation step handled below
        break;
      case 3:
        // Result screen - no next
        return;
    }

    final nextStep = state.currentStep + 1;
    ref.read(eligibilityProvider.notifier).updateCurrentStep(nextStep);
    _pageController.animateToPage(
      nextStep,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _previousStep() {
    final state = ref.read(eligibilityProvider);
    if (state.currentStep == 0) {
      Navigator.of(context).pop();
      return;
    }
    final prevStep = state.currentStep - 1;
    ref.read(eligibilityProvider.notifier).updateCurrentStep(prevStep);
    _pageController.animateToPage(
      prevStep,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eligibilityProvider);
    final notifier = ref.read(eligibilityProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eligibility Checker'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _previousStep,
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildPersonalInfoStep(),
            _buildFinancialProfileStep(),
            _buildDocumentationStep(),
            _buildResultStep(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            if (state.currentStep > 0)
              Expanded(
                child: AppButton(
                  label: 'Back',
                  onPressed: _previousStep,
                ),
              ),
            if (state.currentStep > 0) const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                label: state.currentStep == 3 ? 'Close' : 'Next',
                onPressed: state.currentStep == 3 ? () => Navigator.of(context).pop() : _nextStep,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    final state = ref.watch(eligibilityProvider);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _personalInfoFormKey,
        child: ListView(
          children: [
            Text(
              'Step 1: Personal Info',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                final age = int.tryParse(val ?? '');
                if (age == null || age < 18 || age > 99) {
                  return 'Enter a valid age (18-99)';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<LoanType>(
              initialValue: _selectedLoanType,
              decoration: const InputDecoration(
                labelText: 'Loan Type',
                border: OutlineInputBorder(),
              ),
              items: LoanType.values
                  .map(
                    (lt) => DropdownMenuItem(
                      value: lt,
                      child: Text(lt.name[0].toUpperCase() + lt.name.substring(1)),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() => _selectedLoanType = val),
              validator: (val) => val == null ? 'Select a loan type' : null,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<IncomeSource>(
              initialValue: _selectedIncomeSource,
              decoration: const InputDecoration(
                labelText: 'Income Source',
                border: OutlineInputBorder(),
              ),
              items: IncomeSource.values
                  .map(
                    (isrc) => DropdownMenuItem(
                      value: isrc,
                      child: Text(isrc.name[0].toUpperCase() + isrc.name.substring(1)),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() => _selectedIncomeSource = val),
              validator: (val) => val == null ? 'Select income source' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialProfileStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _financialProfileFormKey,
        child: ListView(
          children: [
            Text(
              'Step 2: Financial Profile',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Salary (₹)',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                final salary = double.tryParse(val ?? '');
                if (salary == null || salary <= 0) {
                  return 'Enter valid salary';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'EMI (₹)',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                final emi = double.tryParse(val ?? '');
                if (emi == null || emi < 0) {
                  return 'Enter valid EMI or 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ccUsageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Credit Card Usage (₹)',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                final usage = double.tryParse(val ?? '');
                if (usage == null || usage < 0) {
                  return 'Enter valid amount or 0';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentationStep() {
    final state = ref.watch(eligibilityProvider);
    final notifier = ref.read(eligibilityProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Text(
            'Step 3: Documentation',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: const Text('PAN Card'),
            value: state.formData.panChecked,
            onChanged: (val) => notifier.updateDocuments(panChecked: val ?? false),
          ),
          CheckboxListTile(
            title: const Text('Aadhaar Card'),
            value: state.formData.aadhaarChecked,
            onChanged: (val) => notifier.updateDocuments(aadhaarChecked: val ?? false),
          ),
          CheckboxListTile(
            title: const Text('Payslips'),
            value: state.formData.payslipsChecked,
            onChanged: (val) => notifier.updateDocuments(payslipsChecked: val ?? false),
          ),
        ],
      ),
    );
  }

  Widget _buildResultStep() {
    final state = ref.watch(eligibilityProvider);
    final result = state.result;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Text(
            'Step 4: Result',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          if (result == null)
            Center(
              child: AppButton(
                label: 'Run Eligibility Check',
                onPressed: () async {
                  await ref.read(eligibilityProvider.notifier).runEligibilityCheck();
                  setState(() {});
                },
              ),
            )
          else ...[
            MeterGauge(
              value: result.approved ? 1.0 : 0.0,
              minAmount: result.eligibleAmountMin,
              maxAmount: result.eligibleAmountMax,
            ),
            const SizedBox(height: 24),
            Text(
              result.approved ? 'Congratulations! You are eligible.' : 'Sorry, you are not eligible.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: result.approved ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            if (result.missingDocuments.isNotEmpty) ...[
              Text(
                'Missing Documents:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...result.missingDocuments.map((doc) => Text('• $doc')),
            ] else
              const Text('All required documents are provided.'),
            const SizedBox(height: 24),
            AppButton(
              label: 'Generate PDF Summary',
              onPressed: () {
                generatePDF();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PDF summary generation (dummy)')),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
