import '../models/home/home_response.dart' as home_data;
import '../screens/home/schedule_model.dart';

class OrderHelper {
  late String scheduleId;
  DaysGroup daysGroup = DaysGroup(
      scheduledDate: DateTime(1900 - 12 - 12), dayOfMonth: 0, hours: []);
  late Hour hourSelected;
  late home_data.Experiences selectedExperienceDetail;
  String noteAdded = '';
  String selectedCategory = 'Couple';
  int numberOfPerson = 4;

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
