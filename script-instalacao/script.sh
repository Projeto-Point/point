#!/bin/bash

VERSAO=11
	
echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Olá, serei seu assistente para instalação do Point!;"
echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Qual versão você deseja?"
echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) [ 1 ] Java (recomendado para computadores)"
echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) [ 2 ] Python (recomendado para servidores)"
read opcao

sleep 1

if [ \"$opcao\" == \"1\" ]
	then
		# Java
		java -version
		if [ $? -eq 0 ]
            then
                echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) : Você já tem o java instalado!!!"
            else
                echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do Java instalado, mas sem problemas, irei resolver isso agora!"
                echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o Java (S/N)?"
                read inst
                if [ \"$inst\" == \"S\" ]
                    then
                        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Ok! Você escolheu instalar o Java ;D"
                        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Adicionando o repositório!"
                        sleep 2
                        sudo add-apt-repository ppa:webupd8team/java -y
                        clear
                        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Atualizando! Quase lá."
                        sleep 2
                        sudo apt update -y
                        clear
                            if [ $VERSAO -eq 11 ]
                                then
                                echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Preparando para instalar a versão 11 do Java. Confirme a instalação quando solicitado ;D"
                                sudo apt install default-jre ; apt install openjdk11-jre-headless; -y
                                clear
                                echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Java instalado com sucesso!"
                            fi
                            else
                                echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Você optou por não instalar o Java por enquanto, até a próxima então!"
                fi
        fi
        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Olá novamente, serei seu assistente para baixar seu .jar do projeto Point!;"
        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Verificando aqui se você possui o repositório instalado...;"
        sleep 2
        git clone https://github.com/Projeto-Point/point-java
        if [ $? -eq 0 ]
            then
                echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) : Você já tem o repositório instalado!!!"
        fi
        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Vou instalar o zip para você;"
        sudo apt install zip
        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) : Você agora tem o zip instalado!!!"
        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) : Adicionarei o caminho do SDK ao Curl para você"
        curl -s "https://get.sdkman.io" | bash
        source "/home/urubu100/.sdkman/bin/sdkman-init.sh"
        sdk install java 11.0.10.j9-adpt
        echo "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) : Tudo pronto!!!!!! Basta executar o .jar no diretório correto!"
	else
		# Python
		echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Baixando aplicação Point"
        git clone https://github.com/Projeto-Point/point-python.git
		echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Instalando bibliotecas python necessárias"
        sudo apt install python3-pip -y
        pip install psutil
        pip install dashing
        pip install pymssql
        pip install geocoder
        pip install pymysql
		echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Vamos instalar o docker, por favor coloque sua senha quando solicitada"
        sudo apt upgrade && sudo apt update -y
        sudo apt install docker.io
        clear
        sudo systemctl start docker
        sudo systemctl enable docker
        echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Criando um container MySQL"
        sudo docker pull mysql:5.7
        sudo docker run -d -p 3306:3306 --name MySqlDocker -e "MYSQL_DATABASE=bd_point" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7
        echo  "$(tput setaf 2)[ASSISTENTE POINT]:$(tput setaf 7) Container criado com sucesso!"
        sudo docker ps
        sudo docker exec -it MySqlDocker bash
fi