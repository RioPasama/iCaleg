import 'package:get/get.dart';

class TextInputValidatorController extends GetxController {
  String? validatorIdentifier(String? val) {
    if (val!.contains(' ')) {
      return 'Identifikasi Anda menggunakan spasi';
    }

    return (GetUtils.isEmail(val)) ? null : 'Identifikasi Anda salah';
  }

  String? validatorPassword(String? val) {
    return (val!.length >= 6) ? null : 'Kata sandi minimal 6 digit';
  }

  String? validatorFullName(String? val) {
    return (val!.length >= 3) ? null : 'Silakan masukkan nama lengkap';
  }

  String? validatorNIK(String? val) {
    return (val!.length >= 16) ? null : 'NIK kurang lengkap';
  }

  String? validatorNumberPhone(String? val) {
    // Periksa apakah nomor telepon dimulai dengan +62
    if (val!.startsWith('+62')) {
      return 'Nomor telepon harus dimulai dengan +62';
    }

    return (GetUtils.isPhoneNumber(val))
        ? null
        : 'Periksa kembali nomor telepon Anda';
  }

  String? validatorEmail(String? val) {
    if (val!.contains(' ')) {
      return 'Email Anda menggunakan spasi';
    }

    return (GetUtils.isEmail(val)) ? null : 'Email Anda tidak valid';
  }

  String? validatorNotNull(Object? val) {
    if (val == null) {
      return 'Isi Data terlebih dahulu';
    } else if (val is String && (val.isEmpty || val.trim().isEmpty)) {
      return 'Isi Data terlebih dahulu';
    }
    return null;
  }

  String? validatorConfirmationPassword(
      {String? val, required String passwordTextEditingController}) {
    return (val == passwordTextEditingController && val != null)
        ? null
        : 'Password Anda tidak sama';
  }
}
