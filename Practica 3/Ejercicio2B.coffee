###
Existen N procesos que deben leer información de una base de datos, la cual es administrada
por un motor que admite una cantidad limitada de consultas simultáneas.

B) Implemente el acceso a la base por parte de los procesos, sabiendo que el motor de
base de datos puede atender a lo sumo 5 consultas de lectura simultáneas.
###

process consulta [ID:0..N] {
    BD.solicitar();
    # Lee la Base de Datos;
    BD.finalizar();
}

Monitor BD {
    int cant = 0;
    cond cola;

    procedure solicitar (){
        while(cant==5){
            wait(cola);
        }
        cant++;   
    }

    procedure finalizar (){
        cant--;
        signal(cola);
    }
}