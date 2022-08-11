# bemol_challenge

Neste repositório há um aplicativo desenvolvido em Flutter e uma REST API desenvolvida em NodeJs. Nesta aplicação foi feita uma única feature, a de cadastro de usuários. Para isso, o app se comunica com API escrita em NodeJs, que por sua vez realiza a persistencia dos dados. Além disso, foi utilizada a API contida no endereço https://viacep.com.br/ para validação dos dados de endereço do usuário.

## Flutter
A pasta bemol_challenge contém um app desenvolvido em Flutter na versão 3.0.5.

### Execução
* Acesse a pasta bemol_challenge em seu terminal;
* Execute o comando 'flutter doctor' para se certificar de estar usando a versão 3.0.5 do Flutter;
* Execute o comando 'flutter pug get' para obter os pacotes utilizados pelo aplicativo;
* Execute o comanda 'flutter run' para abrir o app no navegador ou em seu smartphone;
* Para que seja possível conectar o app ao servidor em NodeJs, será necessário configurar que ambos estejam configurados na mesma rede. Caso o app seja aberto em um navegador, será possível executar o servidor no mesmo dispositivo e a conexão ocorrerá altomaticamente. 

## NodeJs
A pasta bemol_challenge_backend contém a REST API desenvolvida em NodeJs na versão 16.16.0

### Execução
* Acesse a pasta bemol_challenge_backend em seu terminal;
* Certifique-se que você já possui o NodeJs na versão 16.16.0 instalado em seu dispositivo;
* Realize a instalação da última versão do Yarn utilizando o comando 'npm install --global yarn';
* Execute o comando 'yarn' para buscar as dependências;
* Execute o comando 'yarn prisma migrate dev' para aplicar as migrations
* Execute o comando 'yarn dev' para criar o servidor na porta 3000
