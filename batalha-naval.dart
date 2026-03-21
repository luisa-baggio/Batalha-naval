import 'dart:io'; // importa a biblioteca para entrada (teclado) e saída (print)

// Classe que representa uma coordenada no tabuleiro
class Ponto {
  int linha;  // representa a linha (vertical)
  int coluna; // representa a coluna (horizontal)

  // Construtor: recebe linha e coluna e já salva nos atributos
  Ponto(this.linha, this.coluna);
}

// Classe principal do jogo
class BatalhaNaval {
  int tamanho = 16; // define o tamanho do tabuleiro (16x16)

  // Matrizes (listas 2D)
  List<List<String>> tabuleiroNavios = []; // guarda onde estão os navios
  List<List<String>> tabuleiroTiros = [];  // guarda tiros (acertos e erros)

  // Construtor da classe (executa quando cria o jogo)
  BatalhaNaval() {
    // Cria o tabuleiro de navios
    tabuleiroNavios = List.generate(
      tamanho, // quantidade de linhas
      (_) => List.generate(
        tamanho, // quantidade de colunas
        (_) => "[ ]", // preenche cada posição com vazio
      ),
    );

    // Cria o tabuleiro de tiros (mesma lógica)
    tabuleiroTiros = List.generate(
      tamanho,
      (_) => List.generate(tamanho, (_) => "[ ]"),
    );
  }

  // Mostra o tabuleiro de tiros na tela
  void exibirTabuleiroTiros() {
    print("\nTABULEIRO:"); // título

    stdout.write("   "); // espaço para alinhar com os números das linhas

    // Mostra os números das colunas (00, 01, 02...)
    for (int j = 0; j < tamanho; j++) {
      stdout.write("${j.toString().padLeft(2, '0')} ");
    }

    print(""); // quebra linha

    // Percorre todas as linhas
    for (int i = 0; i < tamanho; i++) {
      stdout.write("${i.toString().padLeft(2, '0')} "); // número da linha

      // Percorre todas as colunas
      for (int j = 0; j < tamanho; j++) {
        stdout.write(tabuleiroTiros[i][j]); // imprime cada posição
      }

      print(""); // pula para próxima linha
    }
  }

  // Posiciona um navio no tabuleiro
  void posicionarNavio(int linha, int coluna, int tamanhoNavio) {
    // Repete conforme o tamanho do navio
    for (int i = 0; i < tamanhoNavio; i++) {
      // Coloca o navio na horizontal (vai para direita)
      tabuleiroNavios[linha][coluna + i] = "[S]";
    }
  }

  // Realiza um tiro no tabuleiro
  bool atirar(Ponto ponto) {
    // Verifica se na posição existe um navio
    if (tabuleiroNavios[ponto.linha][ponto.coluna] == "[S]") {
      tabuleiroTiros[ponto.linha][ponto.coluna] = "[X]"; // marca acerto
      return true; // retorna verdadeiro (acertou)
    } else {
      tabuleiroTiros[ponto.linha][ponto.coluna] = "[~]"; // marca água
      return false; // retorna falso (errou)
    }
  }
}

// Função para limpar o terminal
void limparTela() {
  // Código ANSI que limpa a tela e volta o cursor pro topo
  stdout.write("\x1B[2J\x1B[0;0H");
}

// Função para o jogador posicionar navio
void posicionarNavioJogador(BatalhaNaval jogo, String jogador) {
  int tamanhoNavio; // variável para tamanho do navio

  // Loop até o jogador escolher uma posição válida
  while (true) {
    print("\n$jogador escolha o tamanho do navio:");
    tamanhoNavio = int.parse(stdin.readLineSync()!); // lê número digitado

    stdout.write("Linha inicial: ");
    int linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna inicial: ");
    int coluna = int.parse(stdin.readLineSync()!);

    // Verifica se o navio ultrapassa o limite do tabuleiro
    if (coluna + tamanhoNavio > jogo.tamanho) {
      print("⚠ O navio não cabe no tabuleiro. Tente novamente.");
    } else {
      // Se estiver válido, posiciona o navio
      jogo.posicionarNavio(linha, coluna, tamanhoNavio);
      break; // sai do loop
    }
  }
}

// Função principal do programa
void main() {
  int placarJogador1 = 0; // pontos do jogador 1
  int placarJogador2 = 0; // pontos do jogador 2

  // Pede nomes dos jogadores
  stdout.write("Nome do Jogador 1: ");
  String jogador1 = stdin.readLineSync()!;

  stdout.write("Nome do Jogador 2: ");
  String jogador2 = stdin.readLineSync()!;

  // Cria dois jogos (um para cada jogador)
  BatalhaNaval jogo1 = BatalhaNaval();
  BatalhaNaval jogo2 = BatalhaNaval();

  // Jogador 1 posiciona navio
  posicionarNavioJogador(jogo1, jogador1);

  print("\nPasse o computador para $jogador2 e pressione ENTER");
  stdin.readLineSync();
  limparTela();

  // Jogador 2 posiciona navio
  posicionarNavioJogador(jogo2, jogador2);

  print("\nPressione ENTER para começar a batalha!");
  stdin.readLineSync();
  limparTela();

  bool venceu = false; // controla fim do jogo

  // Loop principal do jogo
  while (!venceu) {
    // ===== TURNO JOGADOR 1 =====
    print("\nTurno de $jogador1");
    jogo2.exibirTabuleiroTiros();

    stdout.write("Linha do tiro: ");
    int linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna do tiro: ");
    int coluna = int.parse(stdin.readLineSync()!);

    Ponto tiro = Ponto(linha, coluna); // cria ponto do tiro
    bool acerto = jogo2.atirar(tiro);  // realiza tiro

    jogo2.exibirTabuleiroTiros();

    if (acerto) {
      print(" ACERTOU O NAVIO!");
      placarJogador1++;
      print(" $jogador1 venceu!");
      venceu = true;
      break;
    } else {
      print(" Água!");
    }

    // Troca de jogador
    print("\nPasse o computador para $jogador2 e pressione ENTER");
    stdin.readLineSync();
    limparTela();

    // ===== TURNO JOGADOR 2 =====
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
      print(" ACERTOU O NAVIO!");
      placarJogador2++;
      print(" $jogador2 venceu!");
      venceu = true;
    } else {
      print(" Água!");
    }

    print("\nPasse o computador para $jogador1 e pressione ENTER");
    stdin.readLineSync();
    limparTela();
  }

  // Mostra placar final
  print("\n===== PLACAR FINAL =====");
  print("$jogador1: $placarJogador1");
  print("$jogador2: $placarJogador2");
}
