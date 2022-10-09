###
En un banco hay 3 empleados. Y hay N clientes que deben ser atendidos por uno de ellos (cualquiera) de acuerdo al orden de llegada. Cuando uno de los empleados lo atiende el cliente le entrega los papeles y espera el resultado.
###

process Clientes [ID: 0..N-1]{
    int idE;
    text papel,res;

    Banco.llegada(idE);
    Escritorio[idE].atencion(papel,res);
}

process Empleado [ID:0..2]{
    text datos;

    while true {
        Banco.proximo(id);
        Escritorio[id].esperarDatos(datos);
        res = # resolver solicitud en base de datos
        Escritorio[id].enviarResultado(res);
    }
}

Monitor Banco {
    cola eLibres;
    cond esperaC;
    int esperando = 0;
    int cantLibres = 0;

    procedure llegada (idE: out int){
        if (cantLibres==0){
            esperando++;
            wait (esperaC);
        }
        else cantLibres--;
        pop(elibres,idE);
    }

    procedure proximo (idE: in int){
        push(elibres,idE);
        if (esperando > 0){
            esperando--;
            signal(esperaC);
        }
        else cantLibres++;
    }
}

Monitor Escritorio [id:0..2]{
    cond vcCliente, vcEmpleado;
    text datos, resultados;
    boolean listo=false;

    procedure atencion (D: in text; R: out text){
        datos = D;
        listo = true;
        signal(vcEmpleado);
        wait(vcCliente);
        R = resultados;
        signal(vcEmpleado);
    }

    procedure esperarDatos (D: out text){
        if (not listo){
            wait(vcEmpleado);
        }
        D = datos;
    }

    procedure enviarResultados (R: in text){
        resultados = R;
        signal(vcCliente);
        wait(vcEmpleado);
        listo = false;
    }
}