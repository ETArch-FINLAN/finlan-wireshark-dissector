Autor: Caio Ferreira
Email: caio_c_@yahoo.com.br
Data: 08/07/2011

Construindo um mini dissector para o wireshark.
Esta me fase inicial, sendo necessario varias melhorias.

Por questão de tempo, foi feito utilizando a linguagem Lua e posteriomente 
sera codificado em codigo nativo.

Para executar de maneira simplificada, assim informando o script lua construindo no patth current:

Pacote do finlan protocol embutido para abrir.

# wireshark -X lua_script:finlanproto.lua

