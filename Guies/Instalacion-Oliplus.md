# Instalación de Oliplus

## Descargamos los debs desde jammy

Desde la Web del Pool de Jammy obtenemos el `.deb`.

```shell
http://lliurex.net/jammy/pool/main/z/zero-lliurex-printers/
```

Descargamos el `.deb` correspondiente, en este caso:

```shell
# Esta carpeta luego la borramos
sudo mkdir -p /opt/tmp/
sudo apt install wmctrl
sudo wget http://lliurex.net/jammy/pool/main/z/zero-lliurex-printers/zero-lliurex-oliplus_0.10_all.deb -O /opt/tmp/
sudo dpkg -i /opt/tmp/zero-lliurex-oliplus_0.10_all.deb
sudo /usr/share/zero-lliurex-oliplus/zero-lliurex-oliplus_script download pryntcontrol
sudo /usr/share/zero-lliurex-oliplus/zero-lliurex-oliplus_script installPackage pryntcontrol
```

Si da error el ultimo paso, descargamos desde la web de Oliplus el `.zip` que han preparado:

```shell
https://www.pryntcontrol.com/download/2560/
```

Lo descomprimimos y luego ejecutamos el instalador para 64 bits de ubuntu16 (Esto a ver si lo actualizan ya...).


## Ejecutamos el xhost 

```shell
xhost +si:localuser:root 
```

Esto estaría bien ponerlo en algún script de inicio del usuario, por ejemplo en `/etc/profile.d/` :

yo crearía un fichero así:

```shell
sudo vim /etc/profile.d/senia-oliplus-xhost.sh
```

Con este contenido:

```shell
#!/bin/sh
xhost +si:localuser:root 
```

## Limpieza final

```shell
sudo rm -rf /opt/tmp/
```
