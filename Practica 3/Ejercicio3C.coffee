###
Existen N personas que deben fotocopiar un documento. La fotocopiadora sólo puede ser
usada por una persona a la vez. Analice el problema y defina qué procesos, recursos y
monitores serán necesarios/convenientes, además de las posibles sincronizaciones requeridas
para resolver el problema. Luego, resuelva considerando las siguientes situaciones:

c) Modifique la solución de (b) para el caso en que se deba dar prioridad de acuerdo con la
edad de cada persona (cuando la fotocopiadora está libre la debe usar la persona de mayor
edad entre las que estén esperando para usarla).
###

process personas [ID:1..N]{
    Impresora.solicitaAcceso();
    Fotocopiar();
    Impresora.terminar();
}

Monitor Impresora {
    bool enUso = false;
    int cant = 0;
    cond cola[N];
    int idAux;
    ColaOrdenada fila;

    procedure solicitaAcceso (idPersona, edad: in int){
        if (enUso) {
            insertarOrdenado(fila,idPersona, edad);
            cant++;
            wait(cola[idPersona]);
        }
        else
            enUso = true;
    }

    procedure terminar () {
        if (cant==0){
            enUso = false;
        }
        else{
            cant--;
            sacar(fila,idAux);
            signal(cola[idAux]);
        }
    }
}