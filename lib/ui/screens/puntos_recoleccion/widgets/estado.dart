import 'package:flutter/material.dart';

class EstadoWidget extends StatelessWidget {
  const EstadoWidget({Key? key, required this.estado}) : super(key: key);
  final String estado;
  // PaletteGenerator paletteGenerator = PaletteGenerator.

  // Future<void> _updatePaletteGenerator(Rect? newRegion) async {
  //   paletteGenerator = await PaletteGenerator.fromImageProvider(
  //     widget.image,
  //     size: widget.imageSize,
  //     region: newRegion,
  //     maximumColorCount: 20,
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: estado == 'Pendiente'
            ? Colors.yellow
            : estado == 'Terminado'
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        estado.toUpperCase(),
        style: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 12,
        ),
      ),
    );
  }
}
