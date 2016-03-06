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
-- Name: fingeso; Type: COMMENT; Schema: -; Owner: seba
--

COMMENT ON DATABASE fingeso IS 'BD para la app de fingeso';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cargo_empleado; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE cargo_empleado (
    cargo_cod integer NOT NULL,
    cargo_nom character varying
);


ALTER TABLE public.cargo_empleado OWNER TO seba;

--
-- Name: COLUMN cargo_empleado.cargo_cod; Type: COMMENT; Schema: public; Owner: seba
--

COMMENT ON COLUMN cargo_empleado.cargo_cod IS 'Llave del cargo';


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
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: seba; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO seba;

--
-- Data for Name: cargo_empleado; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY cargo_empleado (cargo_cod, cargo_nom) FROM stdin;
0	Profesor
1	Alumno
2	Administrador
\.


--
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY empleado (emp_rut, cargo_cod, emp_nom, emp_ape, emp_tel, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip) FROM stdin;
5893349-k	2	\N	\N	\N	vero@algo.com	$2a$10$S3YpnD.OUpNkeBQW77CqGu062nwjD7.wb0S0/2x3vppIoyRnbCzvu	\N	\N	\N	0	\N	\N	\N	\N
18519095-1	0	Juan	Perez	78018863	jperez@usach.cl	$2a$10$sOrM8HfRR7gVQNWfHgCeW.DjRQU0yfr0d.AvqjLtd5fJZNUj74wtC	\N	\N	\N	3	2016-03-06 21:19:19.852708	2016-03-06 21:11:55.769872	127.0.0.1	127.0.0.1
18293486-0	2	\N	\N	\N	calde@algo.com	$2a$10$oCV3tVm.vb.Rk7avcUr4jOYJpz0SdH0BiMzQbaIn7i.RtDMUKutWy	\N	\N	\N	8	2016-03-06 21:29:11.342168	2016-03-06 21:18:44.324887	127.0.0.1	127.0.0.1
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: seba
--

COPY schema_migrations (version) FROM stdin;
20160227233957
20160228013804
20160228045642
20160228132157
20160228135130
20160228135136
20160229033559
20160302131659
20160302131707
20160302131712
\.


--
-- Name: cargo; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY cargo_empleado
    ADD CONSTRAINT cargo PRIMARY KEY (cargo_cod);


--
-- Name: pk_empleados; Type: CONSTRAINT; Schema: public; Owner: seba; Tablespace: 
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT pk_empleados PRIMARY KEY (emp_rut);


--
-- Name: empleados_pk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX empleados_pk ON empleado USING btree (emp_rut);


--
-- Name: index_empleados_on_reset_password_token; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX index_empleados_on_reset_password_token ON empleado USING btree (reset_password_token);


--
-- Name: relationship_43_fk; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE INDEX relationship_43_fk ON empleado USING btree (cargo_cod);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: seba; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_empleado_relations_cargo_em; Type: FK CONSTRAINT; Schema: public; Owner: seba
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT fk_empleado_relations_cargo_em FOREIGN KEY (cargo_cod) REFERENCES cargo_empleado(cargo_cod) ON UPDATE CASCADE ON DELETE RESTRICT;


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

