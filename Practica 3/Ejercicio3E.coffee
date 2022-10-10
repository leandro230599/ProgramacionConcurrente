###
Existen N personas que deben fotocopiar un documento. La fotocopiadora sólo puede ser
usada por una persona a la vez. Analice el problema y defina qué procesos, recursos y
monitores serán necesarios/convenientes, además de las posibles sincronizaciones requeridas
para resolver el problema. Luego, resuelva considerando las siguientes situaciones:

e) Modifique la solución de (b) para el caso en que además haya un Empleado que le indica
a cada persona cuando debe usar la fotocopiadora.
###

process personas [ID:1..N]{
    Impresora.solicitaAcceso();
    Fotocopiar();
    Impresora.terminar();
}

process empleado {
    Impresora.indicar();
}

Monitor Impresora {
    int cant = 0;
    cond cola;
    cond aviso;
    cond termino;

    procedure solicitaAcceso (){
        cant++;
        signal(aviso);
        wait(cola);
    }

    procedure terminar () {
        signal(termino);
    }

    procedure indicar () {
        int i;
        for i:= 1..N{
            if (cant == 0){
                wait(aviso);
            }
            cant--;
            signal(cola);
            wait(termino);
        }

    }
}