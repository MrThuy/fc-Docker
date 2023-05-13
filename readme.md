# Comandos Linux
    apt-get update
Atualiza os repositórios do linux

    apt-get install vim
Instalar o vim

    cat index.html
Imprimir conteúdo de um arquivo

    sudo vi index.html
criar um arquivo

    vim index.html
Editar um arquivo

    echo $(pwd)
Mostra caminho absoluto da pasta atual =>


# Comandos Docker
    - sudo service docker start
Comando para o docker subir no wsl

## Comandos Docker
    Docker ps
Lista os containers docker ativos

    docker ps -a
Lista todos os containers ativos e inativos

    docker run -it ubuntu bash
irá iniciar o ubuntu e acessará o bash
* -**it** (TTY) = Modo iterativo (irá manter o processo rodando para interagir com a máquina) permite digitar algo
* **ubuntu** -> Nome da imagem a baixar
* **bash** -> Comando que será executado nesta imagem
* CTRL + D, sai do bash
##
    docker run -it --rm ubuntu:latest bash
* **--rm** -> vai deletar o container após a finalização
##
    docker run -d -p 80:80 --name nginx nginx
* **-p** -> Publica portas da sua máquina para a porta do container [LOCAL:CONTAINER]
* **-d** -> detached (rodar em segundo plano)
* **--name** -> Atribui um nome ao container
##
    docker stop [IDCONTAINER ou NOME]
* **start/stop** -> inicia/para o container criado
##
    docker rm -f [IDCONTAINER OU NOME]
* **rm** -> Remove o container
* **-f** -> Força a remoçào do container
##
    docker rm -f $(docker ps -a -q)
apaga todos os conteiners
##
    docker exec -it NOMECONTAINER bash
* **exec** -> Executa um comando contra o container e abre o bash
## Volumes
    docker run -d --name nginx -p 80:80 -v /home/mrthuy/fullCycle/docker/html/:/usr/share/nginx/html nginx
* **-v** -> monta volume e cria a pasta caso não exista (comando antigo, novo comando -> **--mount**) [PATH_LOCAL:PATH_CONTAINER]
* $(pwd) -> pasta atual
##
    docker run -d --name nginx -p 80:80 --mount type=bind,source="$(pwd)",target=/usr/share/nginx/html nginx**
Exemplo de comando usando o mount
##
    docker volume ls
lista os volumes do docker

    docker volume create meuvolume
Cria um volume no docker
##
    docker volume inspect meuvolume
Inspeciona o volume
##
    docker run -d --name nginx2 -p 81:80 --mount type=volume,source=meuvolume,target=/app nginx
Cria um container utilizando um volume mas com o MOUNT
##
    docker run -d --name nginx3 -p 82:80 -v meuvolume:/app nginx**
Cria containers com volumes com o -v
##
    docker volume prune
Limpa volumes não usados
#
    docker system df
Mostra o uso de disco

---
## Dockerfile
### arquivo para criar imagem
    docker build -t mrthuy/nginx-com-vim:latest .
* **-t** -> nome da tag (*mrthuy* - usuário do dockerhub / *nginx-com-vim* - nome da imagem)
* **.** -> pasta q esta o dockerfile (. pasta atual)
##
    docker build -t mrthuy/nginx-com-vim:latest . -f caminho/Dockerfile.prod
* **-f** -> para infromar o nome do arquivo do Dockerfile se ele for diferente

# Network
* bridge (default) -> para um conteiner se conectar com outro
* host -> pode acessar as portas direto da maquina q esta o docker
* overlay -> conteiner se comunicar com outro em outra maquina
* maclan -> pouco usado (simula um outro dipositovo com endereço MAC)
* none -> sem rede
##
    para o conteiner acessar a maquina host -> http://host.docker.internal:8080
##
    docker run --rm -d --name nginx --network host nginx
*  --network -> + nome da rede para criar o conteiner na rede especifica
##
    docker network connect host nginx
conecta um conteiner a uma network
___
## Docker Compose

    docker-compose up -d --build
* up -> cria e starta os containers
* down -> mata os containers
* -d -> modo detached, libera o terminal
* --build -> rebuild as imagens do Dockerfile
##
    docker-compose ps
mostra todos os container da docker-compose
##
    entrypoint: dockerize -wait tcp://db:3306 -timeout 20s docker-entrypoint.sh
adicionar dentro do docker-compose para aguardar subir outro conteiner, mas antes na imagem precisa instalar o dockerize https://github.com/jwilder/dockerize
* **-wait** -> + *conexão://ip:porta* aguarda ter resposta nesse caminho
* **-timeout** -> + *tempo* tempo máximo para esperar
* **docker-entrypoint.sh** -> ultimo parametro do comando, executa quando a conexão esta ok
uma alternativa do dockerize -> https://github.com/codeedu/docker-wait-for-it
