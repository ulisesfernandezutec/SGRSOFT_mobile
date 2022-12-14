import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/const/forms.dart';

class DeleteConfirmModal extends StatelessWidget {
  const DeleteConfirmModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("¿Confima que desa borrar?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const Spacer(),
      Padding(
          padding: const EdgeInsets.all(10),
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => {Navigator.of(context).pop(false)},
                  label: const Text("Cancelar",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: FormConst.buttonPadding,
                    backgroundColor: Colors.grey,
                  )),
              ElevatedButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(true),
                  label: const Text("Eliminar",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: FormConst.buttonPadding,
                    backgroundColor: Colors.red,
                  )),
            ],
          ))
    ]);
  }
}
