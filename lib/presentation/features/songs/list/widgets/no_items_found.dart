import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/widgets/buttons.dart';
import '/utils/constants/sizes.dart';
import '../providers/providers.dart';


class NoItemsFound extends ConsumerWidget {
  const NoItemsFound({
    super.key,
    required this.hideSearchInput
  });

  final VoidCallback hideSearchInput;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final prov = ref.read(songsListProvider);

    if(prov.filters.isNotEmpty){
      return _EmptySongsWithFilters(
        hideSearchInput: hideSearchInput,
      );
    }
    
    return const _EmptySongs();
  }
}


class _EmptySongs extends StatelessWidget {
  const _EmptySongs();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: FadeIn(
              child: Icon(
                CupertinoIcons.music_note,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            height: Sizes.kPadding,
          ),
          FadeIn(
            child: Text(
              'Sin Letras',
              style: theme.textTheme.titleSmall,
            ),
          ),
          const SizedBox(
            height: Sizes.kPadding / 2,
          ),
          FadeIn(
            child: Text(
              'No tienes letras creadas.\nPresiona el botón para añadir tu primera\nletra.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kPadding,
              vertical: Sizes.kPadding * 3
            ),
            child: FadeIn(
              child: BasicButton(
                text: '+ Crear nueva canción',
                onPressed: () {},
              ),
            )
          ),
        ],
      ),
    );
  }
}

class _EmptySongsWithFilters extends ConsumerWidget {
  const _EmptySongsWithFilters({
    required this.hideSearchInput
  });


  final VoidCallback hideSearchInput;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final prov = ref.read(songsListProvider);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: FadeIn(
              child: Icon(
                CupertinoIcons.music_note,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            height: Sizes.kPadding,
          ),
          FadeIn(
            child: Text(
              'Sin resultados',
              style: theme.textTheme.titleSmall,
            ),
          ),
          
          FadeIn(
            child: Text(
              'No hay coincidencias para:',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: Sizes.kPadding,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(prov.filters.query.isNotEmpty)
              FadeIn(
                child: RichText(
                  text: TextSpan(
                    text: '▫️ Búsqueda ',
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: prov.filters.query,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              if(prov.filters.genre != null)
              FadeIn(
                child: RichText(
                  text: TextSpan(
                    text: '▫️ Canciones con el género ',
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: prov.filters.genre?.genreName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Sizes.kPadding * 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kPadding,
            ),
            child: FadeIn(
              child: BasicButton(
                text: 'Remover filtros',
                onPressed: () {
                  prov.updateFilters((filters) {
                    return filters.copyWith(
                      query: '',
                      genre: null
                    );
                  });
                  hideSearchInput();
                },
              ),
            )
          ),
           const SizedBox(
            height: Sizes.kPadding * 7,
          ),
        ],
      ),
    );
  }
}