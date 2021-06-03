import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../enums/payment_method_enum.dart';
import '../../helper/extensions/context_extensions.dart';
import '../../helper/extensions/string_extension.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//Widgets
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/custom_dialog.dart';
import '../widgets/common/scrollable_column.dart';
import '../widgets/payment/pay_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScrollableColumn(
            children: [
              const SizedBox(height: 20),

              //Back icon and title
              const _BackIconRow(),

              const SizedBox(height: 20),

              //Bill Details White Box
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      //Billing Details Label
                      BillingDetails(),

                      SizedBox(height: 20),

                      //Payment Mode Options
                      PaymentOptions(),

                      SizedBox(height: 20),

                      //Mode Details Form
                      ModeDetailsInput(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //Pay Button
              const PayButton(),

              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackIconRow extends StatelessWidget {
  const _BackIconRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 15),
        InkResponse(
          radius: 25,
          child: const Icon(Icons.arrow_back_sharp, size: 26),
          onTap: () {
            context.router.pop();
          },
        ),

        const SizedBox(width: 65),

        //Title
        Text(
          'Payment Options',
          style: context.headline5.copyWith(fontSize: 20),
        ),

        const Spacer(),
      ],
    );
  }
}

class PaymentOptions extends HookWidget {
  const PaymentOptions();

  @override
  Widget build(BuildContext context) {
    final activePaymentMode = useProvider(paymentsProvider.select((provider) {
      return provider.activePaymentMethod;
    }));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Payment Mode Label
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Payment Mode",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),

        const SizedBox(height: 5),

        //Payment options
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              //COD Button
              Radio<PaymentMethod>(
                value: PaymentMethod.COD,
                fillColor:
                    MaterialStateProperty.all<Color>(Constants.primaryColor),
                activeColor: Constants.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: activePaymentMode,
                onChanged:
                    context.read(paymentsProvider).setActivePaymentMethod,
              ),

              //COD Label
              const Text(
                "Cash On Delivery",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              const SizedBox(width: 20),

              //Card Button
              Radio<PaymentMethod>(
                value: PaymentMethod.CARD,
                fillColor:
                    MaterialStateProperty.all<Color>(Constants.primaryColor),
                activeColor: Constants.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                groupValue: activePaymentMode,
                onChanged:
                    context.read(paymentsProvider).setActivePaymentMethod,
              ),

              //Card Label
              const Text(
                "Card",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BillingDetails extends StatelessWidget {
  const BillingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Billing Details Label
          const Text(
            "Billing Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),

          const SizedBox(height: 15),

          //Billing Summary Labels
          Row(
            children: const [
              SizedBox(
                width: 30,
                child: Text(
                  "Qty",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Ticket Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "Price",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),

          const SizedBox(height: 15),

          //Billing Summary Data
          Row(
            children: const [
              SizedBox(
                width: 30,
                child: Text(
                  "3",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Constants.textGreyColor,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Normal Seat",
                style: TextStyle(
                  fontSize: 16,
                  color: Constants.textGreyColor,
                ),
              ),
              Spacer(),
              Text(
                "${Constants.ticketPrice}",
                style: TextStyle(
                  fontSize: 16,
                  color: Constants.textGreyColor,
                ),
              )
            ],
          ),

          const Divider(color: Colors.black, thickness: 0.8),

          //Billing Total
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "Total - Rs. ${3 * Constants.ticketPrice}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ModeDetailsInput extends StatefulHookWidget {
  const ModeDetailsInput({Key? key}) : super(key: key);

  @override
  _ModeDetailsInputState createState() => _ModeDetailsInputState();
}

class _ModeDetailsInputState extends State<ModeDetailsInput> {
  bool _formHasData = false;
  late final formKey = GlobalKey<FormState>();

  Future<bool> _showConfirmDialog() async {
    if (_formHasData) {
      final doPop = await showDialog<bool>(
        context: context,
        barrierColor: Constants.barrierColor,
        builder: (ctx) => const CustomDialog.confirm(
          title: "Are you sure?",
          body: "Do you want to go back without saving your form data?",
          trueButtonText: "Yes",
          falseButtonText: "No",
        ),
      );
      if (doPop == null || !doPop) return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final deliveryAddressController = useTextEditingController(text: "");
    final zipcodeController = useTextEditingController(text: "");
    final promoCodeController = useTextEditingController(text: "");
    final creditCardNumberController = useTextEditingController(text: "");
    final creditCardCVVController = useTextEditingController(text: "");
    final creditCardExpiryController = useTextEditingController(text: "");

    final activeMode = useProvider(paymentsProvider.select((provider) {
      return provider.activePaymentMethod;
    }));
    final isCOD = activeMode == PaymentMethod.COD ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: formKey,
        onChanged: () {
          if (!_formHasData) _formHasData = true;
        },
        onWillPop: _showConfirmDialog,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 550),
          switchOutCurve: Curves.easeInBack,
          child: isCOD
              ? _CashOnDeliveryDetailFields(
                  deliveryAddressController: deliveryAddressController,
                  zipcodeController: zipcodeController,
                  promoCodeController: promoCodeController,
                )
              : _CardDetailFields(
                  creditCardNumberController: creditCardNumberController,
                  creditCardCVVController: creditCardCVVController,
                  creditCardExpiryController: creditCardExpiryController,
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
      children: [
        const Text(
          "Delivery Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),

        const SizedBox(height: 10),

        //Delivery Address
        CustomTextField(
          controller: deliveryAddressController,
          floatingText: "Delivery address",
          hintText: "Enter delivery address",
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          validator: (deliveryAddress) {
            if (deliveryAddress!.isEmpty) {
              return "Please enter a delivery address";
            }
            return null;
          },
        ),

        const SizedBox(height: 5),

        //Zipcode
        CustomTextField(
          controller: zipcodeController,
          floatingText: "Zip Code",
          hintText: "Enter zip code",
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: (zipCode) {
            if (zipCode != null && zipCode.isValidZipCode) return null;
            return "Please enter a valid zip code";
          },
        ),

        const SizedBox(height: 5),

        //Promo Code
        CustomTextField(
          controller: promoCodeController,
          floatingText: "Promo code",
          hintText: "Enter promo code",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          validator: (_) {},
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
      children: [
        const Text(
          "Card Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),

        const SizedBox(height: 10),

        //Credit Card Number
        CustomTextField(
          controller: creditCardNumberController,
          floatingText: "Credit Card Number",
          hintText: "Enter credit card number",
          maxLength: 16,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: (ccNumber) {
            if (ccNumber != null && ccNumber.isValidCreditCardNumber) {
              return null;
            }
            return "Please enter a valid credit card number";
          },
        ),

        const SizedBox(height: 5),

        //Credit Card CVV
        CustomTextField(
          controller: creditCardCVVController,
          floatingText: "CVV",
          hintText: "Enter CVV",
          maxLength: 3,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: (cvv) {
            if (cvv != null && cvv.isValidCreditCardCVV) return null;
            return "Please enter a valid zip code";
          },
        ),

        const SizedBox(height: 5),

        //Credit Card Expiry Date
        CustomTextField(
          controller: creditCardExpiryController,
          floatingText: "Expiry Date (MM/YYYY)",
          hintText: "Enter expiry date",
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.done,
          validator: (expiry) {
            if (expiry != null && expiry.isValidCreditCardExpiry) return null;
            return "Please enter an expiry date";
          },
        ),
      ],
    );
  }
}
