--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.4
-- Dumped by pg_dump version 9.3.4
-- Started on 2015-05-16 03:05:32

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE IF EXISTS database100;
--
-- TOC entry 1940 (class 1262 OID 29632)
-- Name: database100; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE database100 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE database100 OWNER TO postgres;

\connect database100

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA IF NOT EXISTS public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 1941 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 172 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1943 (class 0 OID 0)
-- Dependencies: 172
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 170 (class 1259 OID 29633)
-- Name: campos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE campos (
    serialno integer NOT NULL,
    campo text
);


ALTER TABLE public.campos OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 29639)
-- Name: campos_serialno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE campos_serialno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campos_serialno_seq OWNER TO postgres;

--
-- TOC entry 1944 (class 0 OID 0)
-- Dependencies: 171
-- Name: campos_serialno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE campos_serialno_seq OWNED BY campos.serialno;


--
-- TOC entry 1824 (class 2604 OID 29641)
-- Name: serialno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campos ALTER COLUMN serialno SET DEFAULT nextval('campos_serialno_seq'::regclass);


--
-- TOC entry 1934 (class 0 OID 29633)
-- Dependencies: 170
-- Data for Name: campos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--COPY campos (serialno, campo) FROM stdin;
--\.


--
-- TOC entry 1945 (class 0 OID 0)
-- Dependencies: 171
-- Name: campos_serialno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('campos_serialno_seq', 4, true);


--
-- TOC entry 1826 (class 2606 OID 29643)
-- Name: serialnopk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY campos
    ADD CONSTRAINT serialnopk PRIMARY KEY (serialno);


--
-- TOC entry 1942 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-05-16 03:05:34

--
-- PostgreSQL database dump complete
--

