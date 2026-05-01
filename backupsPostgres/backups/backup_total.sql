--
-- PostgreSQL database dump
--

\restrict D4tMvyHBdpl1VSgqsJ57dqCb2v2hV7hJJC9rrqUdpaZyStpYcBeoiv03fUqB8uq

-- Dumped from database version 15.17
-- Dumped by pg_dump version 15.17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: procesar_carga_csv(); Type: FUNCTION; Schema: public; Owner: cbas
--

CREATE FUNCTION public.procesar_carga_csv() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Programacion defensiva
    DELETE FROM carga_temporal WHERE email IS NULL OR monto <= 0;

    -- Inserts multiples
    INSERT INTO clientes (nombre, email)
    SELECT DISTINCT nombre_cliente, email 
    FROM carga_temporal
    WHERE email NOT IN (SELECT email FROM clientes);

    -- Inserts multiples
    INSERT INTO pedidos (cliente_id, producto, total)
    SELECT c.id, t.producto, t.monto
    FROM carga_temporal t
    JOIN clientes c ON t.email = c.email;

    -- Me lo cargo
    TRUNCATE TABLE carga_temporal;
    
    RAISE NOTICE '¡Kuchau! Hecho: Clientes actualizados y pedidos registrados.';
END;
$$;


ALTER FUNCTION public.procesar_carga_csv() OWNER TO cbas;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: carga_temporal; Type: TABLE; Schema: public; Owner: cbas
--

CREATE TABLE public.carga_temporal (
    nombre_cliente character varying(100),
    email character varying(100),
    producto character varying(100),
    monto numeric(10,2)
);


ALTER TABLE public.carga_temporal OWNER TO cbas;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: cbas
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clientes OWNER TO cbas;

--
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: cbas
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clientes_id_seq OWNER TO cbas;

--
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cbas
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- Name: pedidos; Type: TABLE; Schema: public; Owner: cbas
--

CREATE TABLE public.pedidos (
    id integer NOT NULL,
    cliente_id integer,
    producto character varying(100),
    total numeric(10,2),
    fecha_pedido timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.pedidos OWNER TO cbas;

--
-- Name: pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: cbas
--

CREATE SEQUENCE public.pedidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pedidos_id_seq OWNER TO cbas;

--
-- Name: pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cbas
--

ALTER SEQUENCE public.pedidos_id_seq OWNED BY public.pedidos.id;


--
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: cbas
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- Name: pedidos id; Type: DEFAULT; Schema: public; Owner: cbas
--

ALTER TABLE ONLY public.pedidos ALTER COLUMN id SET DEFAULT nextval('public.pedidos_id_seq'::regclass);


--
-- Data for Name: carga_temporal; Type: TABLE DATA; Schema: public; Owner: cbas
--

COPY public.carga_temporal (nombre_cliente, email, producto, monto) FROM stdin;
Pedro Picapiedra	pedro@roca.com	Taladro Neumático	150.25
Juan Perez	juan@example.com	Teclado Mecánico	85.50
Marta Sánchez	marta.s@clima.es	Ventilador Torre	45.00
Error Humano	error@test.com	Producto Fantasma	-10.00
Sin Email	\N	Laptop Pro	1200.00
Luis Alfaro	lalfaro@proyectos.com	Silla Ergonómica	210.00
Carmen Soler	csoler@marketing.biz	Licencia Software	99.99
Andrés Kuz	akuz@musica.com	Interfaz Audio	180.00
Beatriz Luna	bluna@viajes.com	Maleta Viaje	120.00
Javier Franco	jfranco@obras.es	Casco Seguridad	25.50
Sofía Vega	svega@estudios.com	Libro SQL Avanzado	40.00
Ricardo Darín	rdarin@cine.ar	Cámara Reflex	850.00
\.


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: cbas
--

COPY public.clientes (id, nombre, email, fecha_registro) FROM stdin;
1	Juan Perez	juan@example.com	2026-05-01 18:39:07.543973
2	Maria Garcia	maria@example.com	2026-05-01 18:39:07.543973
3	Carlos Ruiz	carlos.r@mail.com	2026-05-01 18:39:07.543973
4	Laura Beltrán	lbeltran@servicios.es	2026-05-01 18:39:07.543973
5	Roberto Gómez	rgomez88@gmail.com	2026-05-01 18:39:07.543973
6	Ana Martínez	ana.mtz@empresa.org	2026-05-01 18:39:07.543973
7	Sofía Vega	svega@estudios.com	2026-05-01 18:39:07.543973
8	Diego Torres	dtorres@web.net	2026-05-01 18:39:07.543973
9	Elena Nito	elena@correo.com	2026-05-01 18:39:07.543973
10	Lucía Méndez	lumendez@tienda.io	2026-05-01 18:39:07.543973
\.


--
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: cbas
--

COPY public.pedidos (id, cliente_id, producto, total, fecha_pedido) FROM stdin;
\.


--
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cbas
--

SELECT pg_catalog.setval('public.clientes_id_seq', 10, true);


--
-- Name: pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cbas
--

SELECT pg_catalog.setval('public.pedidos_id_seq', 1, false);


--
-- Name: clientes clientes_email_key; Type: CONSTRAINT; Schema: public; Owner: cbas
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_email_key UNIQUE (email);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: cbas
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: cbas
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);


--
-- Name: pedidos pedidos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cbas
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- PostgreSQL database dump complete
--

\unrestrict D4tMvyHBdpl1VSgqsJ57dqCb2v2hV7hJJC9rrqUdpaZyStpYcBeoiv03fUqB8uq

