import 'dart: io';
import 'dart: math';

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

