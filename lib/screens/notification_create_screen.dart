import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/model/employee_list_response.dart';
import 'package:notificator/model/notification_data.dart';
import 'package:notificator/provider/employee_chip_provider.dart';
import 'package:notificator/provider/employee_list_provider.dart';
import 'package:notificator/provider/firebase_notification_send_provider.dart';
import 'package:notificator/provider/group_chip_provider.dart';
import 'package:notificator/provider/notification_create_provider.dart';
import 'package:notificator/provider/send_to_option_provider.dart';
import 'package:notificator/widgets/select_employee_bottom_sheet.dart';
import 'package:notificator/widgets/select_group_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../model/group_list_response.dart';
import '../provider/auth_key_provider.dart';
import '../provider/group_list_provider.dart';
import '../provider/toast_provider.dart';
import '../util/helper.dart';
import '../util/utils.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';
import '../widgets/send_option_radio_widget.dart';

class CreateNotificationScreen extends StatefulWidget {
  const CreateNotificationScreen({Key? key}) : super(key: key);

  @override
  State<CreateNotificationScreen> createState() =>
      _CreateNotificationScreenState();
}

class _CreateNotificationScreenState extends State<CreateNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _message = TextEditingController();
  final TextEditingController _groupIndividualController =
      TextEditingController();

  final FocusNode _subjectFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void initState() {
    // Display a progress loader
    context.loaderOverlay.show();

    // Instantiate the group and employee list
    instantiateGroup();
    instantiateEmployee();

    // Hide the progress loader
    context.loaderOverlay.hide();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sendToProvider = context.watch<SendToOptionProvider>();
    final provider = context.watch<GroupChipProvider>();
    final employeeProvider = context.watch<EmployeeChipProvider>();
    _groupIndividualController.text = sendToProvider.selectedOption == 1
        ? employeeProvider.selectedEmployeeName
        : provider.selectedGroupName;

    return Scaffold(
      appBar: const MyAppBarWidget(
        title: 'Create Notification',
      ),
      body: GestureDetector(
        onTap: () {
          if (kDebugMode) {
            print('tapped outside the text field');
          }
          // When the user taps outside any text field, hide the keyboard
          _subjectFocusNode.unfocus();
          _messageFocusNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: double.infinity,
            //height: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  SeparatedLabeledTextField(
                    focusNode: _subjectFocusNode,
                    controller: _subject,
                    validator: Utils.validate,
                    labelText: 'Subject',
                    hintText: 'Notification Subject',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Message',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.deepPurple,
                      fontFamily: 'BaiJamjuree',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    focusNode: _messageFocusNode,
                    controller: _message,
                    validator: Utils.validate,
                    //onChanged: (value) {},
                    maxLines: null,
                    minLines: 5,
                    style: const TextStyle(
                      color: AppColors.deepPurple,
                      fontFamily: 'BaiJamjuree',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      hintStyle: TextStyle(
                        color: AppColors.deepPurple.withOpacity(0.5),
                        fontFamily: 'BaiJamjuree',
                      ),
                      filled: true,
                      fillColor: AppColors.deepPurple.withOpacity(0.1),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Send To',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.deepPurple,
                      fontFamily: 'BaiJamjuree',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SendOptionRadioWidget(),
                  const SizedBox(height: 4),
                  Text(
                    sendToProvider.selectedOption == 1 ? 'Individual' : 'Group',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.deepPurple,
                      fontFamily: 'BaiJamjuree',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: sendToProvider.selectedOption == 1
                        ? onTapSelectEmployee
                        : onTapSelectGroup,
                    child: TextFormField(
                      controller: _groupIndividualController,
                      validator: Utils.validate,
                      enabled: false,
                      style: const TextStyle(
                        color: AppColors.deepPurple,
                        fontFamily: 'BaiJamjuree',
                      ),
                      decoration: InputDecoration(
                        hintText: sendToProvider.selectedOption == 1
                            ? 'Select Employee'
                            : 'Choose Group',
                        hintStyle: TextStyle(
                          color: AppColors.deepPurple.withOpacity(0.5),
                          fontFamily: 'BaiJamjuree',
                        ),
                        filled: true,
                        fillColor: AppColors.deepPurple.withOpacity(0.1),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: sendNewNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    child: const Text(
                      'Send Notification',
                      style: TextStyle(
                        color: AppColors.white,
                        fontFamily: 'BaiJamjuree',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subject.dispose();
    _message.dispose();
    _groupIndividualController.dispose();
    _subjectFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  /// show bottom sheet to select group
  void onTapSelectGroup() async {
    // get the number of chips
    int chipsCount = context.read<GroupChipProvider>().groupList.length;

    // show bottom sheet to select group or individual
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectGroupBottomSheet(
          count: chipsCount,
        );
      },
    );

    if (_messageFocusNode.hasFocus) {
      _messageFocusNode.unfocus();
    }
  }

  /// show bottom sheet to select employee
  void onTapSelectEmployee() async {
    // get the number of chips
    int chipsCount = context.read<EmployeeChipProvider>().employeeList.length;

    // show bottom sheet to select group or individual
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectEmployeeBottomSheet(
          count: chipsCount,
        );
      },
    );

    if (_messageFocusNode.hasFocus) {
      _messageFocusNode.unfocus();
    }
  }

  /// fetch all groups
  void instantiateGroup() async {
    // initialize provider
    final provider = context.read<GroupListProvider>();

    // initialize group chip provider
    // clear the selected group list selected before
    final groupChipProvider = context.read<GroupChipProvider>();
    groupChipProvider.clearSelectedGroups();

    // get token through provider
    String token = await Helper.getToken(context);

    //call the rest api to fetch groups
    await provider.getList(token);

    // check if the submission was successful
    if (provider.success) {
      debugPrint('groups fetched successfully');

      // initialize the global groups list with the fetched data
      List<GroupListResponseData>? groups = provider.data;

      if (groups != null && groups.isNotEmpty) {
        // populate the groups list of group chip provider
        groupChipProvider.setGroupList(groups);
      }
    } else {
      // Display an error toast
      debugPrint(provider.error);
    }
  }

  /// fetch all employee
  void instantiateEmployee() async {
    // initialize provider
    final provider = context.read<EmployeeListProvider>();

    // initialize group chip provider
    // clear the selected group list selected before
    final employeeChipProvider = context.read<EmployeeChipProvider>();
    employeeChipProvider.clearSelectedEmployees();

    // get token through provider
    String token = await Helper.getToken(context);

    //call the rest api to fetch groups
    await provider.getList(token);

    // check if the submission was successful
    if (provider.success) {
      debugPrint('employee fetched successfully');

      // initialize the global groups list with the fetched data
      List<EmployeeListResponseData>? employees = provider.data;

      if (employees != null && employees.isNotEmpty) {
        // populate the groups list of group chip provider
        employeeChipProvider.setEmployeeList(employees);
      }
    } else {
      // Display an error toast
      debugPrint(provider.error);
    }
  }

  Future<void> sendNewNotification() async {
    // validate form
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      //get send to type from it's provider
      int sendTo = context.read<SendToOptionProvider>().selectedOption;
      String group = context.read<GroupChipProvider>().selectedGroupId;
      String individual =
          context.read<EmployeeChipProvider>().selectedEmployeeId;

      if (kDebugMode) {
        print('group $group');
        print('ind $individual');
      }

      // get the filed texts
      String subject = _subject.text.trim();
      String message = _message.text.trim();
      String sendId = sendTo == 1 ? individual : group;
      String sendOption = sendTo == 1 ? 'individual' : 'group';

      if (kDebugMode) {
        print('$sendTo $sendOption $sendId $subject $message');
      }

      // create the employee obj
      NotificationData notification = NotificationData(
        subject: subject,
        message: message,
        groupIndividualIds: sendId,
        groupIndividual: sendOption,
      );

      // initialize toast provider
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // get token through provider
      final String? token = context.read<AuthKeyProvider>().userToken;

      // call the rest api through provider & send data through it
      final provider = context.read<NotificationCreateProvider>();
      await provider.create(notification, token!);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        toastProvider.showSuccessToast('notification successfully sent');

        List<String>? userToken = provider.token;
        String notificationId = provider.id.toString();

        if (kDebugMode) {
          print('FCM send 001');
        }

        // send push notification to FCM
        if (context.mounted) {
          if (kDebugMode) {
            print('FCM send 002');
          }
          final firebaseNotificationSendProvider =
              context.read<FirebaseNotificationSendProvider>();

          if (kDebugMode) {
            print('FCM send 003');
          }
          if (sendTo == 1 && userToken?.length == 1) {
            if (kDebugMode) {
              print('registration token: ${userToken?.first}');
            }

            await firebaseNotificationSendProvider.sendIndividualNotification(
              token: userToken?.first ?? '',
              title: subject,
              body: message,
              notificationId: notificationId,
            );

            if (kDebugMode) {
              print('FCM send 004');
            }
          } else {
            //userToken?.forEach((element) => print(element));

            await firebaseNotificationSendProvider.sendGroupNotification(
              userTokens: userToken,
              title: subject,
              body: message,
              notificationId: notificationId,
            );

          }
        }
        // hide the bottom sheet
        if (context.mounted) Navigator.pop(context);
      } else {
        // Display an error toast
        toastProvider.showErrorToast(provider.error);
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
