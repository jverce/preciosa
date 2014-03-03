#!/bin/bash
PROJECT_NAME=$1

DB_NAME=$PROJECT_NAME
VIRTUALENV_NAME=$PROJECT_NAME

PROJECT_DIR=/home/vagrant/$PROJECT_NAME
VIRTUALENV_DIR=/home/vagrant/.virtualenvs/$PROJECT_NAME




# virtualenv setup for project
su - vagrant -c "/usr/local/bin/virtualenv $VIRTUALENV_DIR && \
echo $PROJECT_DIR > $VIRTUALENV_DIR/.project && \
PIP_DOWNLOAD_CACHE=/home/vagrant/.pip_download_cache $VIRTUALENV_DIR/bin/pip install wheel && $VIRTUALENV_DIR/bin/pip install --use-wheel --find-links=/home/vagrant/.pip_download_cache -r $PROJECT_DIR/requirements/core.txt -r $PROJECT_DIR/requirements/optional.txt "

echo "workon $VIRTUALENV_NAME" >> /home/vagrant/.bashrc

# Set execute permissions on manage.py, as they get lost if we build from a zip file
chmod a+x $PROJECT_DIR/manage.py

cp $PROJECT_DIR/preciosa/local_settings.py.template $PROJECT_DIR/preciosa/local_settings.py 

# Django project setup
su - vagrant -c "source $VIRTUALENV_DIR/bin/activate && cd $PROJECT_DIR &&  ./manage.py syncdb --noinput && ./manage.py migrate --noinput &&  ./manage.py cities_light && ./manage.py loaddata fixtures/flatpages.json \
    fixtures/blog.json fixtures/newsletter.json \
    fixtures/ciudades.json  fixtures/sucursales.json \ fixtures/categorias.json fixtures/marcas.json \
    fixtures/productos.json fixtures/precios.json"


