import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/widget/banner_card.dart';

import 'global_errors.dart';

class GlobalErrorsBanner extends StatefulWidget {
  const GlobalErrorsBanner({super.key});

  @override
  State<GlobalErrorsBanner> createState() => _GlobalErrorsBannerState();
}

class _GlobalErrorsBannerState extends State<GlobalErrorsBanner> {
  static const _errorHideDuration = Duration(seconds: 5);
  static const _bannerAnimationDuration = Duration(milliseconds: 500);

  Web3Exception _error = const Web3Exception(0); // Initial error placeholder
  bool _isVisible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final globalErrorsSink = context.read<GlobalErrorsSink>();
    globalErrorsSink.web3ErrorsStream.listen((error) {
      // An error came, so cancel the timer (don't hide the banner)
      _timer?.cancel();

      setState(() {
        _error = error;
        _isVisible = true;

        // Hide the banner after 5 seconds, if no other error comes
        _timer = Timer(_errorHideDuration, _hideError);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        duration: _bannerAnimationDuration,
        opacity: _isVisible ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 56),
          child: BannerCard(
            color: Colors.red,
            icon: const Icon(Icons.error_outline),
            content: Text(_error.getDisplayMessage()),
          ),
        ),
      ),
    );
  }

  void _hideError() {
    _timer = null;
    setState(() {
      _isVisible = false;
    });
  }
}
