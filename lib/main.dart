import 'models/equipamento.dart';
import 'models/indicador.dart';
import 'models/medicao.dart';
import 'models/safra.dart';
import 'models/tipo_informacao.dart';
import 'models/unidade.dart';
import 'models/unidade_de_medida.dart';

void main() {
  final unidadeDeMedida = UnidadeDeMedida(
    id: 1,
    nome: 'Tonelada',
    simbolo: 't',
  );

  final tipoInformacao = TipoInformacao(
    id: 1,
    nome: 'Produção de açúcar',
    unidadeDeMedida: unidadeDeMedida,
  );

  final safra = Safra(
    id: 1,
    nomeSafra: 'Safra 2026',
    dataInicio: DateTime(2026, 4, 1),
    dataFim: DateTime(2026, 11, 30),
  );

  final unidade = Unidade(
    id: 1,
    nome: 'Usina Principal',
  );

  final equipamento = Equipamento(
    id: 1,
    nome: 'Balança industrial',
    unidade: unidade,
  );

  final medicao = Medicao(
    id: 1,
    safra: safra,
    tipoInformacao: tipoInformacao,
    valor: 850.5,
    data: DateTime.now(),
    equipamento: equipamento,
  );

  final indicador = Indicador(
    id: 1,
    nome: 'Produção diária',
    descricao: 'Quantidade de açúcar produzida no dia',
    url: 'https://exemplo.com/indicadores/producao',
  );

  print('Indicador: ${indicador.nome}');
  print('Descrição: ${indicador.descricao}');
  print('Safra: ${medicao.safra.nomeSafra}');
  print('Tipo: ${medicao.tipoInformacao.nome}');
  print('Valor: ${medicao.valor} ${medicao.tipoInformacao.unidadeDeMedida.simbolo}');
  print('Equipamento: ${medicao.equipamento.nome}');
  print('Unidade: ${medicao.equipamento.unidade.nome}');
}