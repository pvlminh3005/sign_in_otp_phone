import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_up_phone/app/routes/app_pages.dart';

class SignUpController extends GetxController {
  var checkPhone = false.obs;
  late FirebaseAuth myAuth;
  var verificationId = '1'.obs;
  var isLoading = false.obs;

  late TextEditingController phoneController;
  late TextEditingController otpController;

  @override
  void onInit() {
    phoneController = TextEditingController();
    otpController = TextEditingController();
    myAuth = FirebaseAuth.instance;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
  }

  Future<void> verifyPhoneNumber() async {
    await myAuth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException exception) {
        Get.snackbar('ERROR', exception.message!,
            snackPosition: SnackPosition.BOTTOM);
      },
      codeSent: (String verificationID, int? resToken) {
        checkPhone.value = true;
        verificationId.value = verificationID;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }

  void signInWithAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    isLoading.value = true;
    try {
      final authCredential =
          await myAuth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        isLoading.value = false;
        Get.offAllNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('ERROR', e.message!, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void verifyOTP() async {
    PhoneAuthCredential phoneAuthCredential =
        await PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otpController.text);
    signInWithAuthCredential(phoneAuthCredential);
  }
}
