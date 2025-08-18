import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpn_client/design/colors.dart';
import 'package:vpnclient_engine_flutter/vpnclient_engine_flutter.dart';
import 'package:vpn_client/localization_service.dart';
import 'package:vpn_client/vpn_state.dart';
import 'package:vpn_client/services/config_service.dart';


class MainBtn extends StatefulWidget {
  const MainBtn({super.key});

  @override
  State<MainBtn> createState() => MainBtnState();
}

class MainBtnState extends State<MainBtn> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _sizeAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.ease),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vpnState = Provider.of<VpnState>(context, listen: false);
      if (vpnState.connectionStatus == ConnectionStatus.connected) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String connectionStatusText(BuildContext context) {
    final vpnState = Provider.of<VpnState>(context, listen: false);

    return {
      ConnectionStatus.connected: LocalizationService.to('connected'),
      ConnectionStatus.disconnected: LocalizationService.to('disconnected'),
      ConnectionStatus.connecting: LocalizationService.to('connecting'),
      ConnectionStatus.error: LocalizationService.to('error'),
    }[vpnState.connectionStatus]!;
  }

  Future<void> _toggleConnection(BuildContext context) async {
    final vpnState = Provider.of<VpnState>(context, listen: false);
    final vpnEngine = VpnclientEngineFlutter.instance;

    switch (vpnState.connectionStatus) {
      case ConnectionStatus.disconnected:
        vpnState.setConnectionStatus(ConnectionStatus.connecting);
        _animationController.repeat(reverse: true);
        
        String link = ConfigService.mainSubscriptionUrl;
        if (await vpnEngine.requestPermissions(EngineType.v2ray)) {
          bool success = await vpnEngine.connect(EngineType.v2ray, link);
          
          if (success) {
            vpnState.startTimer();
            vpnState.setConnectionStatus(ConnectionStatus.connected);
            await _animationController.forward();
            _animationController.stop();
          } else {
            vpnState.setConnectionStatus(ConnectionStatus.error);
            _animationController.stop();
          }
        } else {
          vpnState.setConnectionStatus(ConnectionStatus.error);
          _animationController.stop();
        }
        
      case ConnectionStatus.connected:
        vpnState.setConnectionStatus(ConnectionStatus.connecting);
        _animationController.repeat(reverse: true);
        await vpnEngine.disconnect();
        vpnState.stopTimer();
        vpnState.setConnectionStatus(ConnectionStatus.disconnected);
        await _animationController.reverse();
        _animationController.stop();
      default:
        // Handle error state by resetting to disconnected
        if (vpnState.connectionStatus == ConnectionStatus.error) {
          vpnState.setConnectionStatus(ConnectionStatus.disconnected);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vpnState = Provider.of<VpnState>(context);

    return Column(
      children: [
        Text(
          vpnState.connectionTimeText,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color:
                vpnState.connectionStatus == ConnectionStatus.connected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 70),
        GestureDetector(
          onTap: () => _toggleConnection(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              AnimatedBuilder(
                animation: _sizeAnimation,
                builder: (context, child) {
                  return Container(
                    width: _sizeAnimation.value,
                    height: _sizeAnimation.value,
                    decoration: BoxDecoration(
                      gradient: mainGradient,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.center,
                width: 150,
                height: 150,
                child: const Icon(
                  Icons.power_settings_new_rounded,
                  color: Colors.white,
                  size: 70,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          connectionStatusText(context),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
