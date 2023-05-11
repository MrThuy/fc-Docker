FROM nginx:latest

WORKDIR /app

RUN apt-get update && \
    apt-get install vim -y

COPY html/ /usr/share/nginx/html

#EXECUTA COMANDO FIXO NO FINAL DO RUN
ENTRYPOINT ["echo", "Hello "]

#PODE SER SUBSTITUIDO POR OUTRO COMANDO NO FINAL DO RUN
CMD ["World!", " Bem vindo ao Docker!"]

