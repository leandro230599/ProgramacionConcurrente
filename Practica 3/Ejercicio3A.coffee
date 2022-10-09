###
Existen N personas que deben fotocopiar un documento. La fotocopiadora sólo puede ser
usada por una persona a la vez. Analice el problema y defina qué procesos, recursos y
monitores serán necesarios/convenientes, además de las posibles sincronizaciones requeridas
para resolver el problema. Luego, resuelva considerando las siguientes situaciones:

A) Implemente una solución suponiendo no importa el orden de uso. Existe una función
Fotocopiar() que simula el uso de la fotocopiadora. 
###

process personas [ID:1..N]{
    Impresora.solicitaAcceso();
    Fotocopiar();
    Impresora.terminar();
}

Monitor Impresora {
    bool enUso = false;
    cond cola;

    procedure solicitaAcceso (){
        while (enUso) {
            wait(cola);
        }
        enUso=true;
    }

    procedure terminar (){
        enUso=false;
        signal(cola)
    }
}