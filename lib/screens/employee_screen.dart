import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/employee_delete_provider.dart';
import 'package:notificator/provider/employee_list_provider.dart';
import 'package:notificator/widgets/outlined_button_widget.dart';
import 'package:notificator/widgets/search_employee_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/auth_key_provider.dart';
import '../provider/employee_create_provider.dart';
import '../util/utils.dart';
import '../widgets/elevated_create_button.dart';
import '../widgets/employee_list_item_widget.dart';
import '../widgets/popup_button_widget.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  late final EmployeeListProvider provider;
  late final String token;

  @override
  void initState() {
    instantiate();

    super.initState();
  }

  /// This method is for initializing the provider
  /// and getting the user token
  void instantiate() async {
    final authProvider = context.read<AuthKeyProvider>();
    final employeeDeleteProvider = context.read<EmployeeDeleteProvider>();
    final employeeCreateProvider = context.read<EmployeeCreateProvider>();

    provider = context.read<EmployeeListProvider>();

    // get the user token from the provider
    await context.read<AuthKeyProvider>().getUserToken();

    // initialize the user token
    token = authProvider.userToken!;

    await provider.getList(token);

    // listeners for refresh the ui when item is removed or updated
    employeeDeleteProvider.addListener(() {
      if (employeeDeleteProvider.success) {
        provider.getList(token);
      }
    });

    // listeners for refresh the ui when item is created
    employeeCreateProvider.addListener(() {
      if (employeeCreateProvider.success) {
        provider.getList(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () {
        // Refresh the list when the user pulls down
        return provider.getList(token);
      },
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopupButtonWidget(
                label: 'Sort By',
                icon: Icons.sort,
                sortOptions: Constants.sortOptions,
                onSelected: (String selectedItem) {
                  if (kDebugMode) {
                    print('Selected item: $selectedItem');
                  }

                  sortEmployeeList(selectedItem);
                },
              ),
              const SizedBox(width: 6.0),
              OutlinedButtonWidget(
                label: 'Filter',
                icon: Icons.filter_list,
                onPressed: () {
                  print('OutlinedButtonWidget');
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const SearchEmployeeBottomSheet(),
                        ),
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              ElevatedCreateButtonWidget(
                title: 'Create Employee',
                icon: Icons.add_circle,
                onPressed: () {
                  //navigatePush(context, const CreateEmployeeScreen());

                  Navigator.pushNamed(context, kRouteCreateEmployee);
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Consumer<EmployeeListProvider>(
            builder: (context, provider, child) {
              if (provider.data == null) {
                // show the loader overlay when the data is null
                context.loaderOverlay.show();

                return const SizedBox();
              } else {
                // hide the loader overlay
                context.loaderOverlay.hide();

                // if list is empty show no group text
                // else show the list of groups
                return provider.data!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final employee = provider.data![index];

                          return EmployeeListItemWidget(
                            id: employee.id!,
                            firstName: employee.firstName ?? '',
                            lastName: employee.lastName ?? '',
                            position: employee.position ?? '',
                            photo: employee.photo,
                            email: employee.email,
                            groupName: employee.groupInfo?.name?.join(', '),
                          );
                        },
                      )
                    : SizedBox(
                        height: height * .6,
                        child: const Center(
                          child: Text(
                            'No EMPLOYEE found.',
                            style: Utils.myTxtStyleBodySmall,
                          ),
                        ),
                      );
              }
            },
          ),
        ],
      ),
    );
  }

  void sortEmployeeList(String selectedItem) async {
    String sortType = '';

    switch (selectedItem) {
      case Constants.asc:
        sortType = 'asc';
        break;
      case Constants.desc:
        sortType = 'desc';
        break;
    }

    //final employeeSearchProvider = context.read<EmployeeSearchProvider>();
    await provider.search(token, '', sortType);

    // if the search is successful
    if (provider.success) {
      // update the list
      print('search success');
    }
  }
}
