# Vagrant
###### Cristhian Carvajal Barragán

## Parte A. Investiga antes de modificar el entorno
### _1. Vagrant y el Vagrantfile_
##### 1. Que problema resuelve Vagrant: 
- Vagrant evita los errores de configurar servidores a mano y ahorra el tiempo de borrar y reinstalar una máquina desde cero tras un fallo. Lo soluciona describiendo toda la máquina virtual en un archivo de texto que se llama Vagrantfile, permitiendo a cualquiera ejecutar vagrant up para crear, destruir y recrear un entorno 100 % idéntico de forma automática.

##### 2. Distingue el 
- anfitrión: 
  - Es el ordenador físico con la CPU, RAM, disco duro y SO, donde se instala Vagrant

- Proveedor de virtualización:
  - Es el hipervisor, que se encarga de crear y ejecutar las máquinas virtuales.
  - Vagrant por sí solo no virtualiza hardware

- Box: 
  - Es la imagen base que contiene el SO preinstalado y preconfigurado con acceso SSH a vagrant

- Máquina virtual: 
  - Es la instancia concreta en ejecución que se crea en nuestro disco a partir de una Box, donde se añade la tarjeta de red, el nombre de host…

##### 3. Averigua en qué lenguaje está escrito el `Vagrantfile`. 
- Está escrito en Ruby


### _2. Aprovisionamiento_

##### 1. Que es un provisioner:
- Es un componente de Vagrant que permite instalar paquetes automáticamente, crear usuarios y configurar servicios dentro de la máquina virtual cuando ya esté iniciada 

##### 2. Dónde se ejecuta el script:
- Se ejecuta dentro de la máquina virtual Guest, no en el anfitrión, Vagrant se conecta por SSH a la máquina virtual, copia el script a una ruta temporal interna y lo ejecuta con permisos de admin

##### 3. Cuándo lo lanza Vagrant:
- Lo lanza solo la primera vez que se crea la máquina con el comando vagrant up, una vez creada, Vagrant no vuelve a ejecutar el script para que el inicio sea rápido

##### 4. Qué diferencia hay entre `inline:` y `path:`:
- inline: permite escribir los comandos Bash directamente como texto dentro de vagrantfile
- path: indica la ruta hacia un archivo de script . sh guardado en el proyecto 

#### 5. Que ocurre si modificas el script después del primer `vagrant up` y cómo lo ejecutarías de nuevo. 
- Si se modifica no ocurre nada, porque los cambios no se aplican en la máquina virtual 
- Existen dos formas para ejecutar de nuevo el script
  - Con la maquina encendida, ejecutar “vagrant provision”
  - Si necesitamos reiniciar la máquina y ejecutar de nuevo el script “vagrant reload --provision”


### _3. Interfaces y redes_

##### 1. Investiga qué conexión de red configura Vagrant por defecto y para qué la utiliza.
- Por defecto Vagrant configura siempre en el Adaptador1 el modo NAT
- Las utiliza para dos propósitos:
  - Permitir que Vagrant controle la máquina desde el anfitrión con SSH
  - Dar acceso a internet a la máquina virtual

##### 2. Averigua cómo se añade en el Vagrantfile una segunda interfaz con dirección IP fija.
- Se añade en “ config.vm.network “private_network” ”, añadiendo lo siguiente:
- config.vm.network “private_network”, ip “192.168.56.10”, virtualbox__intnet: "red_laboratorio"

##### 3. Compara NAT, red interna, red privada host-only y red pública: explica con quién puede comunicarse la máquina en cada caso
- NAT: La máquina virtual tiene salida a Internet a través del anfitrión, pero está aislada de otras máquinas y de la LAN. Desde el exterior nadie puede conectarse a ella directamente, menos el propio anfitrión por el reenvío de puertos 

- Red Interna: La máquina virtual solo puede comunicarse con otras máquinas conectadas a esa misma red interna. No tiene comunicación ni con el ordenador anfitrión ni con Internet 

- Red Privada: La máquina virtual puede comunicarse directamente con el equipo anfitrión y con otras máquinas que estén en esa misma red privada, pero no tiene acceso a Internet ni al resto de equipos de la LAN 

- Red Pública: La máquina es como un ordenador físico más dentro de la red local: puede comunicarse con el anfitrión, con otras máquinas, con cualquier equipo de la LAN y con Internet. 

##### 4. Qué función cumple el reenvío de puertos.
- Como la NAT impide que desde fuera hallan conexiones directas a la máquina virtual, el reenvío de puertos tiene la función de abrir una especie de túnel o regla de redirección en el NAT, pone a escuchar un puerto concreto en el equipo anfitrión y todo el tráfico que llega ahí lo reenvía al puerto de destino dentro de la máquina virtual

##### 5. Presta especial atención a la diferencia entre la red interna de VirtualBox y la red privada host-only de VMware.
- En VirtualBox: Crea un switch virtual totalmente aislado donde solo se ven las máquinas que estén conectadas a ese mismo nombre de red interna. El equipo anfitrión no tiene interfaz virtual ni IP 
- En VMware: También crea una red privada aislada del exterior, pero a diferencia de la red interna de VirtualBox, VMware sí crea un adaptador de red virtual en el ordenador anfitrión 

##### 6. Investiga cómo se configura la segunda interfaz en el proveedor que utilices. ¿Añadirla elimina la NAT predeterminada? ¿El reenvío de puertos crea una interfaz nueva? 
- No, se conserva siempre en la interfaz NAT como primera interfaz, porque la necesita para gestionar la máquina por SSH y darle salida a internet
- No, no añade ninguna tarjeta de red adicional a la máquina, usa una regla de redirección de tráfico sobre la primera interfaz NAT que ya existía


### _4. Órdenes y carpeta compartida_
| Orden | ¿Cuándo usar? | Ejecutada |
| --- | --- | --- |
| Vagrant up | Cuando queramos crear y encender la máquina virtual por primera vez o para encenderla cuando está apagada | Si |
| Vagrant status | Cuando queramos consultar desde la terminal en que estado se encuentra la máquina virtual | Si |
| Vagrant ssh | Cuando necesitamos conectarnos por SSH | Si |
| Vagrant reload | Cuando hemos modificado un archivo y se necesita reiniciar la máquina para que se apliquen los cambios | Si |
| Vagrant provision | Cuando la maquina ya esta encendida y queremos ejecutar los scripts "provision" sin reiniciar la maquina | Si |
| Vagrant halt | Cuando queramos apagar la máquina virtual correctamente, guardando el disco duro y los datos | Si |
| Vagrant destroy | Cuando queramos borrar por completo la máquina virtual y eliminar sus discos | No |


## Parte B. Mi primera máquina en Vagrant 

##### 1. Comprueba que el archivo es válido y arranca la máquina con el proveedor que tengas instalado: VirtualBox
- Desde la carpeta del proyecto donde esta el Vagrantfile, primero ponemos el comando vagrant validate para ver que la sintaxis del archivo era correcta y no contenía errores. Despues, se levanta la máquina utilizando el comando vagrant up
- [imagen]


## Parte C. Completa el Vagrantfile

- Asigna un hostname identificable con tu nombre.
  - _config.vm.hostname = "debian-cristhian"_

- Añade una segunda interfaz con IP fija en una red de laboratorio. En VirtualBox configúrala como red interna
  - _config.vm.network "private_network", ip: "192.168.56.10", virtualbox__intnet: true_

- Reenvía el puerto 80 de la máquina virtual al 8080 del anfitrión, únicamente por `127.0.0.1`. Si el 8080 está ocupado, elige otro y justifícalo.
  - _config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"_

- Vincular un script Bash de aprovisionamiento guardado en el repositorio.
  - config.vm.provision "shell", path: "provision.sh"

Podríamos comprobarlo asi
[imagem]


## Parte D. Aprovisiona Apache 

##### 1. Crea un script Bash que instale Apache en Debian 12, active el servicio y escriba una página de inicio sencilla. Esa página debe mostrar tu nombre y el hostname de la máquina. 

[imagen]

##### 2. Investiga cómo volver a ejecutar solo el aprovisionamiento después de modificarlo. 
- Para volver a ejecutarlo usamos el comando vagrant provision

##### 3. Ejecútalo de nuevo y comprueba que el servidor continúa funcionando. 
- nos conectamos con vagrant ssh y ejecutamos el siguiente comando
- [imagen]
- [imagen]
