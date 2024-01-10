import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/contracts/events.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/widget/banner_card.dart';
import 'package:url_launcher/url_launcher.dart';

import 'global_errors.dart';
import 'global_events.dart';

class GlobalErrorsBanner extends StatefulWidget {
  const GlobalErrorsBanner({super.key});

  @override
  State<GlobalErrorsBanner> createState() => _GlobalErrorsBannerState();
}

class _GlobalErrorsBannerState extends State<GlobalErrorsBanner> {
  static const _errorHideDuration = Duration(seconds: 8);

  StreamSubscription<Web3Notice>? _errorsSubscription;
  StreamSubscription<Web3Notice>? _eventsSubscription;

  Web3Notice? _error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final globalErrorsSink = context.read<GlobalErrorsSink>();
    final globalEventsSink = context.read<GlobalEventsSink>();

    _errorsSubscription = globalErrorsSink.web3ErrorsStream.listen(_onEvent);
    _eventsSubscription = globalEventsSink.web3ErrorsStream.listen(_onEvent);
  }

  @override
  void dispose() {
    super.dispose();
    _errorsSubscription?.cancel();
    _eventsSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 56),
      child: _buildCardForNotice(_error),
    );
  }

  Widget _buildCardForNotice(Web3Notice? notice) {
    if (notice == null) {
      return const SizedBox.shrink();
    }

    if (notice is Web3Exception) {
      return ErrorBannerCard.fromWeb3Error(notice);
    }

    const icon = Icon(Icons.check);
    const color = Colors.green;

    if (notice is Web3TransactionSent) {
      // Also show a link to Etherscan (for Sepolia)
      final url = Uri.parse(
          'https://sepolia.etherscan.io/tx/${notice.transactionHash}');
      final link = TextButton.icon(
        onPressed: () => launchUrl(url, webOnlyWindowName: '_blank'),
        icon: const Icon(Icons.open_in_new, color: Colors.white),
        label: Text(
          AppLocalizations.of(context)!.etherscanLinkLabel,
          style: const TextStyle(color: Colors.white),
        ),
      );
      return BannerCard(
        color: color,
        icon: icon,
        content: Text(
          AppLocalizations.of(context)!.transactionSentEventLabel(
            notice.transactionHash,
          ),
        ),
        action: link,
      );
    }

    if (notice is Web3CoinTransfer) {
      final String label;
      if (notice.fromNoOne()) {
        label = AppLocalizations.of(context)!.coinTransferSent(
          notice.value.toString(),
        );
      } else if (notice.toNoOne()) {
        label = AppLocalizations.of(context)!.coinTransferReceived(
          notice.value.toString(),
        );
      } else {
        label = AppLocalizations.of(context)!.coinTransferExchanged(
          notice.value.toString(),
          notice.from,
          notice.to,
        );
      }

      return BannerCard(color: color, icon: icon, content: Text(label));
    }

    return BannerCard(
      color: color,
      icon: icon,
      content: Text(notice.getDisplayMessage()),
    );
  }

  void _onEvent(Web3Notice event) {
    // An error came, so cancel the timer (don't hide the banner)
    _timer?.cancel();

    setState(() {
      _error = event;

      // Hide the banner after 5 seconds, if no other error comes
      _timer = Timer(_errorHideDuration, _hideError);
    });
  }

  void _hideError() {
    _timer = null;
    setState(() {
      _error = null;
    });
  }
}