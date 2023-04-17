import 'package:amazon_clone/features/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import '../../../Constants/Constants.dart';
import '../../../common/custom_text_field.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key, required this.amount}) : super(key: key);
  static const String screenName = "/address-screen";
  final String amount;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final flatBuildingController = TextEditingController();
  final areaController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<PaymentItem> _paymentItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentItems.add(PaymentItem(
      label: 'Total',
      amount: widget.amount,
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityController.dispose();
    areaController.dispose();
    flatBuildingController.dispose();
    pinCodeController.dispose();
  }

  void onApplePayResult(result) {}

  void onGooglePayResult(result) {}

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().get().address;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      maxLines: 1,
                      address,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    maxLines: 1,
                    "OR",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                      hintText: "Flat",
                      controller: flatBuildingController,
                      callback: (value) {
                        _formKey.currentState!.validate();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      hintText: "Area, street",
                      controller: areaController,
                      callback: (value) {
                        _formKey.currentState!.validate();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      hintText: "Pin code",
                      controller: pinCodeController,
                      callback: (value) {
                        _formKey.currentState!.validate();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      hintText: "Town, City",
                      controller: cityController,
                      callback: (value) {
                        _formKey.currentState!.validate();
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  ApplePayButton(
                    style: ApplePayButtonStyle.whiteOutline,
                    type: ApplePayButtonType.buy,
                    height: 50,
                    width: double.maxFinite,
                    paymentConfigurationAsset: "applepay.json",
                    onPaymentResult: onApplePayResult,
                    paymentItems: _paymentItems,
                  ),
                  GooglePayButton(
                    onPaymentResult: onGooglePayResult,
                    paymentItems: _paymentItems,
                    paymentConfigurationAsset: "gpay.json",
                    height: 50,
                    width: double.maxFinite,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
