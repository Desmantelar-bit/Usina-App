import 'package:flutter/material.dart';
import '../../models/medicao.dart';
import '../../models/safra.dart';
import '../../models/tipo_informacao.dart';
import '../../models/equipamento.dart';
import '../../models/unidade.dart';
import '../../models/unidade_de_medida.dart';

class CadastroMedicaoPage extends StatefulWidget {
  const CadastroMedicaoPage({super.key});

  @override
  State<CadastroMedicaoPage> createState() => _CadastroMedicaoPageState();
}

class _CadastroMedicaoPageState extends State<CadastroMedicaoPage> {
  final formKey = GlobalKey<FormState>();
  final valorController = TextEditingController();
  final dataController = TextEditingController();
  final safraController = TextEditingController();
  final tipoInformacaoController = TextEditingController();
  final equipamentoController = TextEditingController();

  @override
  void dispose() {
    valorController.dispose();
    dataController.dispose();
    safraController.dispose();
    tipoInformacaoController.dispose();
    equipamentoController.dispose();
    super.dispose();
  }

  Future<void> selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (data != null) {
      dataController.text =
          '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
    }
  }

  DateTime _parseData(String valor) {
    final partes = valor.split('/');
    return DateTime(
      int.parse(partes[2]),
      int.parse(partes[1]),
      int.parse(partes[0]),
    );
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      final medicao = Medicao(
        id: 0,
        valor: double.parse(valorController.text.trim()),
        data: _parseData(dataController.text),
        safra: Safra(
          id: 0,
          nomeSafra: safraController.text.trim(),
          dataInicio: DateTime.now(),
          dataFim: DateTime.now(),
        ),
        tipoInformacao: TipoInformacao(
          id: 0,
          nome: tipoInformacaoController.text.trim(),
          unidadeDeMedida: UnidadeDeMedida(id: 0, nome: '', simbolo: ''),
        ),
        equipamento: Equipamento(
          id: 0,
          nome: equipamentoController.text.trim(),
          unidade: Unidade(id: 0, nome: ''),
        ),
      );
      print('Valor: ${medicao.valor}');
      print('Data: ${medicao.data}');
      print('Safra: ${medicao.safra.nomeSafra}');
      print('Tipo de Informação: ${medicao.tipoInformacao.nome}');
      print('Equipamento: ${medicao.equipamento.nome}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medição cadastrada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Medição')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: valorController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Valor',
                          border: OutlineInputBorder(),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe o valor';
                          }
                          if (double.tryParse(valor.trim()) == null) {
                            return 'Informe um valor numérico válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dataController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Data',
                          hintText: 'DD/MM/AAAA',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: selecionarData,
                          ),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe a data';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: safraController,
                        decoration: const InputDecoration(
                          labelText: 'Safra',
                          border: OutlineInputBorder(),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe a safra';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: tipoInformacaoController,
                        decoration: const InputDecoration(
                          labelText: 'Tipo de Informação',
                          border: OutlineInputBorder(),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe o tipo de informação';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: equipamentoController,
                        decoration: const InputDecoration(
                          labelText: 'Equipamento',
                          border: OutlineInputBorder(),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe o equipamento';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 140,
                          child: ElevatedButton(
                            onPressed: salvar,
                            child: const Text('Salvar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
