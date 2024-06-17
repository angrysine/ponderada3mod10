# ponderada3m10

Essa ponderada é uma continuação da api de uma todo list assincrona, onde é possível adicionar, deletar, editar e listar tarefas, além de criar usuaŕios.Agora também é possívle adicionar uma imagem a sua task que sera transformada em um l e envia uma notificação para usuário quando a imagem termina de ser processada.

O swagger da api estará disponível em `http://localhost:5001/docs`

O projeto contem uma coleção do insomnia para testar a api, disponível em `insomniaDocAssincrona.json`, para usar as rotas no swagger deve se clicar  no cadeado no canto superior direito da tela e inserir "bearer token", substituindo "token" pelo token gerado ao criar um usuário. Se usar a coleção do insomnia, deve se passar no header o valor do token. Foi adicionada uma rota "uploadfile" que recebe uma imagem e retorna a base64 da imagem transformada em l. Também foi adicioanda uma rota chamada "get_logs" que retorna os logs de criação de usuário e processamento de imagem. 

## Video

Segue aqui um video demonstração do funcionamento da aplicação: [Video](https://youtu.be/hnV6XRmDw8w)
