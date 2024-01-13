import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
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

  final _notices = <Web3Notice>{}; // Empty set

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final notice in _notices) _buildCardForNotice(context, notice),
        ],
      ),
    );
  }

  Widget _buildCardForNotice(BuildContext context, Web3Notice? notice) {
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

    final authenticatedAccount =
        (context.read<AuthBloc>().state as AuthLoggedIn?)?.account.address;

    if (notice is Web3CoinTransfer) {
      final String label;
      if (notice.from == authenticatedAccount) {
        label = AppLocalizations.of(context)!.coinTransferSent(
          notice.value.toString(),
        );
      } else if (notice.to == authenticatedAccount) {
        label = AppLocalizations.of(context)!.coinTransferReceived(
          notice.value.toString(),
        );
      } else {
        // I don't care about this event
        return const SizedBox.shrink();
      }

      return BannerCard(color: color, icon: icon, content: Text(label));
    }

    if (notice is Web3DomainTransfer) {
      final String label;

      if (notice.from == authenticatedAccount) {
        label = AppLocalizations.of(context)!.domainTransferSent(
          notice.domainName,
        );
      } else if (notice.to == authenticatedAccount) {
        label = AppLocalizations.of(context)!.domainTransferReceived(
          notice.domainName,
        );
      } else {
        // I don't care about this event
        return const SizedBox.shrink();
      }

      return BannerCard(color: color, icon: icon, content: Text(label));
    }

    // Ignore events where the seller is someone else
    if (notice is Web3DomainListingForSale &&
        notice.seller != authenticatedAccount) {
      return const SizedBox.shrink();
    }

    // Ignore events where the seller or buyer is someone else
    if (notice is Web3DomainSold &&
        (notice.seller != authenticatedAccount ||
            notice.buyer != authenticatedAccount)) {
      return const SizedBox.shrink();
    }

    return BannerCard(
      color: color,
      icon: icon,
      content: Text(notice.getDisplayMessage()),
    );
  }

  void _onEvent(Web3Notice event) {
    if (_notices.contains(event)) {
      return;
    }

    setState(() {
      _notices.add(event);
    });

    // Hide the banner after N seconds
    Future.delayed(
      _errorHideDuration,
      () => setState(() {
        _notices.remove(event);
      }),
    );
  }
}
