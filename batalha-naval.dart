import 'dart: io';
import 'dart: math';
import 'dart:math';

// - Classe Ponto - 
classe ponto {
    int linha; 
    int coluna;
    Ponto (this.linha, this.coluna );
}

// - Tabuleiro 16x16 -
const int TAMANHO = 16;

List<list<String>> Criar Tabuleiro(){
    return List.generate(TAMANHO, (_) = > List.filled(TAMANHO, '~'));

}

// - Posicionar navio aleatorio-
List<Ponto> posicionarnavio(List<List<String>> tabuleiro, int tamanho){
     Random rng = Random();
  List<Ponto> posicoes = [];

}

while (true) {
    posicoes = [];
    bool horizontal = rng.nextBool();
    int linha = rng.nextlnt(TAMANHO);
    int coluna = rng.nextInt(TAMANHO);

    bool cabe = true;
    for (int i = 0; < tamanho; i++){
        int I = horizontal ? linha: linha + i ;
        int c = horizontal ? coluna + i : coluna;
        if (I> = TAMANHO || c>= TAMANHO ){
            cabe = false;
            break;
        }
           posicoes.add(Ponto(l, c));

    }
    if (cabe ) {
        for (Ponto p in posicoes){
            tabuleiro[p.linha][p.coluna]= 'N';
        }
        return posicoes;
    }
}

// - Imprimir tabuleiro -
void imprimirTabuleiro(List<List<String>> tabuleiro, String titulo){
    print ('\m$titulo')
    stdout.write('');
    for (int c = 0; c < TAMANHO; c++){
        stdout.write('${String.fromCharCode(65+c)}')
    }
    print('');

    for (int I = 0; I < TAMANHO; I++) {
        stdout.write('${(I + 1).toString().padLeft(2)}');
        for (int c = 0; c< TAMANHO; c++){
        stdout.write('${tabuleiro[|][c]}');    
        }
       print(''); 
    }
}

// - Placar-
void imprimirPlacar(String nomeT1, int pontosT1, String nomeT2, int pontosT2){
 print ('\---PLACAR---');
 print ($nomeT1: $pontosT1 acertos(s)'); 
 print ('$nomeT2:  $pontosT2 acerto(s)');
 print('-------');
}