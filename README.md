# Pong em assembly ArmV7

Pong feito 100% em assembly ArmV7

A Velocidade do simulador oscila intensamente, e o código foi feito de modo a evitar ao maximo as oscilações.
Ainda assim elas ocorrem, e podem variar dependendo do computador que estiver rodando o simulador

- Features:
- Modo de 1 jogador com oponente IA ou 2 jogadores humanos
- Audio de última geração
- Utiliza double buffering para evitar tearing
- Código fonte relativamente flexivel para varias situações

Controles:
Jogador 1: W para subir e S para descer
Jogador 2: I para subir e K para descer

### Ações

| Estado | Autor | Função
| ----------- | ----------- | ----------- |
| ✅ | Marco | Ler teclas e Posição para pixel |
| ✅ | Marco | Movimentar e renderizar raquetes |
| ✅ | Marco | Audio, tela de inicio e controle de jogo |
| ✅ | Bernardo | Movimentar e renderizar a bolinha |
| ✅ | Bernardo | Detectar colisão com as raquetes |
| ✅ | Bernardo | Renderizar pontuação e plano de fundo |