import 'package:chef/models/booking/booking_request.dart';

import '../models/home/home_response.dart' as home_data;
import '../screens/home/schedule_model.dart';
import '../screens/home/widget/food_details_screen.dart';

class OrderHelper {
  late String scheduleId;
  DaysGroup daysGroup = DaysGroup(
      scheduledDate: DateTime(1900 - 12 - 12), dayOfMonth: 0, hours: []);
  late Hour hourSelected;
  late home_data.Experiences selectedExperienceDetail;
  List<BookingDetails> bookingMenuDetails = [];
  String noteAdded = '';
  late int openCapacity;
  late String selectedCategory;
  late int selectedPreferenceId;
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
