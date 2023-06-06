
import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/url_helper.dart';
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

  List<FoodieQuestionAnswers> foodieQuestionAnswersList = [];

  List<int> answerIdsUniqueFoodie = [];
  List<int> answerIdPerfectAmbience = [];
  List<int> answerIdsCuisineTaste = [];
  List<int> answerIdInterest = [];

  final ApplicationService _appService;
  late SignUpQuestionsModel signUpQuestionsModel;

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
      foodieQuestionAnswersList.add(FoodieQuestionAnswers(answerIds: answerIdsUniqueFoodie, foodieId: _appService.state.userInfo!.t.id,id: 7,inputAnswer: '',questionId: 7));
      foodieQuestionAnswersList.add(FoodieQuestionAnswers(answerIds: answerIdPerfectAmbience,foodieId: _appService.state.userInfo!.t.id,id: 4,inputAnswer: '',questionId: 4));
      foodieQuestionAnswersList.add(FoodieQuestionAnswers(answerIds: answerIdsCuisineTaste, foodieId: _appService.state.userInfo!.t.id,id: 7,inputAnswer: '',questionId: 7));
      foodieQuestionAnswersList.add(FoodieQuestionAnswers(answerIds: answerIdInterest,foodieId: _appService.state.userInfo!.t.id,id: 4,inputAnswer: '',questionId: 4));
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
      t: save_foodie_request.T(foodieQuestionAnswers: foodieQuestionAnswersList),
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