###
Existen N personas que desean utilizar un cajero automatico. En este segundo caso se debe tener en cuenta el orden de llegada de las personas. Suponga que hay una funcion UsarCajero() que simula el uso del cajero.
###

process Personas [ID:0..N-1]{
    Cajero.ingresarCajero();
    UsarCajero();
    Cajero.salirCajero();

Monitor Cajero {
    bool libre = true;
    cond cv;
    int cant = 0;

    procedure ingresarCajero () {
        if (!libre) {
            cant++;
            wait(cv);
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
            signal(cv);
        }
    }
}