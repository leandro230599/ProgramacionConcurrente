###
Existen N personas que deben fotocopiar un documento. La fotocopiadora sólo puede ser
usada por una persona a la vez. Analice el problema y defina qué procesos, recursos y
monitores serán necesarios/convenientes, además de las posibles sincronizaciones requeridas
para resolver el problema. Luego, resuelva considerando las siguientes situaciones:

B) Modifique la solución de (a) para el caso en que se deba respetar el orden de llegada.
###

process personas [ID:1..N]{
    Impresora.solicitaAcceso();
    Fotocopiar();
    Impresora.terminar();
}

Monitor Impresora {
    bool enUso = false;
    int cant = 0;
    cond cola;

    procedure solicitaAcceso (){
        if (enUso) {
            cant++;
            wait(cola);
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
            signal(cola);
        }
    }
}