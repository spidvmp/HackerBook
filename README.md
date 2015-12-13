##HackerBook

# Persistencia de Favoritos 
Yo he tomado la opcion de guardar el array de libros ya procesados en el NSUserdefaults, de tal forma que cada vez que arranque la app se cargan todos los libros. PAra guardar el favoritos accedo a ese array que no lo he eliminado, busco el libro, cambio el valor y lo vuelvo a guardar en NSUserdefaults.

Otra forma de hacerlo seria teniedo CoreData modificando directamente el valor favorito del libro

# Envio de informacion de AGTBook a AGTLibraryTableVC 
Se mo ocuren 2 formas, una es por notificaciones, que es como esta hecho. 
La otra forma es mediante un delegado. El AGTBook deberia tener una propiedad delegate que apuntaria al controlador. De esta forma el libro puede llegar al controlador para ejecutar un metodo con parametros o directamente modificar unapropiedad. 
Creo que es mas limpio la notificacion, con el delegado el AGTBook se meteria en procesos que debe hacer el controlador y tendria acesso a sus datos, y al AGTBook eso no le debe interesar

# Actualizacion del tableview
Para actualizar la tabla sin recargar todos los datos, podriamos utilizar el metodo insertRowAtIndexPaths, y eliminarlo con deleteRowsAtIndexPaths. Tendriamos que conocer donde se debe insertar el libro que pasamos a favoritos
Tenemos todos los datos en memoria, no hay que acceder a una BD, por lo que no seria un gran pico de memoria ni de CPU y la tabla que estamos manejando ahora es muy pequeña. Cuando se utilice CoreData si que habria que usarlo
