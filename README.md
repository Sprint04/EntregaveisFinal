<img src="https://i.ibb.co/fSkYcw4/read-Me-Banner.gif" alt="read-Me-Banner" width="600px">
<hr>

# TrackWare System
Repostisório que contém toda a solução porposta a ser entregue na sprint 3.


## Nosso foco
Somos uma empresa de monitoramento de hardwares em tempo real e possuímos como público-alvo empresas de logística, as quais representam um dos principais pilares para satisfação do cliente final. Proporcionamos um local seguro e o acesso a informações úteis para o seu negócio. Apenas com a nossa empresa você encontra:

⨠ Disponibilização de informações úteis sobre a saúde dos componentes físicos da máquina.

⨠ Redução de riscos de sobrecarga e quedas nos sistemas.

⨠ Aumento de assertividade em tomadas de decisões.

## Observações

⨠ Nosso site pode não funcionar pois esta conectado com nossa EC2 windows que não esta no ar no momento (porem caso necessario falar com Nathan Ribeiro), porem supostamente ao trocar a conexão banco SQL server do site e rodar o script de criação que esta aqui dentro o site deve funcionar (sem dados, porem apos isso ele coloca).

⨠ Para criar uma EC2 linux do mesmo estilo em que estavamos usando só é necessario criar uma EC2 linux e executar o ShellScript (para facilitar: "https://github.com/Sprint04/ShellScript.git" para só clonar o ShellScript. se o clone não funcionar, use o sh que este arquivo contem mesmo).

⨠ Oque fazer se os graficos não carregarem? de dois cliques na legenda do grafico, a linha deve aparecer, problema normal de responsividade de diferentes monitores que pode ocorrer.

⨠ Meu cadastro não foi e agora? Em caso disso acontecer, apenas tome cuidado para ver se realmente não foi, se realmente não foi um segundo clique deve cadastrar corretamente (A API dos correios as vezes resolve interromper o processo de cadastro, mas ele esta funcionando corretamente, só as vezes pode ser interrompido. Nesses casos, um segundo clique no botão deve fazer funcionar.)

⨠ Alguns individuais não estão funcionando como deviam, oque fazer? verifique no banco de dados se o primeiro dispositivo cadastrado esta corretamente e no caso de alguns individuais existe 2 opções, os componentes não existem onde deveriam existir, oque ocasiona em erro(pode ser verificado no banco e no script do site nos Model), a outra opção é que sem querer pode ter sobrado resquisios de um dispositivo espeficico em algum individual, também no model, se houve foi sem querer ou erro de commit provavelmente, gerir 5 pessoas comitando pode ser um desafio as vezes, e mesmo que seja bem organizado as vezes detalhes minimos como esses podem passar, desculpe o transtorno.

⨠ Nossa solução é capaz de enviar mensagens ao slack, porem durante a verificação não sei se é possivel que entre no nosso slack, sendo o caso, ao criar um slack novo, entrar em gerenciar Apps, desenvolver e criar um bot com a base disposivel e copiar o webhook, somente é preciso colar ele no lugar do nosso nos pythons do grupo e do nathanIndividual para que eles enviem mensagens.
OBS: O slack bloqueia qualquer link dele que seja visto na internet publicamente, como se eu subir no git ele bloqueia o hook, nesse caso o link é pego e separado a ultima sequencia de letras após a / e fica em outro .kt (no caso no SQLserver) e o restante no ScriptPython.kt
Link do nosso slack: https://join.slack.com/t/trackware-grupo/shared_invite/zt-27fu1dwhu-EtT3uEzSCqbDdS932Svq8Q - Esse convite vence em 14 dias - Começa a conta de hoje dia 06/12/2023

⨠ Qualquer problema encontrado, por favor, verifique se ele existe no repositorio original também, pois ao subir muitos arquivos aqui pode ocasionar sem querer em alguma falha que não existia antes.

⨠ Para mais informações entrar em contato por qualquer modo preferencialmente Mensagem direta com um dos membros do grupo.

Trackware - Grupo 9: Cesar, Everton, Giovanna, Gustavo, Nathan

Dia da Apresentação: 06/12/2023
