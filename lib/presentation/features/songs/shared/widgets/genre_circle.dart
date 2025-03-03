import 'package:flutter/material.dart';

class GenreCricle extends StatelessWidget {
  const GenreCricle({
    super.key,
    required this.genreName,
    this.onPressed
  });

  final String genreName;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 25,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.colorScheme.tertiary.withOpacity(0.3),
          border: Border.all(
            color: theme.colorScheme.tertiary
          ),
        ),
        child: Center(
          child: Text(
            genreName,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onBackground,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}