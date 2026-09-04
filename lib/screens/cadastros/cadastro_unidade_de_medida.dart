import 'package:flutter/material.dart';
import '../../models/unidade_de_medida.dart';

class CadastroUnidadeDeMedidaPage extends StatefulWidget {
  const CadastroUnidadeDeMedidaPage({super.key});

  @override
  State<CadastroUnidadeDeMedidaPage> createState() =>
      _CadastroUnidadeDeMedidaPageState();
}

class _CadastroUnidadeDeMedidaPageState
    extends State<CadastroUnidadeDeMedidaPage> {
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final simboloController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    simboloController.dispose();
    super.dispose();
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      final unidadeDeMedida = UnidadeDeMedida(
        id: 0,
        nome: nomeController.text.trim(),
        simbolo: simboloController.text.trim(),
      );
      print('Nome: ${unidadeDeMedida.nome}');
      print('Símbolo: ${unidadeDeMedida.simbolo}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unidade de Medida cadastrada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Unidade de Medida')),
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
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe o nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: simboloController,
                        decoration: const InputDecoration(
                          labelText: 'Símbolo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe o símbolo';
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
