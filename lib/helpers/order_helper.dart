import 'dart:convert';
import '../../../models/home/experience_list_response.dart' as experienceData;
import '../screens/home/schedule_model.dart';

class OrderHelper {
  late String scheduleId;
  late DaysGroup daysGroup;
  late Hour hourSelected;
  late experienceData.T selectedExperienceDetail;
  late String noteAdded;
  late String selectedCategory;
  late String numberOfPerson;

  OrderHelper updateChecklist({
    required OrderHelper checkList,
    //required List<CheckListItem> itemList,
  }) {
    return OrderHelper();
  }

  OrderHelper updateOrderHelperItem({
    required OrderHelper checkListItem,
    required Map<String, dynamic> value,
  }) {
    return OrderHelper();
  }
}
