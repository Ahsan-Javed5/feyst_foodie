
//import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/profile_image_response.dart';
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
import '../../../models/answers_response.dart';
import '../../../models/signup/question_answer_response.dart';
import '../../../models/signup/save_foodie_answers_request.dart' as save_foodie_request;
import '../../../models/signup/save_foodie_answers_request.dart';
import '../../../services/application_state.dart';
import '../../../setup.dart';
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
  late AnswersResponse foodieAnswers;

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
            'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}'
          },
        ),
        data: formData,
      );
      if (response.statusCode == 200) {
        var map = response.data as Map;
        ProfileImageResponse profileImageResponse = ProfileImageResponse.fromJson(response.data);
        await locateService<IStorageService>().writeString(key: 'profile_image', data: profileImageResponse.t!.profileImageUrl.toString());
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
    return null;
  }

  Future<void> getQuestionnaireData(bool isProfileUpdate, {required String userId}) async {
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + Api.singUpQuestionnaireList);

    emit(const Loading());
    final signUpQuestionnaireRequest = baserequest.SignUpQuestionsRequest(
      t: baserequest.T(userId: int.parse(userId), category: 'FOODIE',),
    ).toJson();
    final _header = <String, String>{
      //'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
      'Content-Type': 'application/json'
    };
    final response = await _network.post(
      path: url,
      data: signUpQuestionnaireRequest,
      header: _header,
    );
    signUpQuestionsModel = signUpQuestionsModelFromJson(response.body);
    if(isProfileUpdate == true) await getFoodieAnswers();
    debugPrint("${response.body}");
    response.body != "" || response.body != null ?  emit(Loaded(signUpQuestionsModel)) : emit(const Loading());
  }

  void addModelsFromQuestions({Function? completion, required BuildContext context}){
    if(answerIdsUniqueFoodie.isNotEmpty && answerIdPerfectAmbience.isNotEmpty && answerIdsCuisineTaste.isNotEmpty && answerIdInterest.isNotEmpty){
      foodieQuestionAnswersList.add(T1(answerIds: answerIdsUniqueFoodie, foodieId: _appService.state.userInfo!.t.id,id: 1,inputAnswer: '',questionId: 1));
      foodieQuestionAnswersList.add(T1(answerIds: answerIdPerfectAmbience,foodieId: _appService.state.userInfo!.t.id,id: 2,inputAnswer: '',questionId: 2));
      foodieQuestionAnswersList.add(T1(answerIds: answerIdsCuisineTaste, foodieId: _appService.state.userInfo!.t.id,id: 12,inputAnswer: '',questionId: 12));
      foodieQuestionAnswersList.add(T1(answerIds: answerIdInterest,foodieId: _appService.state.userInfo!.t.id,id: 13,inputAnswer: '',questionId: 13));
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
      t: foodieQuestionAnswersList,
    ).toJson();
    final _header = <String, String>{
     'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
      'Content-Type': 'application/json'
    };
    final response = await _network.post(
      path: url,
      data: saveFoodieRequest,
      header: _header,
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

  Future<void> getFoodieAnswers() async {
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + Api.foodieAnswers);
    final response = await _network.post(
      path: url,
      data: {
        "t": _appService.state.userInfo!.t.id
      },
      header: {
    'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
    'Content-Type': 'application/json'
    },
    );
    foodieAnswers = answersResponseFromJson(response.body);
  }
}