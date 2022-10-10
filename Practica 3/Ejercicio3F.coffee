###
Existen N personas que deben fotocopiar un documento. La fotocopiadora sólo puede ser
usada por una persona a la vez. Analice el problema y defina qué procesos, recursos y
monitores serán necesarios/convenientes, además de las posibles sincronizaciones requeridas
para resolver el problema. Luego, resuelva considerando las siguientes situaciones:

f) Modificar la solución (e) para el caso en que sean 10 fotocopiadoras. El empleado le indica
a la persona cuál fotocopiadora usar y cuándo hacerlo.
###

process personas [ID:1..N]{
    int idImpresora;
    
    Admin.solicitaAcceso(idImpresora, ID);
    Impresora[idImpresora].usarImpresora();
    Admin.terminar(idImpresora);
}

process empleado {
    Admin.cargarLibres();
    Admin.indicar();
}

Monitor Admin {
    int cant = 0;
    cond cola;
    cond aviso;
    cond termino;
    int fotocopiadora_asignada[N] = ([N],-1);
    cola libres;
    cola personas;

    procedure solicitaAcceso (idImpresora: out int, idPersona: in int){
        cant++;
        signal(aviso);
        push(personas, idPersona);
        wait(cola);
        idImpresora = fotocopiadora_asignada[idPersona];
    }

    procedure terminar (idImpresora: in int) {
        signal(termino);
        push(libres, idImpresora);
    }

    procedure indicar () {
        int i, idAux;
        for i:= 1..N{
            if (cant == 0){
                wait(aviso);
            }
            if (empty(libres)){
                wait(termino);
            }
            cant--;
            idAux = pop(personas);
            fotocopiadora_asignada[idAux] = pop(libres);
            signal(cola);
        }
    }

    procedure cargarLibres () {
        int j;
        for j:=1..10 {
            push(libres,j);
        }
    }
}

Monitor Impresora [ID: 1..10] {

    procedure usarImpresora () {
        Fotocopiar()
    }
}