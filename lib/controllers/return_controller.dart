import 'dart:convert';

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:citymall/dialog/dialog.dart';
import 'package:citymall/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citymall/constants.dart';

import 'package:citymall/models/get_api_response_model.dart';

import 'package:citymall/models/user_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

class ReturnController extends GetxController {
  var isLoading = false.obs;
  var showSuccessMessage = false.obs;
  var showErrorMessage = false.obs;
  var order_return_type = ''.obs;
  var where_to_refund = 'Bank Account'.obs;
  Rx<UserModel?> user = (null as UserModel?).obs;
  final detailsController = TextEditingController();
  final qtyController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankAcNoController = TextEditingController();
  final ifscController = TextEditingController();
  final bankAcHolderController = TextEditingController();
  final upiController = TextEditingController();

  RxMap<String, dynamic> single_order = <String, dynamic>{}.obs;
  List<String> reasons_list = [
    'Item Defected',
    'Quantity not exact',
    'Item has bad packaging',
    'ByMistake Ordered',
    'Quality is not good'
  ];
  var selected_item_id = 0.obs;
  var single_order_id = 0.obs;
  var selected_reason = (null as int?).obs;
  var current_timestamp = DateTime.now().millisecondsSinceEpoch.obs;
  // List of selected image
  final ImagePicker picker = ImagePicker();
  Rx<File?> imageFile1 = (null as File?).obs;
  Rx<File?> imageFile2 = (null as File?).obs;
  Rx<File?> imageFile3 = (null as File?).obs;
  Rx<File?> imageFile4 = (null as File?).obs;
  Rx<File?> qrCodeImage = (null as File?).obs;

  @override
  void onInit() async {
    super.onInit();
    // final userBox = await Hive.openBox('Usercache');
    // user.value = await userBox.get('user');

    ever(single_order_id,
        (_) => fetchSingleOrder(single_order_id.value.toString()));
    ever(current_timestamp,
        (_) => fetchSingleOrder(single_order_id.value.toString()));
    ever(selected_reason, (_) => resetModalSheet());
  }

  resetModalSheet() {
    print('reseting scd');
    detailsController.text = '';
    imageFile1.value = null;
    imageFile2.value = null;
    imageFile3.value = null;
    imageFile4.value = null;
    qrCodeImage.value = null;
    showErrorMessage.value = false;
    showSuccessMessage.value = false;
  }

  String getFormattedDate(String date) {
    /// Convert into local date format.
    var localDate = DateTime.parse(date).toLocal();

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  fetchSingleOrder(String orderid) async {

    http.Response response =
        await http.get(Uri.parse(baseApiUrl + '/orders/' + orderid));
    ApiService.getRequest(ApiResponseType.SingleRow,'/orders/' + orderid,
            (res) {
              single_order.value = res;
              List<Map<String, dynamic>> items = [];
              single_order.value['items'] = single_order.value['items']
                  .map((e) => e as Map<String, dynamic>)
                  .toList();
        }, null, showRequestDetail: false);

  }

  Future<XFile?> singleImagePicker() async {
    XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    return pickedImage;
  }

  uploadImage(BuildContext context) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse(baseApiUrl + '/upload');
      http.MultipartRequest request = http.MultipartRequest("POST", uri);
      request.fields['details'] = detailsController.text.trim();
       request.fields['qty'] = qtyController.text.trim();
      request.fields['item_id'] = selected_item_id.value.toString();
      request.fields['order_id'] = single_order_id.value.toString();
      request.fields['reason'] = reasons_list[selected_reason.value ?? 0];
      request.fields['type'] = order_return_type.value;
      if(where_to_refund.value=='Bank Account'){
        request.fields['bank_name'] = bankNameController.text.trim();
        request.fields['account_holder'] = bankAcHolderController.text.trim();
        request.fields['ifsc'] = bankNameController.text.trim();
        request.fields['account_number'] = bankAcNoController.text.trim();
        request.fields['upi'] = upiController.text.trim();
      }
      if (imageFile1.value != null) {

        http.ByteStream stream =
            http.ByteStream(Stream.castFrom(imageFile1.value!.openRead()));
        var length = await imageFile1.value!.length();
        http.MultipartFile multipartFile = http.MultipartFile(
            'image1', stream, length,
            filename: p.basename(imageFile1.value!.path));
        request.files.add(multipartFile);
      }
      if (imageFile2.value != null) {
        http.ByteStream stream =
            http.ByteStream(Stream.castFrom(imageFile2.value!.openRead()));
        var length = await imageFile2.value!.length();
        http.MultipartFile multipartFile = http.MultipartFile(
            'image2', stream, length,
            filename: p.basename(imageFile2.value!.path));
        request.files.add(multipartFile);
      }
      if (imageFile3.value != null) {

        http.ByteStream stream =
            http.ByteStream(Stream.castFrom(imageFile3.value!.openRead()));
        var length = await imageFile3.value!.length();
        http.MultipartFile multipartFile = http.MultipartFile(
            'image3', stream, length,
            filename: p.basename(imageFile3.value!.path));
        request.files.add(multipartFile);
      }
      if (imageFile4.value != null) {
        http.ByteStream stream =
            http.ByteStream(Stream.castFrom(imageFile4.value!.openRead()));
        var length = await imageFile4.value!.length();
        http.MultipartFile multipartFile = http.MultipartFile(
            'image4', stream, length,
            filename: p.basename(imageFile1.value!.path));
        request.files.add(multipartFile);
      }
      if (qrCodeImage.value != null) {

        http.ByteStream stream =
        http.ByteStream(Stream.castFrom(qrCodeImage.value!.openRead()));
        var length = await qrCodeImage.value!.length();
        http.MultipartFile multipartFile = http.MultipartFile(
            'qr_image', stream, length,
            filename: p.basename(qrCodeImage.value!.path));
        request.files.add(multipartFile);
      }


      var response = await request.send();

      if (response.statusCode == 200) {
        showAlertDialog(context, DialogType.success,
            'Return Request placed successfully', 'Success', () {
               current_timestamp.value = DateTime.now().millisecondsSinceEpoch;
          Get.close(2);
        });
      } else {
        print('response ol');
        print(response.toString());
        showAlertDialog(
            context, DialogType.error, 'Some error occurred', 'Error', () {});
      }
    } catch (e) {
      showAlertDialog(context, DialogType.error, e.toString(), 'Error', () {});
    } finally {
      isLoading(false);
    }
  }
  String? validateBankName() {
    if (bankNameController.text.trim().isEmpty  && where_to_refund.value=='Bank Account') {
      return "Bank Name is required";
    }

    return null;
  }
  String? validateBankAc() {
    if (bankAcNoController.text.trim().isEmpty  && where_to_refund.value=='Bank Account') {
      return "Account Number is required";
    }

    return null;
  }
  String? validateBankIfsc() {
    if (ifscController.text.trim().isEmpty  && where_to_refund.value=='Bank Account') {
      return "IFSC is required";
    }

    return null;
  }
  String? validateBankAcHolder() {
    if (bankAcHolderController.text.trim().isEmpty && where_to_refund.value=='Bank Account') {
      return "Account Holder is required";
    }

    return null;
  }


}
