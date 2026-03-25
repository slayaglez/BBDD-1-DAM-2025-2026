const express = require("express");
const { Pool } = require("pg");

const app = express();
const port = 3000;

app.use(express.json());

//! No hacer nunca
const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "postgres",
  password: "postgres",
  port: 5432,
});

async function crearTablaUsuario() {
  const query = `
    CREATE TABLE IF NOT EXISTS usuario (
      id SERIAL PRIMARY KEY,
      nombre VARCHAR(100) NOT NULL,
      email VARCHAR(100) NOT NULL
    )
  `;
  await pool.query(query);
  console.log("Tabla usuario lista");
}

async function crearTablaTareas() {
  const query = `
    CREATE TABLE IF NOT EXISTS tareas (
      id SERIAL PRIMARY KEY,
      titulo VARCHAR(100) NOT NULL,
      descripcion VARCHAR(255) NOT NULL,
      id_usuario INTEGER REFERENCES usuario(id)
    )
  `;
  await pool.query(query);
  console.log("Tabla tareas lista");
}

crearTablaUsuario();
crearTablaTareas();


// USUARIOS

app.get("/usuarios", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM usuario ORDER BY id");

    res.status(200).json({
      status: "ok",
      data: result.rows,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get("/usuarios/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query("SELECT * FROM usuario WHERE id = $1", [
      id,
    ]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Usuario no encontrado",
      });
    }

    res.json({
      status: "ok",
      data: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post("/usuarios", async (req, res) => {
  try {
    const { nombre, email } = req.body;

    if (!nombre || !email) {
      return res.status(400).json({
        error: "nombre y email son obligatorios",
      });
    }

    const result = await pool.query(
      "INSERT INTO usuario(nombre,email) VALUES($1,$2) RETURNING *",
      [nombre, email],
    );

    res.status(201).json({
      status: "usuario creado",
      data: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.put("/usuarios/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre, email } = req.body;

    const result = await pool.query(
      `UPDATE usuario
       SET nombre = $1, email = $2
       WHERE id = $3
       RETURNING *`,
      [nombre, email, id],
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Usuario no encontrado",
      });
    }

    res.json({
      status: "usuario actualizado",
      data: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.delete("/usuarios/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      "DELETE FROM usuario WHERE id = $1 RETURNING *",
      [id],
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Usuario no encontrado",
      });
    }

    res.json({
      status: "usuario eliminado",
      data: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});


// TAREAS

app.get("/usuarios/:id/tareas", async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("SELECT * FROM tareas WHERE id_usuario = $1 ORDER BY id", [
      id,
    ]);

    res.status(200).json({
      status: "ok",
      data: result.rows,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post("/usuarios/:id/tareas", async (req, res) => {
  try {
    const { id } = req.params
    const { titulo, descripcion } = req.body;

    if (!titulo) {
      return res.status(400).json({
        error: "un titulo es obligatorio",
      });
    }

    const result = await pool.query(
      "INSERT INTO tareas(titulo,descripcion,id_usuario) VALUES($1,$2,$3) RETURNING *",
      [titulo, descripcion, id],
    );

    res.status(201).json({
      status: "tarea agregada",
      data: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.delete("/usuarios/:id_usuario/tareas/:id_tarea", async (req, res) => {
  try {
    const { id_tarea } = req.params;

    const result = await pool.query(
      "DELETE FROM tareas WHERE id = $1 RETURNING *",
      [id_tarea],
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Tarea no encontrada",
      });
    }

    res.json({
      status: "Tarea eliminada",
      data: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.put("/usuarios/:id_usuario/tareas/:id_tarea", async (req, res) => {
  try {
    const { id_tarea } = req.params;
    const { titulo, descripcion } = req.body;

    const result = await pool.query(
      `UPDATE tareas
       SET titulo = $1, descripcion = $2
       WHERE id = $3
       RETURNING *`,
      [titulo, descripcion, id_tarea],
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Tarea no encontrada",
      });
    }

    res.json({
      status: "Tarea actualizada",
      data: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.patch("/usuarios/:id_usuario/tareas/:id_tarea", async (req, res) => {
  try {
    const { id_tarea } = req.params;
    const cuerpo = Object.entries(req.body);

    // Si el campo existe en la tabla
    // Lo meto en la sentencia SQL

    cuerpo.forEach(element => {
      console.log(element);
      console.log("Hola estoy dentro del foreach");

      if(["titulo", "descripcion"].includes(element[0])){

      }
    });

    // if (descripcion == null) {
    //   const result = await pool.query(
    //     `UPDATE tareas (titulo) VALUES
    //     ($1)
    //    WHERE id = $3
    //    RETURNING *`,
    //     [titulo, id_tarea],
    //   );
    // }

    // if (titulo == null) {
    //   const result = await pool.query(
    //     `UPDATE tareas
    //    SET descripcion = $2
    //    WHERE id = $3
    //    RETURNING *`,
    //     [descripcion, id_tarea],
    //   );
    // }

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Tarea no encontrada",
      });
    }

    res.json({
      status: "Tarea actualizada",
      data: result.rows[0],
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
