# Super Ponderada.

Esse projeto serve como ponderada 3, 4 e a ponderada extra. Ele contem um gerenciador de tarefas.

## arquitetura

imagem da arquitetura:

![arquitetura](./arquitetura.png)

O projeto é dividido em 3 partes:

- Frontend: é a parte visual do projeto, feita em flutter. Contem um sistema que permite um usuário criar task, visualizar suas tasks e editar suas tasks. Além disso permite transformar uma imagem em um L.
- Gateway: é a parte que faz a comunicação entre o frontend e o backend. Ele é feito utilizanndo o nginx.
- Backend: é a parte que faz a comunicação com o banco de dados. Ele tem 4 serviços.
  
### Mircrosserviços

- Task Manager: é o serviço que gerencia as tasks. Ele permite criar, editar e visualizar tasks. Chama o serviço de login para verificar se o usuário está logado e determinar as tasks que devem ser puxadas baseado no usuário. O sistema de task utiliza redis para armazenar a verificação de login tendo time to live um pouco menor do que o tempo de expiração do token.
- Login: é o serviço que gerencia o login. Ele permite criar, editar e visualizar usuários. Ele é chamado pelo task manager para verificar se o usuário está logado e retornar o id do usuário que permite que o task manager puxe as tasks do usuário correto.
- image processor: é o serviço que processa a imagem. Ele recebe uma imagem e retorna a imagem com um filtro aplicado. Ele é chamado pelo frontend para transformar uma imagem em um L.
- Logger: é o serviço que loga as requisições. Ele é chamado por todos os outros serviços para logar as requisições feitas.

## Demonstração

o video da demonstração do frontend pode ser acessado [aqui](https://youtu.be/vkThyvuH4HU). O video da demonstração do backend pode ser acessado [aqui](https://youtu.be/_J0PBl4kecI). O repositório contem uma collection do insomnia para testar os endpoints chamada endpoints.json na root do projeto.
