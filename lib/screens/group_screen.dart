import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../provider/auth_key_provider.dart';
import '../provider/group_list_provider.dart';
import '../widgets/create_group_bottom_sheet.dart';
import '../widgets/elevated_create_button.dart';
import '../widgets/group_list_item_widget.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late final GroupListProvider provider;
  late final String token;

  @override
  void initState() {
    instantiate();

    super.initState();
  }

  /// This method is for initializing the provider
  /// and getting the user token
  void instantiate() async {
    // get the user token from the provider
    await context.read<AuthKeyProvider>().getUserToken();

    if (context.mounted) {
      // initialize the user token
      token = context.read<AuthKeyProvider>().userToken!;

      // initialize the provider
      provider = context.read<GroupListProvider>();
      await provider.getList(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        // Refresh the list when the user pulls down
        return provider.getList(token);
      },
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ElevatedCreateButtonWidget(
              title: 'Create Group',
              icon: Icons.add_circle_outline,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const CreateGroupBottomSheet(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24.0),
          Consumer<GroupListProvider>(
            builder: (context, provider, child) {
              if (provider.data == null) {
                // show the loader overlay when the data is null
                context.loaderOverlay.show();

                return const SizedBox();
              } else {
                // hide the loader overlay
                context.loaderOverlay.hide();

                // show the list of groups
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final group = provider.data![index];

                    return GroupListItemWidget(name: group.name);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
