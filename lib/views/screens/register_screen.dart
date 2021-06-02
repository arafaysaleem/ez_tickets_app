import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../helper/extensions/string_extension.dart';
import '../../helper/utils/assets_helper.dart';
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Providers
import '../../providers/all_providers.dart';

//States
import '../../providers/states/auth_state.dart';

//Widgets
import '../widgets/common/custom_dialog.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class RegisterScreen extends StatefulHookWidget {
  const RegisterScreen();

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _formHasData = false;
  late final formKey = GlobalKey<FormState>();
  late final ValueNotifier<bool> userDetailsState = ValueNotifier(true);

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

  CustomTextButton buildNextButton() {
    return CustomTextButton.outlined(
      width: double.infinity,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          userDetailsState.value = false;
        }
      },
      padding: const EdgeInsets.only(left: 20, right: 15),
      border: Border.all(color: Constants.primaryColor,width: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Next",
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),

          //Arrow
          Icon(
            Icons.arrow_forward_sharp,
            size: 26,
            color: Constants.primaryColor,
          )
        ],
      ),
    );
  }

  CustomTextButton buildConfirmButton({
    required String email,
    required String password,
    required String fullName,
    required String address,
    required String contact,
  }) {
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          context.read(authProvider.notifier).register(
            email: email,
            password: password,
            fullName: fullName,
            address: address,
            contact: contact,
          );
        }
      },
      gradient: Constants.buttonGradientOrange,
      child: Consumer(
        builder: (context, watch, child) {
          final authState = watch(authProvider);
          if (authState is AUTHENTICATING) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }
          return child!;
        },
        child: const Center(
          child: Text(
            "CONFIRM",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final cPasswordController = useTextEditingController(text: "");
    final fullNameController = useTextEditingController(text: "");
    final addressController = useTextEditingController(text: "");
    final contactController = useTextEditingController(text: "");

    return Scaffold(
      body: ProviderListener(
        provider: authProvider,
        onChange: (_, authState) async {
          if (authState is AUTHENTICATED) {
            emailController.clear();
            passwordController.clear();
            fullNameController.clear();
            addressController.clear();
            cPasswordController.clear();
            contactController.clear();
            _formHasData = false;
            context.router.popUntilRoot();
          } else if (authState is FAILED) {
            await showDialog<bool>(
              context: context,
              barrierColor: Constants.barrierColor.withOpacity(0.75),
              builder: (ctx) {
                return CustomDialog.alert(
                  title: "Register Failed",
                  body: authState.reason,
                  buttonText: "Retry",
                );
              },
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScrollableColumn(
            children: [
              //Input card
              Form(
                key: formKey,
                onChanged: () {
                  if (!_formHasData) _formHasData = true;
                },
                onWillPop: _showConfirmDialog,
                child: RoundedBottomContainer(
                  onBackTap: !userDetailsState.value
                      ? () => userDetailsState.value = true
                      : null,
                  children: [
                    //Page name
                    Text(
                      "Register",
                      style: context.headline3.copyWith(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (userDetailsState.value)
                      _UserDetailFields(
                        fullNameController: fullNameController,
                        emailController: emailController,
                        addressController: addressController,
                        contactController: contactController,
                      )
                    else
                      _PasswordDetailFields(
                        passwordController: passwordController,
                        cPasswordController: cPasswordController,
                      ),
                  ],
                ),
              ),

              const Spacer(),

              //Button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, Constants.bottomInsets),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 550),
                  switchOutCurve: Curves.easeInBack,
                  child: userDetailsState.value
                      ? buildNextButton()
                      : buildConfirmButton(
                          email: emailController.text,
                          password: passwordController.text,
                          fullName: fullNameController.text,
                          address: addressController.text,
                          contact: contactController.text,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _UserDetailFields extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController contactController;
  final TextEditingController addressController;
  final TextEditingController emailController;

  const _UserDetailFields({
    required this.fullNameController,
    required this.emailController,
    required this.addressController,
    required this.contactController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Full name
        CustomTextField(
          controller: fullNameController,
          autofocus: true,
          floatingText: "Full name",
          hintText: "Type your full name",
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: (fullName) {
            if (fullName != null && fullName.isValidFullName) return null;
            return "Please enter a valid full name";
          },
        ),

        const SizedBox(height: 25),

        //Email
        CustomTextField(
          controller: emailController,
          floatingText: "Email",
          hintText: "Type your email address",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (email) {
            if (email != null && email.isValidEmail) return null;
            return "Please enter a valid email address";
          },
        ),

        const SizedBox(height: 25),

        //Address
        CustomTextField(
          controller: addressController,
          floatingText: "Address",
          hintText: "Type your full address",
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          validator: (address) {
            if (address!.isEmpty) return "Please enter a address";
            return null;
          },
        ),

        const SizedBox(height: 25),

        //Contact
        CustomTextField(
          controller: contactController,
          floatingText: "Contact",
          hintText: "Type your mobile #",
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          prefix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 5, 0),
                child: Image.asset(
                  AssetsHelper.pkFlag,
                  width: 25,
                ),
              ),
              const Text(
                "+92",
                style: TextStyle(
                  fontSize: 18,
                  color: Constants.textWhite80Color,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: VerticalDivider(
                  thickness: 1.1,
                  color: Colors.white,
                ),
              )
            ],
          ),
          validator: (contact) {
            if (contact != null && contact.isValidContact) return null;
            return "Please enter a valid contact";
          },
        ),
      ],
    );
  }
}

class _PasswordDetailFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController cPasswordController;

  const _PasswordDetailFields({
    required this.passwordController,
    required this.cPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Password
        CustomTextField(
          controller: passwordController,
          autofocus: true,
          floatingText: "Password",
          hintText: "Type your password",
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: (password) {
            if (password!.isEmpty) return "Please enter a password";
            return null;
          },
        ),

        const SizedBox(height: 25),

        //Confirm Password
        CustomTextField(
          controller: cPasswordController,
          floatingText: "Confirm Password",
          hintText: "Retype your password",
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (cPassword) {
            if (passwordController.text.trim() == cPassword) return null;
            return "Passwords don't match";
          },
        ),
      ],
    );
  }
}
