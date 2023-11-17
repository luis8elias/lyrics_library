import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RegisterScreen extends ConsumerWidget{
  const RegisterScreen({super.key});

  static const String routeName = 'register';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final sessionProv = ref.read(sessionProvider);
    return const Scaffold(
      // appBar: AppBar(
      //   leading: const Padding(
      //     padding: EdgeInsets.all(8.0),
      //     child: BackButtonWidget()
      //   ),
      // ),
      body: Center(
        child: Text('register'),
      ),
    );
  }
}


