import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_app/theme/app_theme.dart';
import 'package:health_app/widgets/page_container.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel userInformation = UserModel(name: '', email: '');
  List<HospitalModel> hospitalsList = [];

  Future<void> getUserInformation() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userInformation = UserModel(
            name: prefs.getString('name') ?? '',
            email: prefs.getString('email') ?? '');
      });
    } catch (e) {
      print(e);
    }
  }

  void addHospitalList() {
    final hospitalListProvider = Provider.of<HospitalListProvider>(context);
    hospitalsList = hospitalListProvider.hospitalsList;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    addHospitalList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    if (userInformation.name == '') {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Información de usuario',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PageContainer(
          child: Column(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: AppTheme.buttonLabelColor,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(userInformation.name),
          const SizedBox(
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Correo electrónico: '),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                ],
              ),
              Text('    ${userInformation.email}'),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Instituciones médicas: '),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                ],
              ),
              ...hospitalsList.map((e) => Text('    - ${e.name}'))
              // Expanded(
              //   child: ListView.builder(
              //       itemCount: 5,
              //       itemBuilder: (BuildContext context, int index) {
              //         return const Text('hospital');
              //       }),
              // )
            ],
          )
        ],
      )),
    );
  }
}
