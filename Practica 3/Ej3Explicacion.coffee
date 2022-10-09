###
Existen N personas que desean utilizar un cajero automatico. En este segundo caso se debe tener en cuenta el orden de llegada de las personas. Suponga que hay una funcion UsarCajero() que simula el uso del cajero.
###

process Personas [ID:0..N-1]{
    int edad;
    Cajero.ingresarCajero(ID, edad);
    UsarCajero();
    Cajero.salirCajero();

Monitor Cajero {
    bool libre = true;
    cond espera[N];
    int cant = 0;
    cola fila;
    int idAux;

    procedure ingresarCajero (idProcess, edad : in int) {
        if (!libre) {
            insertarOrdenado(fila,idProcess, edad);
            cant++;
            wait(espera[idProcess]);
        }
        else {
            libre = false;
        }
    }

    procedure salirCajero () {
        if (cant==0){
            libre = true;
        }
        else {
            cant--;
            sacar(fila,idAux)
            signal(espera[idAux ]);
        }
    }
}