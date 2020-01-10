# Creamos la imagen a partir de httpd, verisón 2.4
FROM httpd:2.4

# Damos información sobre la imagen que estamos creando
LABEL \
	version="1.0" \
	description="Apache2 + nano + index.html" \
	creationDate="23-11-2019" \
	maintainer="Nora San Saturnino <nsansaturnino@birt.eus>"

# Instalamos el editor nano
RUN \
    apt-get update \
    && apt-get install ssh --yes \
    && apt-get install git --yes



# Copiamos el index al directorio por defecto del servidor Web + clave SSH
COPY index.html /usr/local/apache2/htdocs/
COPY SSH-key/id_rsa /etc

#Comandos a ejecutar en el contenedor
RUN eval "$(ssh-agent -s)" \
&& chmod 700 /etc/id_rsa \
&& ssh-add /etc/id_rsa \
&& ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts \
&& git clone git@github.com:deaw-birt/proyecto-html.git /usr/local/apache2/htdocs/proyecto


# Indicamos el puerto que utiliza la imagen
EXPOSE 80