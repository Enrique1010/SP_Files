# Busca actualizaciones del sistema
yum update -y 

# Instala el repositorio epel
yum -y install epel-release

# Instalacion de dependencias
yum -y install libXext libSM libXrender
yum -y install python34 python34-devel python34-pip mod_proxy_uwsgi gcc make
yum -y install gcc g++ gcc-c++ cmake

# Instalacion de dependencias de python
pip3.4 install --upgrade pip
pip3.4 install virtualenv flask uwsgi

# Descarga del codigo del servicio
cd /opt
ssh-keygen -C “{claro mail}”
http://ntptfsapp0001:8080/tfs/Claro_Moviles/Sub-Promotor/_git/TensorFaceApi pyface

# Entrar al directorio del codigo y copiar el servicio del sistema a registrar
cd pyface
cp pyface-nginx.conf /etc/nginx/conf.d
cp pyface-uwsgi.service /usr/lib/systemd/system

# Creacion de directorios necesarios
mkdir -p log
mkdir -p run

cp pyface.ini /opt/pyface/run

# Creacion del entorno virtual de python
virtualenv -p python3 pyfaceenv
source pyfaceenv/bin/activate

# Instalacion de paquetes de python
pip install -r requirements.txt

# Instalacion del servidor uWsgi
pip install uwsgi

chown -R prepago:sprepago /opt/pyface

# Inicio del servicio
systemctl start pyface-uwsgi

# Habilitar como servicio del sistema
systemctl enable pyface-uwsgi.service

# Verificar status
systemctl status pyface-uwsgi

# Pase a produccion
cd /opt/pyface
git pull
systemctl restart uwsgi