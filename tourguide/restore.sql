--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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

DROP DATABASE tourguide;
--
-- Name: tourguide; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE tourguide WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'German_Germany.1252';


ALTER DATABASE tourguide OWNER TO postgres;

\connect tourguide

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dim_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_category (
    cat_pk integer NOT NULL,
    cat_name character varying(20) NOT NULL
);


ALTER TABLE public.dim_category OWNER TO postgres;

--
-- Name: dim_category_cat_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_category_cat_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dim_category_cat_pk_seq OWNER TO postgres;

--
-- Name: dim_category_cat_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_category_cat_pk_seq OWNED BY public.dim_category.cat_pk;


--
-- Name: dim_languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_languages (
    lan_short_pk character varying(3) NOT NULL,
    lan_long_englisch character varying(20) NOT NULL,
    lan_long_deutsch character varying(20)
);


ALTER TABLE public.dim_languages OWNER TO postgres;

--
-- Name: dim_participant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_participant (
    par_pk integer NOT NULL,
    par_firstname character varying(100) NOT NULL,
    par_lastname character varying(100) NOT NULL,
    par_email character varying(100) NOT NULL,
    par_phone character varying(20) NOT NULL
);


ALTER TABLE public.dim_participant OWNER TO postgres;

--
-- Name: dim_participant_par_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_participant_par_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dim_participant_par_pk_seq OWNER TO postgres;

--
-- Name: dim_participant_par_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_participant_par_pk_seq OWNED BY public.dim_participant.par_pk;


--
-- Name: dim_places; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_places (
    pl_pk integer NOT NULL,
    pl_plz character varying(5) NOT NULL,
    pl_street character varying(200) NOT NULL,
    pl_number character varying(10)
);


ALTER TABLE public.dim_places OWNER TO postgres;

--
-- Name: dim_places_pl_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_places_pl_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dim_places_pl_pk_seq OWNER TO postgres;

--
-- Name: dim_places_pl_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_places_pl_pk_seq OWNED BY public.dim_places.pl_pk;


--
-- Name: dim_sightseeings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_sightseeings (
    sg_pk integer NOT NULL,
    sg_name character varying(100) NOT NULL,
    sg_places_fk integer NOT NULL
);


ALTER TABLE public.dim_sightseeings OWNER TO postgres;

--
-- Name: dim_sightseeings_sg_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_sightseeings_sg_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dim_sightseeings_sg_pk_seq OWNER TO postgres;

--
-- Name: dim_sightseeings_sg_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_sightseeings_sg_pk_seq OWNED BY public.dim_sightseeings.sg_pk;


--
-- Name: dim_tourleader; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_tourleader (
    ld_pk integer NOT NULL,
    ld_firstname character varying(100) NOT NULL,
    ld_lastname character varying(100) NOT NULL,
    ld_email character varying(100) NOT NULL,
    ld_phone character varying(20) NOT NULL,
    ld_salery numeric NOT NULL,
    CONSTRAINT dim_tourleader_ld_salery_check CHECK ((ld_salery > (0)::numeric))
);


ALTER TABLE public.dim_tourleader OWNER TO postgres;

--
-- Name: dim_tourleader_ld_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_tourleader_ld_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dim_tourleader_ld_pk_seq OWNER TO postgres;

--
-- Name: dim_tourleader_ld_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_tourleader_ld_pk_seq OWNED BY public.dim_tourleader.ld_pk;


--
-- Name: fact_participants_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_participants_list (
    pal_pk integer NOT NULL,
    pal_tour_fk integer NOT NULL,
    pal_participant_fk integer NOT NULL
);


ALTER TABLE public.fact_participants_list OWNER TO postgres;

--
-- Name: fact_participants_list_pal_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_participants_list_pal_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_participants_list_pal_pk_seq OWNER TO postgres;

--
-- Name: fact_participants_list_pal_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_participants_list_pal_pk_seq OWNED BY public.fact_participants_list.pal_pk;


--
-- Name: fact_tour; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_tour (
    tou_pk integer NOT NULL,
    tou_tourname character varying(200) NOT NULL,
    tou_category_fk integer NOT NULL,
    tou_price numeric NOT NULL,
    tou_duration numeric NOT NULL,
    tou_meetingpoint_fk integer,
    tou_groupsize integer,
    tou_img_website character varying(100) NOT NULL,
    CONSTRAINT fact_tour_tou_duration_check CHECK ((tou_duration > (0)::numeric)),
    CONSTRAINT fact_tour_tou_price_check CHECK ((tou_price > (0)::numeric))
);


ALTER TABLE public.fact_tour OWNER TO postgres;

--
-- Name: fact_tour_booked; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_tour_booked (
    tb_pk integer NOT NULL,
    tb_tour_nr_fk integer NOT NULL,
    tb_tour_tour_fk integer NOT NULL,
    tb_tourleader_nr_fk integer NOT NULL,
    tb_tourleader_leader_fk integer NOT NULL,
    tb_date date NOT NULL,
    tb_starttime time without time zone NOT NULL,
    tb_participants_number integer NOT NULL
);


ALTER TABLE public.fact_tour_booked OWNER TO postgres;

--
-- Name: fact_tour_booked_tb_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_tour_booked_tb_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_tour_booked_tb_pk_seq OWNER TO postgres;

--
-- Name: fact_tour_booked_tb_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_tour_booked_tb_pk_seq OWNED BY public.fact_tour_booked.tb_pk;


--
-- Name: fact_tour_highlights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_tour_highlights (
    th_pk integer NOT NULL,
    th_tour_fk_pk integer NOT NULL,
    th_sightseeing_fk integer NOT NULL
);


ALTER TABLE public.fact_tour_highlights OWNER TO postgres;

--
-- Name: fact_tour_highlights_th_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_tour_highlights_th_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_tour_highlights_th_pk_seq OWNER TO postgres;

--
-- Name: fact_tour_highlights_th_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_tour_highlights_th_pk_seq OWNED BY public.fact_tour_highlights.th_pk;


--
-- Name: fact_tour_languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_tour_languages (
    tlg_pk integer NOT NULL,
    tlg_tour_fk_pk integer NOT NULL,
    tlg_language_fk character varying(3) NOT NULL
);


ALTER TABLE public.fact_tour_languages OWNER TO postgres;

--
-- Name: fact_tour_languages_tlg_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_tour_languages_tlg_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_tour_languages_tlg_pk_seq OWNER TO postgres;

--
-- Name: fact_tour_languages_tlg_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_tour_languages_tlg_pk_seq OWNED BY public.fact_tour_languages.tlg_pk;


--
-- Name: fact_tour_tou_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_tour_tou_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_tour_tou_pk_seq OWNER TO postgres;

--
-- Name: fact_tour_tou_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_tour_tou_pk_seq OWNED BY public.fact_tour.tou_pk;


--
-- Name: fact_tourleader_languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_tourleader_languages (
    tl_pk integer NOT NULL,
    tl_tourleader_fk_pk integer NOT NULL,
    tl_language_fk character varying(3) NOT NULL
);


ALTER TABLE public.fact_tourleader_languages OWNER TO postgres;

--
-- Name: fact_tourleader_languages_tl_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_tourleader_languages_tl_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fact_tourleader_languages_tl_pk_seq OWNER TO postgres;

--
-- Name: fact_tourleader_languages_tl_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_tourleader_languages_tl_pk_seq OWNED BY public.fact_tourleader_languages.tl_pk;


--
-- Name: dim_category cat_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_category ALTER COLUMN cat_pk SET DEFAULT nextval('public.dim_category_cat_pk_seq'::regclass);


--
-- Name: dim_participant par_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_participant ALTER COLUMN par_pk SET DEFAULT nextval('public.dim_participant_par_pk_seq'::regclass);


--
-- Name: dim_places pl_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_places ALTER COLUMN pl_pk SET DEFAULT nextval('public.dim_places_pl_pk_seq'::regclass);


--
-- Name: dim_sightseeings sg_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_sightseeings ALTER COLUMN sg_pk SET DEFAULT nextval('public.dim_sightseeings_sg_pk_seq'::regclass);


--
-- Name: dim_tourleader ld_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_tourleader ALTER COLUMN ld_pk SET DEFAULT nextval('public.dim_tourleader_ld_pk_seq'::regclass);


--
-- Name: fact_participants_list pal_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_participants_list ALTER COLUMN pal_pk SET DEFAULT nextval('public.fact_participants_list_pal_pk_seq'::regclass);


--
-- Name: fact_tour tou_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour ALTER COLUMN tou_pk SET DEFAULT nextval('public.fact_tour_tou_pk_seq'::regclass);


--
-- Name: fact_tour_booked tb_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_booked ALTER COLUMN tb_pk SET DEFAULT nextval('public.fact_tour_booked_tb_pk_seq'::regclass);


--
-- Name: fact_tour_highlights th_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_highlights ALTER COLUMN th_pk SET DEFAULT nextval('public.fact_tour_highlights_th_pk_seq'::regclass);


--
-- Name: fact_tour_languages tlg_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_languages ALTER COLUMN tlg_pk SET DEFAULT nextval('public.fact_tour_languages_tlg_pk_seq'::regclass);


--
-- Name: fact_tourleader_languages tl_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tourleader_languages ALTER COLUMN tl_pk SET DEFAULT nextval('public.fact_tourleader_languages_tl_pk_seq'::regclass);


--
-- Data for Name: dim_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_category (cat_pk, cat_name) FROM stdin;
\.
COPY public.dim_category (cat_pk, cat_name) FROM '$$PATH$$/3106.dat';

--
-- Data for Name: dim_languages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_languages (lan_short_pk, lan_long_englisch, lan_long_deutsch) FROM stdin;
\.
COPY public.dim_languages (lan_short_pk, lan_long_englisch, lan_long_deutsch) FROM '$$PATH$$/3111.dat';

--
-- Data for Name: dim_participant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_participant (par_pk, par_firstname, par_lastname, par_email, par_phone) FROM stdin;
\.
COPY public.dim_participant (par_pk, par_firstname, par_lastname, par_email, par_phone) FROM '$$PATH$$/3110.dat';

--
-- Data for Name: dim_places; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_places (pl_pk, pl_plz, pl_street, pl_number) FROM stdin;
\.
COPY public.dim_places (pl_pk, pl_plz, pl_street, pl_number) FROM '$$PATH$$/3104.dat';

--
-- Data for Name: dim_sightseeings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_sightseeings (sg_pk, sg_name, sg_places_fk) FROM stdin;
\.
COPY public.dim_sightseeings (sg_pk, sg_name, sg_places_fk) FROM '$$PATH$$/3113.dat';

--
-- Data for Name: dim_tourleader; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_tourleader (ld_pk, ld_firstname, ld_lastname, ld_email, ld_phone, ld_salery) FROM stdin;
\.
COPY public.dim_tourleader (ld_pk, ld_firstname, ld_lastname, ld_email, ld_phone, ld_salery) FROM '$$PATH$$/3108.dat';

--
-- Data for Name: fact_participants_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_participants_list (pal_pk, pal_tour_fk, pal_participant_fk) FROM stdin;
\.
COPY public.fact_participants_list (pal_pk, pal_tour_fk, pal_participant_fk) FROM '$$PATH$$/3125.dat';

--
-- Data for Name: fact_tour; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_tour (tou_pk, tou_tourname, tou_category_fk, tou_price, tou_duration, tou_meetingpoint_fk, tou_groupsize, tou_img_website) FROM stdin;
\.
COPY public.fact_tour (tou_pk, tou_tourname, tou_category_fk, tou_price, tou_duration, tou_meetingpoint_fk, tou_groupsize, tou_img_website) FROM '$$PATH$$/3115.dat';

--
-- Data for Name: fact_tour_booked; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_tour_booked (tb_pk, tb_tour_nr_fk, tb_tour_tour_fk, tb_tourleader_nr_fk, tb_tourleader_leader_fk, tb_date, tb_starttime, tb_participants_number) FROM stdin;
\.
COPY public.fact_tour_booked (tb_pk, tb_tour_nr_fk, tb_tour_tour_fk, tb_tourleader_nr_fk, tb_tourleader_leader_fk, tb_date, tb_starttime, tb_participants_number) FROM '$$PATH$$/3123.dat';

--
-- Data for Name: fact_tour_highlights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_tour_highlights (th_pk, th_tour_fk_pk, th_sightseeing_fk) FROM stdin;
\.
COPY public.fact_tour_highlights (th_pk, th_tour_fk_pk, th_sightseeing_fk) FROM '$$PATH$$/3119.dat';

--
-- Data for Name: fact_tour_languages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_tour_languages (tlg_pk, tlg_tour_fk_pk, tlg_language_fk) FROM stdin;
\.
COPY public.fact_tour_languages (tlg_pk, tlg_tour_fk_pk, tlg_language_fk) FROM '$$PATH$$/3117.dat';

--
-- Data for Name: fact_tourleader_languages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_tourleader_languages (tl_pk, tl_tourleader_fk_pk, tl_language_fk) FROM stdin;
\.
COPY public.fact_tourleader_languages (tl_pk, tl_tourleader_fk_pk, tl_language_fk) FROM '$$PATH$$/3121.dat';

--
-- Name: dim_category_cat_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_category_cat_pk_seq', 5, true);


--
-- Name: dim_participant_par_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_participant_par_pk_seq', 49, true);


--
-- Name: dim_places_pl_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_places_pl_pk_seq', 15, true);


--
-- Name: dim_sightseeings_sg_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_sightseeings_sg_pk_seq', 13, true);


--
-- Name: dim_tourleader_ld_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_tourleader_ld_pk_seq', 9, true);


--
-- Name: fact_participants_list_pal_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_participants_list_pal_pk_seq', 49, true);


--
-- Name: fact_tour_booked_tb_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_tour_booked_tb_pk_seq', 5, true);


--
-- Name: fact_tour_highlights_th_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_tour_highlights_th_pk_seq', 38, true);


--
-- Name: fact_tour_languages_tlg_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_tour_languages_tlg_pk_seq', 48, true);


--
-- Name: fact_tour_tou_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_tour_tou_pk_seq', 14, true);


--
-- Name: fact_tourleader_languages_tl_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_tourleader_languages_tl_pk_seq', 20, true);


--
-- Name: dim_category dim_category_cat_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_category
    ADD CONSTRAINT dim_category_cat_name_key UNIQUE (cat_name);


--
-- Name: dim_category dim_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_category
    ADD CONSTRAINT dim_category_pkey PRIMARY KEY (cat_pk);


--
-- Name: dim_languages dim_languages_lan_long_deutsch_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_languages
    ADD CONSTRAINT dim_languages_lan_long_deutsch_key UNIQUE (lan_long_deutsch);


--
-- Name: dim_languages dim_languages_lan_long_englisch_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_languages
    ADD CONSTRAINT dim_languages_lan_long_englisch_key UNIQUE (lan_long_englisch);


--
-- Name: dim_languages dim_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_languages
    ADD CONSTRAINT dim_languages_pkey PRIMARY KEY (lan_short_pk);


--
-- Name: dim_participant dim_participant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_participant
    ADD CONSTRAINT dim_participant_pkey PRIMARY KEY (par_pk);


--
-- Name: dim_places dim_places_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_places
    ADD CONSTRAINT dim_places_pkey PRIMARY KEY (pl_pk);


--
-- Name: dim_sightseeings dim_sightseeings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_sightseeings
    ADD CONSTRAINT dim_sightseeings_pkey PRIMARY KEY (sg_pk);


--
-- Name: dim_tourleader dim_tourleader_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_tourleader
    ADD CONSTRAINT dim_tourleader_pkey PRIMARY KEY (ld_pk);


--
-- Name: fact_participants_list fact_participants_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_participants_list
    ADD CONSTRAINT fact_participants_list_pkey PRIMARY KEY (pal_pk);


--
-- Name: fact_tour_booked fact_tour_booked_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_booked
    ADD CONSTRAINT fact_tour_booked_pkey PRIMARY KEY (tb_pk);


--
-- Name: fact_tour_highlights fact_tour_highlights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_highlights
    ADD CONSTRAINT fact_tour_highlights_pkey PRIMARY KEY (th_pk, th_tour_fk_pk);


--
-- Name: fact_tour_languages fact_tour_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_languages
    ADD CONSTRAINT fact_tour_languages_pkey PRIMARY KEY (tlg_pk, tlg_tour_fk_pk);


--
-- Name: fact_tour fact_tour_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour
    ADD CONSTRAINT fact_tour_pkey PRIMARY KEY (tou_pk);


--
-- Name: fact_tourleader_languages fact_tourleader_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tourleader_languages
    ADD CONSTRAINT fact_tourleader_languages_pkey PRIMARY KEY (tl_pk, tl_tourleader_fk_pk);


--
-- Name: dim_sightseeings dim_sightseeings_sg_places_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_sightseeings
    ADD CONSTRAINT dim_sightseeings_sg_places_fk_fkey FOREIGN KEY (sg_places_fk) REFERENCES public.dim_places(pl_pk);


--
-- Name: fact_participants_list fact_participants_list_pal_participant_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_participants_list
    ADD CONSTRAINT fact_participants_list_pal_participant_fk_fkey FOREIGN KEY (pal_participant_fk) REFERENCES public.dim_participant(par_pk);


--
-- Name: fact_participants_list fact_participants_list_pal_tour_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_participants_list
    ADD CONSTRAINT fact_participants_list_pal_tour_fk_fkey FOREIGN KEY (pal_tour_fk) REFERENCES public.fact_tour_booked(tb_pk);


--
-- Name: fact_tour_booked fact_tour_booked_tb_tour_nr_fk_tb_tour_tour_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_booked
    ADD CONSTRAINT fact_tour_booked_tb_tour_nr_fk_tb_tour_tour_fk_fkey FOREIGN KEY (tb_tour_nr_fk, tb_tour_tour_fk) REFERENCES public.fact_tour_languages(tlg_pk, tlg_tour_fk_pk);


--
-- Name: fact_tour_booked fact_tour_booked_tb_tourleader_nr_fk_tb_tourleader_leader__fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_booked
    ADD CONSTRAINT fact_tour_booked_tb_tourleader_nr_fk_tb_tourleader_leader__fkey FOREIGN KEY (tb_tourleader_nr_fk, tb_tourleader_leader_fk) REFERENCES public.fact_tourleader_languages(tl_pk, tl_tourleader_fk_pk);


--
-- Name: fact_tour_highlights fact_tour_highlights_th_sightseeing_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_highlights
    ADD CONSTRAINT fact_tour_highlights_th_sightseeing_fk_fkey FOREIGN KEY (th_sightseeing_fk) REFERENCES public.dim_sightseeings(sg_pk);


--
-- Name: fact_tour_highlights fact_tour_highlights_th_tour_fk_pk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_highlights
    ADD CONSTRAINT fact_tour_highlights_th_tour_fk_pk_fkey FOREIGN KEY (th_tour_fk_pk) REFERENCES public.fact_tour(tou_pk);


--
-- Name: fact_tour_languages fact_tour_languages_tlg_language_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_languages
    ADD CONSTRAINT fact_tour_languages_tlg_language_fk_fkey FOREIGN KEY (tlg_language_fk) REFERENCES public.dim_languages(lan_short_pk);


--
-- Name: fact_tour_languages fact_tour_languages_tlg_tour_fk_pk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour_languages
    ADD CONSTRAINT fact_tour_languages_tlg_tour_fk_pk_fkey FOREIGN KEY (tlg_tour_fk_pk) REFERENCES public.fact_tour(tou_pk);


--
-- Name: fact_tour fact_tour_tou_category_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour
    ADD CONSTRAINT fact_tour_tou_category_fk_fkey FOREIGN KEY (tou_category_fk) REFERENCES public.dim_category(cat_pk);


--
-- Name: fact_tour fact_tour_tou_meetingpoint_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tour
    ADD CONSTRAINT fact_tour_tou_meetingpoint_fk_fkey FOREIGN KEY (tou_meetingpoint_fk) REFERENCES public.dim_places(pl_pk);


--
-- Name: fact_tourleader_languages fact_tourleader_languages_tl_language_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tourleader_languages
    ADD CONSTRAINT fact_tourleader_languages_tl_language_fk_fkey FOREIGN KEY (tl_language_fk) REFERENCES public.dim_languages(lan_short_pk);


--
-- Name: fact_tourleader_languages fact_tourleader_languages_tl_tourleader_fk_pk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_tourleader_languages
    ADD CONSTRAINT fact_tourleader_languages_tl_tourleader_fk_pk_fkey FOREIGN KEY (tl_tourleader_fk_pk) REFERENCES public.dim_tourleader(ld_pk);


--
-- PostgreSQL database dump complete
--

