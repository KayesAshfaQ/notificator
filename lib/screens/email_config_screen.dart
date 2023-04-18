import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/model/email_config_response.dart';
import 'package:notificator/provider/email_config_provider.dart';
import 'package:provider/provider.dart';

import '../provider/auth_key_provider.dart';
import '../provider/toast_provider.dart';
import '../util/helper.dart';
import '../util/utils.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';

class EmailConfigScreen extends StatefulWidget {
  const EmailConfigScreen({Key? key}) : super(key: key);

  @override
  State<EmailConfigScreen> createState() => _EmailConfigScreenState();
}

class _EmailConfigScreenState extends State<EmailConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _driverController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _encryptionController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _senderNameController = TextEditingController();
  final TextEditingController _senderEmailController = TextEditingController();

  @override
  void initState() {
    fetchEmailConfig();
    super.initState();
  }

  @override
  void dispose() {
    _driverController.dispose();
    _hostController.dispose();
    _portController.dispose();
    _passwordController.dispose();
    _encryptionController.dispose();
    _usernameController.dispose();
    _senderNameController.dispose();
    _senderEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(title: 'Email Configuration'),
      body: SingleChildScrollView(
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
                SeparatedLabeledTextField(
                  controller: _driverController,
                  labelText: 'Driver',
                  hintText: 'Enter Driver Name',
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _hostController,
                  labelText: 'Host Name',
                  hintText: 'Enter Host Name',
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _portController,
                  labelText: 'Port',
                  hintText: 'Enter Port Address',
                  //inputType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _encryptionController,
                  labelText: 'Encryption',
                  hintText: 'Enter Encryption Type',
                  validator: Utils.validate,
                ),

                // assign group field
                const SizedBox(height: 16),

                SeparatedLabeledTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  hintText: 'Enter SMTP Username',
                  validator: Utils.validate,
                ),

                // assign group field
                const SizedBox(height: 16),

                SeparatedLabeledTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter SMTP Password',
                  isPassword: true,
                  validator: Utils.validatePassword,
                ),

                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _senderNameController,
                  labelText: 'Sender Name',
                  hintText: 'Enter Mail Sender Name',
                  validator: Utils.validate,
                ),

                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _senderEmailController,
                  labelText: 'Sender Email',
                  hintText: 'Enter Sender Email Address',
                  validator: Utils.validate,
                ),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: updateEmailConfiguration,
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
                    'Update',
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
    );
  }

  /// update email configurations
  void updateEmailConfiguration() async {
    // validate form
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // get the filed texts
      String driver = _driverController.text.trim();
      String host = _hostController.text.trim();
      String port = _portController.text.trim();
      String encraption = _encryptionController.text.trim();
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();
      String senderName = _senderNameController.text.trim();
      String senderEmail = _senderEmailController.text.trim();

      // create the employee obj
      Config config = Config(
        driver: driver,
        host: host,
        port: port,
        encryption: encraption,
        userName: username,
        password: password,
        senderName: senderName,
        senderEmail: senderEmail,
      );

      // initialize toast provider
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // get token through provider
      final String? token = context.read<AuthKeyProvider>().userToken;

      // call the rest api through provider & send data through it
      final provider = context.read<EmailConfigProvider>();
      await provider.setEmailConfig(config, token!);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        toastProvider.showSuccessToast('SMTP Configurations Updated Successfully');

        // navigate to the home page
        if(context.mounted) Navigator.pop(context);


      } else {
        // Display an error toast
        toastProvider.showErrorToast(provider.error);
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }

  /// fetch config data
  void fetchEmailConfig() async {
    // Display a progress loader
    context.loaderOverlay.show();

    // initialize provider
    final provider = context.read<EmailConfigProvider>();

    // get token through provider
    String token = await Helper.getToken(context);

    //call the rest api to fetch config data
    await provider.getEmailConfig(token);

    // check if the submission was successful
    if (provider.success) {
      debugPrint('groups fetched successfully');

      // initialize the global groups list with the fetched data
      Config? config = provider.data;

      if (config != null) {
        // set the config data to the text fields through controllers
        _driverController.text = config.driver ?? '';
        _hostController.text = config.host ?? '';
        _portController.text = config.port ?? '';
        _encryptionController.text = config.encryption ?? '';
        _usernameController.text = config.userName ?? '';
        _passwordController.text = config.password ?? '';
        _senderNameController.text = config.senderName ?? '';
        _senderEmailController.text = config.senderEmail ?? '';
      }
    } else {
      // Display an error toast
      debugPrint(provider.error);
    }

    // Hide the progress loader
    if (context.mounted) context.loaderOverlay.hide();
  }
}
