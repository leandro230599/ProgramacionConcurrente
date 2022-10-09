###
Existen N personas que deben fotocopiar un documento. La fotocopiadora sólo puede ser
usada por una persona a la vez. Analice el problema y defina qué procesos, recursos y
monitores serán necesarios/convenientes, además de las posibles sincronizaciones requeridas
para resolver el problema. Luego, resuelva considerando las siguientes situaciones:

d) Modifique la solución de (a) para el caso en que se deba respetar estrictamente el orden
dado por el identificador del proceso (la persona X no puede usar la fotocopiadora hasta
que no haya terminado de usarla la persona X-1).
###

process personas [ID:1..N]{
    Impresora.solicitaAcceso();
    Fotocopiar();
    Impresora.terminar();
}

Monitor Impresora {
    int index = 1;
    cond cola[N];

    procedure solicitaAcceso (idPersona){
        if (index<>idPersona){
            wait(cola[idPersona]);
        }
    }

    procedure terminar (){
        index++;
        if (index<=N){
            signal(cola[index]);
        }
    }
}