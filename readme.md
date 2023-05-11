* Instala repositórios do linux  => apt-get update

* Instalar o vim no container  => apt-get install vim

* imprimir conteúdo de um arquivo  => cat index.html

* criar um arquivo  => sudo vi index.html

* Editar um arquivo  => vim index.html

* Mostra caminho absoluto da pasta atual => echo $(pwd)


# Comandos Docker

## Comando para o docker subir no wsl
    - sudo service docker start

## Comandos Docker
* **Docker ps** -> Lista os containers docker ativos
* **docker ps -a** -> Lista todos os containers ativos e inativos
* **docker run -it ubuntu bash** -> irá iniciar o ubuntu e acessará o bash
    -it OU -i -t  ->
        -i = Modo iterativo (irá manter o processo rodando para interagir com a máquina)
        -t (TTY) -> permite digitar algo
    ubuntu -> Nome da imagem a baixar
    bash -> Comando que será executado nesta imagem
    CTRL + D, sai do bash

* **docker run -it --rm ubuntu:latest bash** -> executa o que precisa ser executado e irá remover o container após a finalização

* **docker run -p 80:80 nginx    ** -> Publica portas da sua máquina para a porta do container

* **docker run -d -p 80:80 nginx    ** -> Publica portas da sua máquina para a porta do container
    -d -> detached (rodar em segundo plano)
    -p -> portas a serem publicadas LOCAL:CONTAINER

* **docker stop IDCONTAINER ou NOME** -> para o container
* **docker start** -> inicia o container criado
* **docekr rm IDCONTAINER OU NOME** -> Remove o container
* **docker rm IDCONTAINER OU NOME -f** -> Força a remoçào do container

* **docker run -d -p 80:80 --name nginx nginx
 --name** -> Atribui um nome ao container

* **docker exec -it NOMECONTAINER bash** -> Executa um comando contra o container e abre o bash

* **docker run -d --name nginx -p 80:80  -v /home/mrthuy/fullCycle/docker/html/:/usr/share/nginx/html nginx** -> Monta um volume dentro do container
    OBSERVACAO** -> -v é comando antigo, o que é usado agora é o --mount
    $(pwd) -> pasta atual

* **docker run -d --name nginx -p 80:80 --mount type=bind,source="$(pwd)",target=/usr/share/nginx/html nginx** -> Compartilhamento de volumes de forma atual

* **docker volume ls** -> lista os volumes do docker

* **docker volume create  meuvolume** -> Cria volumes no docker
* **docker volume inspect meuvolume** -> Inspeciona o volume

* **docker run -d --name nginx2 -p 81:80 --mount type=volume,source=meuvolume,target=/app nginx** -> Cria containers com volumes mas com o MOUNT
* **docker run -d --name nginx3 -p 82:80 -v meuvolume:/app nginx** -> Cria containers com volumes com o -v

* **docker volume prune** -> limpa volumes não usados

* **docker system df** -> mostra o uso de disco

* **docker rm $(docker ps -a -q) -f** -> apaga todos os conteiners

## Dockerfile
    -- arquivo para criar imagem

* **docker build -t mrthuy/nginx-com-vim:latest .**
    -t nome da tag (mrthuy - usuário do dockerhub, nginx-com-vim - nome da imagem)
    . -> pasta q esta o dockerfile (. pasta atual)
* **docker build -t mrthuy/nginx-com-vim:latest . -f caminho/Dockerfile.prod**
    -f para infromar o nome do arquivo do Dockerfile se ele for diferente

## Network
    - bridge (default) -> para um conteiner se conectar com outro
    - host -> pode acessar as portas direto da maquina q esta o docker
    - overlay -> conteiner se comunicar com outro em outra maquina
    - maclan -> pouco usado (simula um outro dipositovo com endereço MAC)
    - none -> sem rede

    -- para o conteiner acessar a maquina host -> http://host.docker.internal:8080

* **docker run --rm -d --name nginx --network host nginx**

## Docker Compose
* **docker-compose up -d --build**
    up -> cria e starta os containers
    -d -> modo detached, libera o terminal
    down -> mata os containers
    --build -> rebuild as imagens do Dockerfile

* **docker-compose ps**
    mostra container da docker-compose