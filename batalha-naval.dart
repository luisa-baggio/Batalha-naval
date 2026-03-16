import 'dart: io';
import 'dart: math';
import 'dart:io';
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
//-- Ler cordenadas jogador
Ponto?lerCordenada(){
    stdout.write('digite a cordenada (ex:A1):');
    String entrada = stdin.readLineSync()??"";
    entrada = entrada.trim().toUpperCase();
    
    if (entrada.length < 2) return null;

    int coluna = entrada.codeUnitAt(0) -65;
    int? linha = int.tryParse(entrada.substring(1));

    if (linha ==null) return null;
    linha = linha - 1;

    if (linha < 0 || LINHA >=TAMANHO) return null;
    if (coluna <0 || coluna >= TAMANHO) return null;

    return Pomto(linha, coluna);
}

//--main --

void main(){
    print ('=== BATALHA NAVAL 16X16 ===\n');

    // Nome dos times 
    stdout.write('nome do time 1:');
    String nome T1 = stdin.readLineSync()?? 'Time 1';
    stdout.write('Nome do time 2:');
    String nome T2 = stdin.readLineSync()?? 'Time 2';

    //tabuleiros 

    List<List<String>> tabuleiroT1 = criarTabuleiro();
    List<List<String>> tabuleiroT2 = criarTabuleiro();

    //Posicionar navios tamanho 5
    List<Ponto> navioT1 = posicionarNavio(tabuleiroT1, 5);
    List<Ponto> navioT2 = posicionarNavio(tabuleiroT2, 5);

    print ('\nNavios posicionados! Tamanho: 5 ceelulas cada.')
     //Placar 
     int pontosT1 = 0 ;
     int pontosT2 = 0 ;
     int acertosT1 = 0 ;
     int acertosT2 = 0 ;

     int rodada = 1;

     while (true) {
        print('\n====== RODADA $rodada ======');
        imprimirPlacar(nomeT1, pontosT1, nomeT2, pontosT2);

        //-- Turno Time 1 --
        print('\n[$nomeT1]- Seu turno!');
        imprimirPlacar(nomeT1, pontosT1, nomeT2, pontosT2)
     }
}