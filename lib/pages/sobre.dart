import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Sobre extends StatefulWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        title: const Text('Sobre'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _packageInfo.appName,
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            Text(
              'Versão: ' + _packageInfo.version,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset(
                'assets/images/image01.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '2022 - Lucas Andrade',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Text(
              'Todos os direitos reservados.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
