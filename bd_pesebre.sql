--
-- PostgreSQL database dump
--

\restrict FI7ra3h5JhR9U4FMI8bOjCRzLMukPwfbdhV3pAntzyJ6pFGsuTIimM2ARXPk73Y

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-02 00:13:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16718)
-- Name: auditoria; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA auditoria;


ALTER SCHEMA auditoria OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 16730)
-- Name: fn_log_audit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_log_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'D', OLD, NULL, now(), USER);
    RETURN OLD;
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'U', OLD, NEW, now(), USER);
    RETURN NEW;
  ELSIF (TG_OP = 'INSERT') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'I', NULL, NEW, now(), USER);
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$$;


ALTER FUNCTION public.fn_log_audit() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16720)
-- Name: tb_auditoria; Type: TABLE; Schema: auditoria; Owner: postgres
--

CREATE TABLE auditoria.tb_auditoria (
    id_aud integer NOT NULL,
    tabla_aud text,
    operacion_aud text,
    valoranterior_aud text,
    valornuevo_aud text,
    fecha_aud date,
    usuario_aud text,
    esquema_aud text,
    activar_aud boolean,
    trigger_aud boolean
);


ALTER TABLE auditoria.tb_auditoria OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16719)
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE; Schema: auditoria; Owner: postgres
--

CREATE SEQUENCE auditoria.tb_auditoria_id_aud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auditoria.tb_auditoria_id_aud_seq OWNER TO postgres;

--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 223
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE OWNED BY; Schema: auditoria; Owner: postgres
--

ALTER SEQUENCE auditoria.tb_auditoria_id_aud_seq OWNED BY auditoria.tb_auditoria.id_aud;


--
-- TOC entry 220 (class 1259 OID 16667)
-- Name: calendario_adviento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calendario_adviento (
    dia integer NOT NULL,
    frase text NOT NULL,
    modelo_3d_url character varying(255),
    audio_url character varying(255),
    imagen_url character varying(255),
    villancico_nombre character varying(100),
    fecha_visible date NOT NULL
);


ALTER TABLE public.calendario_adviento OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16703)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    perfil integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    clave character varying(100) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT usuarios_perfil_check CHECK ((perfil = ANY (ARRAY[1, 2, 3])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16702)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 4869 (class 2604 OID 16723)
-- Name: tb_auditoria id_aud; Type: DEFAULT; Schema: auditoria; Owner: postgres
--

ALTER TABLE ONLY auditoria.tb_auditoria ALTER COLUMN id_aud SET DEFAULT nextval('auditoria.tb_auditoria_id_aud_seq'::regclass);


--
-- TOC entry 4867 (class 2604 OID 16706)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 5033 (class 0 OID 16720)
-- Dependencies: 224
-- Data for Name: tb_auditoria; Type: TABLE DATA; Schema: auditoria; Owner: postgres
--

COPY auditoria.tb_auditoria (id_aud, tabla_aud, operacion_aud, valoranterior_aud, valornuevo_aud, fecha_aud, usuario_aud, esquema_aud, activar_aud, trigger_aud) FROM stdin;
1	calendario_adviento	\N	\N	\N	\N	\N	public	\N	f
2	usuarios	\N	\N	\N	\N	\N	public	\N	f
3	usuarios	I	\N	(7,3,Daniela,dani321@gmail.com,123456,"2025-12-01 19:37:27.503124")	2025-12-01	postgres	\N	\N	\N
\.


--
-- TOC entry 5029 (class 0 OID 16667)
-- Dependencies: 220
-- Data for Name: calendario_adviento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calendario_adviento (dia, frase, modelo_3d_url, audio_url, imagen_url, villancico_nombre, fecha_visible) FROM stdin;
1	¡Comienza la espera! El adviento es tiempo de preparación espiritual.	modelos/estrella.glb	audios/villancico1.mp3	imagenes/adviento1.png	Noche de Paz	2025-12-01
2	La fe nos guía como la estrella que llevó a los Magos a Belén.	modelos/angel.glb	audios/villancico2.mp3	imagenes/adviento2.png	Campana sobre Campana	2025-12-02
3	Cada día nos acerca al milagro del nacimiento del Salvador.	modelos/vela.glb	audios/villancico3.mp3	imagenes/adviento3.png	Los Peces en el Río	2025-12-03
4	La esperanza brilla en nuestros corazones como luz en la oscuridad.	modelos/campana.glb	audios/villancico4.mp3	imagenes/adviento4.png	Mi Burrito Sabanero	2025-12-04
5	Preparamos nuestro espíritu para recibir al Niño Dios con amor.	modelos/corona.glb	audios/villancico5.mp3	imagenes/adviento5.png	Blanca Navidad	2025-12-05
6	La alegría navideña comienza a florecer en cada corazón.	modelos/regalo.glb	audios/villancico6.mp3	imagenes/adviento6.png	Feliz Navidad	2025-12-06
7	La paciencia en la espera hace más dulce la llegada.	modelos/bota.glb	audios/villancico7.mp3	imagenes/adviento7.png	Rodolfo el Reno	2025-12-07
8	La luz de la fe ilumina nuestro camino hacia Belén.	modelos/arbol.glb	audios/villancico8.mp3	imagenes/adviento8.png	Jingle Bells	2025-12-08
9	La virtud de la paciencia nos prepara para recibir las bendiciones.	modelos/calcetin.glb	audios/villancico9.mp3	imagenes/adviento9.png	Ven a mi Casa	2025-12-09
10	Cada día de adviento es un regalo que debemos valorar.	modelos/trineo.glb	audios/villancico10.mp3	imagenes/adviento10.png	Arre Borriquito	2025-12-10
11	La Navidad se acerca trayendo mensajes de paz y amor.	modelos/reno.glb	audios/villancico11.mp3	imagenes/adviento11.png	Ya Vienen los Reyes	2025-12-11
12	El amor desinteresado es el verdadero significado de la Navidad.	modelos/casa.glb	audios/villancico12.mp3	imagenes/adviento12.png	Los Pastores a Belén	2025-12-12
13	Compartir alegrías multiplica la felicidad navideña.	modelos/galleta.glb	audios/villancico13.mp3	imagenes/adviento13.png	Cascabel	2025-12-13
14	La familia unida es el mejor tesoro de la temporada.	modelos/baston.glb	audios/villancico14.mp3	imagenes/adviento14.png	Navidad Blanca	2025-12-14
15	La generosidad transforma corazones y renueva esperanzas.	modelos/copo.glb	audios/villancico15.mp3	imagenes/adviento15.png	Noche de Paz	2025-12-15
16	La paz verdadera nace cuando perdonamos y amamos.	modelos/cascanueces.glb	audios/villancico16.mp3	imagenes/adviento16.png	Navidad, Navidad	2025-12-16
17	Pequeños actos de bondad crean grandes milagros navideños.	modelos/pinguino.glb	audios/villancico17.mp3	imagenes/adviento17.png	El Tamborilero	2025-12-17
18	Mantén viva la esperanza, ella te guiará siempre.	modelos/iglu.glb	audios/villancico18.mp3	imagenes/adviento18.png	Villancico Yupanki	2025-12-18
19	La fe construye puentes donde parece haber abismos.	modelos/muñeco_nieve.glb	audios/villancico19.mp3	imagenes/adviento19.png	A la Nanita Nana	2025-12-19
20	El espíritu navideño transforma y renueva cada corazón.	modelos/santa_claus.glb	audios/villancico20.mp3	imagenes/adviento20.png	Santa Claus Llegó a la Ciudad	2025-12-20
21	Los pequeños detalles hacen grande la magia navideña.	modelos/duende_navidad.glb	audios/villancico21.mp3	imagenes/adviento21.png	Adeste Fideles	2025-12-21
22	La alegría compartida crea memorias eternas navideñas.	modelos/guirnalda.glb	audios/villancico22.mp3	imagenes/adviento22.png	Hacia Belén Va una Burra	2025-12-22
23	La anticipación dulce hace la Navidad aún más especial.	modelos/bombillos.glb	audios/villancico23.mp3	imagenes/adviento23.png	Ya Vienen los Reyes Magos	2025-12-23
24	¡Feliz Navidad! Que la Sagrada Familia bendiga tu hogar con amor eterno.	modelos/rosas.glb	audios/villancico24.mp3	imagenes/adviento24.png	Noche de Paz (Versión Coral)	2025-12-24
\.


--
-- TOC entry 5031 (class 0 OID 16703)
-- Dependencies: 222
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, perfil, nombre, correo, clave, fecha_registro) FROM stdin;
1	1	Blake	admin@ups.edu.ec	admin123	2025-12-01 17:44:55.699093
2	2	Carlos 	cpilatunar@est.ups.edu.ec	alumno123	2025-12-01 17:44:55.699093
3	3	Pamela	dpao@gmail.com	invitado123	2025-12-01 17:44:55.699093
5	2	Agata	adaop@est.ups.edu.ec	123456	2025-12-01 18:30:17.909746
6	1	Michael	xaviery@gmail.com	123456	2025-12-01 18:54:51.416876
7	3	Daniela	dani321@gmail.com	123456	2025-12-01 19:37:27.503124
\.


--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 223
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE SET; Schema: auditoria; Owner: postgres
--

SELECT pg_catalog.setval('auditoria.tb_auditoria_id_aud_seq', 3, true);


--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 7, true);


--
-- TOC entry 4878 (class 2606 OID 16728)
-- Name: tb_auditoria pk_tb_auditoria; Type: CONSTRAINT; Schema: auditoria; Owner: postgres
--

ALTER TABLE ONLY auditoria.tb_auditoria
    ADD CONSTRAINT pk_tb_auditoria PRIMARY KEY (id_aud);


--
-- TOC entry 4872 (class 2606 OID 16676)
-- Name: calendario_adviento calendario_adviento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendario_adviento
    ADD CONSTRAINT calendario_adviento_pkey PRIMARY KEY (dia);


--
-- TOC entry 4874 (class 2606 OID 16717)
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- TOC entry 4876 (class 2606 OID 16715)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4879 (class 1259 OID 16729)
-- Name: tb_auditoria_pk; Type: INDEX; Schema: auditoria; Owner: postgres
--

CREATE UNIQUE INDEX tb_auditoria_pk ON auditoria.tb_auditoria USING btree (id_aud);


--
-- TOC entry 4880 (class 2620 OID 16732)
-- Name: calendario_adviento calendario_adviento_tg_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER calendario_adviento_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.calendario_adviento FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();


--
-- TOC entry 4881 (class 2620 OID 16731)
-- Name: usuarios usuarios_tg_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER usuarios_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.usuarios FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();


-- Completed on 2025-12-02 00:13:31

--
-- PostgreSQL database dump complete
--

\unrestrict FI7ra3h5JhR9U4FMI8bOjCRzLMukPwfbdhV3pAntzyJ6pFGsuTIimM2ARXPk73Y

