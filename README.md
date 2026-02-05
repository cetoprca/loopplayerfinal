# LoopPlayer

Proyecto para el modulo de Diseño de Interfaces DAMº2

El proyecto consiste en crear una aplicacion qur sirva de reproductor de audios,
con la capacidad de crear "bucles" de los mismos con los sliders presentes en la pantalla
principal.

## Funciones

1. Leer y reproducir todos los audios del dispositivo
2. Creacion de bucles de los audios
3. Marcar bucles como favoritos para filtrarlos
4. Habilitar o deshabilitar la reproduccion en bucle 
5. Leer metadata del archivo para identificar pistas de musica y audios
6. Configurar el reproductor
7. Reproduccion en segundo plano* (Consultar problemas)

La aplicacion es exclusiva de Android

Funciona como minimo verificado en Android 13 (API 33) y versiones superiores

## Problemas con la version actual
Debido a la forma en la que Android maneja las aplicaciones en segundo plano,
la aplicacion puede ser eliminada de memoria por el sistema operativo al no haber
utilizado ninguna libreria ni sistema para evitar que Android la considere como 
espacio potencialmente disponible en caso de necesitarlo.

Aun con esta problematica, si Android no necesita el espacio en memoria la reproduccion
no termina abruptamente y continua ejecutandose correctamente, incluso con la pantalla
apagada.

## Posibles mejoras

1. Soporte para la reproduccion en segundo plano correctamente
2. Capacidad para editar el nombre de los bucles
3. Mas ajustes de configuracion


# Diseño Figma
https://www.figma.com/design/CPdoQdaHBZDueEbqtGk2T0/LoopPlayer?node-id=6-831&t=xZeIQPaxgUYqgfGj-1


# Manual de usuario
https://drive.google.com/file/d/1e78eYPOdPYsW4fwa_XptuJ-67nkkPcoK/view?usp=sharing