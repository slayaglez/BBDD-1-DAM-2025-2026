const express = require('express')
const app = express()
const port = 3000


app.get('/todolist', (req, res) => {

	let name = "<h3><b>Esclava Remix</b></h3>";
    let lista = ["Hoy de nuevo te voy a ver", "Ando bien bellaco", "Quedate en pantys", "Modelame en tacos", "En lo que ella enrola", "Y desenmoña el saco", "Me quito el pantalón,", "Pero el bóxer no lo saco"];

    lista.forEach(element => {
        name += "<br> "+element+" ";
    });
    
  res.send(`${name}`)
})

app.get('/cucaracha', (req, res) => {

        let name2 = "la Jeepeta";
  res.send(`<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cucaracha Escurridiza 🪳</title>
    <style>
        body {
            margin: 0;
            background: #2c3e50;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            font-family: sans-serif;
        }

        /* El "motor" del juego: un checkbox invisible */
        #game-logic {
            display: none;
        }

        /* El escenario */
        .kitchen {
            width: 80vw;
            height: 80vh;
            background: #ecf0f1;
            border: 10px solid #95a5a6;
            position: relative;
            cursor: crosshair;
        }

        /* La cucaracha (el label del checkbox) */
        .roach {
            position: absolute;
            width: 60px;
            height: 60px;
            font-size: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            z-index: 10;
            /* Animación de movimiento caótico */
            animation: move 7s infinite linear;
        }

        /* Animación absurda de movimiento */
        @keyframes move {
            0%   { top: 10%; left: 10%; transform: rotate(0deg); }
            20%  { top: 80%; left: 20%; transform: rotate(90deg); }
            40%  { top: 50%; left: 80%; transform: rotate(180deg); }
            60%  { top: 10%; left: 60%; transform: rotate(270deg); }
            80%  { top: 70%; left: 40%; transform: rotate(100deg); }
            100% { top: 10%; left: 10%; transform: rotate(0deg); }
        }

        /* Mensaje de victoria (oculto por defecto) */
        .win-message {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(46, 204, 113, 0.9);
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            color: white;
            z-index: 20;
        }

        /* CUANDO HACES CLICK (CHECKED) */
        #game-logic:checked ~ .roach {
            animation-play-state: paused;
            display: none;
        }

        #game-logic:checked ~ .win-message {
            display: block;
        }

        #game-logic:checked ~ .kitchen {
            background: #27ae60;
        }

        h2 { margin: 0; }
    </style>
</head>
<body>

    <!-- El checkbox controla el estado del juego -->
    <input type="checkbox" id="game-logic">

    <!-- La "Cucaracha" es el label vinculado al checkbox -->
    <label for="game-logic" class="roach">🪳</label>

    <div class="win-message">
        <h2>¡CAPTURA ÉPICA!</h2>
        <p>Has derrotado a la cucaracha ninja.</p>
        <p><small>Recarga para volver a jugar</small></p>
    </div>

    <div class="kitchen">
        <h1 style="color: #bdc3c7; text-align: center; margin-top: 20%;">ESTA COCINA ESTÁ SUCIA</h1>
    </div>

</body>
</html>
`)
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

