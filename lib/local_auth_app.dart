import 'package:faceid/auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool authenticated=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Id '),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: ()async{
                  final authenticate =await LocalAuth.authenticate();
                  setState(() {
                    authenticated=authenticate!;
                  });
                },
                child: const Text('Authenticate'),
            ),
            if(authenticated)
              const Text('You are authenticated'),
            if(authenticated)
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    authenticated=false;
                  });
                },
                child: const Text('Log out'),
              ),

          ],
        ),
      ),
    );
  }
}
