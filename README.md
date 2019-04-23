# Grava Atmel
Software gravador de microcontroladores antigos da Atmel, modelos suportados são o AT89s8252, AT89s8253, AT89s51, AT89s52, AT89s53, Atmega8, Atmga8515 e Atmega8535.

# Sobre
O programa surgiu nos anos 2000, era época do Windows 98 e usávamos o *Blast8252* para gravar os microcontroladores dos nossos projetos ~~doidos~~. Quando lançaram os novos Windows 2000 e XP, o *Blast* não era compatível e o desenvolvedor não lançou mais atualizações.
Então resolvi criar um gravador simples de usar igual ao *Blast*, compatível com as novas versões do windows, e assim surgiu o *Grava Atmel*. Com o tempo o gravador recebeu novas funcionalidades, muitas ideias dos usuários e atualmente funciona pela porta serial, compatível com adaptadores Usb-Serial.

# Detalhes
A gravação destes microcontroladores é feita com o protocolo SPI, e cada modelo tem um algoritmo próprio de gravação. O Grava Atmel pulsa os pinos de controle da porta serial, simulando a comunicação SPI.
O código fonte está escrito em Delphi e está super feio, sem comentários e difícil de entender. :poop:

# Compilando
Os fontes estão em Delphi 7, não precisa instalar nenhum componente pois eles são carregados dinamicamente.
Para compilar na linha de comando digite: 
```dcc32 -B Grava.dpr```

# Créditos
[Jakub Jiricek](https://web.archive.org/web/20011129105644/http://www.telegraf.cz/jak/prog.html) pelo Blast8252.
A todos os usuários, os feedbacks, dúvidas e sugestões.

Aos anos 90! :metal:
