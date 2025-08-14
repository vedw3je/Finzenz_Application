import 'package:finzenz_app/commonwidgets/finzenzappbar.dart';
import 'package:finzenz_app/constants/app_colors.dart';
import 'package:finzenz_app/modules/profile/widget/account_selector.dart';
import 'package:finzenz_app/modules/profile/widget/profile_card.dart';
import 'package:finzenz_app/modules/profile/widget/section_heading.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/account_selector.dart';
import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/bloc/home_cubit.dart';
import '../../home/bloc/home_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Account> accounts = [];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeCubit>();
    if (cubit.state is HomeFetched) {
      accounts = (cubit.state as HomeFetched).accounts;
    }
    cubit.fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppColors.mainGradient),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            ProfileCard(),
            const SizedBox(height: 24),
            const SectionHeading(title: "Your Accounts"),
            AccountSelectorSection(accounts: accounts),
            const SectionHeading(title: "Recent Transactions"),
          ],
        ),
      ),
    );
  }
}
