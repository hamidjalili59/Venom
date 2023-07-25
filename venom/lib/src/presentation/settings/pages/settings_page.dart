import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:venom/src/config/routes/router.dart';
import 'package:venom/src/injectable/injectable.dart';

@RoutePage(name: 'settings')
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.monetization_on_outlined),
            title: const Text("Gas price"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              getIt.get<AppRouter>().pushNamed('/default_price_selector');
            },
          ),
          ListTile(
            leading: const Icon(Icons.gas_meter_outlined),
            title: const Text("Gas capacity"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              getIt.get<AppRouter>().pushNamed('/default_vehicle_selector');
            },
          ),
          // Implement this when Theme Service is Ready.
          /*const ListTile(
            leading: Icon(Icons.palette_outlined),
            title: Text("Theme"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),*/
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text("About"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              getIt.get<AppRouter>().pushNamed('/about');
            },
          ),
        ],
      ),
    );
  }
}
