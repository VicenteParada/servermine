Build: Docker version 29.3.0, build 5927d80
Minecraft Purpur (1.20.1)

Docker y Docker Compose instalados.
`Chunky.jar` en la raíz del proyecto.
Tailscale pre-configurado idealmente

Esta build esta pensada y será optimizada para el siguiente hardware:

Fanless i3-5005u, 8gb de ram, 500gb de Disco encendido 24/7
Debian 12.5 Bookworm
Tailscale capa gratuita y probablemente Playit.gg, pero como se juega en LAN no lo estoy usando jaja

=====BUILD SOBRE DEBIAN=====

Ejecuta estos comandos en orden para levantar el servidor desde cero:

1.-Instalación
   
     git clone [https://github.com/VicenteParada/servermine.git](https://github.com/VicenteParada/servermine.git)
     cd servermine

2.-Dar permisos de ejecución al script:

    chmod +x setup-server.sh

3.-Ejecutar el Despliegue

    ./setup-server.sh

4.-Monitorizar Logs (opcional)
    
    sudo docker logs -f mc-purpur-server

5.-Configuración de Pre-generación (Chunky):
   Chunky es un plugin que pre-carga el mundo para evitar lag

   Centrar en el punto de aparición
       sudo docker exec -i mc-purpur-server mc-send-command "chunky spawn"
    
   Definir radio de 5000 bloques
       sudo docker exec -i mc-purpur-server mc-send-command "chunky radius 5000"

   Iniciar proceso
       sudo docker exec -i mc-purpur-server mc-send-command "chunky start"


6.-Respaldos
   La carpeta "data" es el mundo, plugins, configuraciones y basicamente "tu mundo" asi que esa carpeta es lo que hay que comprimir, el script "backup-server.sh" pausa la escritura en disco para que la copia no tenga corrupciones si el server esta encendido ("hot backups"), pero de todas maneras es recomendable hacer los respaldos en frio



