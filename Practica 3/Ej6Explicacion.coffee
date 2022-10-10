###
En una empresa de genética hay N clientes que envían secuencias de ADN para que sean analizadas y esperan los resultados para poder continuar. Para resolver estos análisis la empresa cuenta con un servidor que resuelve los pedidos de acuerdo al orden de llegada de los mismos.
###

Process Cliente [id: 0..N-1] { 
    text S, res;
    while (true) { 
        # generar secuencia S
        Admin.Pedido(id, S, res);
    }
}

Process Servidor { 
    text sec, res;
    int aux;
    while (true) { 
        Admin.Sig(aux, sec);
        res = AnalizarSec(sec);
        Admin.Resultado(aux, res);
    }
}

Monitor Admin {
    Cola C;
    Cond espera;
    Cond HayPedido;
    text res[N];

    procedure Pedido (IdC: in int; S: in text; R: out text) { 
        push (C, (idC,S) );
        signal (HayPedido);
        wait (espera);
        R = res[idC];
    }

    procedure Sig (IdC: out int; S: out text) { 
        if (empty (C)) {
            wait (HayPedido);
        }
        pop (C, (IdC, S));
    }

    procedure Resultado (IdC: in int; R: in text) { 
        res[IdC] = R;
        signal (espera);
    }
}