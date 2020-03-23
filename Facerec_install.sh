# Busca actualizaciones del sistema
yum update -y

# Instala el repositorio epel
yum -y install epel-release

# Instalacion de dependencias
yum -y install libXext libSM libXrender
yum -y install gcc g++ gcc-c++ cmake

rpm -Uiv http://mirror.centos.org/centos/7/os/x86_64/Packages/libXpm-3.5.12-1.el7.x86_64.rpm

rpm -Uiv http://mirror.centos.org/centos/7/os/x86_64/Packages/gperftools-libs-2.6.1-1.el7.x86_64.rpm

rpm -Uiv http://mirror.centos.org/centos/7/os/x86_64/Packages/gd-2.0.35-26.el7.x86_64.rpm

rpm -Uiv http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/n/nginx-1.12.2-2.el7.x86_64.rpm

yum install nginx-all-modules

yum -y install python34 python34-devel python34-pip mod_proxy_uwsgi gcc

rpm -Uiv http://mirror.centos.org/centos/7/os/x86_64/Packages/tcl-8.5.13-8.el7.x86_64.rpm

rpm -Uiv http://mirror.centos.org/centos/7/os/x86_64/Packages/tk-8.5.13-6.el7.x86_64.rpm

yum -y install python34-tkinter

rpm -Uiv http://mirror.centos.org/centos/7/os/x86_64/Packages/libICE-1.0.9-9.el7.x86_64.rpm

rpm -Uiv http://mirror.centos.org/centos/7/os/x86_64/Packages/libSM-1.2.2-2.el7.x86_64.rpm

# Instalacion de dependencias de python
pip3.4 install
pip3.4 install virtualenv flask uwsgi

# Descarga del codigo del servicio
cd /opt
ssh-keygen -C “{claro mail}”

git clone “http://{claro mail}@ntptfsapp0001:8080/tfs/Claro_Moviles/Claro_Moviles/_git/ClaroPyFace” facerec

# Entrar al directorio del codigo y copiar el servicio del sistema a registrar
cd facerec
cp facerec-nginx.conf /etc/nginx/conf.d
cp facerec-uwsgi.service /usr/lib/systemd/system

# Creacion de directorios necesarios
mkdir -p /tmp/logs-temp/facelog
mkdir -p run

cp facerec.ini /opt/facerec/run

# Creacion del entorno virtual de python
virtualenv -p python3 facerecenv
source facerecenv/bin/activate

# Instalacion de paquetes de python
pip install -r requirements.txt

chown -R prepago:sprepago /opt/facerec

# Inicio del servicio
systemctl --user start facerec-uwsgi

# Habilitar como servicio del sistema
systemctl --user enable facerec-uwsgi.service

# Verificar status
systemctl --user status facerec-uwsgi


# Pase a produccion
cd /opt/facerec
git pull
systemctl restart facerec-uwsgi
