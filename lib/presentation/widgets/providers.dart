import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/providers/providers.dart';
import 'custom_error_widget.dart';
import 'loaders.dart';

class SendProviderListener<T> extends ConsumerWidget {
  const SendProviderListener({
    super.key,
    required this.provider,
    required this.child,
    this.onLoading,
    this.onError,
    this.onSuccess
  });

  final ProviderListenable<SendProvider<T>> provider;
  final Widget child;
  final VoidCallback? onLoading;
  final void Function (String error)? onError;
  final void Function (T model, String message)? onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(provider, (previous, next) {

      if (next.status == SendStatus .loading) {
        onLoading != null ? onLoading!() : (){};
      }
      if (next.status == SendStatus .failed) {
        onError != null ? onError!(next.message) : (){};
        next.resetStatus();
      }
      if (next.status == SendStatus.success) {
        onSuccess != null ? onSuccess!(next.model, next.message) : (){};
        next.resetStatus();
      }

    });
    return child;
  
  }
}



class SendProviderBuilder<T> extends ConsumerWidget {
  const SendProviderBuilder({
    super.key,
    required this.provider,
    required this.child,
    this.loaderWidget,
    this.errorWidget,
    this.successWidget,
  });

  final ProviderListenable<SendProvider<T>> provider;
  final Widget child;
  final Widget? loaderWidget;
  final Widget Function(String error)? errorWidget;
  final Widget Function(T model)? successWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final thisProvider  = ref.watch(provider);

    if (thisProvider.status == SendStatus.initial) {
      return child;
    }
    if (thisProvider.status == SendStatus.loading) {
      return loaderWidget ?? child;
    }

    if (thisProvider.status == SendStatus.failed) {
      return errorWidget == null 
      ? child
      : errorWidget!(thisProvider.message);
    }

    if (thisProvider.status == SendStatus.success) {
      return successWidget == null 
      ? child
      : successWidget!(thisProvider.model);
    }

    return child;
  }
}



class FetchProviderListener<T> extends ConsumerWidget {
  const FetchProviderListener({
    super.key,
    required this.provider,
    required this.child,
    this.onLoading,
    this.onError,
    this.onSuccess
  });

  final ProviderListenable<FetchProvider<T>> provider;
  final Widget child;
  final VoidCallback? onLoading;
  final void Function (String error)? onError;
  final void Function (T model, String messaage)? onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(provider, (previous, next) {

      if (next.status == FetchStatus .loading) {
        onLoading != null ? onLoading!() : (){};
      }
      if (next.status == FetchStatus .failed) {
        onError != null ? onError!(next.message) : (){};
      }
      if (next.status == FetchStatus.success) {
        onSuccess != null ? onSuccess!(next.model, next.message) : (){};
      }

    });
    return child;
  
  }
}



class FetchProviderBuilder<T> extends ConsumerWidget {
  const FetchProviderBuilder({
    super.key,
    required this.provider,
    required this.builder,
    this.loaderWidget,
    this.errorWidget
  });

  final ProviderListenable<FetchProvider<T>> provider;
  final Widget Function(T model) builder;
  final Widget Function(String error)? errorWidget;
  final Widget? loaderWidget;
  
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisProvider  = ref.watch(provider);

    if (thisProvider.status == FetchStatus.loading) {
      return loaderWidget ?? const LoadingWidget();
    }

    if (thisProvider.status == FetchStatus.failed) {
      return errorWidget == null 
      ? CustomErrorWidget(errorMessage: thisProvider.message) 
      : errorWidget!(thisProvider.message);
    }

    return builder(thisProvider.model);
    
  }
}
