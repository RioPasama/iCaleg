import 'package:get/get.dart';
import 'package:icaleg/app/controllers/utils_controller.dart';
import 'package:icaleg/app/data/models/app_model.dart';
import 'package:icaleg/app/data/services/app_service.dart';
import 'package:icaleg/infrastructure/theme/theme_data.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

class AppSettingController extends GetxController {
  UtilsController utilsController = Get.put(UtilsController());

  Future<void> initColor() async {
    late AppModel appModel;
    AppModel appModelAPI = await getAppSetting();

    appModel = appModelAPI;

    if (utilsController.isHexStringValid(utilsController.convertStringColorHex(
            hex: appModel.colorPrimary)) &&
        utilsController.isHexStringValid(utilsController.convertStringColorHex(
            hex: appModel.colorGradient)) &&
        utilsController.isHexStringValid(utilsController.convertStringColorHex(
            hex: appModel.colorSecondary))) {
      settingColor(appModel: appModel);
    }
  }

  Future<AppModel> getAppSetting() async {
    AppModel appModel = await AppService.getAppSetting();
    return appModel;
  }

  void settingColor({required AppModel appModel}) {
    colorPrimary = utilsController.colorFromHex(
        hex: utilsController.convertStringColorHex(hex: appModel.colorPrimary));
    colorPrimaryGradient = utilsController.colorFromHex(
        hex:
            utilsController.convertStringColorHex(hex: appModel.colorGradient));
    colorSecondary = utilsController.colorFromHex(
        hex: utilsController.convertStringColorHex(
            hex: appModel.colorSecondary));

    Get.changeTheme(themeData());
  }
}
