import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  Widget _buildPhoneNumber() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TextField(
        //   controller: controller.phoneController,
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(),
        //     labelText: 'Phone',
        //     prefixIcon: Icon(Icons.phone),
        //   ),
        //   keyboardType: TextInputType.phone,
        // ),
        IntlPhoneField(
          // controller: controller.phoneController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          initialCountryCode: 'VN',
          onChanged: (phone) {
            controller.phoneController.text = phone.completeNumber;
          },
        ),
        RaisedButton(
          onPressed: controller.verifyPhoneNumber,
          child: Text('NEXT'),
          elevation: 0,
        )
      ],
    );
  }

  Widget _buildFormOTP() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Verify - ${controller.phoneController.text}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller.otpController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Your OTP',
            hintText: 'OTP',
          ),
          keyboardType: TextInputType.number,
        ),
        RaisedButton(
          onPressed: controller.verifyOTP,
          child: Text('VERIFY'),
          elevation: 0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication with Phone'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => controller.checkPhone.value == false
              ? _buildPhoneNumber()
              : controller.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildFormOTP(),
        ),
      ),
    );
  }
}
