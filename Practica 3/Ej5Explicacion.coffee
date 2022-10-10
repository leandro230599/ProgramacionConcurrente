###
Se debe simular un partido de fútbol 11. Cuando los 22 jugadores llegaron a la cancha juegan durante 90 minutos y luego todos se retiran.
###

process Jugador[id: 0..21] { 
    Cancha.llegada();
}

process Partido { 
    Cancha. Iniciar();
    delay (90minutos); # Se juega el partido
    Cancha.Terminar();
}

Monitor Cancha{ 
    int cant = 0;
    cond espera, inicio;
    
    procedure llegada (){ 
        cant ++;
        if (cant == 22) {
            signal (inicio);
        }
        wait (espera);
    }
    procedure Iniciar (){ 
        if (cant < 22){
            wait (inicio);
        }
    }

    procedure Terminar (){ 
        signal_all(espera);
    }
}