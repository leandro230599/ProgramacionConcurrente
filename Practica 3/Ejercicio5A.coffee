###
En un corralón de materiales se deben atender a N clientes de acuerdo con el orden de llegada.
Cuando un cliente es llamado para ser atendido, entrega una lista con los productos que
comprará, y espera a que alguno de los empleados le entregue el comprobante de la compra
realizada.

a) Resuelva considerando que el corralón tiene un único empleado.
###

process clientes [ID:1..N]{
    text listaDeProductos;
    text comprobante;
    Corralon.formarse();
    Empleado.entregarLista(listaDeProductos);
    Empleado.recibirComprobante();
}

process empleado {
    int index = 1;
    while (index<=N){
        Corralon.llamarCliente();
        Empleado.entregarComprobante();
        index++;
    }
}

Monitor Corralon {
    cond cola;
    cond empleado;
    cond esperandoDatos;
    bool libre = true;
    int esperando = 0;
    text listaDeProductos;

    procedure formarse (){
        esperando++;
        signal(empleado);
        wait(cola);
    }

    procedure llamarCliente (){
        if (esperando == 0){
            wait(empleado);
        }
        esperando--
        signal(cola);

    }
}

Monitor Empleado {
    cond esperaAlEmpleado;
    cond esperaComprobante;
    bool entregoLista = false;
    text listaDeProductos;
    text comprobante;

    procedure entregarLista (lista : in text, resultados : out text){
        listaDeProductos = lista;
        entregoLista = true;
        signal(esperaAlCliente);
        wait(esperaComprobante);
        resultados = comprobante;
    }

    procedure entregarComprobante () {
        if (!entregoLista){
            wait(esperaAlCliente);
        }
        # Arma comprobante
        comprobante = ArmoComprobante();
        signal(esperaComprobante);
    }


    }
}