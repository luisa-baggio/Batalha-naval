import 'dart:io';

class Ponto {
  int linha;
  int coluna;

  Ponto(this.linha, this.coluna);
}

class BatalhaNaval {
  int tamanho = 16;

  List<List<String>> tabuleiroNavios = [];
  List<List<String>> tabuleiroTiros = [];

  BatalhaNaval() {
    tabuleiroNavios = List.generate(
      tamanho,
      (_) => List.generate(tamanho, (_) => "[ ]"),
    );

    tabuleiroTiros = List.generate(
      tamanho,
      (_) => List.generate(tamanho, (_) => "[ ]"),
    );
  }

  void exibirTabuleiroTiros() {
    print("\nTABULEIRO:");

    stdout.write("   ");
    for (int j = 0; j < tamanho; j++) {
      stdout.write("$j ");
    }
    print("");

    for (int i = 0; i < tamanho; i++) {
      stdout.write("$i ");

      for (int j = 0; j < tamanho; j++) {
        stdout.write(tabuleiroTiros[i][j]);
      }

      print("");
    }
  }

  void posicionarNavio(int linha, int coluna, int tamanhoNavio) {
    for (int i = 0; i < tamanhoNavio; i++) {
      tabuleiroNavios[linha][coluna + i] = "[S]";
    }
  }

  bool atirar(Ponto ponto) {
    if (tabuleiroNavios[ponto.linha][ponto.coluna] == "[S]") {
      tabuleiroTiros[ponto.linha][ponto.coluna] = "[X]";
      return true;
    } else {
      tabuleiroTiros[ponto.linha][ponto.coluna] = "[~]";
      return false;
    }
  }
}

void limparTela() {
  stdout.write("\x1B[2J\x1B[0;0H");
}

void posicionarNavioJogador(BatalhaNaval jogo, String jogador) {
  int tamanhoNavio;

  while (true) {
    print("\n$jogador escolha o tamanho do navio:");
    tamanhoNavio = int.parse(stdin.readLineSync()!);

    stdout.write("Linha inicial: ");
    int linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna inicial: ");
    int coluna = int.parse(stdin.readLineSync()!);

    if (coluna + tamanhoNavio > jogo.tamanho) {
      print("⚠ O navio não cabe no tabuleiro. Tente novamente.");
    } else {
      jogo.posicionarNavio(linha, coluna, tamanhoNavio);
      break;
    }
  }
}

void main() {
  int placarJogador1 = 0;
  int placarJogador2 = 0;

  stdout.write("Nome do Jogador 1: ");
  String jogador1 = stdin.readLineSync()!;

  stdout.write("Nome do Jogador 2: ");
  String jogador2 = stdin.readLineSync()!;

  BatalhaNaval jogo1 = BatalhaNaval();
  BatalhaNaval jogo2 = BatalhaNaval();

  posicionarNavioJogador(jogo1, jogador1);

  print("\nPasse o computador para $jogador2 e pressione ENTER");
  stdin.readLineSync();
  limparTela();

  posicionarNavioJogador(jogo2, jogador2);

  print("\nPressione ENTER para começar a batalha!");
  stdin.readLineSync();
  limparTela();

  bool venceu = false;

  while (!venceu) {
    print("\nTurno de $jogador1");
    jogo2.exibirTabuleiroTiros();

    stdout.write("Linha do tiro: ");
    int linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna do tiro: ");
    int coluna = int.parse(stdin.readLineSync()!);

    Ponto tiro = Ponto(linha, coluna);
    bool acerto = jogo2.atirar(tiro);

    jogo2.exibirTabuleiroTiros();

    if (acerto) {
      print("💥 ACERTOU O NAVIO!");
      placarJogador1++;
      print("🏆 $jogador1 venceu!");
      venceu = true;
      break;
    } else {
      print("🌊 Água!");
    }

    print("\nPasse o computador para $jogador2 e pressione ENTER");
    stdin.readLineSync();
    limparTela();

    print("\nTurno de $jogador2");
    jogo1.exibirTabuleiroTiros();

    stdout.write("Linha do tiro: ");
    int linha2 = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna do tiro: ");
    int coluna2 = int.parse(stdin.readLineSync()!);

    Ponto tiro2 = Ponto(linha2, coluna2);
    bool acerto2 = jogo1.atirar(tiro2);

    jogo1.exibirTabuleiroTiros();

    if (acerto2) {
      print("💥 ACERTOU O NAVIO!");
      placarJogador2++;
      print("🏆 $jogador2 venceu!");
      venceu = true;
    } else {
      print("🌊 Água!");
    }

    print("\nPasse o computador para $jogador1 e pressione ENTER");
    stdin.readLineSync();
    limparTela();
  }

  print("\n===== PLACAR FINAL =====");
  print("$jogador1: $placarJogador1");
  print("$jogador2: $placarJogador2");
}
