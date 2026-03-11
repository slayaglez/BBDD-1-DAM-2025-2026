const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {

	let name = "Esclava Remix";
  res.send('${name} <br> Hoy de nuevo te voy a ver <br> Ando bien bellaco <br> Quedate en pantys <br> Modelame en tacos')
})

app.get('/prueba', (req, res) => {

        let name2 = "la Jeepeta";
  res.send('${name2} <br> Arrebatao dando vuelta en la jeepeta <br> Con una rubia que tiene grande las tetas <br> Y quiere que se lo meta')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

