--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: seba
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO seba;

SET search_path = public, pg_catalog;

--
-- Name: a1; Type: TYPE; Schema: public; Owner: seba
--

CREATE TYPE a1 AS (
	det_num_linea integer,
	art_cod character varying(20),
	art_cant integer,
	art_precio integer
);


ALTER TYPE public.a1 OWNER TO seba;

--
-- Name: cambiodeestcot(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestcot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

begin

if (OLD.cot_est_cod <> NEW.cot_est_cod) then

UPDATE hist_est_cot SET cot_estado_hasta = now() WHERE doc_cod = NEW.doc_cod and cot_est_cod = OLD.cot_est_cod;

INSERT INTO hist_est_cot (doc_cod, cot_est_cod, cot_estado_desde) VALUES (NEW.doc_cod, NEW.cot_est_cod, now());

END if;

return NEW;

END;

$$;


ALTER FUNCTION public.cambiodeestcot() OWNER TO seba;

--
-- Name: cambiodeestcot_in(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestcot_in() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
INSERT INTO hist_est_cot (doc_cod, cot_est_cod, cot_estado_desde) VALUES (NEW.doc_cod, NEW.cot_est_cod, now());
RETURN NEW;
END;
$$;


ALTER FUNCTION public.cambiodeestcot_in() OWNER TO seba;

--
-- Name: cambiodeestcotabnotvent(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestcotabnotvent() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
DELETE FROM hist_est_cot WHERE doc_cod = OLD.doc_cod AND cot_est_cod = 0;
UPDATE cotizacion SET not_ven_cod = -1, cot_est_cod = 0 WHERE doc_cod = OLD.doc_cod;
return NEW;
END;
$$;


ALTER FUNCTION public.cambiodeestcotabnotvent() OWNER TO seba;

--
-- Name: cambiodeestfact(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestfact() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if (OLD.fact_est_cod <> NEW.fact_est_cod) then
UPDATE hist_est_fact SET fact_estado_hasta = now() WHERE doc_pago_cod = NEW.doc_pago_cod;
INSERT INTO hist_est_fact (doc_pago_cod, cot_est_fact, fact_estado_desde) VALUES (NEW.doc_pago_cod, NEW.fact_est_cod, now());
END if;
END;
$$;


ALTER FUNCTION public.cambiodeestfact() OWNER TO seba;

--
-- Name: cambiodeestfact_in(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestfact_in() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
INSERT INTO hist_est_fact (doc_pago_cod, fact_est_cod, fact_estado_desde) VALUES (NEW.doc_pago_cod, NEW.fact_est_cod, now());
return NEW;
END;
$$;


ALTER FUNCTION public.cambiodeestfact_in() OWNER TO seba;

--
-- Name: cambiodeestnv(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestnv() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if (OLD.not_ven_est_cod <> NEW.not_ven_est_cod) then
UPDATE hist_est_nv SET not_ven_estado_hasta = now() WHERE not_ven_cod = NEW.not_ven_cod and not_ven_est_cod = OLD.not_ven_est_cod;
INSERT INTO hist_est_nv (not_ven_cod, not_ven_est_cod, not_ven_estado_desde) VALUES (NEW.not_ven_cod, NEW.not_ven_est_cod, now());
END if;
return NEW;
END;
$$;


ALTER FUNCTION public.cambiodeestnv() OWNER TO seba;

--
-- Name: cambiodeestnv_in(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestnv_in() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
INSERT INTO hist_est_nv (not_ven_cod, not_ven_est_cod, not_ven_estado_desde) VALUES (NEW.not_ven_cod, NEW.not_ven_est_cod, now());
RETURN NEW;
END;
$$;


ALTER FUNCTION public.cambiodeestnv_in() OWNER TO seba;

--
-- Name: cambiodeestoc(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestoc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if (OLD.oc_est_cod <> NEW.oc_est_cod) then
UPDATE hist_est_oc SET oc_estado_hasta = now() WHERE doc_cod = NEW.doc_cod;
INSERT INTO hist_est_oc (doc_cod, oc_est_cod, oc_estado_desde) VALUES (NEW.doc_cod, NEW.oc_est_cod, now());
END if;
END;
$$;


ALTER FUNCTION public.cambiodeestoc() OWNER TO seba;

--
-- Name: cambiodeestoc_in(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestoc_in() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
INSERT INTO hist_est_oc (doc_cod, oc_est_cod, oc_estado_desde) VALUES (NEW.doc_cod, NEW.oc_est_cod, now());
END;
$$;


ALTER FUNCTION public.cambiodeestoc_in() OWNER TO seba;

--
-- Name: cambiodeestod(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestod() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if (OLD.OD_est_cod <> NEW.OD_est_cod) then
UPDATE hist_est_od SET od_estado_hasta = now() WHERE od_cod = NEW.od_cod;
INSERT INTO hist_est_od (od_cod, od_est_cod, od_estado_desde) VALUES (NEW.od_cod, NEW.od_est_cod, now());
END if;
END;
$$;


ALTER FUNCTION public.cambiodeestod() OWNER TO seba;

--
-- Name: cambiodeestod_in(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestod_in() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
INSERT INTO hist_est_od (od_cod, od_est_cod, od_estado_desde) VALUES (NEW.od_cod, NEW.od_est_cod, now());
END;
$$;


ALTER FUNCTION public.cambiodeestod_in() OWNER TO seba;

--
-- Name: cambiodeestot(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if (OLD.ot_est_cod <> NEW.ot_est_cod) then
UPDATE hist_est_ot SET ot_estado_hasta = now() WHERE ot_cod = NEW.ot_cod;
INSERT INTO hist_est_ot (ot_cod, ot_est_cod, ot_estado_desde) VALUES (NEW.ot_cod, NEW.ot_est_cod, now());
END if;
END;
$$;


ALTER FUNCTION public.cambiodeestot() OWNER TO seba;

--
-- Name: cambiodeestot_in(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION cambiodeestot_in() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
INSERT INTO hist_est_ot (ot_cod, ot_est_cod, ot_estado_desde) VALUES (NEW.ot_cod, NEW.ot_est_cod, now());
END;
$$;


ALTER FUNCTION public.cambiodeestot_in() OWNER TO seba;

--
-- Name: creaarticulo(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION creaarticulo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO articulo (art_cod, art_tipo_cod, art_nom, art_stock, art_precio) VALUES (NEW.art_cod, NEW.art_tipo_cod, NEW.art_nom, NEW.art_stock, NEW.art_precio);
  INSERT INTO para_instalacion (art_cod, art_tipo_cod, art_nom, art_stock, art_precio) VALUES (NEW.art_cod, NEW.art_tipo_cod, NEW.art_nom, NEW.art_stock, NEW.art_precio);
  return NEW;
END;
$$;


ALTER FUNCTION public.creaarticulo() OWNER TO seba;

--
-- Name: creaarticuloni(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION creaarticuloni() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO articulo (art_cod, art_tipo_cod, art_nom, art_stock, art_precio) VALUES (NEW.art_cod, NEW.art_tipo_cod, NEW.art_nom, NEW.art_stock, NEW.art_precio);
  return NEW;
END;
$$;


ALTER FUNCTION public.creaarticuloni() OWNER TO seba;

--
-- Name: creacotartdocpcot(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION creacotartdocpcot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO doc_previo (doc_cod, cliente_cod, emp_rut, doc_fecha, doc_total) VALUES (NEW.doc_cod, NEW.cliente_cod, NEW.emp_rut, NEW.doc_fecha, NEW.doc_total);
  INSERT INTO cotizacion (doc_cod, cliente_cod, emp_rut, doc_fecha, doc_total, cot_est_cod) VALUES (NEW.doc_cod, NEW.cliente_cod, NEW.emp_rut, NEW.doc_fecha, NEW.doc_total, 0);
  return NEW;
END;
$$;


ALTER FUNCTION public.creacotartdocpcot() OWNER TO seba;

--
-- Name: creacotsidocpcot(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION creacotsidocpcot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO doc_previo (doc_cod, cliente_cod, emp_rut, doc_fecha, doc_total) VALUES (NEW.doc_cod, NEW.cliente_cod, NEW.emp_rut, NEW.doc_fecha, NEW.doc_total);
  INSERT INTO cot_odc_serv (doc_cod, cliente_cod, emp_rut, doc_fecha, doc_total) VALUES (NEW.doc_cod, NEW.cliente_cod, NEW.emp_rut, NEW.doc_fecha, NEW.doc_total);
  INSERT INTO cotizacion (doc_cod, cliente_cod, emp_rut, doc_fecha, doc_total, cot_est_cod) VALUES (NEW.doc_cod, NEW.cliente_cod, NEW.emp_rut, NEW.doc_fecha, NEW.doc_total, 0);
  return NEW;
END;
$$;


ALTER FUNCTION public.creacotsidocpcot() OWNER TO seba;

--
-- Name: creaot(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION creaot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE reg RECORD;
BEGIN

if (SELECT cot_est_descr FROM estado_cotizacion WHERE cot_est_cod = NEW.cot_est_cod) = 'Aprobada' then
if (SELECT * FROM serv_rep WHERE doc_cod = NEW.doc_cod) <> NULL then
FOR reg IN SELECT * FROM serv_rep_det LOOP
INSERT INTO orden_de_trabajo (doc_cod, modelo_cod) VALUES (reg.doc_cod, reg.modelo_cod);
END LOOP;
end if;
if (SELECT * FROM serv_inst WHERE doc_cod = NEW.doc_cod) <> NULL then
FOR reg IN SELECT * FROM serv_inst_det LOOP
INSERT INTO orden_de_trabajo (doc_cod, modelo_cod) VALUES (reg.doc_cod, reg.modelo_cod);
END LOOP;
end if;
end if;
return NULL;
END;
$$;


ALTER FUNCTION public.creaot() OWNER TO seba;

--
-- Name: crearnotvent(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION crearnotvent() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

begin

if (OLD.cot_est_cod <> NEW.cot_est_cod and NEW.cot_est_cod = 1) then

INSERT INTO nota_de_venta (not_ven_est_cod, not_ven_fecha, doc_cod) VALUES (0, now(), NEW.doc_cod);

END if;

return NEW;

END;

$$;


ALTER FUNCTION public.crearnotvent() OWNER TO seba;

--
-- Name: fn_log_audit(); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION fn_log_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    INSERT INTO log ("TableName", "Operation", "OldValue", "NewValue", "UpdateDate", "UserName")
           VALUES (TG_TABLE_NAME, 'D', OLD, NULL, now(), USER);
    RETURN OLD;
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO log ("TableName", "Operation", "OldValue", "NewValue", "UpdateDate", "UserName")
           VALUES (TG_TABLE_NAME, 'U', OLD, NEW, now(), USER);
    RETURN NEW;
  ELSIF (TG_OP = 'INSERT') THEN
    INSERT INTO log ("TableName", "Operation", "OldValue", "NewValue", "UpdateDate", "UserName")
           VALUES (TG_TABLE_NAME, 'I', NULL, NEW, now(), USER);
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$$;


ALTER FUNCTION public.fn_log_audit() OWNER TO seba;

--
-- Name: precio_cot_odc_art(integer); Type: FUNCTION; Schema: public; Owner: seba
--

CREATE FUNCTION precio_cot_odc_art(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
 resultado integer;
 precio_linea integer;
 DECLARE reg RECORD;
 DECLARE reg2 RECORD;
BEGIN
FOR reg IN SELECT art_cod, art_cant, art_desc FROM det_cot_odc_art WHERE doc_cod = $1 LOOP
FOR reg2 IN SELECT art_precio FROM articulo WHERE art_cod = reg.art_cod LOOP
 precio_linea = (reg.art_cant * reg2.art_precio)- ((reg.art_cant * reg2.art_precio)* reg.art_desc)/100;
END LOOP;
resultado = resultado + precio_linea;
END LOOP;
 RETURN resultado;
END;
$_$;


ALTER FUNCTION public.precio_cot_odc_art(integer) OWNER TO seba;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accesorio; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE accesorio (
    art_cod character varying(20) NOT NULL,
    art_tipo_cod integer,
    art_nom character varying(40),
    art_stock integer,
    art_precio integer,
    art_imagen character(254)
);


ALTER TABLE public.accesorio OWNER TO seba;

--
-- Name: TABLE accesorio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE accesorio IS 'Entidad para guardar datos de las distintos accesorios que vende la empresa';


--
-- Name: COLUMN accesorio.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN accesorio.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN accesorio.art_tipo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN accesorio.art_tipo_cod IS 'Identificador primario de un tipo de articulo determinado';


--
-- Name: COLUMN accesorio.art_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN accesorio.art_nom IS 'Nombre del articulo';


--
-- Name: COLUMN accesorio.art_stock; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN accesorio.art_stock IS 'Stock del articulo';


--
-- Name: COLUMN accesorio.art_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN accesorio.art_precio IS 'Precio del articulo';


--
-- Name: COLUMN accesorio.art_imagen; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN accesorio.art_imagen IS 'Imagen del articulo';


--
-- Name: hist_cod_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE hist_cod_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.hist_cod_sec OWNER TO seba;

--
-- Name: hist_cod_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('hist_cod_sec', 1, false);


--
-- Name: art_hist_pre; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE art_hist_pre (
    art_precio integer,
    precio_desde date,
    precio_hasta date,
    hist_cod integer DEFAULT nextval('hist_cod_sec'::regclass) NOT NULL,
    art_cod character varying(20) NOT NULL
);


ALTER TABLE public.art_hist_pre OWNER TO seba;

--
-- Name: TABLE art_hist_pre; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE art_hist_pre IS 'Entidad para guardar los cambios de precio de los distitnos articulos';


--
-- Name: COLUMN art_hist_pre.art_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_hist_pre.art_precio IS 'Precio del articulo';


--
-- Name: COLUMN art_hist_pre.precio_desde; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_hist_pre.precio_desde IS 'Fecha de inicio del precio';


--
-- Name: COLUMN art_hist_pre.precio_hasta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_hist_pre.precio_hasta IS 'Fecha de termino del precio';


--
-- Name: COLUMN art_hist_pre.hist_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_hist_pre.hist_cod IS 'Identificador primario del historial de precio';


--
-- Name: COLUMN art_hist_pre.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_hist_pre.art_cod IS 'Identificador primario del articulo';


--
-- Name: art_prop_valor; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE art_prop_valor (
    prop_cod integer NOT NULL,
    dom_cod integer NOT NULL,
    art_cod character varying(20) NOT NULL,
    valor character varying(300)
);


ALTER TABLE public.art_prop_valor OWNER TO seba;

--
-- Name: TABLE art_prop_valor; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE art_prop_valor IS 'Guarda el valor de las propiedades definidas para los distintos artEDculos';


--
-- Name: COLUMN art_prop_valor.prop_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_prop_valor.prop_cod IS 'Identificador primario de una propiedad';


--
-- Name: COLUMN art_prop_valor.dom_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_prop_valor.dom_cod IS 'Identificador primario de un dominio';


--
-- Name: COLUMN art_prop_valor.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_prop_valor.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN art_prop_valor.valor; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN art_prop_valor.valor IS 'Valor de la propiedad de un articulo determinado';


--
-- Name: articulo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE articulo (
    art_cod character varying(20) NOT NULL,
    art_tipo_cod integer NOT NULL,
    art_nom character varying(100),
    art_stock integer,
    art_precio integer,
    art_imagen character(254)
);


ALTER TABLE public.articulo OWNER TO seba;

--
-- Name: TABLE articulo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE articulo IS 'Entidad para guadar datos de los articulos que vende la empresa.
';


--
-- Name: COLUMN articulo.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN articulo.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN articulo.art_tipo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN articulo.art_tipo_cod IS 'Identificador primario de un tipo de articulo determinado';


--
-- Name: COLUMN articulo.art_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN articulo.art_nom IS 'Nombre del articulo';


--
-- Name: COLUMN articulo.art_stock; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN articulo.art_stock IS 'Stock del articulo';


--
-- Name: COLUMN articulo.art_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN articulo.art_precio IS 'Precio del articulo';


--
-- Name: COLUMN articulo.art_imagen; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN articulo.art_imagen IS 'Imagen del articulo';


--
-- Name: boleta; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE boleta (
    doc_pago_cod integer NOT NULL,
    doc_pago_fecha timestamp without time zone,
    doc_pago_obs character varying(50)
);


ALTER TABLE public.boleta OWNER TO seba;

--
-- Name: TABLE boleta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE boleta IS 'Entidad que contiene la informaciF3n de las boletas de cada venta';


--
-- Name: COLUMN boleta.doc_pago_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN boleta.doc_pago_cod IS 'Identificador primario de un documento de pago';


--
-- Name: COLUMN boleta.doc_pago_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN boleta.doc_pago_fecha IS 'Fecha de creaciF3n del documento de pago';


--
-- Name: COLUMN boleta.doc_pago_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN boleta.doc_pago_obs IS 'ObservaciF3n del documento de pago';


--
-- Name: cargo_empleado_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE cargo_empleado_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cargo_empleado_sec OWNER TO seba;

--
-- Name: cargo_empleado_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('cargo_empleado_sec', 5, true);


--
-- Name: cargo_empleado; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE cargo_empleado (
    cargo_cod integer DEFAULT nextval('cargo_empleado_sec'::regclass) NOT NULL,
    cargo_nom character varying(20)
);


ALTER TABLE public.cargo_empleado OWNER TO seba;

--
-- Name: TABLE cargo_empleado; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE cargo_empleado IS 'Entidad para guardar los distintos cargos que pueden tener los empleados de la empresa';


--
-- Name: COLUMN cargo_empleado.cargo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cargo_empleado.cargo_cod IS 'Indentificador primario de un determinado cargo';


--
-- Name: COLUMN cargo_empleado.cargo_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cargo_empleado.cargo_nom IS 'Nombre del cargo de un empleado de la empresa';


--
-- Name: cliente_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE cliente_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cliente_sec OWNER TO seba;

--
-- Name: cliente_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('cliente_sec', 28, true);


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE cliente (
    cliente_cod integer DEFAULT nextval('cliente_sec'::regclass) NOT NULL,
    tipo_cliente_cod integer NOT NULL,
    cliente_nom character varying(30),
    cliente_ape character varying(30),
    cliente_direccion character varying(50),
    cliente_comuna character varying(30),
    cliente_tel character varying(15),
    cliente_correo character varying(50) NOT NULL,
    cliente_emp character varying(30),
    cliente_frecuente boolean,
    cliente_rut character varying(10)
);


ALTER TABLE public.cliente OWNER TO seba;

--
-- Name: TABLE cliente; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE cliente IS 'Entidad que almacena todos los datos de los clientes de la empresa';


--
-- Name: COLUMN cliente.cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_cod IS 'Identificador primario de un cliente';


--
-- Name: COLUMN cliente.tipo_cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.tipo_cliente_cod IS 'Identificador primario para el tipo de cliente';


--
-- Name: COLUMN cliente.cliente_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_nom IS 'Nombre del cliente';


--
-- Name: COLUMN cliente.cliente_ape; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_ape IS 'Apellido del cliente';


--
-- Name: COLUMN cliente.cliente_direccion; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_direccion IS 'DirecciF3n del cliente';


--
-- Name: COLUMN cliente.cliente_comuna; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_comuna IS 'Comuna donde reside el cliente';


--
-- Name: COLUMN cliente.cliente_tel; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_tel IS 'Telefono del cliente';


--
-- Name: COLUMN cliente.cliente_correo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_correo IS 'Correo del cliente';


--
-- Name: COLUMN cliente.cliente_emp; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_emp IS 'Empresa a la que pertenece el cliente';


--
-- Name: COLUMN cliente.cliente_frecuente; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_frecuente IS 'Booleano para identificar a los clientes frecuentes';


--
-- Name: COLUMN cliente.cliente_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cliente.cliente_rut IS 'Rut del cliente';


--
-- Name: compatibilidad; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE compatibilidad (
    art_cod character varying(20) NOT NULL,
    marca_cod integer NOT NULL,
    modelo_cod integer NOT NULL,
    modelo_ano integer NOT NULL
);


ALTER TABLE public.compatibilidad OWNER TO seba;

--
-- Name: TABLE compatibilidad; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE compatibilidad IS 'Entidad para guardar la compatibilidad posible entre un modelo de vehEDculo y un accesorio o repuesto';


--
-- Name: COLUMN compatibilidad.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN compatibilidad.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN compatibilidad.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN compatibilidad.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN compatibilidad.modelo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN compatibilidad.modelo_cod IS 'Identificador primario de un modelo de vehEDculo';


--
-- Name: cot_odc_art; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE cot_odc_art (
    doc_cod integer NOT NULL,
    cliente_cod integer,
    not_ven_cod integer,
    emp_rut character varying(10),
    doc_fecha date,
    doc_obs character varying(100),
    doc_neto integer,
    doc_iva integer,
    doc_total integer,
    doc_total_desc integer
);


ALTER TABLE public.cot_odc_art OWNER TO seba;

--
-- Name: TABLE cot_odc_art; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE cot_odc_art IS 'Entidad para las cotizaciones u ordenes de compra de articulos';


--
-- Name: COLUMN cot_odc_art.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN cot_odc_art.cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.cliente_cod IS 'Identificador primario de un cliente';


--
-- Name: COLUMN cot_odc_art.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN cot_odc_art.emp_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.emp_rut IS 'Rut e identificador primario de cada empleado';


--
-- Name: COLUMN cot_odc_art.doc_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.doc_fecha IS 'Fecha de emisiF3n del documento';


--
-- Name: COLUMN cot_odc_art.doc_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.doc_obs IS 'ObservaciF3n del documento';


--
-- Name: COLUMN cot_odc_art.doc_neto; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.doc_neto IS 'Precio Neto en el documento';


--
-- Name: COLUMN cot_odc_art.doc_iva; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.doc_iva IS 'IVA asociado al documento';


--
-- Name: COLUMN cot_odc_art.doc_total; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.doc_total IS 'Precio total el documento';


--
-- Name: COLUMN cot_odc_art.doc_total_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_art.doc_total_desc IS 'Descuento asociado al total del documento';


--
-- Name: cot_odc_serv; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE cot_odc_serv (
    doc_cod integer NOT NULL,
    cliente_cod integer,
    not_ven_cod integer,
    emp_rut character varying(10),
    doc_fecha date,
    doc_obs character varying(100),
    doc_neto integer,
    doc_iva integer,
    doc_total integer,
    doc_total_desc integer
);


ALTER TABLE public.cot_odc_serv OWNER TO seba;

--
-- Name: TABLE cot_odc_serv; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE cot_odc_serv IS 'Entidad para las cotizaciones u ordenes de compra de servicios';


--
-- Name: COLUMN cot_odc_serv.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN cot_odc_serv.cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.cliente_cod IS 'Identificador primario de un cliente';


--
-- Name: COLUMN cot_odc_serv.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN cot_odc_serv.emp_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.emp_rut IS 'Rut e identificador primario de cada empleado';


--
-- Name: COLUMN cot_odc_serv.doc_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.doc_fecha IS 'Fecha de emisiF3n del documento';


--
-- Name: COLUMN cot_odc_serv.doc_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.doc_obs IS 'ObservaciF3n del documento';


--
-- Name: COLUMN cot_odc_serv.doc_neto; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.doc_neto IS 'Precio Neto en el documento';


--
-- Name: COLUMN cot_odc_serv.doc_iva; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.doc_iva IS 'IVA asociado al documento';


--
-- Name: COLUMN cot_odc_serv.doc_total; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.doc_total IS 'Precio total el documento';


--
-- Name: COLUMN cot_odc_serv.doc_total_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cot_odc_serv.doc_total_desc IS 'Descuento asociado al total del documento';


--
-- Name: cotizacion; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE cotizacion (
    doc_cod integer NOT NULL,
    cot_est_cod integer NOT NULL,
    cliente_cod integer,
    not_ven_cod integer,
    emp_rut character varying(10),
    doc_fecha date,
    doc_obs character varying(100),
    doc_neto integer,
    doc_iva integer,
    doc_total integer,
    doc_total_desc integer
);


ALTER TABLE public.cotizacion OWNER TO seba;

--
-- Name: TABLE cotizacion; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE cotizacion IS 'Entidad para guardar los datos de las cotizaciones realizadas por los distintos clientes';


--
-- Name: COLUMN cotizacion.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN cotizacion.cot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.cot_est_cod IS 'Identificador primario del estado que puede tomar la cotizaciF3n';


--
-- Name: COLUMN cotizacion.cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.cliente_cod IS 'Identificador primario de un cliente';


--
-- Name: COLUMN cotizacion.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN cotizacion.emp_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.emp_rut IS 'Rut e identificador primario de cada empleado';


--
-- Name: COLUMN cotizacion.doc_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.doc_fecha IS 'Fecha de emisiF3n del documento';


--
-- Name: COLUMN cotizacion.doc_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.doc_obs IS 'ObservaciF3n del documento';


--
-- Name: COLUMN cotizacion.doc_neto; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.doc_neto IS 'Precio Neto en el documento';


--
-- Name: COLUMN cotizacion.doc_iva; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.doc_iva IS 'IVA asociado al documento';


--
-- Name: COLUMN cotizacion.doc_total; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.doc_total IS 'Precio total el documento';


--
-- Name: COLUMN cotizacion.doc_total_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cotizacion.doc_total_desc IS 'Descuento asociado al total del documento';


--
-- Name: det_linea_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE det_linea_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.det_linea_sec OWNER TO seba;

--
-- Name: det_linea_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('det_linea_sec', 1, false);


--
-- Name: det_cot_odc_art; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE det_cot_odc_art (
    doc_cod integer NOT NULL,
    det_num_linea integer DEFAULT nextval('det_linea_sec'::regclass) NOT NULL,
    art_cod character varying(20) NOT NULL,
    art_cant integer,
    art_desc integer,
    art_precio integer
);


ALTER TABLE public.det_cot_odc_art OWNER TO seba;

--
-- Name: TABLE det_cot_odc_art; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE det_cot_odc_art IS 'Guarda la informaciF3n de cada lEDnea de las cotizaciones u odc realizadas';


--
-- Name: COLUMN det_cot_odc_art.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_cot_odc_art.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN det_cot_odc_art.det_num_linea; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_cot_odc_art.det_num_linea IS 'Numero de la linea en el detalle de la cotizaciF3n';


--
-- Name: COLUMN det_cot_odc_art.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_cot_odc_art.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN det_cot_odc_art.art_cant; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_cot_odc_art.art_cant IS 'Cantidad de cada artEDculo en la lEDnea de detalle de cotizaciF3n';


--
-- Name: COLUMN det_cot_odc_art.art_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_cot_odc_art.art_desc IS 'Si se desea efectuar un descuento en el total los productos de un tipo, se utiliza este atributo';


--
-- Name: det_ot; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE det_ot (
    ot_cod integer NOT NULL,
    ot_num_linea integer NOT NULL,
    serv_cod integer NOT NULL,
    marca_cod integer NOT NULL,
    modelo_cod integer NOT NULL,
    modelo_ano integer NOT NULL,
    sr_ad_precio integer,
    sr_ad_cant integer
);


ALTER TABLE public.det_ot OWNER TO seba;

--
-- Name: TABLE det_ot; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE det_ot IS 'Entidad que guarda la informaciF3n de cada lEDnea de detalle de la orden de trabajo';


--
-- Name: COLUMN det_ot.ot_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_ot.ot_cod IS 'Identificador primario de la orden de trabajo';


--
-- Name: COLUMN det_ot.ot_num_linea; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_ot.ot_num_linea IS 'NFAmero de lEDnea de detalle de la orden de trabajo';


--
-- Name: COLUMN det_ot.serv_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_ot.serv_cod IS 'Identificador primario para los distintos servicios que presta la empresa';


--
-- Name: COLUMN det_ot.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_ot.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN det_ot.modelo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_ot.modelo_cod IS 'Identificador primario de un modelo de vehEDculo';


--
-- Name: COLUMN det_ot.sr_ad_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_ot.sr_ad_precio IS 'Precio del servicio de reparacion adicional';


--
-- Name: COLUMN det_ot.sr_ad_cant; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN det_ot.sr_ad_cant IS 'Cantidad de servicios de reparacion adicional en la orden de trabajo';


--
-- Name: doc_pago_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE doc_pago_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.doc_pago_sec OWNER TO seba;

--
-- Name: doc_pago_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('doc_pago_sec', 10, true);


--
-- Name: doc_previo_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE doc_previo_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.doc_previo_sec OWNER TO seba;

--
-- Name: doc_previo_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('doc_previo_sec', 61, true);


--
-- Name: doc_previo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE doc_previo (
    doc_cod integer DEFAULT nextval('doc_previo_sec'::regclass) NOT NULL,
    cliente_cod integer NOT NULL,
    not_ven_cod integer,
    emp_rut character varying(10) NOT NULL,
    doc_fecha timestamp without time zone,
    doc_obs character varying(100),
    doc_neto integer,
    doc_iva integer,
    doc_total integer,
    doc_total_desc integer
);


ALTER TABLE public.doc_previo OWNER TO seba;

--
-- Name: TABLE doc_previo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE doc_previo IS 'Documento previo a la nota de venta';


--
-- Name: COLUMN doc_previo.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN doc_previo.cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.cliente_cod IS 'Identificador primario de un cliente';


--
-- Name: COLUMN doc_previo.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN doc_previo.emp_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.emp_rut IS 'Rut e identificador primario de cada empleado';


--
-- Name: COLUMN doc_previo.doc_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.doc_fecha IS 'Fecha de emisiF3n del documento';


--
-- Name: COLUMN doc_previo.doc_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.doc_obs IS 'ObservaciF3n del documento';


--
-- Name: COLUMN doc_previo.doc_neto; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.doc_neto IS 'Precio Neto en el documento';


--
-- Name: COLUMN doc_previo.doc_iva; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.doc_iva IS 'IVA asociado al documento';


--
-- Name: COLUMN doc_previo.doc_total; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.doc_total IS 'Precio total el documento';


--
-- Name: COLUMN doc_previo.doc_total_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN doc_previo.doc_total_desc IS 'Descuento asociado al total del documento';


--
-- Name: documento_de_pago; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE documento_de_pago (
    doc_pago_cod integer DEFAULT nextval('doc_pago_sec'::regclass) NOT NULL,
    doc_pago_fecha timestamp without time zone,
    doc_pago_obs character varying(50)
);


ALTER TABLE public.documento_de_pago OWNER TO seba;

--
-- Name: TABLE documento_de_pago; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE documento_de_pago IS 'Entidad para crear la herencia de Boleta y Factura, para indicar que una nota de venta podrE1 tener uno de estos documentos, pero no los dos';


--
-- Name: COLUMN documento_de_pago.doc_pago_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN documento_de_pago.doc_pago_cod IS 'Identificador primario de un documento de pago';


--
-- Name: COLUMN documento_de_pago.doc_pago_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN documento_de_pago.doc_pago_fecha IS 'Fecha de creaciF3n del documento de pago';


--
-- Name: COLUMN documento_de_pago.doc_pago_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN documento_de_pago.doc_pago_obs IS 'ObservaciF3n del documento de pago';


--
-- Name: dom_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE dom_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.dom_sec OWNER TO seba;

--
-- Name: dom_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('dom_sec', 1, false);


--
-- Name: dom_val_art; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE dom_val_art (
    dom_cod integer DEFAULT nextval('dom_sec'::regclass) NOT NULL,
    dom_nom character varying(30),
    dom_tipo character varying(40),
    dom_min integer,
    dom_max integer
);


ALTER TABLE public.dom_val_art OWNER TO seba;

--
-- Name: TABLE dom_val_art; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE dom_val_art IS 'Para las distintas propiedades de los diferentes artEDculos se necesita saber quE9 valores pueden tomar estas. ';


--
-- Name: COLUMN dom_val_art.dom_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN dom_val_art.dom_cod IS 'Identificador primario de un dominio';


--
-- Name: COLUMN dom_val_art.dom_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN dom_val_art.dom_nom IS 'Nombre del dominio';


--
-- Name: COLUMN dom_val_art.dom_tipo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN dom_val_art.dom_tipo IS 'Tipo de dominio';


--
-- Name: COLUMN dom_val_art.dom_min; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN dom_val_art.dom_min IS 'Minimo valor para el dominio';


--
-- Name: COLUMN dom_val_art.dom_max; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN dom_val_art.dom_max IS 'ME1ximo valor para el dominio';


--
-- Name: empleado; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE empleado (
    emp_rut character varying(10) NOT NULL,
    cargo_cod integer NOT NULL,
    emp_nom character varying(20),
    emp_ape character varying(20),
    emp_tel character varying(10),
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet
);


ALTER TABLE public.empleado OWNER TO seba;

--
-- Name: estado_cotizacion_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE estado_cotizacion_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.estado_cotizacion_sec OWNER TO seba;

--
-- Name: estado_cotizacion_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('estado_cotizacion_sec', 1, false);


--
-- Name: estado_cotizacion; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE estado_cotizacion (
    cot_est_cod integer DEFAULT nextval('estado_cotizacion_sec'::regclass) NOT NULL,
    cot_est_descr character varying(30)
);


ALTER TABLE public.estado_cotizacion OWNER TO seba;

--
-- Name: TABLE estado_cotizacion; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE estado_cotizacion IS 'Entidad que guarda los estados que pueden tomar las cotizaciones';


--
-- Name: COLUMN estado_cotizacion.cot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_cotizacion.cot_est_cod IS 'Identificador primario del estado que puede tomar la cotizaciF3n';


--
-- Name: COLUMN estado_cotizacion.cot_est_descr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_cotizacion.cot_est_descr IS 'Estado en el cual puede estar una cotizaciF3n';


--
-- Name: estado_factura_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE estado_factura_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.estado_factura_sec OWNER TO seba;

--
-- Name: estado_factura_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('estado_factura_sec', 1, false);


--
-- Name: estado_factura; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE estado_factura (
    fact_est_cod integer DEFAULT nextval('estado_factura_sec'::regclass) NOT NULL,
    fact_est_descr character varying(30)
);


ALTER TABLE public.estado_factura OWNER TO seba;

--
-- Name: TABLE estado_factura; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE estado_factura IS 'Entidad que guarda los estado que pueden tomar facturas
';


--
-- Name: COLUMN estado_factura.fact_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_factura.fact_est_cod IS 'Identificador primario de un estado de una factura';


--
-- Name: COLUMN estado_factura.fact_est_descr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_factura.fact_est_descr IS 'Estado en el cual puede estar una factura';


--
-- Name: estado_nv_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE estado_nv_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.estado_nv_sec OWNER TO seba;

--
-- Name: estado_nv_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('estado_nv_sec', 1, false);


--
-- Name: estado_nota_de_venta; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE estado_nota_de_venta (
    not_ven_est_cod integer DEFAULT nextval('estado_nv_sec'::regclass) NOT NULL,
    not_ven_est_descr character varying(30)
);


ALTER TABLE public.estado_nota_de_venta OWNER TO seba;

--
-- Name: TABLE estado_nota_de_venta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE estado_nota_de_venta IS 'Entidad para guardar los posibles estados de una nota de venta';


--
-- Name: COLUMN estado_nota_de_venta.not_ven_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_nota_de_venta.not_ven_est_cod IS 'Identificador primario de un estado de una nota de venta';


--
-- Name: COLUMN estado_nota_de_venta.not_ven_est_descr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_nota_de_venta.not_ven_est_descr IS 'Estado en el cual puede estar una nota de venta';


--
-- Name: estado_oc_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE estado_oc_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.estado_oc_sec OWNER TO seba;

--
-- Name: estado_oc_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('estado_oc_sec', 1, false);


--
-- Name: estado_oc; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE estado_oc (
    oc_est_cod integer DEFAULT nextval('estado_oc_sec'::regclass) NOT NULL,
    oc_est_descr character varying(30)
);


ALTER TABLE public.estado_oc OWNER TO seba;

--
-- Name: TABLE estado_oc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE estado_oc IS 'Entidad para guardar los posibles estados de una orden de compra';


--
-- Name: COLUMN estado_oc.oc_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_oc.oc_est_cod IS 'Identificador primario de un estado de una orden de compra';


--
-- Name: COLUMN estado_oc.oc_est_descr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_oc.oc_est_descr IS 'Estado en el cual puede estar una orden de compra';


--
-- Name: estado_od_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE estado_od_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.estado_od_sec OWNER TO seba;

--
-- Name: estado_od_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('estado_od_sec', 1, false);


--
-- Name: estado_od; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE estado_od (
    od_est_cod integer DEFAULT nextval('estado_od_sec'::regclass) NOT NULL,
    od_est_descr character varying(30)
);


ALTER TABLE public.estado_od OWNER TO seba;

--
-- Name: TABLE estado_od; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE estado_od IS 'Entidad que guarda los distintos estados que puede tomar la orden de despacho';


--
-- Name: COLUMN estado_od.od_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_od.od_est_cod IS 'Identificador primario del estado de la orden de despacho';


--
-- Name: COLUMN estado_od.od_est_descr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_od.od_est_descr IS 'Estado en el cual puede estar una orden de despacho';


--
-- Name: estado_ot_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE estado_ot_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.estado_ot_sec OWNER TO seba;

--
-- Name: estado_ot_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('estado_ot_sec', 1, false);


--
-- Name: estado_ot; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE estado_ot (
    ot_est_cod integer DEFAULT nextval('estado_ot_sec'::regclass) NOT NULL,
    ot_est_descr character varying(30)
);


ALTER TABLE public.estado_ot OWNER TO seba;

--
-- Name: TABLE estado_ot; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE estado_ot IS 'Entidad para guardar los posibles estados de una orden de trabajo';


--
-- Name: COLUMN estado_ot.ot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_ot.ot_est_cod IS 'Identificador primario del estado que puede tomar la orden de trabajo';


--
-- Name: COLUMN estado_ot.ot_est_descr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN estado_ot.ot_est_descr IS 'DescripciF3n del estado de la orden de trabajo';


--
-- Name: factura; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE factura (
    doc_pago_cod integer NOT NULL,
    fact_est_cod integer NOT NULL,
    doc_pago_fecha timestamp without time zone,
    doc_pago_obs character varying(50)
);


ALTER TABLE public.factura OWNER TO seba;

--
-- Name: TABLE factura; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE factura IS 'Entidad que contiene la informaciF3n de las facturas de cada venta';


--
-- Name: COLUMN factura.doc_pago_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN factura.doc_pago_cod IS 'Identificador primario de un documento de pago';


--
-- Name: COLUMN factura.fact_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN factura.fact_est_cod IS 'Identificador primario de un estado de una factura';


--
-- Name: COLUMN factura.doc_pago_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN factura.doc_pago_fecha IS 'Fecha de creaciF3n del documento de pago';


--
-- Name: COLUMN factura.doc_pago_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN factura.doc_pago_obs IS 'ObservaciF3n del documento de pago';


--
-- Name: herramienta; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE herramienta (
    art_cod character varying(20) NOT NULL,
    art_tipo_cod integer,
    art_nom character varying(40),
    art_stock integer,
    art_precio integer,
    art_imagen character(254)
);


ALTER TABLE public.herramienta OWNER TO seba;

--
-- Name: TABLE herramienta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE herramienta IS 'Entidad para guardar datos de las distintas herramientas que vende la empresa
';


--
-- Name: COLUMN herramienta.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN herramienta.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN herramienta.art_tipo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN herramienta.art_tipo_cod IS 'Identificador primario de un tipo de articulo determinado';


--
-- Name: COLUMN herramienta.art_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN herramienta.art_nom IS 'Nombre del articulo';


--
-- Name: COLUMN herramienta.art_stock; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN herramienta.art_stock IS 'Stock del articulo';


--
-- Name: COLUMN herramienta.art_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN herramienta.art_precio IS 'Precio del articulo';


--
-- Name: COLUMN herramienta.art_imagen; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN herramienta.art_imagen IS 'Imagen del articulo';


--
-- Name: hist_est_cot; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE hist_est_cot (
    doc_cod integer NOT NULL,
    cot_est_cod integer NOT NULL,
    cot_estado_desde timestamp without time zone,
    cot_estado_hasta timestamp without time zone
);


ALTER TABLE public.hist_est_cot OWNER TO seba;

--
-- Name: TABLE hist_est_cot; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE hist_est_cot IS 'Entidad que guarda la fecha de inicio, fecha de termino y los estados por los que ha pasado una cotizaciF3n';


--
-- Name: COLUMN hist_est_cot.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_cot.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN hist_est_cot.cot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_cot.cot_est_cod IS 'Identificador primario del estado que puede tomar la cotizaciF3n';


--
-- Name: COLUMN hist_est_cot.cot_estado_desde; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_cot.cot_estado_desde IS 'Fecha en la que empezF3 el estado de la cotizaciF3n';


--
-- Name: COLUMN hist_est_cot.cot_estado_hasta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_cot.cot_estado_hasta IS 'Fecha en la que terminF3 el estado de la cotizaciF3n';


--
-- Name: hist_est_fact; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE hist_est_fact (
    fact_est_cod integer NOT NULL,
    doc_pago_cod integer NOT NULL,
    fact_estado_desde date,
    fact_estado_hasta date
);


ALTER TABLE public.hist_est_fact OWNER TO seba;

--
-- Name: TABLE hist_est_fact; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE hist_est_fact IS 'Entidad que guarda la fecha de inicio, fecha de termino y los estados por los que ha pasado una factura';


--
-- Name: COLUMN hist_est_fact.fact_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_fact.fact_est_cod IS 'Identificador primario de un estado de una factura';


--
-- Name: COLUMN hist_est_fact.doc_pago_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_fact.doc_pago_cod IS 'Identificador primario de un documento de pago';


--
-- Name: COLUMN hist_est_fact.fact_estado_desde; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_fact.fact_estado_desde IS 'Fecha en la que empezF3 el estado de la factura';


--
-- Name: COLUMN hist_est_fact.fact_estado_hasta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_fact.fact_estado_hasta IS 'Fecha en la que terminF3 el estado de la cotizaciF3n';


--
-- Name: hist_est_nv; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE hist_est_nv (
    not_ven_cod integer NOT NULL,
    not_ven_est_cod integer NOT NULL,
    not_ven_estado_desde timestamp without time zone,
    not_ven_estado_hasta timestamp without time zone
);


ALTER TABLE public.hist_est_nv OWNER TO seba;

--
-- Name: TABLE hist_est_nv; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE hist_est_nv IS 'Entidad que guarda la fecha de inicio, fecha de termino y los estados por los que ha pasado una nota de venta';


--
-- Name: COLUMN hist_est_nv.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_nv.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN hist_est_nv.not_ven_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_nv.not_ven_est_cod IS 'Identificador primario de un estado de una nota de venta';


--
-- Name: COLUMN hist_est_nv.not_ven_estado_desde; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_nv.not_ven_estado_desde IS 'Fecha en la que empezF3 el estado de la nota de venta';


--
-- Name: COLUMN hist_est_nv.not_ven_estado_hasta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_nv.not_ven_estado_hasta IS 'Fecha en la que terminF3 el estado de la nota de venta';


--
-- Name: hist_est_oc; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE hist_est_oc (
    doc_cod integer NOT NULL,
    oc_est_cod integer NOT NULL,
    oc_estado_desde date,
    oc_estado_hasta date
);


ALTER TABLE public.hist_est_oc OWNER TO seba;

--
-- Name: TABLE hist_est_oc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE hist_est_oc IS 'Entidad que guarda la fecha de inicio, fecha de termino y los estados por los que ha pasado una orden de compra';


--
-- Name: COLUMN hist_est_oc.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_oc.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN hist_est_oc.oc_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_oc.oc_est_cod IS 'Identificador primario de un estado de una orden de compra';


--
-- Name: COLUMN hist_est_oc.oc_estado_desde; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_oc.oc_estado_desde IS 'Fecha en la que empezF3 el estado de la orden de compra';


--
-- Name: COLUMN hist_est_oc.oc_estado_hasta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_oc.oc_estado_hasta IS 'Fecha en la que terminF3 el estado de la orden de compra';


--
-- Name: hist_est_od; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE hist_est_od (
    od_cod integer NOT NULL,
    od_est_cod integer NOT NULL,
    od_estado_desde date,
    od_estado_hasta date
);


ALTER TABLE public.hist_est_od OWNER TO seba;

--
-- Name: TABLE hist_est_od; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE hist_est_od IS 'Entidad que guarda la fecha de inicio, fecha de termino y los estados por los que ha pasado una orden de despacho.';


--
-- Name: COLUMN hist_est_od.od_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_od.od_cod IS 'Identificador primario de la orden de despacho';


--
-- Name: COLUMN hist_est_od.od_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_od.od_est_cod IS 'Identificador primario del estado de la orden de despacho';


--
-- Name: COLUMN hist_est_od.od_estado_desde; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_od.od_estado_desde IS 'Fecha en la que empezF3 el estado de la orden de despacho';


--
-- Name: COLUMN hist_est_od.od_estado_hasta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_od.od_estado_hasta IS 'Fecha en la que terminF3 el estado de la orden de despacho';


--
-- Name: hist_est_ot; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE hist_est_ot (
    ot_cod integer NOT NULL,
    ot_est_cod integer NOT NULL,
    ot_estado_desde date,
    ot_estado_hasta date
);


ALTER TABLE public.hist_est_ot OWNER TO seba;

--
-- Name: TABLE hist_est_ot; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE hist_est_ot IS 'Entidad que guarda la fecha de inicio, fecha de termino y los estados por los que ha pasado una orden de trabajo';


--
-- Name: COLUMN hist_est_ot.ot_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_ot.ot_cod IS 'Identificador primario de la orden de trabajo';


--
-- Name: COLUMN hist_est_ot.ot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_ot.ot_est_cod IS 'Identificador primario del estado que puede tomar la orden de trabajo';


--
-- Name: COLUMN hist_est_ot.ot_estado_desde; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_ot.ot_estado_desde IS 'Fecha en la que empezF3 el estado de la orden de trabajo';


--
-- Name: COLUMN hist_est_ot.ot_estado_hasta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN hist_est_ot.ot_estado_hasta IS 'Fecha en la que terminF3 el estado de la orden de trabajo';


--
-- Name: insumo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE insumo (
    art_cod character varying(20) NOT NULL,
    art_tipo_cod integer,
    art_nom character varying(40),
    art_stock integer,
    art_precio integer,
    art_imagen character(254)
);


ALTER TABLE public.insumo OWNER TO seba;

--
-- Name: TABLE insumo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE insumo IS 'Entidad para guardar datos de las distintos insumos que vende la empresa';


--
-- Name: COLUMN insumo.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN insumo.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN insumo.art_tipo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN insumo.art_tipo_cod IS 'Identificador primario de un tipo de articulo determinado';


--
-- Name: COLUMN insumo.art_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN insumo.art_nom IS 'Nombre del articulo';


--
-- Name: COLUMN insumo.art_stock; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN insumo.art_stock IS 'Stock del articulo';


--
-- Name: COLUMN insumo.art_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN insumo.art_precio IS 'Precio del articulo';


--
-- Name: COLUMN insumo.art_imagen; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN insumo.art_imagen IS 'Imagen del articulo';


--
-- Name: log; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE log (
    pk_audit integer NOT NULL,
    "TableName" character(45) NOT NULL,
    "Operation" character(1) NOT NULL,
    "OldValue" text,
    "NewValue" text,
    "UpdateDate" timestamp without time zone NOT NULL,
    "UserName" character(45) NOT NULL
);


ALTER TABLE public.log OWNER TO seba;

--
-- Name: marca_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE marca_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.marca_sec OWNER TO seba;

--
-- Name: marca_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('marca_sec', 15, true);


--
-- Name: marca; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE marca (
    marca_cod integer DEFAULT nextval('marca_sec'::regclass) NOT NULL,
    marca_nombre character varying(30)
);


ALTER TABLE public.marca OWNER TO seba;

--
-- Name: TABLE marca; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE marca IS 'Entidad para guardar la informaciF3n de las distintas marcas de vehEDculos ';


--
-- Name: COLUMN marca.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN marca.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN marca.marca_nombre; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN marca.marca_nombre IS 'Nombre de la marca del vehEDculo';


--
-- Name: metodo_de_pago_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE metodo_de_pago_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.metodo_de_pago_sec OWNER TO seba;

--
-- Name: metodo_de_pago_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('metodo_de_pago_sec', 1, false);


--
-- Name: metodo_de_pago; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE metodo_de_pago (
    pago_cod integer DEFAULT nextval('metodo_de_pago_sec'::regclass) NOT NULL,
    pago_tipo character varying(20)
);


ALTER TABLE public.metodo_de_pago OWNER TO seba;

--
-- Name: TABLE metodo_de_pago; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE metodo_de_pago IS 'Entidad que contiene las distintas formas de pago que se especifican dentro de una nota de venta.';


--
-- Name: COLUMN metodo_de_pago.pago_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN metodo_de_pago.pago_cod IS 'Identificador primario de una forma de pago';


--
-- Name: COLUMN metodo_de_pago.pago_tipo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN metodo_de_pago.pago_tipo IS 'Tipo de pago que puede realizarse';


--
-- Name: modelo_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE modelo_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.modelo_sec OWNER TO seba;

--
-- Name: modelo_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('modelo_sec', 11, true);


--
-- Name: modelo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE modelo (
    marca_cod integer NOT NULL,
    modelo_cod integer DEFAULT nextval('modelo_sec'::regclass) NOT NULL,
    modelo_nombre character varying(30),
    modelo_ano integer NOT NULL
);


ALTER TABLE public.modelo OWNER TO seba;

--
-- Name: TABLE modelo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE modelo IS 'Entidad para guardar informaciF3n de los modelos de los distintos vehEDculos que reciben servicios';


--
-- Name: COLUMN modelo.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN modelo.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN modelo.modelo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN modelo.modelo_cod IS 'Identificador primario de un modelo de vehEDculo';


--
-- Name: COLUMN modelo.modelo_nombre; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN modelo.modelo_nombre IS 'Nombre del modelo de un vehEDculo';


--
-- Name: COLUMN modelo.modelo_ano; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN modelo.modelo_ano IS 'AF1o del modelo del vehEDculo';


--
-- Name: nv_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE nv_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.nv_sec OWNER TO seba;

--
-- Name: nv_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('nv_sec', 12, true);


--
-- Name: nota_de_venta; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE nota_de_venta (
    not_ven_cod integer DEFAULT nextval('nv_sec'::regclass) NOT NULL,
    od_cod integer,
    not_ven_est_cod integer NOT NULL,
    doc_pago_cod integer,
    pago_cod integer,
    not_ven_fecha date,
    not_ven_obs character varying(100),
    doc_cod integer NOT NULL
);


ALTER TABLE public.nota_de_venta OWNER TO seba;

--
-- Name: TABLE nota_de_venta; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE nota_de_venta IS 'Entidad para guardar datos de las distintas Notas de Venta realizadas a partir de las cotizaciones aceptadas';


--
-- Name: COLUMN nota_de_venta.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN nota_de_venta.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN nota_de_venta.od_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN nota_de_venta.od_cod IS 'Identificador primario de la orden de despacho';


--
-- Name: COLUMN nota_de_venta.not_ven_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN nota_de_venta.not_ven_est_cod IS 'Identificador primario de un estado de una nota de venta';


--
-- Name: COLUMN nota_de_venta.doc_pago_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN nota_de_venta.doc_pago_cod IS 'Identificador primario de un documento de pago';


--
-- Name: COLUMN nota_de_venta.pago_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN nota_de_venta.pago_cod IS 'Identificador primario de una forma de pago';


--
-- Name: COLUMN nota_de_venta.not_ven_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN nota_de_venta.not_ven_fecha IS 'Fecha de creaciF3n de la nota de venta';


--
-- Name: COLUMN nota_de_venta.not_ven_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN nota_de_venta.not_ven_obs IS 'ObservaciF3n de la nota de venta';


--
-- Name: od_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE od_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.od_sec OWNER TO seba;

--
-- Name: od_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('od_sec', 1, false);


--
-- Name: orden_de_compra; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE orden_de_compra (
    doc_cod integer NOT NULL,
    oc_est_cod integer NOT NULL,
    cliente_cod integer,
    not_ven_cod integer,
    emp_rut character varying(10),
    doc_fecha date,
    doc_obs character varying(100),
    doc_neto integer,
    doc_iva integer,
    doc_total integer,
    doc_total_desc integer
);


ALTER TABLE public.orden_de_compra OWNER TO seba;

--
-- Name: TABLE orden_de_compra; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE orden_de_compra IS 'Entidad para guardar datos de las distintas Ordenes de Compra enviadas por los clientes.';


--
-- Name: COLUMN orden_de_compra.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN orden_de_compra.oc_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.oc_est_cod IS 'Identificador primario de un estado de una orden de compra';


--
-- Name: COLUMN orden_de_compra.cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.cliente_cod IS 'Identificador primario de un cliente';


--
-- Name: COLUMN orden_de_compra.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN orden_de_compra.emp_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.emp_rut IS 'Rut e identificador primario de cada empleado';


--
-- Name: COLUMN orden_de_compra.doc_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.doc_fecha IS 'Fecha de emisiF3n del documento';


--
-- Name: COLUMN orden_de_compra.doc_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.doc_obs IS 'ObservaciF3n del documento';


--
-- Name: COLUMN orden_de_compra.doc_neto; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.doc_neto IS 'Precio Neto en el documento';


--
-- Name: COLUMN orden_de_compra.doc_iva; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.doc_iva IS 'IVA asociado al documento';


--
-- Name: COLUMN orden_de_compra.doc_total; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.doc_total IS 'Precio total el documento';


--
-- Name: COLUMN orden_de_compra.doc_total_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_compra.doc_total_desc IS 'Descuento asociado al total del documento';


--
-- Name: orden_de_despacho; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE orden_de_despacho (
    od_cod integer DEFAULT nextval('od_sec'::regclass) NOT NULL,
    not_ven_cod integer NOT NULL,
    od_est_cod integer NOT NULL,
    od_fecha date,
    od_obs character varying(100),
    desp_fecha date,
    od_dir character varying(50)
);


ALTER TABLE public.orden_de_despacho OWNER TO seba;

--
-- Name: TABLE orden_de_despacho; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE orden_de_despacho IS 'Orden de despacho de una nota de venta.';


--
-- Name: COLUMN orden_de_despacho.od_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_despacho.od_cod IS 'Identificador primario de la orden de despacho';


--
-- Name: COLUMN orden_de_despacho.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_despacho.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN orden_de_despacho.od_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_despacho.od_est_cod IS 'Identificador primario del estado de la orden de despacho';


--
-- Name: COLUMN orden_de_despacho.od_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_despacho.od_fecha IS 'Fecha de creaciF3n de la orden de despacho';


--
-- Name: COLUMN orden_de_despacho.od_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_despacho.od_obs IS 'ObservaciF3n de la orden de despacho';


--
-- Name: COLUMN orden_de_despacho.desp_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_despacho.desp_fecha IS 'Fecha destinada a la realizaciF3n del despacho';


--
-- Name: COLUMN orden_de_despacho.od_dir; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_despacho.od_dir IS 'Direccion para la orden de despacho';


--
-- Name: ot_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE ot_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ot_sec OWNER TO seba;

--
-- Name: ot_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('ot_sec', 1, false);


--
-- Name: orden_de_trabajo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE orden_de_trabajo (
    ot_cod integer DEFAULT nextval('ot_sec'::regclass) NOT NULL,
    veh_pat character varying(6),
    not_ven_cod integer,
    doc_cod integer NOT NULL,
    ot_est_cod integer,
    emp_rut character varying(10),
    ot_fecha date NOT NULL,
    ot_obs character varying(100),
    modelo_cod integer
);


ALTER TABLE public.orden_de_trabajo OWNER TO seba;

--
-- Name: TABLE orden_de_trabajo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE orden_de_trabajo IS 'Entidad que guarda los datos de la orden de trabajo de una cotizaciF3n realizada con servicios involucrados.';


--
-- Name: COLUMN orden_de_trabajo.ot_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_trabajo.ot_cod IS 'Identificador primario de la orden de trabajo';


--
-- Name: COLUMN orden_de_trabajo.veh_pat; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_trabajo.veh_pat IS 'Identificador primario del vehEDculo que recibe servicios';


--
-- Name: COLUMN orden_de_trabajo.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_trabajo.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN orden_de_trabajo.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_trabajo.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN orden_de_trabajo.ot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_trabajo.ot_est_cod IS 'Identificador primario del estado que puede tomar la orden de trabajo';


--
-- Name: COLUMN orden_de_trabajo.emp_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_trabajo.emp_rut IS 'Rut e identificador primario de cada empleado';


--
-- Name: COLUMN orden_de_trabajo.ot_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_trabajo.ot_fecha IS 'Fecha de creaciF3n de la orden de trabajo';


--
-- Name: COLUMN orden_de_trabajo.ot_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN orden_de_trabajo.ot_obs IS 'ObservaciF3n de una orden de trabajo';


--
-- Name: para_instalacion; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE para_instalacion (
    art_cod character varying(20) NOT NULL,
    art_tipo_cod integer,
    art_nom character varying(40),
    art_stock integer,
    art_precio integer,
    art_imagen character(254)
);


ALTER TABLE public.para_instalacion OWNER TO seba;

--
-- Name: TABLE para_instalacion; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE para_instalacion IS 'Entidad para guardar los articulos que son instalados';


--
-- Name: COLUMN para_instalacion.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN para_instalacion.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN para_instalacion.art_tipo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN para_instalacion.art_tipo_cod IS 'Identificador primario de un tipo de articulo determinado';


--
-- Name: COLUMN para_instalacion.art_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN para_instalacion.art_nom IS 'Nombre del articulo';


--
-- Name: COLUMN para_instalacion.art_stock; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN para_instalacion.art_stock IS 'Stock del articulo';


--
-- Name: COLUMN para_instalacion.art_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN para_instalacion.art_precio IS 'Precio del articulo';


--
-- Name: COLUMN para_instalacion.art_imagen; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN para_instalacion.art_imagen IS 'Imagen del articulo';


--
-- Name: param_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE param_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.param_sec OWNER TO seba;

--
-- Name: param_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('param_sec', 1, false);


--
-- Name: parametros; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE parametros (
    param_cod integer DEFAULT nextval('param_sec'::regclass) NOT NULL,
    param_nom character varying(20),
    param_valor integer,
    param_valor_tipo character varying(30)
);


ALTER TABLE public.parametros OWNER TO seba;

--
-- Name: TABLE parametros; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE parametros IS 'Entidad para guardar los parametros de la aplicacion';


--
-- Name: COLUMN parametros.param_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN parametros.param_cod IS 'Identificador primario del parametro';


--
-- Name: COLUMN parametros.param_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN parametros.param_nom IS 'Nombre del parametro';


--
-- Name: COLUMN parametros.param_valor; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN parametros.param_valor IS 'Valor del parametro';


--
-- Name: COLUMN parametros.param_valor_tipo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN parametros.param_valor_tipo IS 'Tipo de valor para el parametro';


--
-- Name: prop_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE prop_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.prop_sec OWNER TO seba;

--
-- Name: prop_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('prop_sec', 1, false);


--
-- Name: propiedad_articulo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE propiedad_articulo (
    prop_cod integer DEFAULT nextval('prop_sec'::regclass) NOT NULL,
    dom_cod integer NOT NULL,
    art_tipo_cod integer NOT NULL,
    prop_nom character varying(40),
    prop_med character varying(20)
);


ALTER TABLE public.propiedad_articulo OWNER TO seba;

--
-- Name: TABLE propiedad_articulo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE propiedad_articulo IS 'Entidad que guarda las propiedades que puede tener un determinado artEDculo.
';


--
-- Name: COLUMN propiedad_articulo.prop_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN propiedad_articulo.prop_cod IS 'Identificador primario de una propiedad';


--
-- Name: COLUMN propiedad_articulo.dom_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN propiedad_articulo.dom_cod IS 'Identificador primario de un dominio';


--
-- Name: COLUMN propiedad_articulo.art_tipo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN propiedad_articulo.art_tipo_cod IS 'Identificador primario de un tipo de articulo determinado';


--
-- Name: COLUMN propiedad_articulo.prop_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN propiedad_articulo.prop_nom IS 'Nombre de la propiedad';


--
-- Name: COLUMN propiedad_articulo.prop_med; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN propiedad_articulo.prop_med IS 'Unidad de medida de la propiedad';


--
-- Name: prov_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE prov_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.prov_sec OWNER TO seba;

--
-- Name: prov_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('prov_sec', 1, false);


--
-- Name: proveedor; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE proveedor (
    prov_cod integer DEFAULT nextval('prov_sec'::regclass) NOT NULL,
    prov_nom character varying(30),
    prov_web character varying(40)
);


ALTER TABLE public.proveedor OWNER TO seba;

--
-- Name: TABLE proveedor; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE proveedor IS 'Entidad para guardar a los diferentes proveedores de los articulos de la empresa';


--
-- Name: COLUMN proveedor.prov_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN proveedor.prov_cod IS 'Identificador primario del proveedor';


--
-- Name: COLUMN proveedor.prov_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN proveedor.prov_nom IS 'Nombre del proveedor';


--
-- Name: COLUMN proveedor.prov_web; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN proveedor.prov_web IS 'Pagina web del proveedor';


--
-- Name: proveedor_articulo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE proveedor_articulo (
    prov_cod integer NOT NULL,
    art_cod character varying(20) NOT NULL,
    cod_prov_art character varying(30)
);


ALTER TABLE public.proveedor_articulo OWNER TO seba;

--
-- Name: TABLE proveedor_articulo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE proveedor_articulo IS 'Entidad para relacionar los codigos de los articulos segun los proveedores con los codigos propios de la empresa';


--
-- Name: COLUMN proveedor_articulo.prov_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN proveedor_articulo.prov_cod IS 'Identificador primario del proveedor';


--
-- Name: COLUMN proveedor_articulo.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN proveedor_articulo.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN proveedor_articulo.cod_prov_art; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN proveedor_articulo.cod_prov_art IS 'Codigo de un articulo segun el proveedor';


--
-- Name: repuesto; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE repuesto (
    art_cod character varying(20) NOT NULL,
    art_tipo_cod integer,
    art_nom character varying(40),
    art_stock integer,
    art_precio integer,
    art_imagen character(254)
);


ALTER TABLE public.repuesto OWNER TO seba;

--
-- Name: TABLE repuesto; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE repuesto IS 'Entidad para guardar datos de cada repuesto que vende la empresa
';


--
-- Name: COLUMN repuesto.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN repuesto.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN repuesto.art_tipo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN repuesto.art_tipo_cod IS 'Identificador primario de un tipo de articulo determinado';


--
-- Name: COLUMN repuesto.art_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN repuesto.art_nom IS 'Nombre del articulo';


--
-- Name: COLUMN repuesto.art_stock; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN repuesto.art_stock IS 'Stock del articulo';


--
-- Name: COLUMN repuesto.art_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN repuesto.art_precio IS 'Precio del articulo';


--
-- Name: COLUMN repuesto.art_imagen; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN repuesto.art_imagen IS 'Imagen del articulo';


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO seba;

--
-- Name: serv_inst; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE serv_inst (
    doc_cod integer NOT NULL,
    not_ven_cod integer,
    emp_rut character varying(10),
    doc_fecha date,
    doc_obs character varying(100),
    doc_neto integer,
    doc_iva integer,
    doc_total integer,
    doc_total_desc integer,
    cliente_cod integer
);


ALTER TABLE public.serv_inst OWNER TO seba;

--
-- Name: TABLE serv_inst; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE serv_inst IS 'Entidad para las cotizaciones u ordenes de compra por servicios de instalacion ';


--
-- Name: COLUMN serv_inst.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN serv_inst.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN serv_inst.emp_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.emp_rut IS 'Rut e identificador primario de cada empleado';


--
-- Name: COLUMN serv_inst.doc_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.doc_fecha IS 'Fecha de emisiF3n del documento';


--
-- Name: COLUMN serv_inst.doc_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.doc_obs IS 'ObservaciF3n del documento';


--
-- Name: COLUMN serv_inst.doc_neto; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.doc_neto IS 'Precio Neto en el documento';


--
-- Name: COLUMN serv_inst.doc_iva; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.doc_iva IS 'IVA asociado al documento';


--
-- Name: COLUMN serv_inst.doc_total; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.doc_total IS 'Precio total el documento';


--
-- Name: COLUMN serv_inst.doc_total_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst.doc_total_desc IS 'Descuento asociado al total del documento';


--
-- Name: serv_inst_det; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE serv_inst_det (
    doc_cod integer NOT NULL,
    si_num_linea integer NOT NULL,
    marca_cod integer NOT NULL,
    art_cod character varying(20) NOT NULL,
    modelo_cod integer NOT NULL,
    modelo_ano integer NOT NULL,
    si_desc integer,
    serv_precio integer
);


ALTER TABLE public.serv_inst_det OWNER TO seba;

--
-- Name: TABLE serv_inst_det; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE serv_inst_det IS 'Entidad para los detalles de cada cotizacion u orden de compra por servicios de instalacion';


--
-- Name: COLUMN serv_inst_det.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst_det.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN serv_inst_det.si_num_linea; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst_det.si_num_linea IS 'Numero de linea de detalle de la cotizacion u orden de compra de un servicio de instalacion';


--
-- Name: COLUMN serv_inst_det.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst_det.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN serv_inst_det.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst_det.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN serv_inst_det.modelo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst_det.modelo_cod IS 'Identificador primario de un modelo de vehEDculo';


--
-- Name: COLUMN serv_inst_det.si_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_inst_det.si_desc IS 'Descuento para un servicio de instalacion';


--
-- Name: serv_rep; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE serv_rep (
    doc_cod integer NOT NULL,
    cliente_cod integer,
    not_ven_cod integer,
    emp_rut character varying(10),
    doc_fecha date,
    doc_obs character varying(100),
    doc_neto integer,
    doc_iva integer,
    doc_total integer,
    doc_total_desc integer
);


ALTER TABLE public.serv_rep OWNER TO seba;

--
-- Name: TABLE serv_rep; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE serv_rep IS 'Entidad para guardar las cotizaciones u ordenes de compra por servicios de reparacion';


--
-- Name: COLUMN serv_rep.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN serv_rep.cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.cliente_cod IS 'Identificador primario de un cliente';


--
-- Name: COLUMN serv_rep.not_ven_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.not_ven_cod IS 'Identificador primario de la nota de venta';


--
-- Name: COLUMN serv_rep.emp_rut; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.emp_rut IS 'Rut e identificador primario de cada empleado';


--
-- Name: COLUMN serv_rep.doc_fecha; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.doc_fecha IS 'Fecha de emisiF3n del documento';


--
-- Name: COLUMN serv_rep.doc_obs; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.doc_obs IS 'ObservaciF3n del documento';


--
-- Name: COLUMN serv_rep.doc_neto; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.doc_neto IS 'Precio Neto en el documento';


--
-- Name: COLUMN serv_rep.doc_iva; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.doc_iva IS 'IVA asociado al documento';


--
-- Name: COLUMN serv_rep.doc_total; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.doc_total IS 'Precio total el documento';


--
-- Name: COLUMN serv_rep.doc_total_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep.doc_total_desc IS 'Descuento asociado al total del documento';


--
-- Name: serv_rep_det; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE serv_rep_det (
    doc_cod integer NOT NULL,
    sr_num_linea integer NOT NULL,
    serv_cod integer NOT NULL,
    marca_cod integer NOT NULL,
    modelo_cod integer NOT NULL,
    modelo_ano integer NOT NULL,
    sr_desc integer,
    sr_precio integer,
    sr_cant integer
);


ALTER TABLE public.serv_rep_det OWNER TO seba;

--
-- Name: TABLE serv_rep_det; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE serv_rep_det IS 'Entidad para los detalles de cada una de las cotizaciones u ordenes de compra por servicios de reparacion';


--
-- Name: COLUMN serv_rep_det.doc_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep_det.doc_cod IS 'Identificador primario de la cotizacion o de la orden de compra, segun corresponda';


--
-- Name: COLUMN serv_rep_det.sr_num_linea; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep_det.sr_num_linea IS 'Numero de linea de detalle en el documento para servicios de reparacion';


--
-- Name: COLUMN serv_rep_det.serv_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep_det.serv_cod IS 'Identificador primario para los distintos servicios que presta la empresa';


--
-- Name: COLUMN serv_rep_det.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep_det.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN serv_rep_det.modelo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep_det.modelo_cod IS 'Identificador primario de un modelo de vehEDculo';


--
-- Name: COLUMN serv_rep_det.sr_desc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep_det.sr_desc IS 'Descuento para la reparacion en el documento';


--
-- Name: COLUMN serv_rep_det.sr_precio; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep_det.sr_precio IS 'Precio del servicio de reparacion';


--
-- Name: COLUMN serv_rep_det.sr_cant; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN serv_rep_det.sr_cant IS 'Cantidad de reparaciones';


--
-- Name: sr_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE sr_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sr_sec OWNER TO seba;

--
-- Name: sr_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('sr_sec', 7, true);


--
-- Name: servicio_reparacion; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE servicio_reparacion (
    serv_cod integer DEFAULT nextval('sr_sec'::regclass) NOT NULL,
    serv_nom character varying(40)
);


ALTER TABLE public.servicio_reparacion OWNER TO seba;

--
-- Name: TABLE servicio_reparacion; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE servicio_reparacion IS 'Entidad para guardar la informaciF3n de los distintos servicios de reparacion';


--
-- Name: COLUMN servicio_reparacion.serv_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN servicio_reparacion.serv_cod IS 'Identificador primario para los distintos servicios que presta la empresa';


--
-- Name: COLUMN servicio_reparacion.serv_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN servicio_reparacion.serv_nom IS 'Nombre del servicio que presta la empresa';


--
-- Name: si_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE si_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.si_sec OWNER TO seba;

--
-- Name: si_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('si_sec', 3, true);


--
-- Name: si_vehiculo_articulo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE si_vehiculo_articulo (
    art_cod character varying(20) NOT NULL,
    marca_cod integer NOT NULL,
    modelo_cod integer NOT NULL,
    modelo_ano integer NOT NULL,
    s_v_a_mo_pr integer,
    s_v_a_in_pr integer,
    si_cod integer DEFAULT nextval('si_sec'::regclass)
);


ALTER TABLE public.si_vehiculo_articulo OWNER TO seba;

--
-- Name: TABLE si_vehiculo_articulo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE si_vehiculo_articulo IS 'Entidad para guardar los costos de instalaciF3n para artEDculos determinados en vehEDculos determinados. SI: Servicio de InstalaciF3n';


--
-- Name: COLUMN si_vehiculo_articulo.art_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN si_vehiculo_articulo.art_cod IS 'Identificador primario del articulo';


--
-- Name: COLUMN si_vehiculo_articulo.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN si_vehiculo_articulo.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN si_vehiculo_articulo.modelo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN si_vehiculo_articulo.modelo_cod IS 'Identificador primario de un modelo de vehEDculo';


--
-- Name: COLUMN si_vehiculo_articulo.s_v_a_mo_pr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN si_vehiculo_articulo.s_v_a_mo_pr IS 'Precio de mano de obra de la instalaciF3n de un determinado artEDculo';


--
-- Name: tbl_audit_pk_audit_seq; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE tbl_audit_pk_audit_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tbl_audit_pk_audit_seq OWNER TO seba;

--
-- Name: tbl_audit_pk_audit_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: seba
--

ALTER SEQUENCE tbl_audit_pk_audit_seq OWNED BY log.pk_audit;


--
-- Name: tbl_audit_pk_audit_seq; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('tbl_audit_pk_audit_seq', 814, true);


--
-- Name: tipo_art_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE tipo_art_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tipo_art_sec OWNER TO seba;

--
-- Name: tipo_art_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('tipo_art_sec', 23, true);


--
-- Name: tipo_articulo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE tipo_articulo (
    art_tipo_cod integer DEFAULT nextval('tipo_art_sec'::regclass) NOT NULL,
    tipo_nom character varying(40)
);


ALTER TABLE public.tipo_articulo OWNER TO seba;

--
-- Name: TABLE tipo_articulo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE tipo_articulo IS 'Entidad para guardar datos de las clases o tipos de artEDculos que vende la empresa';


--
-- Name: COLUMN tipo_articulo.art_tipo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN tipo_articulo.art_tipo_cod IS 'Identificador primario de un tipo de articulo determinado';


--
-- Name: COLUMN tipo_articulo.tipo_nom; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN tipo_articulo.tipo_nom IS 'Nombre del tipo de artEDculo. Ej: Cristal, moldura, etc.';


--
-- Name: tipo_cliente_sec; Type: SEQUENCE; Schema: public; Owner: seba
--

CREATE SEQUENCE tipo_cliente_sec
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tipo_cliente_sec OWNER TO seba;

--
-- Name: tipo_cliente_sec; Type: SEQUENCE SET; Schema: public; Owner: seba
--

SELECT pg_catalog.setval('tipo_cliente_sec', 8, true);


--
-- Name: tipo_cliente; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE tipo_cliente (
    tipo_cliente_cod integer DEFAULT nextval('tipo_cliente_sec'::regclass) NOT NULL,
    tipo_cliente_descr character varying(30)
);


ALTER TABLE public.tipo_cliente OWNER TO seba;

--
-- Name: TABLE tipo_cliente; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE tipo_cliente IS 'Entidad para guardar los tipos distintos de clientes que pueden exisitir';


--
-- Name: COLUMN tipo_cliente.tipo_cliente_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN tipo_cliente.tipo_cliente_cod IS 'Identificador primario para el tipo de cliente';


--
-- Name: COLUMN tipo_cliente.tipo_cliente_descr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN tipo_cliente.tipo_cliente_descr IS 'DescripciF3n del tipo de cliente';


--
-- Name: tran_est_cot; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE tran_est_cot (
    cot_est_cod integer NOT NULL,
    est_cot_est_cod integer NOT NULL
);


ALTER TABLE public.tran_est_cot OWNER TO seba;

--
-- Name: TABLE tran_est_cot; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE tran_est_cot IS 'Entidad que guarda las transiciones posibles de realizar entre los estados de una cotizaciF3n';


--
-- Name: COLUMN tran_est_cot.cot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN tran_est_cot.cot_est_cod IS 'Identificador primario del estado que puede tomar la cotizaciF3n';


--
-- Name: COLUMN tran_est_cot.est_cot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN tran_est_cot.est_cot_est_cod IS 'Identificador primario del estado que puede tomar la cotizaciF3n';


--
-- Name: trans_est_fact; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE trans_est_fact (
    fact_est_cod integer NOT NULL,
    est_fact_est_cod integer NOT NULL
);


ALTER TABLE public.trans_est_fact OWNER TO seba;

--
-- Name: TABLE trans_est_fact; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE trans_est_fact IS 'Entidad que guarda las transiciones posibles de realizar entre los estados de una factura';


--
-- Name: COLUMN trans_est_fact.fact_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_fact.fact_est_cod IS 'Identificador primario de un estado de una factura';


--
-- Name: COLUMN trans_est_fact.est_fact_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_fact.est_fact_est_cod IS 'Identificador primario de un estado de una factura';


--
-- Name: trans_est_nv; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE trans_est_nv (
    est_not_ven_est_cod integer NOT NULL,
    not_ven_est_cod integer NOT NULL
);


ALTER TABLE public.trans_est_nv OWNER TO seba;

--
-- Name: TABLE trans_est_nv; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE trans_est_nv IS 'Entidad que guarda las transiciones posibles de realizar entre los estados de una nota de venta';


--
-- Name: COLUMN trans_est_nv.est_not_ven_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_nv.est_not_ven_est_cod IS 'Identificador primario de un estado de una nota de venta';


--
-- Name: COLUMN trans_est_nv.not_ven_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_nv.not_ven_est_cod IS 'Identificador primario de un estado de una nota de venta';


--
-- Name: trans_est_oc; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE trans_est_oc (
    est_oc_est_cod integer NOT NULL,
    oc_est_cod integer NOT NULL
);


ALTER TABLE public.trans_est_oc OWNER TO seba;

--
-- Name: TABLE trans_est_oc; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE trans_est_oc IS 'Entidad que guarda las transiciones posibles de realizar entre los estados de una orden de compra';


--
-- Name: COLUMN trans_est_oc.est_oc_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_oc.est_oc_est_cod IS 'Identificador primario de un estado de una orden de compra';


--
-- Name: COLUMN trans_est_oc.oc_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_oc.oc_est_cod IS 'Identificador primario de un estado de una orden de compra';


--
-- Name: trans_est_od; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE trans_est_od (
    od_est_cod integer NOT NULL,
    est_od_est_cod integer NOT NULL
);


ALTER TABLE public.trans_est_od OWNER TO seba;

--
-- Name: TABLE trans_est_od; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE trans_est_od IS 'Entidad que guarda las transiciones posibles de realizar entre los estados de una orden de despacho';


--
-- Name: COLUMN trans_est_od.od_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_od.od_est_cod IS 'Identificador primario del estado de la orden de despacho';


--
-- Name: COLUMN trans_est_od.est_od_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_od.est_od_est_cod IS 'Identificador primario del estado de la orden de despacho';


--
-- Name: trans_est_ot; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE trans_est_ot (
    ot_est_cod integer NOT NULL,
    est_ot_est_cod integer NOT NULL
);


ALTER TABLE public.trans_est_ot OWNER TO seba;

--
-- Name: TABLE trans_est_ot; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE trans_est_ot IS 'Entidad que guarda las transiciones posibles de realizar entre los estados de una orden de trabajo';


--
-- Name: COLUMN trans_est_ot.ot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_ot.ot_est_cod IS 'Identificador primario del estado que puede tomar la orden de trabajo';


--
-- Name: COLUMN trans_est_ot.est_ot_est_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN trans_est_ot.est_ot_est_cod IS 'Identificador primario del estado que puede tomar la orden de trabajo';


--
-- Name: vehiculo; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE vehiculo (
    veh_pat character varying(6) NOT NULL,
    marca_cod integer NOT NULL,
    modelo_cod integer NOT NULL,
    modelo_ano integer NOT NULL,
    veh_km integer,
    veh_color character varying(10)
);


ALTER TABLE public.vehiculo OWNER TO seba;

--
-- Name: TABLE vehiculo; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE vehiculo IS 'Entidad para guardar la informaciF3n de los vehEDculos que reciben servicios de la empresa';


--
-- Name: COLUMN vehiculo.veh_pat; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo.veh_pat IS 'Identificador primario del vehEDculo que recibe servicios';


--
-- Name: COLUMN vehiculo.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN vehiculo.modelo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo.modelo_cod IS 'Identificador primario de un modelo de vehEDculo';


--
-- Name: COLUMN vehiculo.veh_km; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo.veh_km IS 'Cantidad de kilometraje del vehEDculo';


--
-- Name: COLUMN vehiculo.veh_color; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo.veh_color IS 'Color del vehEDculo que recibe servicios';


--
-- Name: vehiculo_serviciorep; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE vehiculo_serviciorep (
    serv_cod integer NOT NULL,
    marca_cod integer NOT NULL,
    modelo_cod integer NOT NULL,
    modelo_ano integer NOT NULL,
    sr_v_mo_pr integer,
    sr_v_in_pr integer
);


ALTER TABLE public.vehiculo_serviciorep OWNER TO seba;

--
-- Name: TABLE vehiculo_serviciorep; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON TABLE vehiculo_serviciorep IS 'Entidad que relaciona un servicio determinado con un vehEDculo, para poder guardar el precio de este. Este servicio es solo de reparaciF3n.';


--
-- Name: COLUMN vehiculo_serviciorep.serv_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo_serviciorep.serv_cod IS 'Identificador primario para los distintos servicios que presta la empresa';


--
-- Name: COLUMN vehiculo_serviciorep.marca_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo_serviciorep.marca_cod IS 'Identificar primario de las distintas marcas';


--
-- Name: COLUMN vehiculo_serviciorep.modelo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo_serviciorep.modelo_cod IS 'Identificador primario de un modelo de vehEDculo';


--
-- Name: COLUMN vehiculo_serviciorep.sr_v_mo_pr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo_serviciorep.sr_v_mo_pr IS 'Precio correspondiente a la mano de obra por un servicio de reparaciF3n a un vehEDculo determinado';


--
-- Name: COLUMN vehiculo_serviciorep.sr_v_in_pr; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN vehiculo_serviciorep.sr_v_in_pr IS 'Precio correspondiente a los insumos utilizados en un servicio de reparaciF3n';


--
-- Name: vista_accesorio; Type: VIEW; Schema: public; Owner: seba
--

CREATE VIEW vista_accesorio AS
    SELECT accesorio.art_cod, accesorio.art_tipo_cod, accesorio.art_nom, accesorio.art_stock, accesorio.art_precio, accesorio.art_imagen FROM accesorio;


ALTER TABLE public.vista_accesorio OWNER TO seba;

--
-- Name: vista_articulos_instalacion; Type: VIEW; Schema: public; Owner: seba
--

CREATE VIEW vista_articulos_instalacion AS
    SELECT para_instalacion.art_cod, para_instalacion.art_tipo_cod, para_instalacion.art_nom, para_instalacion.art_stock, para_instalacion.art_precio, para_instalacion.art_imagen FROM para_instalacion;


ALTER TABLE public.vista_articulos_instalacion OWNER TO seba;

--
-- Name: vista_repuestos; Type: VIEW; Schema: public; Owner: seba
--

CREATE VIEW vista_repuestos AS
    SELECT repuesto.art_cod, repuesto.art_tipo_cod, repuesto.art_nom, repuesto.art_stock, repuesto.art_precio, repuesto.art_imagen FROM repuesto;


ALTER TABLE public.vista_repuestos OWNER TO seba;

--
-- Name: pk_audit; Type: DEFAULT; Schema: public; Owner: seba
--

ALTER TABLE ONLY log ALTER COLUMN pk_audit SET DEFAULT nextval('tbl_audit_pk_audit_seq'::regclass);


--
-- Data for Name: accesorio; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY accesorio (art_cod, art_tipo_cod, art_nom, art_stock, art_precio, art_imagen) FROM stdin;
acc-01	2	Radio Hawk	48	25000	\N
acc-02	23	Sens HAWK	15	10000	\N
\.


--
-- Data for Name: art_hist_pre; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY art_hist_pre (art_precio, precio_desde, precio_hasta, hist_cod, art_cod) FROM stdin;
\.


--
-- Data for Name: art_prop_valor; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY art_prop_valor (prop_cod, dom_cod, art_cod, valor) FROM stdin;
\.


--
-- Data for Name: articulo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY articulo (art_cod, art_tipo_cod, art_nom, art_stock, art_precio, art_imagen) FROM stdin;
acc-02	23	Sens HAWK	15	10000	\N
CK-RK-500	21	Mango Solido	37	14000	\N
acc-01	2	Radio Hawk	45	25000	\N
Qc-200	21	Tirador Metalico	42	15000	\N
Rep-01	14	Par 01	20	40000	\N
Herr-01	7	Equalizer GripTape	10	9900	\N
Ins-01	5	Magnibond 005	21	9900	\N
\.


--
-- Data for Name: boleta; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY boleta (doc_pago_cod, doc_pago_fecha, doc_pago_obs) FROM stdin;
8	2016-03-06 03:45:56.760457	\N
\.


--
-- Data for Name: cargo_empleado; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY cargo_empleado (cargo_cod, cargo_nom) FROM stdin;
1	Vendedor
2	Jefe de Ventas
3	Jefe de Bodega
4	Jefe de Servicios
0	Administrador
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY cliente (cliente_cod, tipo_cliente_cod, cliente_nom, cliente_ape, cliente_direccion, cliente_comuna, cliente_tel, cliente_correo, cliente_emp, cliente_frecuente, cliente_rut) FROM stdin;
17	5	Pedro	Perez				pedro@perez.com	Avis	t	
23	6	sebastian	calderon	avenida santa victoria 1165	avenida santa victoria 1165	78018863	scalderon@serviventas.cl	Serviventas	t	18293486-0
24	3	Daniel 	Morales				dmorales@hotmail.com		t	18122548-6
21	5	Sebastian				\N	seba_pardo@hotmail.com	Avis	f	
18	6	Carlos		Avenida las Palmas 234	Avenida las Palmas 234	\N	Carlos.ca@live.cl		f	22333668-k
20	6	Rodrigo				\N	ro_saez@yahoo.es		f	11890333-1
25	6					\N	francisco@hotmail.com		f	
27	6	Nombre			Cerro Navia	\N	nuevo@cliente.cl		f	
28	5					\N	cliente@nuevo.cl		f	
22	3	Hugo		avenida santa victoria 6548	Pudahuel	\N	Hugo_cepeda@hotmail.com		f	
26	3	jp		jp	jp	\N	x@x.com	empresa	f	17673797-2
19	4	Ricardo	Rojas	Heraldica 9897	Heraldica 9897		Ricardo_bravo@live.cl	Automotora Continental	f	
\.


--
-- Data for Name: compatibilidad; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY compatibilidad (art_cod, marca_cod, modelo_cod, modelo_ano) FROM stdin;
\.


--
-- Data for Name: cot_odc_art; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY cot_odc_art (doc_cod, cliente_cod, not_ven_cod, emp_rut, doc_fecha, doc_obs, doc_neto, doc_iva, doc_total, doc_total_desc) FROM stdin;
1	26	11	18293486-0	2016-03-06	\N	\N	\N	14000	\N
2	27	12	18293486-0	2016-03-06	\N	\N	\N	54000	\N
\.


--
-- Data for Name: cot_odc_serv; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY cot_odc_serv (doc_cod, cliente_cod, not_ven_cod, emp_rut, doc_fecha, doc_obs, doc_neto, doc_iva, doc_total, doc_total_desc) FROM stdin;
\.


--
-- Data for Name: cotizacion; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY cotizacion (doc_cod, cot_est_cod, cliente_cod, not_ven_cod, emp_rut, doc_fecha, doc_obs, doc_neto, doc_iva, doc_total, doc_total_desc) FROM stdin;
1	1	26	11	18293486-0	2016-03-06	\N	\N	\N	14000	\N
2	1	27	12	18293486-0	2016-03-06	\N	\N	\N	54000	\N
\.


--
-- Data for Name: det_cot_odc_art; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY det_cot_odc_art (doc_cod, det_num_linea, art_cod, art_cant, art_desc, art_precio) FROM stdin;
1	1	CK-RK-500	1	\N	14000
2	1	CK-RK-500	1	\N	14000
2	2	acc-01	1	\N	25000
2	3	Qc-200	1	\N	15000
\.


--
-- Data for Name: det_ot; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY det_ot (ot_cod, ot_num_linea, serv_cod, marca_cod, modelo_cod, modelo_ano, sr_ad_precio, sr_ad_cant) FROM stdin;
\.


--
-- Data for Name: doc_previo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY doc_previo (doc_cod, cliente_cod, not_ven_cod, emp_rut, doc_fecha, doc_obs, doc_neto, doc_iva, doc_total, doc_total_desc) FROM stdin;
1	26	\N	18293486-0	2016-03-06 00:00:00	\N	\N	\N	14000	\N
2	27	\N	18293486-0	2016-03-06 00:00:00	\N	\N	\N	54000	\N
\.


--
-- Data for Name: documento_de_pago; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY documento_de_pago (doc_pago_cod, doc_pago_fecha, doc_pago_obs) FROM stdin;
2	2016-03-06 03:06:26.615339	\N
3	2016-03-06 03:07:45.539257	\N
4	2016-03-06 03:09:17.885218	\N
5	2016-03-06 03:27:49.856777	\N
6	2016-03-06 03:32:45.153702	\N
7	2016-03-06 03:33:24.021923	\N
8	2016-03-06 03:45:56.760457	\N
9	2016-03-06 05:32:11.164766	\N
10	2016-03-06 05:34:00.322679	\N
\.


--
-- Data for Name: dom_val_art; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY dom_val_art (dom_cod, dom_nom, dom_tipo, dom_min, dom_max) FROM stdin;
\.


--
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY empleado (emp_rut, cargo_cod, emp_nom, emp_ape, emp_tel, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip) FROM stdin;
18122672-2	1	Gustavo 	Aguayo	78945612	gaguayo@serviventas.cl	$2a$10$N4l/1LFP9Hy64l0ZkchOwuiga281u1qkTTCtCIZg77kGRGDNz7ucW	\N	\N	\N	1	2016-03-02 04:16:02.044437	2016-03-02 04:16:02.044437	127.0.0.1	127.0.0.1
5893349-k	0	Rodrigo	Bravo	78945612	rbravo@serviventas.cl	$2a$10$UKStv36kU9FJc.lZlOEGLuI3lHCljd1qaWxxtVQJqlkDJNdBUx2NS	\N	\N	\N	1	2016-03-02 04:16:48.807421	2016-03-02 04:16:48.807421	127.0.0.1	127.0.0.1
17673797-2	0	jp	jp		a@a.xx	$2a$10$U0yukdIzSE5T.IQu3PjGPeU0kAci4rZENfekZYwN/u8He0Fh1tl6e	\N	\N	\N	1	2016-03-02 11:27:15.785996	2016-03-02 11:27:15.785996	127.0.0.1	127.0.0.1
21882841-8	2	Karla	Bravo	78945612	kbravo@serviventas.cl	$2a$10$b18wFkVQqJ/G0..HadOdv.Cp5LWGgBYrWYrkP3knlF7VbuYV6AHJi	\N	\N	\N	5	2016-03-02 18:32:16.047217	2016-03-02 18:31:27.432664	127.0.0.1	127.0.0.1
23578433-5	1	Jorge			jorge@serviventas.cl	$2a$10$xBKqMsIwEUDjBgWdSqjhv.rz0rbt0GaReSB8EOweu8Cyfa4y1BcT.	\N	\N	\N	0	\N	\N	\N	\N
18293486-0	0	Sebastian	Calderon	78018863	scalderon@serviventas.cl	$2a$10$zgHEpX2hL4./edVCBoK3OuDmWtJN6rUaXupUQOi0hAKR5VfGcQtlK	2664509a87dfa736730d08987ca7df97da538bba69584ac913ec4b0b12397ced	2016-03-01 16:55:24.773185	\N	27	2016-03-05 21:38:45.553923	2016-03-04 13:16:36.060044	127.0.0.1	127.0.0.1
\.


--
-- Data for Name: estado_cotizacion; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY estado_cotizacion (cot_est_cod, cot_est_descr) FROM stdin;
0	Pendiente
1	Aprobada
\.


--
-- Data for Name: estado_factura; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY estado_factura (fact_est_cod, fact_est_descr) FROM stdin;
0	Pagada
\.


--
-- Data for Name: estado_nota_de_venta; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY estado_nota_de_venta (not_ven_est_cod, not_ven_est_descr) FROM stdin;
0	Pendiente
1	Pagada
\.


--
-- Data for Name: estado_oc; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY estado_oc (oc_est_cod, oc_est_descr) FROM stdin;
\.


--
-- Data for Name: estado_od; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY estado_od (od_est_cod, od_est_descr) FROM stdin;
\.


--
-- Data for Name: estado_ot; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY estado_ot (ot_est_cod, ot_est_descr) FROM stdin;
\.


--
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY factura (doc_pago_cod, fact_est_cod, doc_pago_fecha, doc_pago_obs) FROM stdin;
4	0	2016-03-06 03:09:17.885218	\N
5	0	2016-03-06 03:27:49.856777	\N
6	0	2016-03-06 03:32:45.153702	\N
7	0	2016-03-06 03:33:24.021923	\N
9	0	2016-03-06 05:32:11.164766	\N
10	0	2016-03-06 05:34:00.322679	\N
\.


--
-- Data for Name: herramienta; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY herramienta (art_cod, art_tipo_cod, art_nom, art_stock, art_precio, art_imagen) FROM stdin;
CK-RK-500	21	Mango Solido	37	14000	\N
Qc-200	21	Tirador Metalico	42	15000	\N
Herr-01	7	Equalizer GripTape	20	9900	\N
\.


--
-- Data for Name: hist_est_cot; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY hist_est_cot (doc_cod, cot_est_cod, cot_estado_desde, cot_estado_hasta) FROM stdin;
\.


--
-- Data for Name: hist_est_fact; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY hist_est_fact (fact_est_cod, doc_pago_cod, fact_estado_desde, fact_estado_hasta) FROM stdin;
0	4	2016-03-06	\N
0	5	2016-03-06	\N
0	6	2016-03-06	\N
0	7	2016-03-06	\N
0	9	2016-03-06	\N
0	10	2016-03-06	\N
\.


--
-- Data for Name: hist_est_nv; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY hist_est_nv (not_ven_cod, not_ven_est_cod, not_ven_estado_desde, not_ven_estado_hasta) FROM stdin;
\.


--
-- Data for Name: hist_est_oc; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY hist_est_oc (doc_cod, oc_est_cod, oc_estado_desde, oc_estado_hasta) FROM stdin;
\.


--
-- Data for Name: hist_est_od; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY hist_est_od (od_cod, od_est_cod, od_estado_desde, od_estado_hasta) FROM stdin;
\.


--
-- Data for Name: hist_est_ot; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY hist_est_ot (ot_cod, ot_est_cod, ot_estado_desde, ot_estado_hasta) FROM stdin;
\.


--
-- Data for Name: insumo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY insumo (art_cod, art_tipo_cod, art_nom, art_stock, art_precio, art_imagen) FROM stdin;
Ins-01	5	Magnibond 005	21	9900	\N
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY log (pk_audit, "TableName", "Operation", "OldValue", "NewValue", "UpdateDate", "UserName") FROM stdin;
349	servicio_reparacion                          	D	(4,Piquetes)	\N	2016-03-03 20:29:33.35914	seba                                         
350	si_vehiculo_articulo                         	I	\N	(asd2,1,5,2005,,)	2016-03-04 02:00:12.837584	seba                                         
351	si_vehiculo_articulo                         	I	\N	(codigo-10,1,5,2005,,)	2016-03-04 03:12:05.739426	seba                                         
352	si_vehiculo_articulo                         	I	\N	(codigo-10,4,11,2012,,)	2016-03-04 04:03:08.648774	seba                                         
353	si_vehiculo_articulo                         	I	\N	(codigo-10,4,10,2011,10000,10000)	2016-03-04 04:05:49.90404	seba                                         
354	si_vehiculo_articulo                         	D	(asd2,1,5,2005,,)	\N	2016-03-04 01:06:10.830159	seba                                         
355	si_vehiculo_articulo                         	D	(codigo-10,1,5,2005,,)	\N	2016-03-04 01:06:17.477119	seba                                         
356	si_vehiculo_articulo                         	D	(codigo-10,4,10,2011,10000,10000)	\N	2016-03-04 01:06:21.933247	seba                                         
357	si_vehiculo_articulo                         	D	(codigo-10,4,11,2012,,)	\N	2016-03-04 01:06:26.967581	seba                                         
358	si_vehiculo_articulo                         	I	\N	(codigo-10,3,6,1999,15000,5000)	2016-03-04 04:07:02.867091	seba                                         
359	si_vehiculo_articulo                         	I	\N	(asd2,2,3,2017,5000,3000)	2016-03-04 04:07:25.334114	seba                                         
360	si_vehiculo_articulo                         	I	\N	(asd2,4,9,2010,5000,5000)	2016-03-04 04:07:38.628526	seba                                         
363	si_vehiculo_articulo                         	D	(asd2,2,3,2017,5000,3000,)	\N	2016-03-04 13:08:19.228941	seba                                         
364	si_vehiculo_articulo                         	D	(codigo-10,3,6,1999,15000,5000,)	\N	2016-03-04 13:08:23.927582	seba                                         
365	si_vehiculo_articulo                         	D	(asd2,4,9,2010,5000,5000,)	\N	2016-03-04 13:08:29.705426	seba                                         
366	si_vehiculo_articulo                         	I	\N	(codigo-10,4,11,2012,10000,5000,1)	2016-03-04 16:10:56.312463	seba                                         
367	si_vehiculo_articulo                         	I	\N	(asd2,4,7,2015,10000,10000,2)	2016-03-04 16:27:56.200017	seba                                         
368	si_vehiculo_articulo                         	I	\N	(asd2,4,9,2010,5000,10000,3)	2016-03-04 16:28:11.779379	seba                                         
369	doc_previo                                   	I	\N	(62,22,,18293486-0,2016-03-04,,,,140000,)	2016-03-04 20:41:52.723275	seba                                         
370	doc_previo                                   	D	(55,21,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:18.902694	seba                                         
371	cotizacion                                   	D	(55,0,21,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:18.902694	seba                                         
372	hist_est_cot                                 	D	(55,0,2016-02-29,)	\N	2016-03-04 17:50:18.902694	seba                                         
373	doc_previo                                   	D	(56,18,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:23.328804	seba                                         
374	cotizacion                                   	D	(56,0,18,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:23.328804	seba                                         
375	hist_est_cot                                 	D	(56,0,2016-02-29,)	\N	2016-03-04 17:50:23.328804	seba                                         
376	doc_previo                                   	D	(57,19,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:26.320473	seba                                         
377	cotizacion                                   	D	(57,0,19,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:26.320473	seba                                         
378	hist_est_cot                                 	D	(57,0,2016-02-29,)	\N	2016-03-04 17:50:26.320473	seba                                         
379	doc_previo                                   	D	(58,20,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:29.481846	seba                                         
380	cotizacion                                   	D	(58,0,20,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:29.481846	seba                                         
381	hist_est_cot                                 	D	(58,0,2016-02-29,)	\N	2016-03-04 17:50:29.481846	seba                                         
382	doc_previo                                   	D	(59,22,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:32.359003	seba                                         
383	cotizacion                                   	D	(59,0,22,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:32.359003	seba                                         
384	hist_est_cot                                 	D	(59,0,2016-02-29,)	\N	2016-03-04 17:50:32.359003	seba                                         
385	doc_previo                                   	D	(60,25,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:35.161368	seba                                         
386	cotizacion                                   	D	(60,0,,,18293486-0,2016-02-29,,,,,)	\N	2016-03-04 17:50:35.161368	seba                                         
387	hist_est_cot                                 	D	(60,0,2016-02-29,)	\N	2016-03-04 17:50:35.161368	seba                                         
388	doc_previo                                   	D	(61,26,,17673797-2,2016-03-02,,,,,)	\N	2016-03-04 17:50:38.046869	seba                                         
389	cotizacion                                   	D	(61,0,,,17673797-2,2016-03-02,,,,,)	\N	2016-03-04 17:50:38.046869	seba                                         
390	hist_est_cot                                 	D	(61,0,2016-03-02,)	\N	2016-03-04 17:50:38.046869	seba                                         
391	doc_previo                                   	D	(62,22,,18293486-0,2016-03-04,,,,140000,)	\N	2016-03-04 17:50:41.350791	seba                                         
392	doc_previo                                   	I	\N	(1,22,,18293486-0,2016-03-04,,,,140000,)	2016-03-04 20:56:04.668692	seba                                         
393	hist_est_cot                                 	I	\N	(1,0,2016-03-04,)	2016-03-04 20:56:04.668692	seba                                         
394	cotizacion                                   	I	\N	(1,0,22,,18293486-0,2016-03-04,,,,140000,)	2016-03-04 20:56:04.668692	seba                                         
395	cliente                                      	I	\N	(27,7,"","","","",,nuevo@cliente.cl,"",f,"")	2016-03-04 21:09:01.596286	seba                                         
396	doc_previo                                   	I	\N	(2,27,,18293486-0,2016-03-04,,,,155000,)	2016-03-04 21:09:01.596286	seba                                         
397	hist_est_cot                                 	I	\N	(2,0,2016-03-04,)	2016-03-04 21:09:01.596286	seba                                         
398	cotizacion                                   	I	\N	(2,0,27,,18293486-0,2016-03-04,,,,155000,)	2016-03-04 21:09:01.596286	seba                                         
399	doc_previo                                   	I	\N	(3,22,,18293486-0,2016-03-04,,,,195000,)	2016-03-04 21:26:09.637001	seba                                         
400	hist_est_cot                                 	I	\N	(3,0,2016-03-04,)	2016-03-04 21:26:09.637001	seba                                         
401	cotizacion                                   	I	\N	(3,0,22,,18293486-0,2016-03-04,,,,195000,)	2016-03-04 21:26:09.637001	seba                                         
402	serv_inst_det                                	I	\N	(3,0,4,asd2,7,2015,)	2016-03-04 21:26:09.940749	seba                                         
403	serv_inst_det                                	I	\N	(3,1,4,asd2,9,2010,)	2016-03-04 21:26:10.074295	seba                                         
404	serv_inst_det                                	I	\N	(3,2,4,codigo-10,11,2012,)	2016-03-04 21:26:10.129981	seba                                         
405	doc_previo                                   	I	\N	(4,22,,18293486-0,2016-03-04,,,,5,)	2016-03-05 01:39:46.871729	seba                                         
406	hist_est_cot                                 	I	\N	(4,0,2016-03-05,)	2016-03-05 01:39:46.871729	seba                                         
407	cotizacion                                   	I	\N	(4,0,22,,18293486-0,2016-03-04,,,,5,)	2016-03-05 01:39:46.871729	seba                                         
408	doc_previo                                   	I	\N	(5,22,,18293486-0,2016-03-04,,,,5,)	2016-03-05 01:40:32.148151	seba                                         
409	hist_est_cot                                 	I	\N	(5,0,2016-03-05,)	2016-03-05 01:40:32.148151	seba                                         
410	cotizacion                                   	I	\N	(5,0,22,,18293486-0,2016-03-04,,,,5,)	2016-03-05 01:40:32.148151	seba                                         
411	doc_previo                                   	I	\N	(6,22,,18293486-0,2016-03-04,,,,5,)	2016-03-05 01:40:46.890589	seba                                         
412	hist_est_cot                                 	I	\N	(6,0,2016-03-05,)	2016-03-05 01:40:46.890589	seba                                         
413	cotizacion                                   	I	\N	(6,0,22,,18293486-0,2016-03-04,,,,5,)	2016-03-05 01:40:46.890589	seba                                         
414	doc_previo                                   	I	\N	(7,22,,18293486-0,2016-03-04,,,,5,)	2016-03-05 01:41:05.059955	seba                                         
415	hist_est_cot                                 	I	\N	(7,0,2016-03-05,)	2016-03-05 01:41:05.059955	seba                                         
416	cotizacion                                   	I	\N	(7,0,22,,18293486-0,2016-03-04,,,,5,)	2016-03-05 01:41:05.059955	seba                                         
417	det_cot_odc_art                              	I	\N	(7,1,asd2,2,)	2016-03-05 01:41:05.075185	seba                                         
418	det_cot_odc_art                              	I	\N	(7,2," PKXL",2,)	2016-03-05 01:41:05.115911	seba                                         
419	det_cot_odc_art                              	I	\N	(7,3," Qc-200",1,)	2016-03-05 01:41:05.126813	seba                                         
420	doc_previo                                   	D	(1,22,,18293486-0,2016-03-04,,,,140000,)	\N	2016-03-04 22:53:18.132885	seba                                         
421	cotizacion                                   	D	(1,0,22,,18293486-0,2016-03-04,,,,140000,)	\N	2016-03-04 22:53:18.132885	seba                                         
422	hist_est_cot                                 	D	(1,0,2016-03-04,)	\N	2016-03-04 22:53:18.132885	seba                                         
423	doc_previo                                   	D	(2,27,,18293486-0,2016-03-04,,,,155000,)	\N	2016-03-04 22:53:26.255435	seba                                         
424	cotizacion                                   	D	(2,0,27,,18293486-0,2016-03-04,,,,155000,)	\N	2016-03-04 22:53:26.255435	seba                                         
425	hist_est_cot                                 	D	(2,0,2016-03-04,)	\N	2016-03-04 22:53:26.255435	seba                                         
426	doc_previo                                   	D	(3,22,,18293486-0,2016-03-04,,,,195000,)	\N	2016-03-04 22:53:31.731842	seba                                         
427	cotizacion                                   	D	(3,0,22,,18293486-0,2016-03-04,,,,195000,)	\N	2016-03-04 22:53:31.731842	seba                                         
428	hist_est_cot                                 	D	(3,0,2016-03-04,)	\N	2016-03-04 22:53:31.731842	seba                                         
429	serv_inst_det                                	D	(3,0,4,asd2,7,2015,,)	\N	2016-03-04 22:53:31.731842	seba                                         
430	serv_inst_det                                	D	(3,1,4,asd2,9,2010,,)	\N	2016-03-04 22:53:31.731842	seba                                         
431	serv_inst_det                                	D	(3,2,4,codigo-10,11,2012,,)	\N	2016-03-04 22:53:31.731842	seba                                         
432	doc_previo                                   	D	(4,22,,18293486-0,2016-03-04,,,,5,)	\N	2016-03-05 00:12:24.208906	seba                                         
433	cotizacion                                   	D	(4,0,22,,18293486-0,2016-03-04,,,,5,)	\N	2016-03-05 00:12:24.208906	seba                                         
434	hist_est_cot                                 	D	(4,0,2016-03-05,)	\N	2016-03-05 00:12:24.208906	seba                                         
435	doc_previo                                   	D	(5,22,,18293486-0,2016-03-04,,,,5,)	\N	2016-03-05 00:12:29.997004	seba                                         
436	cotizacion                                   	D	(5,0,22,,18293486-0,2016-03-04,,,,5,)	\N	2016-03-05 00:12:29.997004	seba                                         
437	hist_est_cot                                 	D	(5,0,2016-03-05,)	\N	2016-03-05 00:12:29.997004	seba                                         
438	doc_previo                                   	D	(6,22,,18293486-0,2016-03-04,,,,5,)	\N	2016-03-05 00:12:34.496253	seba                                         
439	cotizacion                                   	D	(6,0,22,,18293486-0,2016-03-04,,,,5,)	\N	2016-03-05 00:12:34.496253	seba                                         
440	hist_est_cot                                 	D	(6,0,2016-03-05,)	\N	2016-03-05 00:12:34.496253	seba                                         
441	doc_previo                                   	D	(7,22,,18293486-0,2016-03-04,,,,5,)	\N	2016-03-05 00:12:41.178849	seba                                         
442	cotizacion                                   	D	(7,0,22,,18293486-0,2016-03-04,,,,5,)	\N	2016-03-05 00:12:41.178849	seba                                         
443	det_cot_odc_art                              	D	(7,1,asd2,2,)	\N	2016-03-05 00:12:41.178849	seba                                         
444	det_cot_odc_art                              	D	(7,2," PKXL",2,)	\N	2016-03-05 00:12:41.178849	seba                                         
445	det_cot_odc_art                              	D	(7,3," Qc-200",1,)	\N	2016-03-05 00:12:41.178849	seba                                         
446	hist_est_cot                                 	D	(7,0,2016-03-05,)	\N	2016-03-05 00:12:41.178849	seba                                         
447	si_vehiculo_articulo                         	D	(asd2,4,7,2015,10000,10000,2)	\N	2016-03-05 00:15:24.737348	seba                                         
448	si_vehiculo_articulo                         	D	(asd2,4,9,2010,5000,10000,3)	\N	2016-03-05 00:15:24.737348	seba                                         
449	si_vehiculo_articulo                         	U	(codigo-10,4,11,2012,10000,5000,1)	(asd,4,11,2012,10000,5000,1)	2016-03-05 00:15:40.3089	seba                                         
450	si_vehiculo_articulo                         	D	(asd,4,11,2012,10000,5000,1)	\N	2016-03-05 00:15:47.331027	seba                                         
451	tipo_articulo                                	D	(11,Piola2)	\N	2016-03-05 16:03:05.479321	seba                                         
452	tipo_articulo                                	I	\N	(18,Esmalte)	2016-03-05 16:05:38.430927	seba                                         
453	tipo_articulo                                	U	(2,Espada)	(2,Espada2)	2016-03-05 16:08:33.400338	seba                                         
454	tipo_articulo                                	U	(2,Espada2)	(2,Espada)	2016-03-05 16:08:40.078876	seba                                         
455	tipo_articulo                                	I	\N	(19,Ampolleta)	2016-03-05 16:08:57.48481	seba                                         
456	tipo_articulo                                	I	\N	(20,Kit)	2016-03-05 16:09:49.452524	seba                                         
457	tipo_articulo                                	I	\N	(21,Tirador)	2016-03-05 16:12:46.664432	seba                                         
458	cliente                                      	U	(27,7,"","","","",,nuevo@cliente.cl,"",f,"")	(27,6,Nombre,"","","Cerro Navia",,nuevo@cliente.cl,"",f,"")	2016-03-05 16:17:41.009844	seba                                         
459	doc_previo                                   	I	\N	(1,27,,18293486-0,2016-03-05,,,,30000,)	2016-03-05 16:17:41.009844	seba                                         
460	hist_est_cot                                 	I	\N	(1,0,2016-03-05,)	2016-03-05 16:17:41.009844	seba                                         
461	cotizacion                                   	I	\N	(1,0,27,,18293486-0,2016-03-05,,,,30000,)	2016-03-05 16:17:41.009844	seba                                         
462	det_cot_odc_art                              	I	\N	(1,1,Qc-200,2,)	2016-03-05 16:17:41.077628	seba                                         
465	hist_est_cot                                 	U	(1,0,2016-03-05,)	(1,0,2016-03-05,2016-03-05)	2016-03-05 16:28:40.787614	seba                                         
466	hist_est_cot                                 	I	\N	(1,1,2016-03-05,)	2016-03-05 16:28:40.787614	seba                                         
469	hist_est_cot                                 	D	(1,1,2016-03-05,)	\N	2016-03-05 13:36:21.461678	seba                                         
470	hist_est_cot                                 	U	(1,0,2016-03-05,2016-03-05)	(1,0,2016-03-05,2016-03-05)	2016-03-05 16:36:38.130089	seba                                         
471	hist_est_cot                                 	I	\N	(1,1,2016-03-05,)	2016-03-05 16:36:38.130089	seba                                         
472	hist_est_cot                                 	D	(1,1,2016-03-05,)	\N	2016-03-05 13:37:31.774221	seba                                         
473	hist_est_cot                                 	U	(1,0,2016-03-05,2016-03-05)	(1,0,2016-03-05,2016-03-05)	2016-03-05 16:39:19.644752	seba                                         
474	hist_est_cot                                 	I	\N	(1,1,2016-03-05,)	2016-03-05 16:39:19.644752	seba                                         
475	cotizacion                                   	U	(1,0,27,,18293486-0,2016-03-05,,,,30000,)	(1,1,27,,18293486-0,2016-03-05,,,,30000,)	2016-03-05 16:39:19.644752	seba                                         
476	doc_previo                                   	D	(1,27,,18293486-0,2016-03-05,,,,30000,)	\N	2016-03-05 16:57:09.310998	seba                                         
477	cotizacion                                   	D	(1,1,27,,18293486-0,2016-03-05,,,,30000,)	\N	2016-03-05 16:57:09.310998	seba                                         
478	det_cot_odc_art                              	D	(1,1,Qc-200,2,)	\N	2016-03-05 16:57:09.310998	seba                                         
479	hist_est_cot                                 	D	(1,0,2016-03-05,2016-03-05)	\N	2016-03-05 16:57:09.310998	seba                                         
480	hist_est_cot                                 	D	(1,1,2016-03-05,)	\N	2016-03-05 16:57:09.310998	seba                                         
481	cliente                                      	I	\N	(28,5,"","","","",,cliente@nuevo.cl,"",f,"")	2016-03-05 17:10:59.505395	seba                                         
482	doc_previo                                   	I	\N	(1,28,,18293486-0,2016-03-05,,,,69000,)	2016-03-05 17:10:59.505395	seba                                         
483	hist_est_cot                                 	I	\N	(1,0,2016-03-05,)	2016-03-05 17:10:59.505395	seba                                         
484	cotizacion                                   	I	\N	(1,0,28,,18293486-0,2016-03-05,,,,69000,)	2016-03-05 17:10:59.505395	seba                                         
485	det_cot_odc_art                              	I	\N	(1,1,RK-160,2,)	2016-03-05 17:10:59.712765	seba                                         
486	det_cot_odc_art                              	I	\N	(1,2,CK-RK-500,1,)	2016-03-05 17:10:59.758538	seba                                         
487	det_cot_odc_art                              	I	\N	(1,3,Qc-200,1,)	2016-03-05 17:10:59.803011	seba                                         
488	doc_previo                                   	D	(1,28,,18293486-0,2016-03-05,,,,69000,)	\N	2016-03-05 17:13:24.995926	seba                                         
489	cotizacion                                   	D	(1,0,28,,18293486-0,2016-03-05,,,,69000,)	\N	2016-03-05 17:13:24.995926	seba                                         
490	det_cot_odc_art                              	D	(1,1,RK-160,2,)	\N	2016-03-05 17:13:24.995926	seba                                         
491	det_cot_odc_art                              	D	(1,2,CK-RK-500,1,)	\N	2016-03-05 17:13:24.995926	seba                                         
492	det_cot_odc_art                              	D	(1,3,Qc-200,1,)	\N	2016-03-05 17:13:24.995926	seba                                         
493	hist_est_cot                                 	D	(1,0,2016-03-05,)	\N	2016-03-05 17:13:24.995926	seba                                         
494	cliente                                      	U	(22,3,Hugo,"","avenida santa victoria 6548","avenida santa victoria 6548",,Hugo_cepeda@hotmail.com,"",f,"")	(22,3,Hugo,"","avenida santa victoria 6548",Pudahuel,,Hugo_cepeda@hotmail.com,"",f,"")	2016-03-05 18:42:17.897156	seba                                         
495	doc_previo                                   	I	\N	(1,22,,18293486-0,2016-03-05,,,,40000,)	2016-03-05 18:42:17.897156	seba                                         
496	hist_est_cot                                 	I	\N	(1,0,2016-03-05,)	2016-03-05 18:42:17.897156	seba                                         
497	cotizacion                                   	I	\N	(1,0,22,,18293486-0,2016-03-05,,,,40000,)	2016-03-05 18:42:17.897156	seba                                         
498	det_cot_odc_art                              	I	\N	(1,1,RK-160,2,)	2016-03-05 18:42:18.028302	seba                                         
499	hist_est_cot                                 	U	(1,0,2016-03-05,)	(1,0,2016-03-05,2016-03-05)	2016-03-05 18:42:20.806572	seba                                         
500	hist_est_cot                                 	I	\N	(1,1,2016-03-05,)	2016-03-05 18:42:20.806572	seba                                         
501	cotizacion                                   	U	(1,0,22,,18293486-0,2016-03-05,,,,40000,)	(1,1,22,,18293486-0,2016-03-05,,,,40000,)	2016-03-05 18:42:20.806572	seba                                         
502	doc_previo                                   	D	(1,22,,18293486-0,2016-03-05,,,,40000,)	\N	2016-03-05 18:43:10.495796	seba                                         
503	cotizacion                                   	D	(1,1,22,,18293486-0,2016-03-05,,,,40000,)	\N	2016-03-05 18:43:10.495796	seba                                         
504	det_cot_odc_art                              	D	(1,1,RK-160,2,)	\N	2016-03-05 18:43:10.495796	seba                                         
505	hist_est_cot                                 	D	(1,0,"2016-03-05 00:00:00","2016-03-05 00:00:00")	\N	2016-03-05 18:43:10.495796	seba                                         
506	hist_est_cot                                 	D	(1,1,"2016-03-05 00:00:00",)	\N	2016-03-05 18:43:10.495796	seba                                         
507	doc_previo                                   	I	\N	(1,22,,18293486-0,2016-03-05,,,,15000,)	2016-03-05 18:43:45.961116	seba                                         
508	hist_est_cot                                 	I	\N	(1,0,"2016-03-05 18:43:45.961116",)	2016-03-05 18:43:45.961116	seba                                         
509	cotizacion                                   	I	\N	(1,0,22,,18293486-0,2016-03-05,,,,15000,)	2016-03-05 18:43:45.961116	seba                                         
510	det_cot_odc_art                              	I	\N	(1,1,Qc-200,1,)	2016-03-05 18:43:46.027095	seba                                         
511	hist_est_cot                                 	U	(1,0,"2016-03-05 18:43:45.961116",)	(1,0,"2016-03-05 18:43:45.961116","2016-03-05 18:43:48.716607")	2016-03-05 18:43:48.716607	seba                                         
512	hist_est_cot                                 	I	\N	(1,1,"2016-03-05 18:43:48.716607",)	2016-03-05 18:43:48.716607	seba                                         
513	cotizacion                                   	U	(1,0,22,,18293486-0,2016-03-05,,,,15000,)	(1,1,22,,18293486-0,2016-03-05,,,,15000,)	2016-03-05 18:43:48.716607	seba                                         
514	doc_previo                                   	D	(1,22,,18293486-0,2016-03-05,,,,15000,)	\N	2016-03-05 18:44:17.960134	seba                                         
515	cotizacion                                   	D	(1,1,22,,18293486-0,2016-03-05,,,,15000,)	\N	2016-03-05 18:44:17.960134	seba                                         
516	det_cot_odc_art                              	D	(1,1,Qc-200,1,)	\N	2016-03-05 18:44:17.960134	seba                                         
517	hist_est_cot                                 	D	(1,0,"2016-03-05 18:43:45.961116","2016-03-05 18:43:48.716607")	\N	2016-03-05 18:44:17.960134	seba                                         
518	hist_est_cot                                 	D	(1,1,"2016-03-05 18:43:48.716607",)	\N	2016-03-05 18:44:17.960134	seba                                         
519	doc_previo                                   	I	\N	(1,21,,18293486-0,2016-03-05,,,,98000,)	2016-03-05 18:44:43.382707	seba                                         
520	hist_est_cot                                 	I	\N	(1,0,"2016-03-05 18:44:43.382707",)	2016-03-05 18:44:43.382707	seba                                         
521	cotizacion                                   	I	\N	(1,0,21,,18293486-0,2016-03-05,,,,98000,)	2016-03-05 18:44:43.382707	seba                                         
522	det_cot_odc_art                              	I	\N	(1,1,Qc-200,2,)	2016-03-05 18:44:43.428131	seba                                         
523	det_cot_odc_art                              	I	\N	(1,2,RK-160,2,)	2016-03-05 18:44:43.463658	seba                                         
524	det_cot_odc_art                              	I	\N	(1,3,CK-RK-500,2,)	2016-03-05 18:44:43.495133	seba                                         
525	empleado                                     	U	(18293486-0,0,Sebastian,Calderon,78018863,scalderon@serviventas.cl,$2a$10$zgHEpX2hL4./edVCBoK3OuDmWtJN6rUaXupUQOi0hAKR5VfGcQtlK,2664509a87dfa736730d08987ca7df97da538bba69584ac913ec4b0b12397ced,"2016-03-01 16:55:24.773185",,26,"2016-03-04 13:16:36.060044","2016-03-04 04:22:36.025319",127.0.0.1,127.0.0.1)	(18293486-0,0,Sebastian,Calderon,78018863,scalderon@serviventas.cl,$2a$10$zgHEpX2hL4./edVCBoK3OuDmWtJN6rUaXupUQOi0hAKR5VfGcQtlK,2664509a87dfa736730d08987ca7df97da538bba69584ac913ec4b0b12397ced,"2016-03-01 16:55:24.773185",,27,"2016-03-05 21:38:45.553923","2016-03-04 13:16:36.060044",127.0.0.1,127.0.0.1)	2016-03-05 21:38:45.554868	seba                                         
526	estado_nota_de_venta                         	I	\N	(0,Pendiente)	2016-03-05 18:50:23.798605	seba                                         
527	estado_nota_de_venta                         	I	\N	(1,Pagada)	2016-03-05 18:50:28.943943	seba                                         
541	hist_est_cot                                 	U	(1,0,"2016-03-05 18:44:43.382707",)	(1,0,"2016-03-05 18:44:43.382707","2016-03-05 22:05:11.682128")	2016-03-05 22:05:11.682128	seba                                         
542	hist_est_cot                                 	I	\N	(1,1,"2016-03-05 22:05:11.682128",)	2016-03-05 22:05:11.682128	seba                                         
543	cotizacion                                   	U	(1,0,21,,18293486-0,2016-03-05,,,,98000,)	(1,1,21,,18293486-0,2016-03-05,,,,98000,)	2016-03-05 22:05:11.682128	seba                                         
544	hist_est_nv                                  	I	\N	(3,0,"2016-03-05 22:05:11.682128",)	2016-03-05 22:05:11.682128	seba                                         
545	nota_de_venta                                	I	\N	(3,,0,,,"2016-03-05 22:05:11.682128",,1)	2016-03-05 22:05:11.682128	seba                                         
546	nota_de_venta                                	D	(3,,0,,,"2016-03-05 22:05:11.682128",,1)	\N	2016-03-05 19:19:17.892722	seba                                         
547	hist_est_nv                                  	D	(3,0,"2016-03-05 22:05:11.682128",)	\N	2016-03-05 19:19:17.892722	seba                                         
548	doc_previo                                   	D	(1,21,,18293486-0,2016-03-05,,,,98000,)	\N	2016-03-05 22:19:43.130935	seba                                         
549	cotizacion                                   	D	(1,1,21,,18293486-0,2016-03-05,,,,98000,)	\N	2016-03-05 22:19:43.130935	seba                                         
550	det_cot_odc_art                              	D	(1,1,Qc-200,2,)	\N	2016-03-05 22:19:43.130935	seba                                         
551	det_cot_odc_art                              	D	(1,2,RK-160,2,)	\N	2016-03-05 22:19:43.130935	seba                                         
552	det_cot_odc_art                              	D	(1,3,CK-RK-500,2,)	\N	2016-03-05 22:19:43.130935	seba                                         
553	hist_est_cot                                 	D	(1,0,"2016-03-05 18:44:43.382707","2016-03-05 22:05:11.682128")	\N	2016-03-05 22:19:43.130935	seba                                         
554	hist_est_cot                                 	D	(1,1,"2016-03-05 22:05:11.682128",)	\N	2016-03-05 22:19:43.130935	seba                                         
555	doc_previo                                   	I	\N	(1,22,,18293486-0,2016-03-05,,,,20000,)	2016-03-05 22:19:53.165745	seba                                         
556	hist_est_cot                                 	I	\N	(1,0,"2016-03-05 22:19:53.165745",)	2016-03-05 22:19:53.165745	seba                                         
557	cotizacion                                   	I	\N	(1,0,22,,18293486-0,2016-03-05,,,,20000,)	2016-03-05 22:19:53.165745	seba                                         
558	det_cot_odc_art                              	I	\N	(1,1,RK-160,1,)	2016-03-05 22:19:53.440567	seba                                         
559	hist_est_cot                                 	U	(1,0,"2016-03-05 22:19:53.165745",)	(1,0,"2016-03-05 22:19:53.165745","2016-03-05 22:19:55.847689")	2016-03-05 22:19:55.847689	seba                                         
560	hist_est_cot                                 	I	\N	(1,1,"2016-03-05 22:19:55.847689",)	2016-03-05 22:19:55.847689	seba                                         
561	cotizacion                                   	U	(1,0,22,,18293486-0,2016-03-05,,,,20000,)	(1,1,22,,18293486-0,2016-03-05,,,,20000,)	2016-03-05 22:19:55.847689	seba                                         
562	hist_est_nv                                  	I	\N	(4,0,"2016-03-05 22:19:55.847689",)	2016-03-05 22:19:55.847689	seba                                         
563	nota_de_venta                                	I	\N	(4,,0,,,"2016-03-05 22:19:55.847689",,1)	2016-03-05 22:19:55.847689	seba                                         
564	cotizacion                                   	U	(1,1,22,,18293486-0,2016-03-05,,,,20000,)	(1,1,22,4,18293486-0,2016-03-05,,,,20000,)	2016-03-05 22:22:46.146627	seba                                         
565	nota_de_venta                                	D	(4,,0,,,"2016-03-05 22:19:55.847689",,1)	\N	2016-03-05 19:36:03.581932	seba                                         
566	hist_est_nv                                  	D	(4,0,"2016-03-05 22:19:55.847689",)	\N	2016-03-05 19:36:03.581932	seba                                         
567	doc_previo                                   	D	(1,22,,18293486-0,2016-03-05,,,,20000,)	\N	2016-03-05 22:37:08.980205	seba                                         
568	cotizacion                                   	D	(1,1,22,4,18293486-0,2016-03-05,,,,20000,)	\N	2016-03-05 22:37:08.980205	seba                                         
569	det_cot_odc_art                              	D	(1,1,RK-160,1,)	\N	2016-03-05 22:37:08.980205	seba                                         
612	nota_de_venta                                	I	\N	(6,,0,,,"2016-03-06 01:38:59.47779",,1)	2016-03-06 01:38:59.47779	seba                                         
570	hist_est_cot                                 	D	(1,0,"2016-03-05 22:19:53.165745","2016-03-05 22:19:55.847689")	\N	2016-03-05 22:37:08.980205	seba                                         
571	hist_est_cot                                 	D	(1,1,"2016-03-05 22:19:55.847689",)	\N	2016-03-05 22:37:08.980205	seba                                         
572	doc_previo                                   	I	\N	(1,22,,18293486-0,2016-03-05,,,,14000,)	2016-03-05 22:37:19.917268	seba                                         
573	hist_est_cot                                 	I	\N	(1,0,"2016-03-05 22:37:19.917268",)	2016-03-05 22:37:19.917268	seba                                         
574	cotizacion                                   	I	\N	(1,0,22,,18293486-0,2016-03-05,,,,14000,)	2016-03-05 22:37:19.917268	seba                                         
575	det_cot_odc_art                              	I	\N	(1,1,CK-RK-500,1,)	2016-03-05 22:37:19.964349	seba                                         
576	hist_est_cot                                 	U	(1,0,"2016-03-05 22:37:19.917268",)	(1,0,"2016-03-05 22:37:19.917268","2016-03-05 22:37:26.228178")	2016-03-05 22:37:26.228178	seba                                         
577	hist_est_cot                                 	I	\N	(1,1,"2016-03-05 22:37:26.228178",)	2016-03-05 22:37:26.228178	seba                                         
578	cotizacion                                   	U	(1,0,22,,18293486-0,2016-03-05,,,,14000,)	(1,1,22,,18293486-0,2016-03-05,,,,14000,)	2016-03-05 22:37:26.228178	seba                                         
579	hist_est_nv                                  	I	\N	(5,0,"2016-03-05 22:37:26.228178",)	2016-03-05 22:37:26.228178	seba                                         
580	nota_de_venta                                	I	\N	(5,,0,,,"2016-03-05 22:37:26.228178",,1)	2016-03-05 22:37:26.228178	seba                                         
581	cotizacion                                   	U	(1,1,22,,18293486-0,2016-03-05,,,,14000,)	(1,1,22,5,18293486-0,2016-03-05,,,,14000,)	2016-03-05 22:37:43.31449	seba                                         
584	hist_est_nv                                  	U	(5,0,"2016-03-05 22:37:26.228178",)	(5,0,"2016-03-05 22:37:26.228178","2016-03-06 00:36:06.384466")	2016-03-06 00:36:06.384466	seba                                         
585	hist_est_nv                                  	I	\N	(5,1,"2016-03-06 00:36:06.384466",)	2016-03-06 00:36:06.384466	seba                                         
586	nota_de_venta                                	U	(5,,0,,,"2016-03-05 22:37:26.228178",,1)	(5,,1,,,"2016-03-05 22:37:26.228178",,1)	2016-03-06 00:36:06.384466	seba                                         
587	metodo_de_pago                               	I	\N	(0,Transferencia)	2016-03-05 22:13:23.342357	seba                                         
588	metodo_de_pago                               	I	\N	(1,Efectivo)	2016-03-05 22:13:28.030115	seba                                         
589	metodo_de_pago                               	I	\N	(2,Cheque)	2016-03-05 22:13:31.0644	seba                                         
590	metodo_de_pago                               	I	\N	(3,"Tarjeta de Credito")	2016-03-05 22:15:28.001221	seba                                         
596	nota_de_venta                                	D	(5,,1,,,"2016-03-05 22:37:26.228178",,1)	\N	2016-03-05 22:36:58.445272	seba                                         
597	hist_est_nv                                  	D	(5,0,"2016-03-05 22:37:26.228178","2016-03-06 00:36:06.384466")	\N	2016-03-05 22:36:58.445272	seba                                         
598	hist_est_nv                                  	D	(5,1,"2016-03-06 00:36:06.384466",)	\N	2016-03-05 22:36:58.445272	seba                                         
599	doc_previo                                   	D	(1,22,,18293486-0,"2016-03-05 00:00:00",,,,14000,)	\N	2016-03-06 01:37:40.093976	seba                                         
600	cotizacion                                   	D	(1,1,22,5,18293486-0,2016-03-05,,,,14000,)	\N	2016-03-06 01:37:40.093976	seba                                         
601	det_cot_odc_art                              	D	(1,1,CK-RK-500,1,)	\N	2016-03-06 01:37:40.093976	seba                                         
602	hist_est_cot                                 	D	(1,0,"2016-03-05 22:37:19.917268","2016-03-05 22:37:26.228178")	\N	2016-03-06 01:37:40.093976	seba                                         
603	hist_est_cot                                 	D	(1,1,"2016-03-05 22:37:26.228178",)	\N	2016-03-06 01:37:40.093976	seba                                         
604	doc_previo                                   	I	\N	(1,22,,18293486-0,"2016-03-05 00:00:00",,,,40000,)	2016-03-06 01:38:05.286679	seba                                         
605	hist_est_cot                                 	I	\N	(1,0,"2016-03-06 01:38:05.286679",)	2016-03-06 01:38:05.286679	seba                                         
606	cotizacion                                   	I	\N	(1,0,22,,18293486-0,2016-03-05,,,,40000,)	2016-03-06 01:38:05.286679	seba                                         
607	det_cot_odc_art                              	I	\N	(1,1,RK-160,2,)	2016-03-06 01:38:05.346175	seba                                         
608	hist_est_cot                                 	U	(1,0,"2016-03-06 01:38:05.286679",)	(1,0,"2016-03-06 01:38:05.286679","2016-03-06 01:38:59.47779")	2016-03-06 01:38:59.47779	seba                                         
609	hist_est_cot                                 	I	\N	(1,1,"2016-03-06 01:38:59.47779",)	2016-03-06 01:38:59.47779	seba                                         
610	cotizacion                                   	U	(1,0,22,,18293486-0,2016-03-05,,,,40000,)	(1,1,22,,18293486-0,2016-03-05,,,,40000,)	2016-03-06 01:38:59.47779	seba                                         
611	hist_est_nv                                  	I	\N	(6,0,"2016-03-06 01:38:59.47779",)	2016-03-06 01:38:59.47779	seba                                         
613	cotizacion                                   	U	(1,1,22,,18293486-0,2016-03-05,,,,40000,)	(1,1,22,6,18293486-0,2016-03-05,,,,40000,)	2016-03-06 01:38:59.517974	seba                                         
614	hist_est_nv                                  	U	(6,0,"2016-03-06 01:38:59.47779",)	(6,0,"2016-03-06 01:38:59.47779","2016-03-06 02:19:44.396535")	2016-03-06 02:19:44.396535	seba                                         
615	hist_est_nv                                  	I	\N	(6,1,"2016-03-06 02:19:44.396535",)	2016-03-06 02:19:44.396535	seba                                         
616	nota_de_venta                                	U	(6,,0,,,"2016-03-06 01:38:59.47779",,1)	(6,,1,,1,"2016-03-06 01:38:59.47779",,1)	2016-03-06 02:19:44.396535	seba                                         
617	documento_de_pago                            	I	\N	(1,"2016-03-06 02:21:04.509348",)	2016-03-06 02:21:04.512379	seba                                         
618	nota_de_venta                                	D	(6,,1,,1,"2016-03-06 01:38:59.47779",,1)	\N	2016-03-05 23:29:57.262498	seba                                         
619	hist_est_nv                                  	D	(6,0,"2016-03-06 01:38:59.47779","2016-03-06 02:19:44.396535")	\N	2016-03-05 23:29:57.262498	seba                                         
620	hist_est_nv                                  	D	(6,1,"2016-03-06 02:19:44.396535",)	\N	2016-03-05 23:29:57.262498	seba                                         
621	documento_de_pago                            	D	(1,"2016-03-06 02:21:04.509348",)	\N	2016-03-05 23:30:11.375118	seba                                         
622	doc_previo                                   	D	(1,22,,18293486-0,"2016-03-05 00:00:00",,,,40000,)	\N	2016-03-05 23:58:41.495347	seba                                         
623	cotizacion                                   	D	(1,1,22,6,18293486-0,2016-03-05,,,,40000,)	\N	2016-03-05 23:58:41.495347	seba                                         
624	det_cot_odc_art                              	D	(1,1,RK-160,2,)	\N	2016-03-05 23:58:41.495347	seba                                         
625	hist_est_cot                                 	D	(1,0,"2016-03-06 01:38:05.286679","2016-03-06 01:38:59.47779")	\N	2016-03-05 23:58:41.495347	seba                                         
626	hist_est_cot                                 	D	(1,1,"2016-03-06 01:38:59.47779",)	\N	2016-03-05 23:58:41.495347	seba                                         
627	doc_previo                                   	I	\N	(1,22,,18293486-0,"2016-03-06 00:00:00",,,,49000,)	2016-03-06 03:00:40.055572	seba                                         
628	hist_est_cot                                 	I	\N	(1,0,"2016-03-06 03:00:40.055572",)	2016-03-06 03:00:40.055572	seba                                         
629	cotizacion                                   	I	\N	(1,0,22,,18293486-0,2016-03-06,,,,49000,)	2016-03-06 03:00:40.055572	seba                                         
630	det_cot_odc_art                              	I	\N	(1,1,Qc-200,1,)	2016-03-06 03:00:40.448864	seba                                         
631	det_cot_odc_art                              	I	\N	(1,2,CK-RK-500,1,)	2016-03-06 03:00:40.491029	seba                                         
632	det_cot_odc_art                              	I	\N	(1,3,RK-160,1,)	2016-03-06 03:00:40.530054	seba                                         
633	hist_est_cot                                 	U	(1,0,"2016-03-06 03:00:40.055572",)	(1,0,"2016-03-06 03:00:40.055572","2016-03-06 03:00:47.04058")	2016-03-06 03:00:47.04058	seba                                         
634	hist_est_cot                                 	I	\N	(1,1,"2016-03-06 03:00:47.04058",)	2016-03-06 03:00:47.04058	seba                                         
635	cotizacion                                   	U	(1,0,22,,18293486-0,2016-03-06,,,,49000,)	(1,1,22,,18293486-0,2016-03-06,,,,49000,)	2016-03-06 03:00:47.04058	seba                                         
636	hist_est_nv                                  	I	\N	(7,0,"2016-03-06 03:00:47.04058",)	2016-03-06 03:00:47.04058	seba                                         
637	nota_de_venta                                	I	\N	(7,,0,,,"2016-03-06 03:00:47.04058",,1)	2016-03-06 03:00:47.04058	seba                                         
638	cotizacion                                   	U	(1,1,22,,18293486-0,2016-03-06,,,,49000,)	(1,1,22,7,18293486-0,2016-03-06,,,,49000,)	2016-03-06 03:00:47.37395	seba                                         
641	hist_est_nv                                  	U	(7,0,"2016-03-06 03:00:47.04058",)	(7,0,"2016-03-06 03:00:47.04058","2016-03-06 03:06:26.520956")	2016-03-06 03:06:26.520956	seba                                         
642	hist_est_nv                                  	I	\N	(7,1,"2016-03-06 03:06:26.520956",)	2016-03-06 03:06:26.520956	seba                                         
643	nota_de_venta                                	U	(7,,0,,,"2016-03-06 03:00:47.04058",,1)	(7,,1,,2,"2016-03-06 03:00:47.04058",,1)	2016-03-06 03:06:26.520956	seba                                         
644	documento_de_pago                            	I	\N	(2,"2016-03-06 03:06:26.615339",)	2016-03-06 03:06:26.618036	seba                                         
645	estado_factura                               	I	\N	(0,Pagada)	2016-03-06 00:07:06.156848	seba                                         
646	documento_de_pago                            	I	\N	(3,"2016-03-06 03:07:45.539257",)	2016-03-06 03:07:45.542623	seba                                         
648	documento_de_pago                            	I	\N	(4,"2016-03-06 03:09:17.885218",)	2016-03-06 03:09:17.885737	seba                                         
649	hist_est_fact                                	I	\N	(0,4,2016-03-06,)	2016-03-06 03:09:17.896717	seba                                         
650	hist_est_cot                                 	D	(1,0,"2016-03-06 03:00:40.055572","2016-03-06 03:00:47.04058")	\N	2016-03-06 00:12:30.239288	seba                                         
651	hist_est_cot                                 	U	(1,1,"2016-03-06 03:00:47.04058",)	(1,1,"2016-03-06 03:00:47.04058","2016-03-06 00:12:30.239288")	2016-03-06 00:12:30.239288	seba                                         
652	hist_est_cot                                 	I	\N	(1,0,"2016-03-06 00:12:30.239288",)	2016-03-06 00:12:30.239288	seba                                         
653	cotizacion                                   	U	(1,1,22,7,18293486-0,2016-03-06,,,,49000,)	(1,0,22,-1,18293486-0,2016-03-06,,,,49000,)	2016-03-06 00:12:30.239288	seba                                         
654	nota_de_venta                                	D	(7,,1,,2,"2016-03-06 03:00:47.04058",,1)	\N	2016-03-06 00:12:30.239288	seba                                         
655	hist_est_nv                                  	D	(7,0,"2016-03-06 03:00:47.04058","2016-03-06 03:06:26.520956")	\N	2016-03-06 00:12:30.239288	seba                                         
656	hist_est_nv                                  	D	(7,1,"2016-03-06 03:06:26.520956",)	\N	2016-03-06 00:12:30.239288	seba                                         
658	hist_est_cot                                 	D	(1,0,"2016-03-06 00:12:30.239288",)	\N	2016-03-06 00:20:20.227207	seba                                         
659	cotizacion                                   	U	(1,0,22,-1,18293486-0,2016-03-06,,,,49000,)	(1,1,22,-1,18293486-0,2016-03-06,,,,49000,)	2016-03-06 03:27:38.472822	seba                                         
660	nota_de_venta                                	I	\N	(8,,0,,,"2016-03-06 03:27:38.472822",,1)	2016-03-06 03:27:38.472822	seba                                         
661	cotizacion                                   	U	(1,1,22,-1,18293486-0,2016-03-06,,,,49000,)	(1,1,22,8,18293486-0,2016-03-06,,,,49000,)	2016-03-06 03:27:38.634877	seba                                         
662	nota_de_venta                                	U	(8,,0,,,"2016-03-06 03:27:38.472822",,1)	(8,,1,,1,"2016-03-06 03:27:38.472822",,1)	2016-03-06 03:27:49.324453	seba                                         
663	documento_de_pago                            	I	\N	(5,"2016-03-06 03:27:49.856777",)	2016-03-06 03:27:49.857221	seba                                         
664	hist_est_fact                                	I	\N	(0,5,2016-03-06,)	2016-03-06 03:27:49.868316	seba                                         
665	doc_previo                                   	I	\N	(2,21,,18293486-0,"2016-03-06 00:00:00",,,,49000,)	2016-03-06 03:32:20.737713	seba                                         
666	cotizacion                                   	I	\N	(2,0,21,,18293486-0,2016-03-06,,,,49000,)	2016-03-06 03:32:20.737713	seba                                         
667	det_cot_odc_art                              	I	\N	(2,1,Qc-200,1,)	2016-03-06 03:32:20.787659	seba                                         
668	det_cot_odc_art                              	I	\N	(2,2,RK-160,1,)	2016-03-06 03:32:20.824773	seba                                         
669	det_cot_odc_art                              	I	\N	(2,3,CK-RK-500,1,)	2016-03-06 03:32:20.863723	seba                                         
670	cotizacion                                   	U	(2,0,21,,18293486-0,2016-03-06,,,,49000,)	(2,1,21,,18293486-0,2016-03-06,,,,49000,)	2016-03-06 03:32:26.908879	seba                                         
671	nota_de_venta                                	I	\N	(9,,0,,,"2016-03-06 03:32:26.908879",,2)	2016-03-06 03:32:26.908879	seba                                         
672	cotizacion                                   	U	(2,1,21,,18293486-0,2016-03-06,,,,49000,)	(2,1,21,9,18293486-0,2016-03-06,,,,49000,)	2016-03-06 03:32:27.25207	seba                                         
673	nota_de_venta                                	U	(9,,0,,,"2016-03-06 03:32:26.908879",,2)	(9,,1,,3,"2016-03-06 03:32:26.908879",,2)	2016-03-06 03:32:45.036304	seba                                         
674	documento_de_pago                            	I	\N	(6,"2016-03-06 03:32:45.153702",)	2016-03-06 03:32:45.157018	seba                                         
675	hist_est_fact                                	I	\N	(0,6,2016-03-06,)	2016-03-06 03:32:45.167229	seba                                         
676	documento_de_pago                            	I	\N	(7,"2016-03-06 03:33:24.021923",)	2016-03-06 03:33:24.025775	seba                                         
677	hist_est_fact                                	I	\N	(0,7,2016-03-06,)	2016-03-06 03:33:24.034986	seba                                         
678	nota_de_venta                                	U	(9,,1,,3,"2016-03-06 03:32:26.908879",,2)	(9,,1,7,3,"2016-03-06 03:32:26.908879",,2)	2016-03-06 03:33:24.042877	seba                                         
679	cotizacion                                   	U	(1,1,22,8,18293486-0,2016-03-06,,,,49000,)	(1,0,22,-1,18293486-0,2016-03-06,,,,49000,)	2016-03-06 00:43:27.822098	seba                                         
680	nota_de_venta                                	D	(8,,1,,1,"2016-03-06 03:27:38.472822",,1)	\N	2016-03-06 00:43:27.822098	seba                                         
681	cliente                                      	U	(26,3,jp,2222,jp,jp,,x@x.com,empresa,f,17673797-2)	(26,3,jp,"",jp,jp,,x@x.com,empresa,f,17673797-2)	2016-03-06 03:45:22.246913	seba                                         
682	doc_previo                                   	I	\N	(3,26,,18293486-0,"2016-03-06 00:00:00",,,,54000,)	2016-03-06 03:45:22.246913	seba                                         
683	cotizacion                                   	I	\N	(3,0,26,,18293486-0,2016-03-06,,,,54000,)	2016-03-06 03:45:22.246913	seba                                         
684	det_cot_odc_art                              	I	\N	(3,1,RK-160,2,)	2016-03-06 03:45:22.340926	seba                                         
685	det_cot_odc_art                              	I	\N	(3,2,CK-RK-500,1,)	2016-03-06 03:45:22.381699	seba                                         
686	cotizacion                                   	U	(3,0,26,,18293486-0,2016-03-06,,,,54000,)	(3,1,26,,18293486-0,2016-03-06,,,,54000,)	2016-03-06 03:45:26.322526	seba                                         
687	nota_de_venta                                	I	\N	(10,,0,,,"2016-03-06 03:45:26.322526",,3)	2016-03-06 03:45:26.322526	seba                                         
688	cotizacion                                   	U	(3,1,26,,18293486-0,2016-03-06,,,,54000,)	(3,1,26,10,18293486-0,2016-03-06,,,,54000,)	2016-03-06 03:45:26.480816	seba                                         
689	nota_de_venta                                	U	(10,,0,,,"2016-03-06 03:45:26.322526",,3)	(10,,1,,1,"2016-03-06 03:45:26.322526",,3)	2016-03-06 03:45:56.673858	seba                                         
690	documento_de_pago                            	I	\N	(8,"2016-03-06 03:45:56.760457",)	2016-03-06 03:45:56.764528	seba                                         
691	nota_de_venta                                	U	(10,,1,,1,"2016-03-06 03:45:26.322526",,3)	(10,,1,8,1,"2016-03-06 03:45:26.322526",,3)	2016-03-06 03:45:56.78196	seba                                         
692	doc_previo                                   	I	\N	(4,22,,18293486-0,"2016-03-06 00:00:00",,,,40000,)	2016-03-06 04:14:12.071688	seba                                         
693	cotizacion                                   	I	\N	(4,0,22,,18293486-0,2016-03-06,,,,40000,)	2016-03-06 04:14:12.071688	seba                                         
694	det_cot_odc_art                              	I	\N	(4,1,RK-160,2,)	2016-03-06 04:14:12.269414	seba                                         
695	doc_previo                                   	D	(1,22,,18293486-0,"2016-03-06 00:00:00",,,,49000,)	\N	2016-03-06 04:14:21.962301	seba                                         
696	cotizacion                                   	D	(1,0,22,-1,18293486-0,2016-03-06,,,,49000,)	\N	2016-03-06 04:14:21.962301	seba                                         
697	det_cot_odc_art                              	D	(1,1,Qc-200,1,)	\N	2016-03-06 04:14:21.962301	seba                                         
698	det_cot_odc_art                              	D	(1,2,CK-RK-500,1,)	\N	2016-03-06 04:14:21.962301	seba                                         
699	det_cot_odc_art                              	D	(1,3,RK-160,1,)	\N	2016-03-06 04:14:21.962301	seba                                         
700	hist_est_cot                                 	D	(1,1,"2016-03-06 03:00:47.04058","2016-03-06 00:12:30.239288")	\N	2016-03-06 04:14:21.962301	seba                                         
701	cliente                                      	U	(19,4,Ricardo,"","Heraldica 9897","Heraldica 9897",,Ricardo_bravo@live.cl,"Automotora Continental",f,"")	(19,4,Ricardo,Rojas,"Heraldica 9897","Heraldica 9897","",Ricardo_bravo@live.cl,"Automotora Continental",f,"")	2016-03-06 04:16:53.766422	seba                                         
702	servicio_reparacion                          	I	\N	(7,Embrague)	2016-03-06 04:19:35.646072	seba                                         
703	servicio_reparacion                          	D	(7,Embrague)	\N	2016-03-06 04:20:54.101314	seba                                         
704	servicio_reparacion                          	U	(6,"reparacion de embrague")	(6,"Reparacion de Embrague")	2016-03-06 04:21:41.04223	seba                                         
705	marca                                        	D	(14,Fiat)	\N	2016-03-06 04:22:28.493913	seba                                         
706	marca                                        	I	\N	(15,fiat)	2016-03-06 04:22:35.383463	seba                                         
707	marca                                        	U	(15,fiat)	(15,Fiat)	2016-03-06 04:22:40.925623	seba                                         
708	tipo_articulo                                	D	(13,"Vidrio Puerta")	\N	2016-03-06 04:25:36.58206	seba                                         
709	tipo_articulo                                	I	\N	(22,Palanca)	2016-03-06 04:25:51.500152	seba                                         
710	tipo_articulo                                	U	(22,Palanca)	(22,Palanca2)	2016-03-06 04:26:02.154443	seba                                         
711	tipo_articulo                                	U	(22,Palanca2)	(22,Palanca)	2016-03-06 04:26:13.800007	seba                                         
712	det_cot_odc_art                              	U	(2,2,RK-160,1,)	(2,2,RK-1601,1,)	2016-03-06 04:27:31.993731	seba                                         
713	det_cot_odc_art                              	U	(3,1,RK-160,2,)	(3,1,RK-1601,2,)	2016-03-06 04:27:31.993731	seba                                         
714	det_cot_odc_art                              	U	(4,1,RK-160,2,)	(4,1,RK-1601,2,)	2016-03-06 04:27:31.993731	seba                                         
715	det_cot_odc_art                              	U	(2,2,RK-1601,1,)	(2,2,RK-160,1,)	2016-03-06 04:27:38.037916	seba                                         
716	det_cot_odc_art                              	U	(3,1,RK-1601,2,)	(3,1,RK-160,2,)	2016-03-06 04:27:38.037916	seba                                         
717	det_cot_odc_art                              	U	(4,1,RK-1601,2,)	(4,1,RK-160,2,)	2016-03-06 04:27:38.037916	seba                                         
718	doc_previo                                   	I	\N	(5,20,,18293486-0,"2016-03-06 00:00:00",,,,25000,)	2016-03-06 04:30:30.925761	seba                                         
719	cotizacion                                   	I	\N	(5,0,20,,18293486-0,2016-03-06,,,,25000,)	2016-03-06 04:30:30.925761	seba                                         
720	det_cot_odc_art                              	I	\N	(5,1,acc-01,1,)	2016-03-06 04:30:30.98779	seba                                         
721	doc_previo                                   	I	\N	(6,22,,18293486-0,"2016-03-06 00:00:00",,,,20000,)	2016-03-06 04:31:47.757144	seba                                         
722	cotizacion                                   	I	\N	(6,0,22,,18293486-0,2016-03-06,,,,20000,)	2016-03-06 04:31:47.757144	seba                                         
723	det_cot_odc_art                              	I	\N	(6,1,RK-160,1,)	2016-03-06 04:31:47.803771	seba                                         
724	doc_previo                                   	I	\N	(7,22,,18293486-0,"2016-03-06 00:00:00",,,,34000,)	2016-03-06 04:51:25.818047	seba                                         
725	cotizacion                                   	I	\N	(7,0,22,,18293486-0,2016-03-06,,,,34000,)	2016-03-06 04:51:25.818047	seba                                         
726	det_cot_odc_art                              	I	\N	(7,1,RK-160,1,)	2016-03-06 04:51:26.260488	seba                                         
727	det_cot_odc_art                              	I	\N	(7,2,CK-RK-500,1,)	2016-03-06 04:51:26.335166	seba                                         
728	doc_previo                                   	I	\N	(8,22,,18293486-0,"2016-03-06 00:00:00",,,,34000,)	2016-03-06 04:51:44.47396	seba                                         
729	cotizacion                                   	I	\N	(8,0,22,,18293486-0,2016-03-06,,,,34000,)	2016-03-06 04:51:44.47396	seba                                         
730	det_cot_odc_art                              	I	\N	(8,1,RK-160,1,)	2016-03-06 04:51:44.639009	seba                                         
731	det_cot_odc_art                              	I	\N	(8,2,CK-RK-500,1,)	2016-03-06 04:51:44.645656	seba                                         
732	doc_previo                                   	I	\N	(9,22,,18293486-0,"2016-03-06 00:00:00",,,,0,)	2016-03-06 04:52:14.447687	seba                                         
733	cotizacion                                   	I	\N	(9,0,22,,18293486-0,2016-03-06,,,,0,)	2016-03-06 04:52:14.447687	seba                                         
734	doc_previo                                   	I	\N	(10,22,,18293486-0,"2016-03-06 00:00:00",,,,0,)	2016-03-06 04:53:21.754413	seba                                         
735	cotizacion                                   	I	\N	(10,0,22,,18293486-0,2016-03-06,,,,0,)	2016-03-06 04:53:21.754413	seba                                         
736	doc_previo                                   	D	(10,22,,18293486-0,"2016-03-06 00:00:00",,,,0,)	\N	2016-03-06 04:53:47.307951	seba                                         
737	cotizacion                                   	D	(10,0,22,,18293486-0,2016-03-06,,,,0,)	\N	2016-03-06 04:53:47.307951	seba                                         
738	doc_previo                                   	D	(9,22,,18293486-0,"2016-03-06 00:00:00",,,,0,)	\N	2016-03-06 04:53:50.576555	seba                                         
739	cotizacion                                   	D	(9,0,22,,18293486-0,2016-03-06,,,,0,)	\N	2016-03-06 04:53:50.576555	seba                                         
740	doc_previo                                   	D	(8,22,,18293486-0,"2016-03-06 00:00:00",,,,34000,)	\N	2016-03-06 04:53:53.637946	seba                                         
741	cotizacion                                   	D	(8,0,22,,18293486-0,2016-03-06,,,,34000,)	\N	2016-03-06 04:53:53.637946	seba                                         
742	det_cot_odc_art                              	D	(8,1,RK-160,1,)	\N	2016-03-06 04:53:53.637946	seba                                         
743	det_cot_odc_art                              	D	(8,2,CK-RK-500,1,)	\N	2016-03-06 04:53:53.637946	seba                                         
744	doc_previo                                   	D	(7,22,,18293486-0,"2016-03-06 00:00:00",,,,34000,)	\N	2016-03-06 04:53:57.003717	seba                                         
745	cotizacion                                   	D	(7,0,22,,18293486-0,2016-03-06,,,,34000,)	\N	2016-03-06 04:53:57.003717	seba                                         
746	det_cot_odc_art                              	D	(7,1,RK-160,1,)	\N	2016-03-06 04:53:57.003717	seba                                         
747	det_cot_odc_art                              	D	(7,2,CK-RK-500,1,)	\N	2016-03-06 04:53:57.003717	seba                                         
748	doc_previo                                   	D	(6,22,,18293486-0,"2016-03-06 00:00:00",,,,20000,)	\N	2016-03-06 04:54:01.362637	seba                                         
749	cotizacion                                   	D	(6,0,22,,18293486-0,2016-03-06,,,,20000,)	\N	2016-03-06 04:54:01.362637	seba                                         
750	det_cot_odc_art                              	D	(6,1,RK-160,1,)	\N	2016-03-06 04:54:01.362637	seba                                         
751	doc_previo                                   	I	\N	(6,22,,18293486-0,"2016-03-06 00:00:00",,,,14000,)	2016-03-06 04:55:41.940765	seba                                         
752	cotizacion                                   	I	\N	(6,0,22,,18293486-0,2016-03-06,,,,14000,)	2016-03-06 04:55:41.940765	seba                                         
753	det_cot_odc_art                              	I	\N	(6,1,CK-RK-500,1,)	2016-03-06 04:55:42.03958	seba                                         
754	doc_previo                                   	I	\N	(7,22,,18293486-0,"2016-03-06 00:00:00",,,,14000,)	2016-03-06 04:56:06.599159	seba                                         
755	cotizacion                                   	I	\N	(7,0,22,,18293486-0,2016-03-06,,,,14000,)	2016-03-06 04:56:06.599159	seba                                         
756	det_cot_odc_art                              	I	\N	(7,1,CK-RK-500,1,)	2016-03-06 04:56:07.008003	seba                                         
757	doc_previo                                   	D	(5,20,,18293486-0,"2016-03-06 00:00:00",,,,25000,)	\N	2016-03-06 05:13:11.812002	seba                                         
758	cotizacion                                   	D	(5,0,20,,18293486-0,2016-03-06,,,,25000,)	\N	2016-03-06 05:13:11.812002	seba                                         
759	det_cot_odc_art                              	D	(5,1,acc-01,1,,)	\N	2016-03-06 05:13:11.812002	seba                                         
760	doc_previo                                   	D	(7,22,,18293486-0,"2016-03-06 00:00:00",,,,14000,)	\N	2016-03-06 05:13:14.701019	seba                                         
761	cotizacion                                   	D	(7,0,22,,18293486-0,2016-03-06,,,,14000,)	\N	2016-03-06 05:13:14.701019	seba                                         
762	det_cot_odc_art                              	D	(7,1,CK-RK-500,1,,)	\N	2016-03-06 05:13:14.701019	seba                                         
763	doc_previo                                   	D	(6,22,,18293486-0,"2016-03-06 00:00:00",,,,14000,)	\N	2016-03-06 05:13:19.206696	seba                                         
764	cotizacion                                   	D	(6,0,22,,18293486-0,2016-03-06,,,,14000,)	\N	2016-03-06 05:13:19.206696	seba                                         
765	det_cot_odc_art                              	D	(6,1,CK-RK-500,1,,)	\N	2016-03-06 05:13:19.206696	seba                                         
766	doc_previo                                   	D	(4,22,,18293486-0,"2016-03-06 00:00:00",,,,40000,)	\N	2016-03-06 05:13:21.894216	seba                                         
767	cotizacion                                   	D	(4,0,22,,18293486-0,2016-03-06,,,,40000,)	\N	2016-03-06 05:13:21.894216	seba                                         
768	det_cot_odc_art                              	D	(4,1,RK-160,2,,)	\N	2016-03-06 05:13:21.894216	seba                                         
769	cotizacion                                   	U	(3,1,26,10,18293486-0,2016-03-06,,,,54000,)	(3,0,26,-1,18293486-0,2016-03-06,,,,54000,)	2016-03-06 02:13:47.83996	seba                                         
770	nota_de_venta                                	D	(10,,1,8,1,"2016-03-06 03:45:26.322526",,3)	\N	2016-03-06 02:13:47.83996	seba                                         
771	cotizacion                                   	U	(2,1,21,9,18293486-0,2016-03-06,,,,49000,)	(2,0,21,-1,18293486-0,2016-03-06,,,,49000,)	2016-03-06 02:13:50.832256	seba                                         
772	nota_de_venta                                	D	(9,,1,7,3,"2016-03-06 03:32:26.908879",,2)	\N	2016-03-06 02:13:50.832256	seba                                         
773	doc_previo                                   	D	(2,21,,18293486-0,"2016-03-06 00:00:00",,,,49000,)	\N	2016-03-06 05:13:59.867076	seba                                         
774	cotizacion                                   	D	(2,0,21,-1,18293486-0,2016-03-06,,,,49000,)	\N	2016-03-06 05:13:59.867076	seba                                         
775	det_cot_odc_art                              	D	(2,1,Qc-200,1,,)	\N	2016-03-06 05:13:59.867076	seba                                         
776	det_cot_odc_art                              	D	(2,3,CK-RK-500,1,,)	\N	2016-03-06 05:13:59.867076	seba                                         
777	det_cot_odc_art                              	D	(2,2,RK-160,1,,)	\N	2016-03-06 05:13:59.867076	seba                                         
778	doc_previo                                   	D	(3,26,,18293486-0,"2016-03-06 00:00:00",,,,54000,)	\N	2016-03-06 05:14:02.688576	seba                                         
779	cotizacion                                   	D	(3,0,26,-1,18293486-0,2016-03-06,,,,54000,)	\N	2016-03-06 05:14:02.688576	seba                                         
780	det_cot_odc_art                              	D	(3,2,CK-RK-500,1,,)	\N	2016-03-06 05:14:02.688576	seba                                         
781	det_cot_odc_art                              	D	(3,1,RK-160,2,,)	\N	2016-03-06 05:14:02.688576	seba                                         
782	doc_previo                                   	I	\N	(1,22,,18293486-0,"2016-03-06 00:00:00",,,,148000,)	2016-03-06 05:14:35.778015	seba                                         
783	cotizacion                                   	I	\N	(1,0,22,,18293486-0,2016-03-06,,,,148000,)	2016-03-06 05:14:35.778015	seba                                         
784	det_cot_odc_art                              	I	\N	(1,1,acc-01,2,,25000)	2016-03-06 05:14:35.831362	seba                                         
785	det_cot_odc_art                              	I	\N	(1,2,RK-160,2,,20000)	2016-03-06 05:14:35.870078	seba                                         
786	det_cot_odc_art                              	I	\N	(1,3,CK-RK-500,2,,14000)	2016-03-06 05:14:35.925973	seba                                         
787	det_cot_odc_art                              	I	\N	(1,4,Qc-200,2,,15000)	2016-03-06 05:14:35.981135	seba                                         
788	doc_previo                                   	D	(1,22,,18293486-0,"2016-03-06 00:00:00",,,,148000,)	\N	2016-03-06 05:24:41.861983	seba                                         
789	cotizacion                                   	D	(1,0,22,,18293486-0,2016-03-06,,,,148000,)	\N	2016-03-06 05:24:41.861983	seba                                         
790	det_cot_odc_art                              	D	(1,1,acc-01,2,,25000)	\N	2016-03-06 05:24:41.861983	seba                                         
791	det_cot_odc_art                              	D	(1,2,RK-160,2,,20000)	\N	2016-03-06 05:24:41.861983	seba                                         
792	det_cot_odc_art                              	D	(1,3,CK-RK-500,2,,14000)	\N	2016-03-06 05:24:41.861983	seba                                         
793	det_cot_odc_art                              	D	(1,4,Qc-200,2,,15000)	\N	2016-03-06 05:24:41.861983	seba                                         
794	doc_previo                                   	I	\N	(1,26,,18293486-0,"2016-03-06 00:00:00",,,,14000,)	2016-03-06 05:26:01.433706	seba                                         
795	cotizacion                                   	I	\N	(1,0,26,,18293486-0,2016-03-06,,,,14000,)	2016-03-06 05:26:01.433706	seba                                         
796	det_cot_odc_art                              	I	\N	(1,1,CK-RK-500,1,,14000)	2016-03-06 05:26:01.476116	seba                                         
797	cotizacion                                   	U	(1,0,26,,18293486-0,2016-03-06,,,,14000,)	(1,1,26,,18293486-0,2016-03-06,,,,14000,)	2016-03-06 05:27:17.880331	seba                                         
798	nota_de_venta                                	I	\N	(11,,0,,,"2016-03-06 05:27:17.880331",,1)	2016-03-06 05:27:17.880331	seba                                         
799	cotizacion                                   	U	(1,1,26,,18293486-0,2016-03-06,,,,14000,)	(1,1,26,11,18293486-0,2016-03-06,,,,14000,)	2016-03-06 05:27:18.398991	seba                                         
800	doc_previo                                   	I	\N	(2,27,,18293486-0,"2016-03-06 00:00:00",,,,54000,)	2016-03-06 05:28:18.400266	seba                                         
801	cotizacion                                   	I	\N	(2,0,27,,18293486-0,2016-03-06,,,,54000,)	2016-03-06 05:28:18.400266	seba                                         
802	det_cot_odc_art                              	I	\N	(2,1,CK-RK-500,1,,14000)	2016-03-06 05:28:18.887057	seba                                         
803	det_cot_odc_art                              	I	\N	(2,2,acc-01,1,,25000)	2016-03-06 05:28:18.925921	seba                                         
804	det_cot_odc_art                              	I	\N	(2,3,Qc-200,1,,15000)	2016-03-06 05:28:18.969471	seba                                         
805	cotizacion                                   	U	(2,0,27,,18293486-0,2016-03-06,,,,54000,)	(2,1,27,,18293486-0,2016-03-06,,,,54000,)	2016-03-06 05:28:24.341244	seba                                         
806	nota_de_venta                                	I	\N	(12,,0,,,"2016-03-06 05:28:24.341244+00",,2)	2016-03-06 05:28:24.341244	seba                                         
807	cotizacion                                   	U	(2,1,27,,18293486-0,2016-03-06,,,,54000,)	(2,1,27,12,18293486-0,2016-03-06,,,,54000,)	2016-03-06 05:28:24.423383	seba                                         
808	nota_de_venta                                	U	(12,,0,,,2016-03-06,,2)	(12,,1,,2,2016-03-06,,2)	2016-03-06 05:29:57.373482	seba                                         
809	documento_de_pago                            	I	\N	(9,"2016-03-06 05:32:11.164766",)	2016-03-06 05:32:11.168287	seba                                         
810	hist_est_fact                                	I	\N	(0,9,2016-03-06,)	2016-03-06 05:32:11.180524	seba                                         
811	documento_de_pago                            	I	\N	(10,"2016-03-06 05:34:00.322679",)	2016-03-06 05:34:00.326269	seba                                         
812	hist_est_fact                                	I	\N	(0,10,2016-03-06,)	2016-03-06 05:34:00.339106	seba                                         
813	nota_de_venta                                	U	(12,,1,,2,2016-03-06,,2)	(12,,1,10,2,2016-03-06,,2)	2016-03-06 05:34:00.34388	seba                                         
814	tipo_articulo                                	I	\N	(23,"Sensor de Retroceso")	2016-03-06 06:11:22.105292	seba                                         
\.


--
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY marca (marca_cod, marca_nombre) FROM stdin;
1	Chevrolet
2	Nissan
3	Toyota
4	Audi
5	BMW
6	Porsche
7	Ferrari
8	Dodge
9	Subaru
10	Honda
11	Alfa Romeo
12	Citroen
15	Fiat
\.


--
-- Data for Name: metodo_de_pago; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY metodo_de_pago (pago_cod, pago_tipo) FROM stdin;
0	Transferencia
1	Efectivo
2	Cheque
3	Tarjeta de Credito
\.


--
-- Data for Name: modelo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY modelo (marca_cod, modelo_cod, modelo_nombre, modelo_ano) FROM stdin;
2	3	Murano	2017
2	4	Murano	2016
1	5	Corsa	2005
3	6	Supra	1999
4	7	TT	2015
1	8	Corsa	2010
4	9	A3	2010
4	10	A3	2011
4	11	A3	2012
\.


--
-- Data for Name: nota_de_venta; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY nota_de_venta (not_ven_cod, od_cod, not_ven_est_cod, doc_pago_cod, pago_cod, not_ven_fecha, not_ven_obs, doc_cod) FROM stdin;
11	\N	0	\N	\N	2016-03-06	\N	1
12	\N	1	10	2	2016-03-06	\N	2
\.


--
-- Data for Name: orden_de_compra; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY orden_de_compra (doc_cod, oc_est_cod, cliente_cod, not_ven_cod, emp_rut, doc_fecha, doc_obs, doc_neto, doc_iva, doc_total, doc_total_desc) FROM stdin;
\.


--
-- Data for Name: orden_de_despacho; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY orden_de_despacho (od_cod, not_ven_cod, od_est_cod, od_fecha, od_obs, desp_fecha, od_dir) FROM stdin;
\.


--
-- Data for Name: orden_de_trabajo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY orden_de_trabajo (ot_cod, veh_pat, not_ven_cod, doc_cod, ot_est_cod, emp_rut, ot_fecha, ot_obs, modelo_cod) FROM stdin;
\.


--
-- Data for Name: para_instalacion; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY para_instalacion (art_cod, art_tipo_cod, art_nom, art_stock, art_precio, art_imagen) FROM stdin;
acc-01	2	Radio Hawk	50	25000	\N
Rep-01	14	Par 01	20	40000	\N
acc-02	23	Sens HAWK	15	10000	\N
\.


--
-- Data for Name: parametros; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY parametros (param_cod, param_nom, param_valor, param_valor_tipo) FROM stdin;
\.


--
-- Data for Name: propiedad_articulo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY propiedad_articulo (prop_cod, dom_cod, art_tipo_cod, prop_nom, prop_med) FROM stdin;
\.


--
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY proveedor (prov_cod, prov_nom, prov_web) FROM stdin;
\.


--
-- Data for Name: proveedor_articulo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY proveedor_articulo (prov_cod, art_cod, cod_prov_art) FROM stdin;
\.


--
-- Data for Name: repuesto; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY repuesto (art_cod, art_tipo_cod, art_nom, art_stock, art_precio, art_imagen) FROM stdin;
Rep-01	14	Par 01	20	40000	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY schema_migrations (version) FROM stdin;
20160226211408
20160227001849
20160227153309
20160227155348
20160227233957
20160228013804
20160228132157
20160228132453
20160228135130
20160228135136
20160228045642
20160229033559
20160302131654
20160302131659
20160302131707
20160302131712
20160302173732
20160302175520
20160302193507
20160302193517
20160303195321
20160303195354
20160303204146
20160304013615
20160304180413
20160305221554
20160305233004
20160306011608
20160306011613
20160306011643
20160306011702
\.


--
-- Data for Name: serv_inst; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY serv_inst (doc_cod, not_ven_cod, emp_rut, doc_fecha, doc_obs, doc_neto, doc_iva, doc_total, doc_total_desc, cliente_cod) FROM stdin;
\.


--
-- Data for Name: serv_inst_det; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY serv_inst_det (doc_cod, si_num_linea, marca_cod, art_cod, modelo_cod, modelo_ano, si_desc, serv_precio) FROM stdin;
\.


--
-- Data for Name: serv_rep; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY serv_rep (doc_cod, cliente_cod, not_ven_cod, emp_rut, doc_fecha, doc_obs, doc_neto, doc_iva, doc_total, doc_total_desc) FROM stdin;
\.


--
-- Data for Name: serv_rep_det; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY serv_rep_det (doc_cod, sr_num_linea, serv_cod, marca_cod, modelo_cod, modelo_ano, sr_desc, sr_precio, sr_cant) FROM stdin;
\.


--
-- Data for Name: servicio_reparacion; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY servicio_reparacion (serv_cod, serv_nom) FROM stdin;
5	Defroster
6	Reparacion de Embrague
\.


--
-- Data for Name: si_vehiculo_articulo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY si_vehiculo_articulo (art_cod, marca_cod, modelo_cod, modelo_ano, s_v_a_mo_pr, s_v_a_in_pr, si_cod) FROM stdin;
\.


--
-- Data for Name: tipo_articulo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY tipo_articulo (art_tipo_cod, tipo_nom) FROM stdin;
3	Cuchilla
4	Montador
5	Resina
6	Lámpara
7	Tomador
8	Moldura
9	Sensor de Lluvia
10	Cinta
12	Luneta
14	Parabrisas
15	Otro
17	Radio
18	Esmalte
2	Espada
19	Ampolleta
20	Kit
21	Tirador
22	Palanca
23	Sensor de Retroceso
\.


--
-- Data for Name: tipo_cliente; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY tipo_cliente (tipo_cliente_cod, tipo_cliente_descr) FROM stdin;
4	Automotora
5	Rent-a-Car
6	Otro
7	Otro2
3	Particular215
\.


--
-- Data for Name: tran_est_cot; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY tran_est_cot (cot_est_cod, est_cot_est_cod) FROM stdin;
\.


--
-- Data for Name: trans_est_fact; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY trans_est_fact (fact_est_cod, est_fact_est_cod) FROM stdin;
\.


--
-- Data for Name: trans_est_nv; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY trans_est_nv (est_not_ven_est_cod, not_ven_est_cod) FROM stdin;
\.


--
-- Data for Name: trans_est_oc; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY trans_est_oc (est_oc_est_cod, oc_est_cod) FROM stdin;
\.


--
-- Data for Name: trans_est_od; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY trans_est_od (od_est_cod, est_od_est_cod) FROM stdin;
\.


--
-- Data for Name: trans_est_ot; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY trans_est_ot (ot_est_cod, est_ot_est_cod) FROM stdin;
\.


--
-- Data for Name: vehiculo; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY vehiculo (veh_pat, marca_cod, modelo_cod, modelo_ano, veh_km, veh_color) FROM stdin;
\.


--
-- Data for Name: vehiculo_serviciorep; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY vehiculo_serviciorep (serv_cod, marca_cod, modelo_cod, modelo_ano, sr_v_mo_pr, sr_v_in_pr) FROM stdin;
\.


--
-- Name: pk_accesorio; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY accesorio
    ADD CONSTRAINT pk_accesorio PRIMARY KEY (art_cod);


--
-- Name: pk_art_hist_pre; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY art_hist_pre
    ADD CONSTRAINT pk_art_hist_pre PRIMARY KEY (hist_cod);


--
-- Name: pk_art_prop_valor; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY art_prop_valor
    ADD CONSTRAINT pk_art_prop_valor PRIMARY KEY (prop_cod, dom_cod);


--
-- Name: pk_articulo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY articulo
    ADD CONSTRAINT pk_articulo PRIMARY KEY (art_cod);


--
-- Name: pk_audit; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY log
    ADD CONSTRAINT pk_audit PRIMARY KEY (pk_audit);


--
-- Name: pk_boleta; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY boleta
    ADD CONSTRAINT pk_boleta PRIMARY KEY (doc_pago_cod);


--
-- Name: pk_cargo_empleado; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY cargo_empleado
    ADD CONSTRAINT pk_cargo_empleado PRIMARY KEY (cargo_cod);


--
-- Name: pk_cliente; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (cliente_cod);


--
-- Name: pk_compatibilidad; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY compatibilidad
    ADD CONSTRAINT pk_compatibilidad PRIMARY KEY (marca_cod, art_cod, modelo_cod, modelo_ano);


--
-- Name: pk_cot_odc_art; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY cot_odc_art
    ADD CONSTRAINT pk_cot_odc_art PRIMARY KEY (doc_cod);


--
-- Name: pk_cot_odc_serv; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY cot_odc_serv
    ADD CONSTRAINT pk_cot_odc_serv PRIMARY KEY (doc_cod);


--
-- Name: pk_cotizacion; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY cotizacion
    ADD CONSTRAINT pk_cotizacion PRIMARY KEY (doc_cod);


--
-- Name: pk_det_cot_odc_art; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY det_cot_odc_art
    ADD CONSTRAINT pk_det_cot_odc_art PRIMARY KEY (doc_cod, det_num_linea);


--
-- Name: pk_det_ot; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY det_ot
    ADD CONSTRAINT pk_det_ot PRIMARY KEY (ot_cod, ot_num_linea);


--
-- Name: pk_doc_previo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY doc_previo
    ADD CONSTRAINT pk_doc_previo PRIMARY KEY (doc_cod);


--
-- Name: pk_documento_de_pago; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY documento_de_pago
    ADD CONSTRAINT pk_documento_de_pago PRIMARY KEY (doc_pago_cod);


--
-- Name: pk_dom_val_art; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY dom_val_art
    ADD CONSTRAINT pk_dom_val_art PRIMARY KEY (dom_cod);


--
-- Name: pk_empleados; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT pk_empleados PRIMARY KEY (emp_rut);


--
-- Name: pk_estado_cotizacion; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY estado_cotizacion
    ADD CONSTRAINT pk_estado_cotizacion PRIMARY KEY (cot_est_cod);


--
-- Name: pk_estado_factura; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY estado_factura
    ADD CONSTRAINT pk_estado_factura PRIMARY KEY (fact_est_cod);


--
-- Name: pk_estado_nota_de_venta; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY estado_nota_de_venta
    ADD CONSTRAINT pk_estado_nota_de_venta PRIMARY KEY (not_ven_est_cod);


--
-- Name: pk_estado_oc; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY estado_oc
    ADD CONSTRAINT pk_estado_oc PRIMARY KEY (oc_est_cod);


--
-- Name: pk_estado_od; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY estado_od
    ADD CONSTRAINT pk_estado_od PRIMARY KEY (od_est_cod);


--
-- Name: pk_estado_ot; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY estado_ot
    ADD CONSTRAINT pk_estado_ot PRIMARY KEY (ot_est_cod);


--
-- Name: pk_factura; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT pk_factura PRIMARY KEY (doc_pago_cod);


--
-- Name: pk_herramienta; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY herramienta
    ADD CONSTRAINT pk_herramienta PRIMARY KEY (art_cod);


--
-- Name: pk_hist_est_cot; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY hist_est_cot
    ADD CONSTRAINT pk_hist_est_cot PRIMARY KEY (doc_cod, cot_est_cod);


--
-- Name: pk_hist_est_fact; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY hist_est_fact
    ADD CONSTRAINT pk_hist_est_fact PRIMARY KEY (fact_est_cod, doc_pago_cod);


--
-- Name: pk_hist_est_nv; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY hist_est_nv
    ADD CONSTRAINT pk_hist_est_nv PRIMARY KEY (not_ven_cod, not_ven_est_cod);


--
-- Name: pk_hist_est_oc; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY hist_est_oc
    ADD CONSTRAINT pk_hist_est_oc PRIMARY KEY (doc_cod, oc_est_cod);


--
-- Name: pk_hist_est_od; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY hist_est_od
    ADD CONSTRAINT pk_hist_est_od PRIMARY KEY (od_cod, od_est_cod);


--
-- Name: pk_hist_est_ot; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY hist_est_ot
    ADD CONSTRAINT pk_hist_est_ot PRIMARY KEY (ot_cod, ot_est_cod);


--
-- Name: pk_insumo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY insumo
    ADD CONSTRAINT pk_insumo PRIMARY KEY (art_cod);


--
-- Name: pk_marca; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT pk_marca PRIMARY KEY (marca_cod);


--
-- Name: pk_metodo_de_pago; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY metodo_de_pago
    ADD CONSTRAINT pk_metodo_de_pago PRIMARY KEY (pago_cod);


--
-- Name: pk_modelo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY modelo
    ADD CONSTRAINT pk_modelo PRIMARY KEY (marca_cod, modelo_cod, modelo_ano);


--
-- Name: pk_nota_de_venta; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY nota_de_venta
    ADD CONSTRAINT pk_nota_de_venta PRIMARY KEY (not_ven_cod);


--
-- Name: pk_orden_de_compra; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY orden_de_compra
    ADD CONSTRAINT pk_orden_de_compra PRIMARY KEY (doc_cod);


--
-- Name: pk_orden_de_despacho; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY orden_de_despacho
    ADD CONSTRAINT pk_orden_de_despacho PRIMARY KEY (od_cod);


--
-- Name: pk_orden_de_trabajo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY orden_de_trabajo
    ADD CONSTRAINT pk_orden_de_trabajo PRIMARY KEY (ot_cod);


--
-- Name: pk_para_instalacion; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY para_instalacion
    ADD CONSTRAINT pk_para_instalacion PRIMARY KEY (art_cod);


--
-- Name: pk_parametros; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT pk_parametros PRIMARY KEY (param_cod);


--
-- Name: pk_propiedad_articulo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY propiedad_articulo
    ADD CONSTRAINT pk_propiedad_articulo PRIMARY KEY (prop_cod);


--
-- Name: pk_proveedor; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY proveedor
    ADD CONSTRAINT pk_proveedor PRIMARY KEY (prov_cod);


--
-- Name: pk_proveedor_articulo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY proveedor_articulo
    ADD CONSTRAINT pk_proveedor_articulo PRIMARY KEY (prov_cod, art_cod);


--
-- Name: pk_repuesto; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY repuesto
    ADD CONSTRAINT pk_repuesto PRIMARY KEY (art_cod);


--
-- Name: pk_serv_inst; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY serv_inst
    ADD CONSTRAINT pk_serv_inst PRIMARY KEY (doc_cod);


--
-- Name: pk_serv_inst_det; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY serv_inst_det
    ADD CONSTRAINT pk_serv_inst_det PRIMARY KEY (doc_cod, si_num_linea);


--
-- Name: pk_serv_rep; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY serv_rep
    ADD CONSTRAINT pk_serv_rep PRIMARY KEY (doc_cod);


--
-- Name: pk_serv_rep_det; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY serv_rep_det
    ADD CONSTRAINT pk_serv_rep_det PRIMARY KEY (doc_cod, sr_num_linea);


--
-- Name: pk_servicio_reparacion; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY servicio_reparacion
    ADD CONSTRAINT pk_servicio_reparacion PRIMARY KEY (serv_cod);


--
-- Name: pk_si_vehiculo_articulo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY si_vehiculo_articulo
    ADD CONSTRAINT pk_si_vehiculo_articulo PRIMARY KEY (marca_cod, art_cod, modelo_cod, modelo_ano);


--
-- Name: pk_tipo_articulo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY tipo_articulo
    ADD CONSTRAINT pk_tipo_articulo PRIMARY KEY (art_tipo_cod);


--
-- Name: pk_tipo_cliente; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY tipo_cliente
    ADD CONSTRAINT pk_tipo_cliente PRIMARY KEY (tipo_cliente_cod);


--
-- Name: pk_tran_est_cot; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY tran_est_cot
    ADD CONSTRAINT pk_tran_est_cot PRIMARY KEY (cot_est_cod, est_cot_est_cod);


--
-- Name: pk_trans_est_fact; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY trans_est_fact
    ADD CONSTRAINT pk_trans_est_fact PRIMARY KEY (fact_est_cod, est_fact_est_cod);


--
-- Name: pk_trans_est_nv; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY trans_est_nv
    ADD CONSTRAINT pk_trans_est_nv PRIMARY KEY (est_not_ven_est_cod, not_ven_est_cod);


--
-- Name: pk_trans_est_oc; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY trans_est_oc
    ADD CONSTRAINT pk_trans_est_oc PRIMARY KEY (est_oc_est_cod, oc_est_cod);


--
-- Name: pk_trans_est_od; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY trans_est_od
    ADD CONSTRAINT pk_trans_est_od PRIMARY KEY (od_est_cod, est_od_est_cod);


--
-- Name: pk_trans_est_ot; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY trans_est_ot
    ADD CONSTRAINT pk_trans_est_ot PRIMARY KEY (ot_est_cod, est_ot_est_cod);


--
-- Name: pk_vehiculo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY vehiculo
    ADD CONSTRAINT pk_vehiculo PRIMARY KEY (veh_pat);


--
-- Name: pk_vehiculo_serviciorep; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY vehiculo_serviciorep
    ADD CONSTRAINT pk_vehiculo_serviciorep PRIMARY KEY (serv_cod, marca_cod, modelo_cod, modelo_ano);


--
-- Name: accesorio_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX accesorio_pk ON accesorio USING btree (art_cod);


--
-- Name: art_hist_pre_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX art_hist_pre_pk ON art_hist_pre USING btree (hist_cod);


--
-- Name: art_prop_valor_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX art_prop_valor_pk ON art_prop_valor USING btree (prop_cod, dom_cod);


--
-- Name: articulo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX articulo_pk ON articulo USING btree (art_cod);


--
-- Name: boleta_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX boleta_pk ON boleta USING btree (doc_pago_cod);


--
-- Name: cargo_empleado_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX cargo_empleado_pk ON cargo_empleado USING btree (cargo_cod);


--
-- Name: cliente_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX cliente_pk ON cliente USING btree (cliente_cod);


--
-- Name: compatibilidad_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX compatibilidad_pk ON compatibilidad USING btree (marca_cod, art_cod, modelo_cod, modelo_ano);


--
-- Name: cot_odc_art_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX cot_odc_art_pk ON cot_odc_art USING btree (doc_cod);


--
-- Name: cot_odc_serv_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX cot_odc_serv_pk ON cot_odc_serv USING btree (doc_cod);


--
-- Name: cotizacion_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX cotizacion_pk ON cotizacion USING btree (doc_cod);


--
-- Name: det_cot_odc_art_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX det_cot_odc_art_pk ON det_cot_odc_art USING btree (doc_cod, det_num_linea);


--
-- Name: det_ot_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX det_ot_pk ON det_ot USING btree (ot_cod, ot_num_linea);


--
-- Name: doc_previo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX doc_previo_pk ON doc_previo USING btree (doc_cod);


--
-- Name: documento_de_pago_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX documento_de_pago_pk ON documento_de_pago USING btree (doc_pago_cod);


--
-- Name: dom_val_art_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX dom_val_art_pk ON dom_val_art USING btree (dom_cod);


--
-- Name: empleados_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX empleados_pk ON empleado USING btree (emp_rut);


--
-- Name: estado_cotizacion_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX estado_cotizacion_pk ON estado_cotizacion USING btree (cot_est_cod);


--
-- Name: estado_factura_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX estado_factura_pk ON estado_factura USING btree (fact_est_cod);


--
-- Name: estado_nota_de_venta_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX estado_nota_de_venta_pk ON estado_nota_de_venta USING btree (not_ven_est_cod);


--
-- Name: estado_oc_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX estado_oc_pk ON estado_oc USING btree (oc_est_cod);


--
-- Name: estado_od_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX estado_od_pk ON estado_od USING btree (od_est_cod);


--
-- Name: estado_ot_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX estado_ot_pk ON estado_ot USING btree (ot_est_cod);


--
-- Name: factura_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX factura_pk ON factura USING btree (doc_pago_cod);


--
-- Name: herramienta_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX herramienta_pk ON herramienta USING btree (art_cod);


--
-- Name: hist_est_cot_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX hist_est_cot_pk ON hist_est_cot USING btree (doc_cod, cot_est_cod);


--
-- Name: hist_est_fact_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX hist_est_fact_pk ON hist_est_fact USING btree (fact_est_cod, doc_pago_cod);


--
-- Name: hist_est_nv_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX hist_est_nv_pk ON hist_est_nv USING btree (not_ven_cod, not_ven_est_cod);


--
-- Name: hist_est_oc_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX hist_est_oc_pk ON hist_est_oc USING btree (doc_cod, oc_est_cod);


--
-- Name: hist_est_od_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX hist_est_od_pk ON hist_est_od USING btree (od_cod, od_est_cod);


--
-- Name: hist_est_ot_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX hist_est_ot_pk ON hist_est_ot USING btree (ot_cod, ot_est_cod);


--
-- Name: index_empleados_on_reset_password_token; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX index_empleados_on_reset_password_token ON empleado USING btree (reset_password_token);


--
-- Name: insumo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX insumo_pk ON insumo USING btree (art_cod);


--
-- Name: marca_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX marca_pk ON marca USING btree (marca_cod);


--
-- Name: metodo_de_pago_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX metodo_de_pago_pk ON metodo_de_pago USING btree (pago_cod);


--
-- Name: modelo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX modelo_pk ON modelo USING btree (marca_cod, modelo_cod, modelo_ano);


--
-- Name: nota_de_venta_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX nota_de_venta_pk ON nota_de_venta USING btree (not_ven_cod);


--
-- Name: orden_de_compra_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX orden_de_compra_pk ON orden_de_compra USING btree (doc_cod);


--
-- Name: orden_de_despacho_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX orden_de_despacho_pk ON orden_de_despacho USING btree (od_cod);


--
-- Name: orden_de_trabajo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX orden_de_trabajo_pk ON orden_de_trabajo USING btree (ot_cod);


--
-- Name: para_instalacion_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX para_instalacion_pk ON para_instalacion USING btree (art_cod);


--
-- Name: propiedad_articulo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX propiedad_articulo_pk ON propiedad_articulo USING btree (prop_cod);


--
-- Name: proveedor_articulo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX proveedor_articulo_pk ON proveedor_articulo USING btree (prov_cod, art_cod);


--
-- Name: proveedor_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX proveedor_pk ON proveedor USING btree (prov_cod);


--
-- Name: relationship_101_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_101_fk ON tran_est_cot USING btree (cot_est_cod);


--
-- Name: relationship_102_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_102_fk ON tran_est_cot USING btree (est_cot_est_cod);


--
-- Name: relationship_103_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_103_fk ON hist_est_cot USING btree (doc_cod);


--
-- Name: relationship_104_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_104_fk ON hist_est_cot USING btree (cot_est_cod);


--
-- Name: relationship_10_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_10_fk ON vehiculo_serviciorep USING btree (serv_cod);


--
-- Name: relationship_111_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_111_fk ON hist_est_oc USING btree (doc_cod);


--
-- Name: relationship_114_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_114_fk ON trans_est_oc USING btree (est_oc_est_cod);


--
-- Name: relationship_115_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_115_fk ON trans_est_oc USING btree (oc_est_cod);


--
-- Name: relationship_116_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_116_fk ON hist_est_oc USING btree (oc_est_cod);


--
-- Name: relationship_11_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_11_fk ON modelo USING btree (marca_cod);


--
-- Name: relationship_12_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_12_fk ON vehiculo_serviciorep USING btree (marca_cod, modelo_cod, modelo_ano);


--
-- Name: relationship_13_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_13_fk ON serv_rep_det USING btree (serv_cod, marca_cod, modelo_cod, modelo_ano);


--
-- Name: relationship_14_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_14_fk ON proveedor_articulo USING btree (prov_cod);


--
-- Name: relationship_15_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_15_fk ON proveedor_articulo USING btree (art_cod);


--
-- Name: relationship_16_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_16_fk ON si_vehiculo_articulo USING btree (art_cod);


--
-- Name: relationship_17_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_17_fk ON si_vehiculo_articulo USING btree (marca_cod, modelo_cod, modelo_ano);


--
-- Name: relationship_18_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_18_fk ON serv_inst_det USING btree (marca_cod, art_cod, modelo_cod, modelo_ano);


--
-- Name: relationship_19_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_19_fk ON articulo USING btree (art_tipo_cod);


--
-- Name: relationship_1_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_1_fk ON det_cot_odc_art USING btree (doc_cod);


--
-- Name: relationship_26_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_26_fk ON propiedad_articulo USING btree (dom_cod);


--
-- Name: relationship_27_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_27_fk ON compatibilidad USING btree (art_cod);


--
-- Name: relationship_28_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_28_fk ON compatibilidad USING btree (marca_cod, modelo_cod, modelo_ano);


--
-- Name: relationship_29_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_29_fk ON propiedad_articulo USING btree (art_tipo_cod);


--
-- Name: relationship_2_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_2_fk ON det_cot_odc_art USING btree (art_cod);


--
-- Name: relationship_30_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_30_fk ON art_prop_valor USING btree (art_cod);


--
-- Name: relationship_31_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_31_fk ON art_prop_valor USING btree (prop_cod);


--
-- Name: relationship_32_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_32_fk ON art_prop_valor USING btree (dom_cod);


--
-- Name: relationship_35_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_35_fk ON art_hist_pre USING btree (art_cod);


--
-- Name: relationship_36_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_36_fk ON orden_de_trabajo USING btree (doc_cod);


--
-- Name: relationship_37_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_37_fk ON orden_de_trabajo USING btree (not_ven_cod);


--
-- Name: relationship_38_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_38_fk ON vehiculo USING btree (marca_cod, modelo_cod, modelo_ano);


--
-- Name: relationship_39_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_39_fk ON orden_de_trabajo USING btree (veh_pat);


--
-- Name: relationship_40_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_40_fk ON det_ot USING btree (ot_cod);


--
-- Name: relationship_41_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_41_fk ON det_ot USING btree (serv_cod, marca_cod, modelo_cod, modelo_ano);


--
-- Name: relationship_42_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_42_fk ON nota_de_venta USING btree (pago_cod);


--
-- Name: relationship_43_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_43_fk ON empleado USING btree (cargo_cod);


--
-- Name: relationship_4_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_4_fk ON serv_inst_det USING btree (doc_cod);


--
-- Name: relationship_51_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_51_fk ON nota_de_venta USING btree (od_cod);


--
-- Name: relationship_52_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_52_fk ON orden_de_despacho USING btree (not_ven_cod);


--
-- Name: relationship_53_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_53_fk ON cotizacion USING btree (cot_est_cod);


--
-- Name: relationship_55_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_55_fk ON orden_de_despacho USING btree (od_est_cod);


--
-- Name: relationship_56_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_56_fk ON orden_de_trabajo USING btree (ot_est_cod);


--
-- Name: relationship_66_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_66_fk ON doc_previo USING btree (emp_rut);


--
-- Name: relationship_67_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_67_fk ON orden_de_trabajo USING btree (emp_rut);


--
-- Name: relationship_69_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_69_fk ON nota_de_venta USING btree (doc_pago_cod);


--
-- Name: relationship_6_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_6_fk ON serv_rep_det USING btree (doc_cod);


--
-- Name: relationship_77_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_77_fk ON nota_de_venta USING btree (not_ven_est_cod);


--
-- Name: relationship_7_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_7_fk ON doc_previo USING btree (not_ven_cod);


--
-- Name: relationship_80_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_80_fk ON orden_de_compra USING btree (oc_est_cod);


--
-- Name: relationship_81_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_81_fk ON trans_est_nv USING btree (est_not_ven_est_cod);


--
-- Name: relationship_82_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_82_fk ON trans_est_nv USING btree (not_ven_est_cod);


--
-- Name: relationship_83_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_83_fk ON hist_est_nv USING btree (not_ven_cod);


--
-- Name: relationship_84_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_84_fk ON hist_est_nv USING btree (not_ven_est_cod);


--
-- Name: relationship_85_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_85_fk ON trans_est_ot USING btree (ot_est_cod);


--
-- Name: relationship_86_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_86_fk ON trans_est_ot USING btree (est_ot_est_cod);


--
-- Name: relationship_87_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_87_fk ON hist_est_ot USING btree (ot_cod);


--
-- Name: relationship_88_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_88_fk ON hist_est_ot USING btree (ot_est_cod);


--
-- Name: relationship_89_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_89_fk ON trans_est_od USING btree (od_est_cod);


--
-- Name: relationship_8_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_8_fk ON doc_previo USING btree (cliente_cod);


--
-- Name: relationship_90_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_90_fk ON trans_est_od USING btree (est_od_est_cod);


--
-- Name: relationship_93_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_93_fk ON hist_est_od USING btree (od_cod);


--
-- Name: relationship_94_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_94_fk ON hist_est_od USING btree (od_est_cod);


--
-- Name: relationship_95_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_95_fk ON trans_est_fact USING btree (fact_est_cod);


--
-- Name: relationship_96_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_96_fk ON trans_est_fact USING btree (est_fact_est_cod);


--
-- Name: relationship_97_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_97_fk ON factura USING btree (fact_est_cod);


--
-- Name: relationship_98_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_98_fk ON hist_est_fact USING btree (fact_est_cod);


--
-- Name: relationship_99_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_99_fk ON hist_est_fact USING btree (doc_pago_cod);


--
-- Name: relationship_9_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_9_fk ON cliente USING btree (tipo_cliente_cod);


--
-- Name: repuesto_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX repuesto_pk ON repuesto USING btree (art_cod);


--
-- Name: serv_inst_det_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX serv_inst_det_pk ON serv_inst_det USING btree (doc_cod, si_num_linea);


--
-- Name: serv_inst_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX serv_inst_pk ON serv_inst USING btree (doc_cod);


--
-- Name: serv_rep_det_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX serv_rep_det_pk ON serv_rep_det USING btree (doc_cod, sr_num_linea);


--
-- Name: serv_rep_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX serv_rep_pk ON serv_rep USING btree (doc_cod);


--
-- Name: servicio_reparacion_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX servicio_reparacion_pk ON servicio_reparacion USING btree (serv_cod);


--
-- Name: si_vehiculo_articulo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX si_vehiculo_articulo_pk ON si_vehiculo_articulo USING btree (marca_cod, art_cod, modelo_cod, modelo_ano);


--
-- Name: tipo_articulo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX tipo_articulo_pk ON tipo_articulo USING btree (art_tipo_cod);


--
-- Name: tipo_cliente_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX tipo_cliente_pk ON tipo_cliente USING btree (tipo_cliente_cod);


--
-- Name: tran_est_cot_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX tran_est_cot_pk ON tran_est_cot USING btree (cot_est_cod, est_cot_est_cod);


--
-- Name: trans_est_fact_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX trans_est_fact_pk ON trans_est_fact USING btree (fact_est_cod, est_fact_est_cod);


--
-- Name: trans_est_nv_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX trans_est_nv_pk ON trans_est_nv USING btree (est_not_ven_est_cod, not_ven_est_cod);


--
-- Name: trans_est_oc_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX trans_est_oc_pk ON trans_est_oc USING btree (est_oc_est_cod, oc_est_cod);


--
-- Name: trans_est_od_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX trans_est_od_pk ON trans_est_od USING btree (od_est_cod, est_od_est_cod);


--
-- Name: trans_est_ot_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX trans_est_ot_pk ON trans_est_ot USING btree (ot_est_cod, est_ot_est_cod);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: vehiculo_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX vehiculo_pk ON vehiculo USING btree (veh_pat);


--
-- Name: vehiculo_serviciorep_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX vehiculo_serviciorep_pk ON vehiculo_serviciorep USING btree (serv_cod, marca_cod, modelo_cod, modelo_ano);


--
-- Name: accesorio_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER accesorio_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON cliente
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: borrarnotadeventa; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER borrarnotadeventa
    AFTER DELETE ON nota_de_venta
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestcotabnotvent();


--
-- Name: cambio_est_cot; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_cot
    AFTER UPDATE ON cotizacion
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestcot();

ALTER TABLE cotizacion DISABLE TRIGGER cambio_est_cot;


--
-- Name: cambio_est_cot_in; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_cot_in
    AFTER INSERT ON cotizacion
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestcot_in();

ALTER TABLE cotizacion DISABLE TRIGGER cambio_est_cot_in;


--
-- Name: cambio_est_fact; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_fact
    BEFORE UPDATE ON factura
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestfact();


--
-- Name: cambio_est_fact_in; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_fact_in
    AFTER INSERT ON factura
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestfact_in();


--
-- Name: cambio_est_nv; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_nv
    BEFORE UPDATE ON nota_de_venta
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestnv();

ALTER TABLE nota_de_venta DISABLE TRIGGER cambio_est_nv;


--
-- Name: cambio_est_nv_in; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_nv_in
    AFTER INSERT ON nota_de_venta
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestnv_in();

ALTER TABLE nota_de_venta DISABLE TRIGGER cambio_est_nv_in;


--
-- Name: cambio_est_oc; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_oc
    BEFORE UPDATE ON orden_de_compra
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestoc();


--
-- Name: cambio_est_oc_in; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_oc_in
    AFTER INSERT ON orden_de_compra
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestoc_in();


--
-- Name: cambio_est_od; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_od
    BEFORE UPDATE ON orden_de_despacho
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestod();


--
-- Name: cambio_est_od_in; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_od_in
    AFTER INSERT ON orden_de_despacho
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestod_in();


--
-- Name: cambio_est_ot; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_ot
    BEFORE UPDATE ON orden_de_trabajo
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestot();


--
-- Name: cambio_est_ot_in; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cambio_est_ot_in
    AFTER INSERT ON orden_de_trabajo
    FOR EACH ROW
    EXECUTE PROCEDURE cambiodeestot_in();


--
-- Name: cargo_empleado_fact_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cargo_empleado_fact_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON cargo_empleado
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: compatibilidad_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER compatibilidad_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON compatibilidad
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: cotizacion_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER cotizacion_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON cotizacion
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: creaarticulohetrg; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER creaarticulohetrg
    BEFORE INSERT ON herramienta
    FOR EACH ROW
    EXECUTE PROCEDURE creaarticuloni();


--
-- Name: creaarticulointrg; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER creaarticulointrg
    BEFORE INSERT ON insumo
    FOR EACH ROW
    EXECUTE PROCEDURE creaarticuloni();


--
-- Name: creaarticuloretrg; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER creaarticuloretrg
    BEFORE INSERT ON repuesto
    FOR EACH ROW
    EXECUTE PROCEDURE creaarticulo();


--
-- Name: creaarticulotrg; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER creaarticulotrg
    BEFORE INSERT ON accesorio
    FOR EACH ROW
    EXECUTE PROCEDURE creaarticulo();


--
-- Name: creacotart; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER creacotart
    BEFORE INSERT ON cot_odc_art
    FOR EACH ROW
    EXECUTE PROCEDURE creacotartdocpcot();


--
-- Name: creacotsi; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER creacotsi
    BEFORE INSERT ON serv_inst
    FOR EACH ROW
    EXECUTE PROCEDURE creacotsidocpcot();


--
-- Name: creanotav; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER creanotav
    AFTER UPDATE ON cotizacion
    FOR EACH ROW
    EXECUTE PROCEDURE crearnotvent();


--
-- Name: creaot_oc; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER creaot_oc
    AFTER UPDATE ON orden_de_compra
    FOR EACH ROW
    EXECUTE PROCEDURE creaot();


--
-- Name: det_cot_odc_art_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER det_cot_odc_art_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON det_cot_odc_art
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: det_ot_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER det_ot_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON det_ot
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: doc_previo_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER doc_previo_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON doc_previo
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: documento_de_pago_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER documento_de_pago_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON documento_de_pago
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: dom_val_art_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER dom_val_art_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON dom_val_art
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: empleado_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER empleado_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON empleado
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: estado_cotizacion_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER estado_cotizacion_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON estado_cotizacion
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: estado_factura_art_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER estado_factura_art_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON estado_factura
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: estado_nota_de_venta_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER estado_nota_de_venta_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON estado_nota_de_venta
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: estado_oc_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER estado_oc_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON estado_oc
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: estado_od_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER estado_od_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON estado_od
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: estado_ot_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER estado_ot_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON estado_ot
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: hist_est_cot_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER hist_est_cot_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON hist_est_cot
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: hist_est_fact_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER hist_est_fact_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON hist_est_fact
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: hist_est_nv_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER hist_est_nv_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON hist_est_nv
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: hist_est_oc_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER hist_est_oc_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON hist_est_oc
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: hist_est_od_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER hist_est_od_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON hist_est_od
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: hist_est_ot_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER hist_est_ot_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON hist_est_ot
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: marca_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER marca_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON marca
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: metodo_de_pago_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER metodo_de_pago_audit
    AFTER INSERT OR DELETE OR UPDATE ON metodo_de_pago
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: modelo_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER modelo_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON modelo
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: nota_de_venta_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER nota_de_venta_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON nota_de_venta
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: orden_de_compra_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER orden_de_compra_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON orden_de_compra
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: orden_de_despacho_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER orden_de_despacho_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON orden_de_despacho
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: orden_de_trabajo_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER orden_de_trabajo_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON orden_de_trabajo
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: parametros_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER parametros_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON parametros
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: propiedad_articulo_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER propiedad_articulo_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON propiedad_articulo
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: proveedor_articulo_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER proveedor_articulo_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON proveedor_articulo
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: proveedor_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER proveedor_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON proveedor
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: serv_inst_det_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER serv_inst_det_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON serv_inst_det
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: serv_rep_det_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER serv_rep_det_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON serv_rep_det
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: servicio_reparacion_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER servicio_reparacion_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON servicio_reparacion
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: si_vehiculo_articulo_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER si_vehiculo_articulo_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON si_vehiculo_articulo
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: tipo_articulo_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER tipo_articulo_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON tipo_articulo
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: tipo_cliente_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER tipo_cliente_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON tipo_cliente
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: tran_est_cot_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER tran_est_cot_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON tran_est_cot
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: trans_est_fact_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER trans_est_fact_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON trans_est_fact
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: trans_est_nv_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER trans_est_nv_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON trans_est_nv
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: trans_est_oc_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER trans_est_oc_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON trans_est_oc
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: trans_est_od_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER trans_est_od_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON trans_est_fact
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: trans_est_ot_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER trans_est_ot_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON trans_est_fact
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: vehiculo_serviciorep_fact_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER vehiculo_serviciorep_fact_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON vehiculo_serviciorep
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: vehiculo_tg_audit; Type: TRIGGER; Schema: public; Owner: seba
--

CREATE TRIGGER vehiculo_tg_audit
    AFTER INSERT OR DELETE OR UPDATE ON vehiculo
    FOR EACH ROW
    EXECUTE PROCEDURE fn_log_audit();


--
-- Name: fk_accesori_inheritan_para_ins; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY accesorio
    ADD CONSTRAINT fk_accesori_inheritan_para_ins FOREIGN KEY (art_cod) REFERENCES para_instalacion(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_art_hist_relations_articulo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY art_hist_pre
    ADD CONSTRAINT fk_art_hist_relations_articulo FOREIGN KEY (art_cod) REFERENCES articulo(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_art_prop_relations_articulo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY art_prop_valor
    ADD CONSTRAINT fk_art_prop_relations_articulo FOREIGN KEY (art_cod) REFERENCES articulo(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_art_prop_relations_dom_val_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY art_prop_valor
    ADD CONSTRAINT fk_art_prop_relations_dom_val_ FOREIGN KEY (dom_cod) REFERENCES dom_val_art(dom_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_art_prop_relations_propieda; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY art_prop_valor
    ADD CONSTRAINT fk_art_prop_relations_propieda FOREIGN KEY (prop_cod) REFERENCES propiedad_articulo(prop_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_articulo_relations_tipo_art; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY articulo
    ADD CONSTRAINT fk_articulo_relations_tipo_art FOREIGN KEY (art_tipo_cod) REFERENCES tipo_articulo(art_tipo_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_boleta_inheritan_document; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY boleta
    ADD CONSTRAINT fk_boleta_inheritan_document FOREIGN KEY (doc_pago_cod) REFERENCES documento_de_pago(doc_pago_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_cliente_cot_odc_art; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY cot_odc_art
    ADD CONSTRAINT fk_cliente_cot_odc_art FOREIGN KEY (cliente_cod) REFERENCES cliente(cliente_cod);


--
-- Name: fk_cliente_relations_tipo_cli; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT fk_cliente_relations_tipo_cli FOREIGN KEY (tipo_cliente_cod) REFERENCES tipo_cliente(tipo_cliente_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_cliente_serv_inst; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY serv_inst
    ADD CONSTRAINT fk_cliente_serv_inst FOREIGN KEY (cliente_cod) REFERENCES cliente(cliente_cod);


--
-- Name: fk_compatib_relations_modelo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY compatibilidad
    ADD CONSTRAINT fk_compatib_relations_modelo FOREIGN KEY (marca_cod, modelo_cod, modelo_ano) REFERENCES modelo(marca_cod, modelo_cod, modelo_ano) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_compatib_relations_para_ins; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY compatibilidad
    ADD CONSTRAINT fk_compatib_relations_para_ins FOREIGN KEY (art_cod) REFERENCES para_instalacion(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_cot_odc__inheritan_doc_prev; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY cot_odc_art
    ADD CONSTRAINT fk_cot_odc__inheritan_doc_prev FOREIGN KEY (doc_cod) REFERENCES doc_previo(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_cot_odc__inheritan_doc_prev; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY cot_odc_serv
    ADD CONSTRAINT fk_cot_odc__inheritan_doc_prev FOREIGN KEY (doc_cod) REFERENCES doc_previo(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_cotizaci_inheritan_doc_prev; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY cotizacion
    ADD CONSTRAINT fk_cotizaci_inheritan_doc_prev FOREIGN KEY (doc_cod) REFERENCES doc_previo(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_cotizaci_relations_estado_c; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY cotizacion
    ADD CONSTRAINT fk_cotizaci_relations_estado_c FOREIGN KEY (cot_est_cod) REFERENCES estado_cotizacion(cot_est_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_det_cot__relations_articulo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY det_cot_odc_art
    ADD CONSTRAINT fk_det_cot__relations_articulo FOREIGN KEY (art_cod) REFERENCES articulo(art_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_det_cot__relations_cot_odc_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY det_cot_odc_art
    ADD CONSTRAINT fk_det_cot__relations_cot_odc_ FOREIGN KEY (doc_cod) REFERENCES cot_odc_art(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_det_ot_relations_orden_de; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY det_ot
    ADD CONSTRAINT fk_det_ot_relations_orden_de FOREIGN KEY (ot_cod) REFERENCES orden_de_trabajo(ot_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_det_ot_relations_vehiculo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY det_ot
    ADD CONSTRAINT fk_det_ot_relations_vehiculo FOREIGN KEY (serv_cod, marca_cod, modelo_cod, modelo_ano) REFERENCES vehiculo_serviciorep(serv_cod, marca_cod, modelo_cod, modelo_ano) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_doc_prev_relations_cliente; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY doc_previo
    ADD CONSTRAINT fk_doc_prev_relations_cliente FOREIGN KEY (cliente_cod) REFERENCES cliente(cliente_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_doc_prev_relations_empleado; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY doc_previo
    ADD CONSTRAINT fk_doc_prev_relations_empleado FOREIGN KEY (emp_rut) REFERENCES empleado(emp_rut) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_doc_prev_relations_nota_de_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY doc_previo
    ADD CONSTRAINT fk_doc_prev_relations_nota_de_ FOREIGN KEY (not_ven_cod) REFERENCES nota_de_venta(not_ven_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_docp_notvent; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY nota_de_venta
    ADD CONSTRAINT fk_docp_notvent FOREIGN KEY (doc_cod) REFERENCES doc_previo(doc_cod);


--
-- Name: fk_empleado_relations_cargo_em; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT fk_empleado_relations_cargo_em FOREIGN KEY (cargo_cod) REFERENCES cargo_empleado(cargo_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_factura_inheritan_document; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT fk_factura_inheritan_document FOREIGN KEY (doc_pago_cod) REFERENCES documento_de_pago(doc_pago_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_factura_relations_estado_f; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT fk_factura_relations_estado_f FOREIGN KEY (fact_est_cod) REFERENCES estado_factura(fact_est_cod) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_herramie_inheritan_articulo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY herramienta
    ADD CONSTRAINT fk_herramie_inheritan_articulo FOREIGN KEY (art_cod) REFERENCES articulo(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_cotizaci; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_cot
    ADD CONSTRAINT fk_hist_est_relations_cotizaci FOREIGN KEY (doc_cod) REFERENCES cotizacion(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_estado_c; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_cot
    ADD CONSTRAINT fk_hist_est_relations_estado_c FOREIGN KEY (cot_est_cod) REFERENCES estado_cotizacion(cot_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_estado_f; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_fact
    ADD CONSTRAINT fk_hist_est_relations_estado_f FOREIGN KEY (fact_est_cod) REFERENCES estado_factura(fact_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_estado_n; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_nv
    ADD CONSTRAINT fk_hist_est_relations_estado_n FOREIGN KEY (not_ven_est_cod) REFERENCES estado_nota_de_venta(not_ven_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_estado_o; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_oc
    ADD CONSTRAINT fk_hist_est_relations_estado_o FOREIGN KEY (oc_est_cod) REFERENCES estado_oc(oc_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_estado_o; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_od
    ADD CONSTRAINT fk_hist_est_relations_estado_o FOREIGN KEY (od_est_cod) REFERENCES estado_od(od_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_estado_o; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_ot
    ADD CONSTRAINT fk_hist_est_relations_estado_o FOREIGN KEY (ot_est_cod) REFERENCES estado_ot(ot_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_factura; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_fact
    ADD CONSTRAINT fk_hist_est_relations_factura FOREIGN KEY (doc_pago_cod) REFERENCES factura(doc_pago_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_nota_de_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_nv
    ADD CONSTRAINT fk_hist_est_relations_nota_de_ FOREIGN KEY (not_ven_cod) REFERENCES nota_de_venta(not_ven_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_orden_de; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_oc
    ADD CONSTRAINT fk_hist_est_relations_orden_de FOREIGN KEY (doc_cod) REFERENCES orden_de_compra(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_orden_de; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_od
    ADD CONSTRAINT fk_hist_est_relations_orden_de FOREIGN KEY (od_cod) REFERENCES orden_de_despacho(od_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_hist_est_relations_orden_de; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY hist_est_ot
    ADD CONSTRAINT fk_hist_est_relations_orden_de FOREIGN KEY (ot_cod) REFERENCES orden_de_trabajo(ot_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_insumo_inheritan_articulo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY insumo
    ADD CONSTRAINT fk_insumo_inheritan_articulo FOREIGN KEY (art_cod) REFERENCES articulo(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_modelo_relations_marca; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY modelo
    ADD CONSTRAINT fk_modelo_relations_marca FOREIGN KEY (marca_cod) REFERENCES marca(marca_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_nota_de__relations_document; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY nota_de_venta
    ADD CONSTRAINT fk_nota_de__relations_document FOREIGN KEY (doc_pago_cod) REFERENCES documento_de_pago(doc_pago_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_nota_de__relations_estado_n; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY nota_de_venta
    ADD CONSTRAINT fk_nota_de__relations_estado_n FOREIGN KEY (not_ven_est_cod) REFERENCES estado_nota_de_venta(not_ven_est_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_nota_de__relations_metodo_d; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY nota_de_venta
    ADD CONSTRAINT fk_nota_de__relations_metodo_d FOREIGN KEY (pago_cod) REFERENCES metodo_de_pago(pago_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_nota_de__relations_orden_de; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY nota_de_venta
    ADD CONSTRAINT fk_nota_de__relations_orden_de FOREIGN KEY (od_cod) REFERENCES orden_de_despacho(od_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_orden_de_inheritan_doc_prev; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_compra
    ADD CONSTRAINT fk_orden_de_inheritan_doc_prev FOREIGN KEY (doc_cod) REFERENCES doc_previo(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_orden_de_relations_doc_prev; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_trabajo
    ADD CONSTRAINT fk_orden_de_relations_doc_prev FOREIGN KEY (doc_cod) REFERENCES doc_previo(doc_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_orden_de_relations_empleado; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_trabajo
    ADD CONSTRAINT fk_orden_de_relations_empleado FOREIGN KEY (emp_rut) REFERENCES empleado(emp_rut) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_orden_de_relations_estado_o; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_compra
    ADD CONSTRAINT fk_orden_de_relations_estado_o FOREIGN KEY (oc_est_cod) REFERENCES estado_oc(oc_est_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_orden_de_relations_estado_o; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_despacho
    ADD CONSTRAINT fk_orden_de_relations_estado_o FOREIGN KEY (od_est_cod) REFERENCES estado_od(od_est_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_orden_de_relations_estado_o; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_trabajo
    ADD CONSTRAINT fk_orden_de_relations_estado_o FOREIGN KEY (ot_est_cod) REFERENCES estado_ot(ot_est_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fk_orden_de_relations_nota_de_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_despacho
    ADD CONSTRAINT fk_orden_de_relations_nota_de_ FOREIGN KEY (not_ven_cod) REFERENCES nota_de_venta(not_ven_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_orden_de_relations_nota_de_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_trabajo
    ADD CONSTRAINT fk_orden_de_relations_nota_de_ FOREIGN KEY (not_ven_cod) REFERENCES nota_de_venta(not_ven_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_orden_de_relations_vehiculo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY orden_de_trabajo
    ADD CONSTRAINT fk_orden_de_relations_vehiculo FOREIGN KEY (veh_pat) REFERENCES vehiculo(veh_pat) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_para_ins_inheritan_articulo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY para_instalacion
    ADD CONSTRAINT fk_para_ins_inheritan_articulo FOREIGN KEY (art_cod) REFERENCES articulo(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_propieda_relations_dom_val_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY propiedad_articulo
    ADD CONSTRAINT fk_propieda_relations_dom_val_ FOREIGN KEY (dom_cod) REFERENCES dom_val_art(dom_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_propieda_relations_tipo_art; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY propiedad_articulo
    ADD CONSTRAINT fk_propieda_relations_tipo_art FOREIGN KEY (art_tipo_cod) REFERENCES tipo_articulo(art_tipo_cod) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_proveedo_relations_articulo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY proveedor_articulo
    ADD CONSTRAINT fk_proveedo_relations_articulo FOREIGN KEY (art_cod) REFERENCES articulo(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_proveedo_relations_proveedo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY proveedor_articulo
    ADD CONSTRAINT fk_proveedo_relations_proveedo FOREIGN KEY (prov_cod) REFERENCES proveedor(prov_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_repuesto_inheritan_para_ins; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY repuesto
    ADD CONSTRAINT fk_repuesto_inheritan_para_ins FOREIGN KEY (art_cod) REFERENCES para_instalacion(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_serv_ins_inheritan_cot_odc_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY serv_inst
    ADD CONSTRAINT fk_serv_ins_inheritan_cot_odc_ FOREIGN KEY (doc_cod) REFERENCES cot_odc_serv(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_serv_ins_relations_serv_ins; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY serv_inst_det
    ADD CONSTRAINT fk_serv_ins_relations_serv_ins FOREIGN KEY (doc_cod) REFERENCES serv_inst(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_serv_ins_relations_si_vehic; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY serv_inst_det
    ADD CONSTRAINT fk_serv_ins_relations_si_vehic FOREIGN KEY (marca_cod, art_cod, modelo_cod, modelo_ano) REFERENCES si_vehiculo_articulo(marca_cod, art_cod, modelo_cod, modelo_ano) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_serv_rep_inheritan_cot_odc_; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY serv_rep
    ADD CONSTRAINT fk_serv_rep_inheritan_cot_odc_ FOREIGN KEY (doc_cod) REFERENCES cot_odc_serv(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_serv_rep_relations_serv_rep; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY serv_rep_det
    ADD CONSTRAINT fk_serv_rep_relations_serv_rep FOREIGN KEY (doc_cod) REFERENCES serv_rep(doc_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_serv_rep_relations_vehiculo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY serv_rep_det
    ADD CONSTRAINT fk_serv_rep_relations_vehiculo FOREIGN KEY (serv_cod, marca_cod, modelo_cod, modelo_ano) REFERENCES vehiculo_serviciorep(serv_cod, marca_cod, modelo_cod, modelo_ano) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_si_vehic_relations_modelo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY si_vehiculo_articulo
    ADD CONSTRAINT fk_si_vehic_relations_modelo FOREIGN KEY (marca_cod, modelo_cod, modelo_ano) REFERENCES modelo(marca_cod, modelo_cod, modelo_ano) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_si_vehic_relations_para_ins; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY si_vehiculo_articulo
    ADD CONSTRAINT fk_si_vehic_relations_para_ins FOREIGN KEY (art_cod) REFERENCES para_instalacion(art_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_tran_est_relations_estado_c1; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY tran_est_cot
    ADD CONSTRAINT fk_tran_est_relations_estado_c1 FOREIGN KEY (cot_est_cod) REFERENCES estado_cotizacion(cot_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_tran_est_relations_estado_c2; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY tran_est_cot
    ADD CONSTRAINT fk_tran_est_relations_estado_c2 FOREIGN KEY (est_cot_est_cod) REFERENCES estado_cotizacion(cot_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_f1; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_fact
    ADD CONSTRAINT fk_trans_es_relations_estado_f1 FOREIGN KEY (fact_est_cod) REFERENCES estado_factura(fact_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_f2; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_fact
    ADD CONSTRAINT fk_trans_es_relations_estado_f2 FOREIGN KEY (est_fact_est_cod) REFERENCES estado_factura(fact_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_n1; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_nv
    ADD CONSTRAINT fk_trans_es_relations_estado_n1 FOREIGN KEY (est_not_ven_est_cod) REFERENCES estado_nota_de_venta(not_ven_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_n2; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_nv
    ADD CONSTRAINT fk_trans_es_relations_estado_n2 FOREIGN KEY (not_ven_est_cod) REFERENCES estado_nota_de_venta(not_ven_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_o1; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_oc
    ADD CONSTRAINT fk_trans_es_relations_estado_o1 FOREIGN KEY (est_oc_est_cod) REFERENCES estado_oc(oc_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_o1; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_od
    ADD CONSTRAINT fk_trans_es_relations_estado_o1 FOREIGN KEY (od_est_cod) REFERENCES estado_od(od_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_o1; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_ot
    ADD CONSTRAINT fk_trans_es_relations_estado_o1 FOREIGN KEY (ot_est_cod) REFERENCES estado_ot(ot_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_o2; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_oc
    ADD CONSTRAINT fk_trans_es_relations_estado_o2 FOREIGN KEY (oc_est_cod) REFERENCES estado_oc(oc_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_o2; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_od
    ADD CONSTRAINT fk_trans_es_relations_estado_o2 FOREIGN KEY (est_od_est_cod) REFERENCES estado_od(od_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_trans_es_relations_estado_o2; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY trans_est_ot
    ADD CONSTRAINT fk_trans_es_relations_estado_o2 FOREIGN KEY (est_ot_est_cod) REFERENCES estado_ot(ot_est_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_vehiculo_relations_modelo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY vehiculo
    ADD CONSTRAINT fk_vehiculo_relations_modelo FOREIGN KEY (marca_cod, modelo_cod, modelo_ano) REFERENCES modelo(marca_cod, modelo_cod, modelo_ano) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fk_vehiculo_relations_modelo; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY vehiculo_serviciorep
    ADD CONSTRAINT fk_vehiculo_relations_modelo FOREIGN KEY (marca_cod, modelo_cod, modelo_ano) REFERENCES modelo(marca_cod, modelo_cod, modelo_ano) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_vehiculo_relations_servicio; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY vehiculo_serviciorep
    ADD CONSTRAINT fk_vehiculo_relations_servicio FOREIGN KEY (serv_cod) REFERENCES servicio_reparacion(serv_cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

