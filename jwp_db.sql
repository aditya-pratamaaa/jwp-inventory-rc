--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2026-04-25 11:00:03

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 57920)
-- Name: Barang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Barang" (
    kode_barang integer NOT NULL,
    nama_barang text NOT NULL,
    harga_barang integer NOT NULL
);


ALTER TABLE public."Barang" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 58103)
-- Name: RequestBarang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RequestBarang" (
    id integer NOT NULL,
    nama_barang text NOT NULL,
    nama_pemohon text NOT NULL,
    kontak text NOT NULL,
    catatan text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."RequestBarang" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 58102)
-- Name: RequestBarang_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."RequestBarang_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."RequestBarang_id_seq" OWNER TO postgres;

--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 225
-- Name: RequestBarang_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."RequestBarang_id_seq" OWNED BY public."RequestBarang".id;


--
-- TOC entry 224 (class 1259 OID 58001)
-- Name: Stok; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Stok" (
    id integer NOT NULL,
    kode_barang integer NOT NULL,
    jumlah_stok integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Stok" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 58000)
-- Name: Stok_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Stok_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Stok_id_seq" OWNER TO postgres;

--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 223
-- Name: Stok_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Stok_id_seq" OWNED BY public."Stok".id;


--
-- TOC entry 222 (class 1259 OID 57928)
-- Name: Transaksi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaksi" (
    kode_transaksi integer NOT NULL,
    kode_barang integer NOT NULL,
    jumlah_barang integer NOT NULL,
    total_harga integer NOT NULL
);


ALTER TABLE public."Transaksi" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 57927)
-- Name: Transaksi_kode_transaksi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transaksi_kode_transaksi_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Transaksi_kode_transaksi_seq" OWNER TO postgres;

--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 221
-- Name: Transaksi_kode_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transaksi_kode_transaksi_seq" OWNED BY public."Transaksi".kode_transaksi;


--
-- TOC entry 219 (class 1259 OID 57912)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 57911)
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 218
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 217 (class 1259 OID 57902)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 4771 (class 2604 OID 58106)
-- Name: RequestBarang id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RequestBarang" ALTER COLUMN id SET DEFAULT nextval('public."RequestBarang_id_seq"'::regclass);


--
-- TOC entry 4769 (class 2604 OID 58004)
-- Name: Stok id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stok" ALTER COLUMN id SET DEFAULT nextval('public."Stok_id_seq"'::regclass);


--
-- TOC entry 4768 (class 2604 OID 57931)
-- Name: Transaksi kode_transaksi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaksi" ALTER COLUMN kode_transaksi SET DEFAULT nextval('public."Transaksi_kode_transaksi_seq"'::regclass);


--
-- TOC entry 4767 (class 2604 OID 57915)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 4937 (class 0 OID 57920)
-- Dependencies: 220
-- Data for Name: Barang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Barang" (kode_barang, nama_barang, harga_barang) FROM stdin;
1001	Motor Brushless Rocket 540 3900KV	450000
1002	ESC Hobbywing Quicrun 1060 60A	350000
1003	Servo JX PDI-6221MG 20KG Metal Gear	220000
1004	Baterai LiPo 2S 5200mAh 50C	385000
1005	Ban Drift Hard Compound (4pcs)	125000
\.


--
-- TOC entry 4943 (class 0 OID 58103)
-- Dependencies: 226
-- Data for Name: RequestBarang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RequestBarang" (id, nama_barang, nama_pemohon, kontak, catatan, "createdAt") FROM stdin;
3	Casis 	Budi	08976789567	Permintaan baru 	2026-04-25 03:58:40.609
\.


--
-- TOC entry 4941 (class 0 OID 58001)
-- Dependencies: 224
-- Data for Name: Stok; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Stok" (id, kode_barang, jumlah_stok) FROM stdin;
5	1003	7
6	1004	10
7	1005	20
3	1001	8
4	1002	3
\.


--
-- TOC entry 4939 (class 0 OID 57928)
-- Dependencies: 222
-- Data for Name: Transaksi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaksi" (kode_transaksi, kode_barang, jumlah_barang, total_harga) FROM stdin;
6	1001	2	900000
7	1002	2	700000
\.


--
-- TOC entry 4936 (class 0 OID 57912)
-- Dependencies: 219
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, username, password) FROM stdin;
4	admin	$2b$10$GecbhQf/F9MOcGbOCUQJneHTYiHYVc8sBc1iDCXE3DfdKfhCVAwq2
\.


--
-- TOC entry 4934 (class 0 OID 57902)
-- Dependencies: 217
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
781b6293-18d0-4010-9056-9e41d29c2658	453b97525e171c5f4ddc26d067211fdd19e79b3994756becf8937722b57c983c	2026-04-23 21:53:59.41334+07	20260423145359_init_database_schema	\N	\N	2026-04-23 21:53:59.369304+07	1
71c0c55d-c18d-4919-b58b-51f0b33373a6	bd5f5a4a8a190563bee0397c97577c87e38f4e7f2443170396d181c8afc2aa08	2026-04-24 20:39:15.662698+07	20260424133915_add_stok_table	\N	\N	2026-04-24 20:39:15.53147+07	1
384fd6bf-a5a5-426c-a001-ccc882ffad32	a882d5b3eef52d1072ec60bf20ba2516abb09e17f55cdf471c126f88c8afe2db	2026-04-25 10:04:11.140156+07	20260425030410_add_request_barang	\N	\N	2026-04-25 10:04:10.991449+07	1
\.


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 225
-- Name: RequestBarang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."RequestBarang_id_seq"', 3, true);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 223
-- Name: Stok_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Stok_id_seq"', 7, true);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 221
-- Name: Transaksi_kode_transaksi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaksi_kode_transaksi_seq"', 7, true);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 218
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 4, true);


--
-- TOC entry 4779 (class 2606 OID 57926)
-- Name: Barang Barang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Barang"
    ADD CONSTRAINT "Barang_pkey" PRIMARY KEY (kode_barang);


--
-- TOC entry 4786 (class 2606 OID 58111)
-- Name: RequestBarang RequestBarang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RequestBarang"
    ADD CONSTRAINT "RequestBarang_pkey" PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 58007)
-- Name: Stok Stok_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stok"
    ADD CONSTRAINT "Stok_pkey" PRIMARY KEY (id);


--
-- TOC entry 4781 (class 2606 OID 57933)
-- Name: Transaksi Transaksi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaksi"
    ADD CONSTRAINT "Transaksi_pkey" PRIMARY KEY (kode_transaksi);


--
-- TOC entry 4776 (class 2606 OID 57919)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 4774 (class 2606 OID 57910)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4782 (class 1259 OID 58008)
-- Name: Stok_kode_barang_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Stok_kode_barang_key" ON public."Stok" USING btree (kode_barang);


--
-- TOC entry 4777 (class 1259 OID 57934)
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- TOC entry 4788 (class 2606 OID 58009)
-- Name: Stok Stok_kode_barang_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Stok"
    ADD CONSTRAINT "Stok_kode_barang_fkey" FOREIGN KEY (kode_barang) REFERENCES public."Barang"(kode_barang) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4787 (class 2606 OID 57935)
-- Name: Transaksi Transaksi_kode_barang_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaksi"
    ADD CONSTRAINT "Transaksi_kode_barang_fkey" FOREIGN KEY (kode_barang) REFERENCES public."Barang"(kode_barang) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-04-25 11:00:04

--
-- PostgreSQL database dump complete
--

