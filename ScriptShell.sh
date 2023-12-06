#!/bin/bash

PURPLE='\033[0;35m'
NC='\033[0m'
VERSAO=11

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Olá Usuário, serei seu assistente para instalação!"
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Vamos preparar a sua máquina para dispor da aplicação Trackware!"
sleep 5

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Vamos começar atualizando os pacotes do sistema: "
sudo apt update -y
sudo apt upgrade -y
sleep 2

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) A seguir vamos realizar a instalação do Java"
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando aqui se você possui o Java instalado..."
sleep 2

java -version
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você já possui o Java instalado!!!"
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do Java instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o Java (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o Java ;D"
        sudo apt install openjdk-17-jre -y

        # verificando se a instalação foi bem sucedida
        java -version
        if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Java instalado com sucesso!"
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do Java."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o Java por enquanto, vamos prosseguir!"
    fi
fi
sleep 2

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) A seguir vamos realizar a instalação do Docker"
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando aqui se você possui o Docker instalado..."

docker --version
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você já possui o Docker instalado!!!"
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do Docker instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o Docker (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o Docker ;D"
        sudo apt install docker.io -y
         # verificando se a instalação foi bem sucedida
        docker --version
        if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Docker instalado com sucesso!"
	    sudo systemctl start docker
     	    sudo systemctl enable docker
	    sudo docker pull mysql:5.7
	    sudo docker run -d -p 3306:3306 --name ContainerBD -e "MYSQL_DATABASE=trackware" -e "MYSQL_ROOT_PASSWORD=Trackware000" mysql:5.7
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do Docker."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o Docker por enquanto, vamos prosseguir!"
    fi
fi
sleep 2



echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) A seguir vamos realizar a verificação do Python"

if command -v python3 &>/dev/null; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você já possui o Python instalado!!!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando se há atualizações para o Python..."
    sudo apt update
    sudo apt list --upgradable | grep -i python3
    if [ $? -eq 0 ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Existem atualizações disponíveis para o Python."
	sudo apt upgrade python3 -y
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Python atualizado!"
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) O Python está atualizado."
    fi
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Python não encontrado, vamos instalar."
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o Python(S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o Python ;D"
        sudo apt install python3 python3-pip -y
        if command -v python3 &>/dev/null; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Python instalado com sucesso!"
        else
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do Python."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o Python por enquanto, vamos prosseguir!"
    fi
fi
sleep 2

if ! grep -q "alias py='python3'" ~/.bashrc; then
    echo "alias py='python3'" >> ~/.bashrc
    echo "Alias 'py' para executar Python 3 adicionado ao ~/.bashrc"
else
    echo "O alias 'py' já existe no ~/.bashrc"
fi

# Carrega as configurações
source ~/.bashrc


echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) A seguir vamos realizar a instalação do PIP e em seguida os seus pacotes necessários"
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando aqui se você possui o PIP instalado..."
pip3 --version
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você já possui o PIP instalado!!!"
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do PIP instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o PIP(S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o PIP ;D"
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Durante a instalação do PIP uma tela roxa será exibida"
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Quando ocorrer por favor clique em 'Enter' no seu teclado para concluir"
        sudo apt install python3-pip -y
        # verificando se a instalação foi bem sucedida
        pip3 --version
        if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) PIP instalado com sucesso!"
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do PIP."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o PIP por enquanto, vamos prosseguir!"
    fi
fi
sleep 2


echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação dos pacotes necessários..."
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação do pacote Geocoder..."
pip3 list | grep -q 'geocoder'
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) O pacote 'geocoder' já está instalado."
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei o pacote 'geocoder' instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o pacote 'geocoder'(S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o pacote 'geocoder' ;D"
        sudo pip3 install geocoder
        # verificando se a instalação foi bem sucedida
        pip3 list | grep -q 'geocoder'
         if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Pacote 'geocoder' instalado com sucesso!"
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do pacote 'geocoder'."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o pacote 'geocoder' por enquanto, vamos prosseguir!"
    fi
fi
sleep 2

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação dos pacotes necessários..."
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação do pacote Psutil..."
pip3 list | grep -q 'psutil'
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) O pacote 'psutil' já está instalado."
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei o pacote 'psutil' instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o pacote 'psutil'(S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o pacote 'psutil' ;D"
        sudo pip3 install psutil
        # verificando se a instalação foi bem sucedida
        pip3 list | grep -q 'psutil'
         if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Pacote 'psutil' instalado com sucesso!"
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do pacote 'psutil'."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o pacote 'psutil' por enquanto, vamos prosseguir!"
    fi
fi
sleep 2


echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação dos pacotes necessários..."
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação do pacote mysql-connector..."
pip3 list | grep -q 'mysql-connector'
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) O pacote 'mysql-connector' já está instalado."
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei o pacote 'mysql-connector' instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o pacote 'mysql-connector'(S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o pacote 'mysql-connector' ;D"
        sudo pip3 install mysql-connector
        # verificando se a instalação foi bem sucedida
        pip3 list | grep -q 'mysql-connector'
         if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Pacote 'mysql-connector' instalado com sucesso!"
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do pacote 'mysql-connector'."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o pacote 'mysql-connector' por enquanto, vamos prosseguir!"
    fi
fi
sleep 2

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação dos pacotes necessários..."
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação do pacote pymssql..."
pip3 list | grep -q 'pymssql'
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) O pacote 'pymssql' já está instalado."
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei o pacote 'pymssql' instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o pacote 'pymssql'(S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o pacote 'pymssql' ;D"
        sudo pip3 install pymssql
        # verificando se a instalação foi bem sucedida
        pip3 list | grep -q 'pymssql'
         if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Pacote 'pymssql' instalado com sucesso!"
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do pacote 'pymssql'."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o pacote 'pymssql' por enquanto, vamos prosseguir!"
    fi
fi
sleep 2

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação dos pacotes necessários..."
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação do pacote requests..."
pip3 list | grep -q 'requests'
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) O pacote 'requests' já está instalado."
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei o pacote 'requests' instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o pacote 'requests'(S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o pacote 'requests' ;D"
        sudo pip3 install requests
        # verificando se a instalação foi bem sucedida
        pip3 list | grep -q 'requests'
         if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Pacote 'requests' instalado com sucesso!"
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do pacote 'requests'."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o pacote 'requests' por enquanto, vamos prosseguir!"
    fi
fi
sleep 2

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação dos pacotes necessários..."
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Verificando instalação do pacote simplejson..."
pip3 list | grep -q 'pymssql'
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) O pacote 'simplejson' já está instalado."
else
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Opa! Não identifiquei o pacote 'simplejson' instalado, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Confirme para mim se realmente deseja instalar o pacote 'simplejson'(S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Ok! Você escolheu instalar o pacote 'simplejson' ;D"
        sudo pip3 install simplejson
        # verificando se a instalação foi bem sucedida
        pip3 list | grep -q 'simplejson'
         if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Pacote 'simplejson' instalado com sucesso!"
        else 
            echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro na instalação do pacote 'simplejson'."
        fi
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Você optou por não instalar o pacote 'simplejson' por enquanto, vamos prosseguir!"
    fi
fi
sleep 2


echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Por fim faremos a clonagem do JAR da aplicação.."
 echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Clonando o projeto do GitHub"
    git clone https://github.com/Sprint04/JAR-Grupo.git
    
    mv JAR-Grupo/APItrackware.jar ../
    rm -rf JAR-Grupo
    cd ..
    
    if [ $? -eq 0 ]; then
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Projeto clonado com sucesso."
    else
        echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Erro ao clonar o projeto do GitHub."
    fi
 sleep 2

echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Instalação concluída! A Trackware agredece."
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Em casos de problemas com a instalação procure nosso suporte por meio da plataforma Trackware!"
echo "$(tput setaf 10)[Trackware assistant]:$(tput setaf 7) Com precisão e qualidade, a Trackware guia a sua realidade!"
source ~/.bashrc
