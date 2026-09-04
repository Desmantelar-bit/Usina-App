import 'package:flutter/material.dart';
import '../../models/safra.dart';

class CadastroSafraPage extends StatefulWidget {
  const CadastroSafraPage({super.key});

  @override
  State<CadastroSafraPage> createState() => _CadastroSafraPageState();
}

class _CadastroSafraPageState extends State<CadastroSafraPage> {
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final dataInicioController = TextEditingController();
  final dataFimController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    dataInicioController.dispose();
    dataFimController.dispose();
    super.dispose();
  }

  Future<void> selecionarData(TextEditingController controller) async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (data != null) {
      controller.text =
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
      final safra = Safra(
        id: 0,
        nomeSafra: nomeController.text.trim(),
        dataInicio: _parseData(dataInicioController.text),
        dataFim: _parseData(dataFimController.text),
      );
      print('Nome: ${safra.nomeSafra}');
      print('Data Início: ${safra.dataInicio}');
      print('Data Fim: ${safra.dataFim}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Safra cadastrada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Safra')),
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
                        controller: nomeController,
                        decoration: const InputDecoration(
                          labelText: 'Nome da Safra',
                          border: OutlineInputBorder(),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe o nome da safra';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dataInicioController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Data de Início',
                          hintText: 'DD/MM/AAAA',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => selecionarData(dataInicioController),
                          ),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe a data de início';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dataFimController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Data de Fim',
                          hintText: 'DD/MM/AAAA',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => selecionarData(dataFimController),
                          ),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe a data de fim';
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
