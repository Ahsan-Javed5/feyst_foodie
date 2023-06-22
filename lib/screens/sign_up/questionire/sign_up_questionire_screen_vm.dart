
//import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/url_helper.dart';
import 'package:http_parser/http_parser.dart';
import 'package:chef/models/signup/sign_up_questionnaire_request.dart' as baserequest;
import 'package:chef/models/signup/sign_up_questionnaire_response_model.dart';
import 'package:chef/screens/sign_up/questionire/sign_up_questionire_screen_m.dart';
import 'package:chef/services/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../constants/api.dart';
import '../../../models/signup/question_answer_response.dart';
import '../../../models/signup/save_foodie_answers_request.dart' as save_foodie_request;
import '../../../models/signup/save_foodie_answers_request.dart';
import '../../../services/application_state.dart';
import '../../../ui_kit/helpers/toaster_helper.dart';
import 'dart:developer' as developer;

@injectable
class  SignUpQuestionnaireScreenViewModel extends BaseViewModel<SignUpQuestionnaireState> {
  SignUpQuestionnaireScreenViewModel({
    required INetworkService network,
    required ApplicationService appService,
}) : _network = network, _appService = appService, super(const Loading());


  final INetworkService _network;
  bool? isProfileUpdate;
  List<T1> foodieQuestionAnswersList = [];

  List<int> answerIdsUniqueFoodie = [];
  List<int> answerIdPerfectAmbience = [];
  List<int> answerIdsCuisineTaste = [];
  List<int> answerIdInterest = [];
  ValueNotifier<File?> selectedImageNotifier = ValueNotifier<File?>(null);
  final ApplicationService _appService;
  late SignUpQuestionsModel signUpQuestionsModel;

  bool isImageSelected = false;
  void updateSelectedImage(File? image) {
    isImageSelected = false;
    if (image != null) {
      selectedImageNotifier.value = image;
      isImageSelected = true;
    }
  }

  Future<bool?> uploadFoodieImage(
      { file, required String baseUrl}) async {
    final url = InfininURLHelpers.getRestApiURL(
        baseUrl + "foodie/profile-image/${_appService.state.userInfo!.t.id}");
    try {
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(file.path,  contentType: MediaType("image", "jpg"),),
      });
      final response = await Dio().post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
        data: formData,
      );
      if (response.statusCode == 200) {
        var map = response.data as Map;
        print('success');
        if (map['status'] == 'Successfully registered') {
          return true;
        } else {
          return false;
        }
      } else if(response.statusCode == 200) {
        //BotToast is a package for toasts available on pub.dev
       // BotToast.showText(text: 'Validation Error Occurs');
        return false;
      }
    } catch (error) {
      print(error);
      //log(error.message);
     // throw YourException(error);
    } catch (_) {
     // log(_.toString());
      throw 'Something Went Wrong';
    }
  }


  Future<String> uploadImage(asset,baseUrl) async {
    final url = InfininURLHelpers.getRestApiURL(
        baseUrl + "foodie/profile-image/${_appService.state.userInfo!.t.id}");
    // String to uri
    Uri uri = Uri.parse(url);

    // create multipart request
    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();



    http.MultipartFile multipartFile =  http.MultipartFile.fromBytes(
      'image',
      imageData,
      filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
      contentType: MediaType("image", "jpg"),
    );

    // Add field to your request
    //request.fields['FieldName'] = fieldValue;

    // add file to multipart
    request.files.add(multipartFile);
    // send
    var response = await request.send();

    // Decode response
    final respStr = await response.stream.bytesToString();

    return respStr;
  }


  Future<void> savePicture({
    required String baseUrl,
    required BuildContext context,
    required String image,
    required path,
    required bytes,
    required mimeType,
    Function? completion,
  }) async {
    final url = InfininURLHelpers.getRestApiURL(
        baseUrl + "foodie/profile-image/${_appService.state.userInfo!.t.id}");

    final savePicRequest = {
      "image": image,
    };
    developer.log("this is savePicReq" "$savePicRequest");

    try {
      final uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      final httpImage = http.MultipartFile.fromBytes(path, bytes,
          contentType: MediaType.parse(mimeType),);
      request.files.add(httpImage);
      final response = await request.send();
      print(response);
      // final response = await _network.post(
      //   path: url,
      //   data: savePicRequest,
      // );

      // if (response != null) {
      //  // developer.log(' Response of Save Pic is  ' '${response.body}');
      //   //Toaster.infoToast(context: context, message: response.message);
      //   //completion!();
      // } else {
      //   Toaster.infoToast(context: context, message: 'Error in calling the Api');
      // }
    }catch (e) {
      // TODO
      print(e);
    }
  }


  upload(File imageFile, String baseUrl) async {
    // open a bytestream
    try {
      var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();
      final url = InfininURLHelpers.getRestApiURL(
          baseUrl + "foodie/profile-image/${_appService.state.userInfo!.t.id}");
      // string to uri
      var uri = Uri.parse(url);

      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      print(response.statusCode);

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    } catch (e) {
      print(e);
      // TODO
    }
  }

  // Future<String> uploadImage(File file, baseUrl) async {
  //   Dio dio = Dio();
  //   final url = InfininURLHelpers.getRestApiURL(
  //       baseUrl + "foodie/profile-image/${_appService.state.userInfo!.t.id}");
  //  // String fileName = file.path.split('/').last;
  //   var formData = dio.FormData.fromMap({
  //     "file":
  //     await MultipartFile.fromFile(file.path,contentType: MediaType("image", "jpg")),
  //   });
  //
  //   var response = await dio.post(url, data: formData).then((response) {
  //     print(response);
  //   }).catchError((error) => print(error));
  //   return response.data;
  // }

  Future<dynamic> uploadImg(file, baseUrl) async {
    final url = InfininURLHelpers.getRestApiURL(
        baseUrl + "foodie/profile-image/${_appService.state.userInfo!.t.id}");
    if (file == null) return;
    String fileName = file.path.split('/').last;
    Map<String, dynamic> formData = {
      "image": await MultipartFile.fromFile(file.path,filename: fileName, contentType: MediaType('image', fileName.split(".").last)),
    };
    return await Dio()
        .post(url,data:formData).
    then((dynamic result){
      print(result.toString());
    });
  }

  Future<void> getQuestionnaireData({required String userId}) async {
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + Api.singUpQuestionnaireList);

    emit(const Loading());

    final signUpQuestionnaireRequest = baserequest.SignUpQuestionsRequest(
      t: baserequest.T(userId: int.parse(userId), category: 'FOODIE',),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: signUpQuestionnaireRequest,
    );

    signUpQuestionsModel = signUpQuestionsModelFromJson(response.body);
    debugPrint("${response.body}");

    response.body != "" || response.body != null ?  emit(Loaded(signUpQuestionsModel)) : emit(const Loading());
  }

  void addModelsFromQuestions({Function? completion, required BuildContext context}){
    if(answerIdsUniqueFoodie.isNotEmpty && answerIdPerfectAmbience.isNotEmpty && answerIdsCuisineTaste.isNotEmpty && answerIdInterest.isNotEmpty){
      foodieQuestionAnswersList.add(T1(answerIds: answerIdsUniqueFoodie, foodieId: _appService.state.userInfo!.t.id,id: 7,inputAnswer: '',questionId: 7));
      foodieQuestionAnswersList.add(T1(answerIds: answerIdPerfectAmbience,foodieId: _appService.state.userInfo!.t.id,id: 4,inputAnswer: '',questionId: 4));
      foodieQuestionAnswersList.add(T1(answerIds: answerIdsCuisineTaste, foodieId: _appService.state.userInfo!.t.id,id: 7,inputAnswer: '',questionId: 7));
      foodieQuestionAnswersList.add(T1(answerIds: answerIdInterest,foodieId: _appService.state.userInfo!.t.id,id: 4,inputAnswer: '',questionId: 4));
      completion!();
    }else{
      Toaster.errorToast(context: context, message: 'Please fill all the fields');
    }
  }

  Future<void> saveFoodie({
    required String baseUrl,
    required BuildContext context,
    Function? completion,
  }) async {
    final url = InfininURLHelpers.getRestApiURL(baseUrl + Api.saveFoodieAnswers);
    final saveFoodieRequest = save_foodie_request.SaveFoodieRequest(
      userId: _appService.state.userInfo?.t.id,
      t: foodieQuestionAnswersList,
    ).toJson();
    final response = await _network.post(
      path: url,
      data: saveFoodieRequest,
    );
    developer.log("$saveFoodieRequest");
    // final currentQuestionirData = questionireResponseFromJson(response.body);
    if (response != null) {
      developer.log(' Response of Save Foodie is  ' '${response.body}');
      FoodieQuestionAnswerResponse foodieQuestionAnswerResponse = foodieQuestionAnswerResponseFromJson(response.body);
      Toaster.infoToast(
          context: context, message: foodieQuestionAnswerResponse.message.toString());
      completion!();
    } else {
      Toaster.infoToast(context: context, message: 'Error in calling the Api');
    }
  }

}