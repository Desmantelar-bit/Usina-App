import 'package:flutter/material.dart';
import '../../models/tipo_informacao.dart';
import '../../models/unidade_de_medida.dart';

class CadastroTipoInformacaoPage extends StatefulWidget {
  const CadastroTipoInformacaoPage({super.key});

  @override
  State<CadastroTipoInformacaoPage> createState() =>
      _CadastroTipoInformacaoPageState();
}

class _CadastroTipoInformacaoPageState
    extends State<CadastroTipoInformacaoPage> {
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final unidadeDeMedidaController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    unidadeDeMedidaController.dispose();
    super.dispose();
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      final tipoInformacao = TipoInformacao(
        id: 0,
        nome: nomeController.text.trim(),
        unidadeDeMedida: UnidadeDeMedida(
          id: 0,
          nome: unidadeDeMedidaController.text.trim(),
          simbolo: '',
        ),
      );
      print('Nome: ${tipoInformacao.nome}');
      print('Unidade de Medida: ${tipoInformacao.unidadeDeMedida.nome}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tipo de Informação cadastrado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Tipo de Informação')),
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
                        controller: unidadeDeMedidaController,
                        decoration: const InputDecoration(
                          labelText: 'Unidade de Medida',
                          border: OutlineInputBorder(),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Informe a unidade de medida';
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
