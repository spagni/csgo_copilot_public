import 'package:csgo_copilot/application/auth/auth_bloc.dart';
import 'package:csgo_copilot/application/stats/stats_bloc.dart';
import 'package:csgo_copilot/presentation/screens/home/drawer/navigation_list_item.dart';
import 'package:csgo_copilot/presentation/screens/weapons/weapons_screen.dart';
import 'package:csgo_copilot/presentation/widgets/toast.dart';
import 'package:csgo_copilot/utils/di.dart';
import 'package:csgo_copilot/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.85),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(50.0),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _header,
            NavigationListItem(
              title: 'WEAPONS',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider<StatsBloc>.value(
                      value: context.read<StatsBloc>(),
                      child: WeaponsScreen(),
                    ),
                  ),
                );
              },
            ),
            NavigationListItem(
              title: 'MAPS',
              onPressed: () {},
            ),
            NavigationListItem(
              title: 'ABOUT',
              onPressed: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();

                showDialog(
                  context: context,
                  builder: (context) {
                    return AboutDialog(
                      applicationVersion: packageInfo.version,
                      children: [
                        InkWell(
                          highlightColor: Theme.of(context).accentColor,
                          splashColor: Theme.of(context).primaryColor,
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: Preferences.getStringValueByType(
                                  PreferenceTypes.USER_STEAM_ID,
                                ),
                              ),
                            );

                            Toast.show(
                              context,
                              content: 'SteamID copied to the clipboard',
                              backgroundColor: Theme.of(context).accentColor,
                            );
                          },
                          child: ListTile(
                            leading: Icon(Icons.copy),
                            title: Text('Copy my SteamID'),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Injector.getIt<AuthBloc>()..add(SignOut());
              },
              child: Text('SIGN OUT'),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _header {
    return Builder(
      builder: (context) {
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: Neumorphic(
                margin: EdgeInsets.only(left: 8.0),
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 1,
                  lightSource: LightSource.topLeft,
                  color: Theme.of(context).primaryColor,
                  intensity: .6,
                ),
                child: SvgPicture.asset(
                  'assets/svgs/icon.svg',
                  height: 70,
                  width: 70,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: FittedBox(
                child: Text(
                  'COPILOT',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.white.withOpacity(.8),
                      ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        );
      },
    );
  }
}
