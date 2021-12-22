import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../enums/payment_method_enum.dart';
import '../../../helper/utils/form_validator.dart';
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/payments_provider.dart';

//Widgets
import '../common/custom_dialog.dart';
import '../common/custom_textfield.dart';

class ModeDetailsInput extends StatefulHookConsumerWidget {
  const ModeDetailsInput({Key? key}) : super(key: key);

  @override
  _ModeDetailsInputState createState() => _ModeDetailsInputState();
}

class _ModeDetailsInputState extends ConsumerState<ModeDetailsInput> {
  bool _formHasData = false;
  late final formKey = GlobalKey<FormState>();

  Future<bool> _showConfirmDialog() async {
    if (_formHasData) {
      final doPop = await showDialog<bool>(
        context: context,
        barrierColor: Constants.barrierColor,
        builder: (ctx) => const CustomDialog.confirm(
          title: 'Are you sure?',
          body: 'Do you want to go back without saving your form data?',
          trueButtonText: 'Yes',
          falseButtonText: 'No',
        ),
      );
      if (doPop == null || !doPop) return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  void onFormChanged() {
    if (!_formHasData) _formHasData = true;
  }

  @override
  Widget build(BuildContext context) {
    final deliveryAddressController = useTextEditingController(text: '');
    final branchNameController = useTextEditingController(text: '');
    final zipcodeController = useTextEditingController(text: '');
    final promoCodeController = useTextEditingController(text: '');
    final creditCardNumberController = useTextEditingController(text: '');
    final creditCardCVVController = useTextEditingController(text: '');
    final creditCardExpiryController = useTextEditingController(text: '');
    final activeMode = ref.watch(activePaymentModeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        onChanged: onFormChanged,
        onWillPop: _showConfirmDialog,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 550),
          switchOutCurve: Curves.easeInBack,
          switchInCurve: Curves.easeIn,
          child: activeMode == PaymentMethod.COD
              ? _CashOnDeliveryDetailFields(
                  deliveryAddressController: deliveryAddressController,
                  zipcodeController: zipcodeController,
                  promoCodeController: promoCodeController,
                )
              : activeMode == PaymentMethod.CARD
                  ? _CardDetailFields(
                      creditCardNumberController: creditCardNumberController,
                      creditCardCVVController: creditCardCVVController,
                      creditCardExpiryController: creditCardExpiryController,
                    )
                  : _CashOnHandDetailFields(
                      branchNameController: branchNameController,
                      promoCodeController: promoCodeController,
                    ),
        ),
      ),
    );
  }
}

class _CashOnDeliveryDetailFields extends StatelessWidget {
  final TextEditingController deliveryAddressController;
  final TextEditingController zipcodeController;
  final TextEditingController promoCodeController;

  const _CashOnDeliveryDetailFields({
    Key? key,
    required this.deliveryAddressController,
    required this.zipcodeController,
    required this.promoCodeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 5),

        //Delivery Address
        CustomTextField(
          controller: deliveryAddressController,
          floatingText: 'Delivery address',
          hintText: 'Enter delivery address',
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.addressValidator,
        ),

        const SizedBox(height: 5),

        //Zipcode
        CustomTextField(
          controller: zipcodeController,
          floatingText: 'Zip Code',
          hintText: 'Enter zip code',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: FormValidator.zipCodeValidator,
        ),

        const SizedBox(height: 5),

        //Promo Code
        CustomTextField(
          controller: promoCodeController,
          floatingText: 'Promo code',
          hintText: 'Enter promo code',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          validator: FormValidator.promoCodeValidator,
          prefix: const Icon(
            Icons.local_activity_rounded,
            color: Constants.primaryColor,
          ),
        ),
      ],
    );
  }
}

class _CashOnHandDetailFields extends StatelessWidget {
  final TextEditingController branchNameController;
  final TextEditingController promoCodeController;

  const _CashOnHandDetailFields({
    Key? key,
    required this.branchNameController,
    required this.promoCodeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 5),

        //Branch Name
        CustomTextField(
          controller: branchNameController,
          floatingText: 'Branch Name',
          hintText: 'Enter the branch name',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: FormValidator.branchNameValidator,
        ),

        const SizedBox(height: 5),

        //Promo Code
        CustomTextField(
          controller: promoCodeController,
          floatingText: 'Promo code',
          hintText: 'Enter promo code',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          validator: FormValidator.promoCodeValidator,
          prefix: const Icon(
            Icons.local_activity_rounded,
            color: Constants.primaryColor,
          ),
        ),
      ],
    );
  }
}

class _CardDetailFields extends StatelessWidget {
  final TextEditingController creditCardNumberController;
  final TextEditingController creditCardCVVController;
  final TextEditingController creditCardExpiryController;

  const _CardDetailFields({
    Key? key,
    required this.creditCardNumberController,
    required this.creditCardCVVController,
    required this.creditCardExpiryController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 5),

        //Credit Card Number
        CustomTextField(
          controller: creditCardNumberController,
          floatingText: 'Credit Card Number',
          hintText: 'Enter credit card number',
          maxLength: 16,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: FormValidator.creditCardNumberValidator,
        ),

        const SizedBox(height: 5),

        //Credit Card CVV
        CustomTextField(
          controller: creditCardCVVController,
          floatingText: 'CVV',
          hintText: 'Enter CVV',
          maxLength: 3,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: FormValidator.creditCardCVVValidator,
        ),

        const SizedBox(height: 5),

        //Credit Card Expiry Date
        CustomTextField(
          controller: creditCardExpiryController,
          floatingText: 'Expiry Date (MM/YYYY)',
          hintText: 'Enter expiry date',
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.done,
          validator: FormValidator.creditCardExpiryValidator,
        ),
      ],
    );
  }
}
