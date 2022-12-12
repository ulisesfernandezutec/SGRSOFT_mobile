import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:sgrsoft/domain/enums/punto_recoleccion_estados.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';

typedef ValueChanged<T> = void Function(T value);

class SearchBoxPuntosRecoleccion extends StatelessWidget {
  // Tipos de residuos para el filtro
  final List<TipoDeResiduo> tiposResiduos;
  final ValueChanged<List<int>> onTiposResiduosSelected;
  // Buscar
  final TextEditingController buscarControl;
  final ValueChanged<String> onBuscar;
  // Expandir filtro
  final bool filterExpand;
  final ValueChanged<bool> onFilterExpand;
  // Objeto de busqueda
  final SearchPuntosRecoleccionObject objSearch;

  const SearchBoxPuntosRecoleccion(
      {super.key,
      required this.filterExpand,
      required this.onFilterExpand,
      required this.objSearch,
      required this.tiposResiduos,
      required this.onTiposResiduosSelected,
      required this.buscarControl,
      required this.onBuscar});

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Card(
          // color: Colors.white.withOpacity(0.8),
          elevation: 5,
          child: Container(
            height: filterExpand ? 300 : 58,
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Theme.of(context).drawerTheme.backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              Row(
                children: <Widget>[
                  Icon(Icons.search,
                      color: Theme.of(context).colorScheme.primary),
                  Expanded(
                      child: TextField(
                    controller: buscarControl,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Buscar',
                    ),
                    onChanged: (String e) => onBuscar(e),
                  )),
                  Container(
                    height: 38,
                    // padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //     color: const Color(0xff39ceb9), width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton.icon(
                      onPressed: () => onFilterExpand(filterExpand),
                      icon: const Icon(
                        Icons.tune,
                        size: 24.0,
                      ),
                      label: const Text('Filtros'),
                    ),
                  ),
                ],
              ),
              filterExpand ? const Divider() : Container(),
              filterExpand
                  ? Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Form(
                              child: Column(children: [
                            tiposResiduos.isNotEmpty
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: MultiSelectFormField(
                                      autovalidate:
                                          AutovalidateMode.onUserInteraction,
                                      chipBackGroundColor:
                                          Theme.of(context).primaryColor,
                                      chipLabelStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      // dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                                      checkBoxActiveColor:
                                          Theme.of(context).primaryColor,
                                      checkBoxCheckColor: Colors.white,
                                      dialogShapeBorder:
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0))),
                                      title: const Text(
                                        "Tipos de Residuos",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      dataSource: tiposResiduos
                                          .map((e) => {
                                                "nombre": e.nombre,
                                                "id": e.id.toInt()
                                              })
                                          .toList(),
                                      textField: 'nombre',
                                      valueField: 'id',
                                      okButtonLabel: 'SELECCIONAR',
                                      cancelButtonLabel: 'CANCELAR',
                                      hintWidget: const Text(
                                          'Por favor seleccione uno o más'),
                                      initialValue: objSearch.tipos
                                          ?.map((e) => e.id.toInt())
                                          .toList(),
                                      onSaved: (value) {
                                        if (value == null) return;
                                        List<int> iDs = List<int>.from(value);
                                        onTiposResiduosSelected(iDs);
                                      },
                                    ))
                                : Container(
                                    padding: const EdgeInsets.all(5),
                                    child: const Text(
                                        "No se pudieron cargar los tipos de residuos")),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    border: OutlineInputBorder(
                                      // borderSide:
                                      //     BorderSide(color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(16),
                                    // fillColor: Colors.blueAccent,
                                  ),
                                  validator: (value) => value == null
                                      ? 'Seleccione un tipo de residuo'
                                      : null,
                                  // value: "",
                                  hint: const Text(
                                      "Seleccione el estado del punto de recolección"),
                                  items: PuntoRecoleccionEstadoOptions.values
                                      .map((o) => DropdownMenuItem(
                                          value: o.value, child: Text(o.value)))
                                      .toList(),
                                  onChanged: (value) {
                                    // updateSeleced(value);
                                  }),
                            ),
                          ]))))
                  : Container(),
            ]),
          )),
    );
  }
}
