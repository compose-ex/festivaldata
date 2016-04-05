--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: compose_session_replication_role(text); Type: FUNCTION; Schema: public; Owner: focker
--

CREATE FUNCTION compose_session_replication_role(role text) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
        DECLARE
                curr_val text := 'unset';
        BEGIN
                EXECUTE 'SET session_replication_role = ' || quote_literal(role);
                EXECUTE 'SHOW session_replication_role' INTO curr_val;
                RETURN curr_val;
        END
$$;


ALTER FUNCTION public.compose_session_replication_role(role text) OWNER TO focker;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: artists; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE artists (
    name text NOT NULL,
    mb_id uuid,
    date_formed date,
    CONSTRAINT artists_name_check CHECK ((length(name) < 256))
);


ALTER TABLE artists OWNER TO admin;

--
-- Name: rating_types; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE rating_types (
    name text NOT NULL,
    description text NOT NULL,
    CONSTRAINT rating_types_description_check CHECK ((length(description) < 512)),
    CONSTRAINT rating_types_name_check CHECK ((length(name) < 256))
);


ALTER TABLE rating_types OWNER TO admin;

--
-- Name: ratings; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE ratings (
    artist_name text NOT NULL,
    email text NOT NULL,
    rating_type_name text NOT NULL,
    rating integer NOT NULL,
    at timestamp with time zone DEFAULT now()
);


ALTER TABLE ratings OWNER TO admin;

--
-- Name: sort_types; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE sort_types (
    name text NOT NULL,
    description text NOT NULL,
    CONSTRAINT sort_types_description_check CHECK ((length(description) < 512)),
    CONSTRAINT sort_types_name_check CHECK ((length(name) < 256))
);


ALTER TABLE sort_types OWNER TO admin;

--
-- Name: sorts; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE sorts (
    artist_name text NOT NULL,
    sort_type_name text NOT NULL,
    ordinal integer NOT NULL
);


ALTER TABLE sorts OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE users (
    email text NOT NULL,
    pass text NOT NULL,
    role name NOT NULL,
    CONSTRAINT users_email_check CHECK ((email ~* '^.+@.+\..+$'::text)),
    CONSTRAINT users_pass_check CHECK ((length(pass) < 256)),
    CONSTRAINT users_role_check CHECK ((length((role)::text) < 256))
);


ALTER TABLE users OWNER TO admin;

--
-- Data for Name: artists; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY artists (name, mb_id, date_formed) FROM stdin;
Pearl Jam	83b9cbe7-9857-49e2-ab8e-b57b01038103	1990-12-31
Dead & Company (2 Sets)	\N	\N
LCD Soundsystem	2aaf7396-6ab8-40f3-9776-a41c42c8e26b	2001-12-31
J. Cole	875203e1-8e58-4b86-8dcb-7190faf411c5	1985-01-28
Ellie Goulding	33ca19f4-18c8-4411-98df-ac23890ce9f5	1986-12-30
Macklemore & Ryan Lewis	97b226c8-7140-4da3-91ac-15e62e131a81	2009-12-31
Tame Impala (Late Night)	\N	\N
Death Cab for Cutie	0039c7ae-e1a7-4a7d-9b49-0cbc716821a6	1997-12-31
M83	6d7b7cd4-254b-4c25-83f6-dd20f98ceacd	2001-12-31
Haïm	50601ad0-50e5-40ae-b446-d6ada5986d19	2030-12-31
Halsey	3377f3bb-60fc-4403-aea9-7e800612e060	1994-09-29
Ween	c0eee88b-47f2-4cd2-ac48-a045e902a432	1984-12-31
Jason Isbell	4c501a41-5f23-41c9-a36a-5b86e894e08d	1979-02-01
CHVRCHES	\N	\N
Miguel	b7db83c6-6ccc-490b-887f-edafd0949e61	2030-12-31
Chris Stapleton	bdf9a24e-2bb5-4218-b4d8-e33769843f24	2030-12-31
Judd Apatow & Friends	\N	\N
The Chainsmokers	91a81925-92f9-4fc9-b897-93cf01226282	2012-12-31
Bonnaroo Superjam	f2f53b43-55cd-4630-81f5-73a15ec90822	2030-12-31
Big Grams (Big Boi + Phantogram)	\N	\N
Band of Horses	07b6020a-c539-4d68-aeef-f159f3befc76	2004-12-31
Leon Bridges	69d9dfd7-19b7-4a75-8a53-9f733fb5d774	1989-07-13
Grace Potter	b1103b87-3b91-4ec5-9d7b-15c2d1e486af	1983-06-20
Father John Misty	172053e5-a7fb-4548-a64d-c53858b5e775	1981-05-03
Adam DeVine	7c283224-9cfc-4663-9920-727aa7fab117	1983-11-07
Purity Ring	fdb53441-e5e6-4657-9aad-8dab672e1cdc	2010-12-31
The Claypool Lennon Delirium	\N	\N
Two Door Cinema Club	6f1de078-6684-4792-820d-2ffad64c15ed	2007-12-31
Sam Hunt	be9a991d-319c-4a58-b115-ee3f4bb3613d	1946-07-04
Flosstradamus	8ca3f991-47c7-4506-8fa2-327e376c71b4	2006-12-31
Zeds Dead	f9fdca15-1bef-43a0-8213-758b6ee0aa91	2009-12-31
Adventure Club	b9696d80-70c9-4c3d-be9d-8a525b125d23	2011-12-31
Tyler, the Creator	f6beac20-5dfe-4d1f-ae02-0b0a740aafd6	1991-03-06
Bridget Everett	d59b63a0-0ff5-40d2-94b8-787751138846	2000-04-21
Griz	245256dc-298f-46f5-8b66-fae1145c5ecc	2030-12-31
Touchpants	1bb7576e-d009-4633-b16b-f5b16ad09d93	2030-12-31
Lamb of God	298909e4-ebcb-47b8-95e9-cc53b087fc65	1998-12-31
Nathaniel Rateliff & the Night Sweats	2d97d9a8-e7dd-443f-b7cb-e35700dacd0a	2030-12-31
Kurt Vile & The Violators	\N	\N
Blood Orange	e43daa78-3cf3-4cf9-bc27-af4d4e675a02	2030-12-31
Lord Huron	51c76d97-0635-433c-b26d-66beb81657f8	2030-12-31
RL Grime	c046b587-5e98-4631-a5c0-e5d8e18d6b13	2030-12-31
The Bluegrass Situation SuperJam Featuring Ed Helms and Friends	\N	\N
X Ambassadors	298f4089-1948-44b5-b5e8-d5381f42362f	2008-10-22
St. Lucia	d996eadd-029d-4478-aa4b-fc9446653548	2030-12-31
Piff the Magic Dragon	\N	\N
Lucius	9e233b0e-9e9d-4865-9d66-18fbcaf02bd8	1996-02-29
Vince Staples	78e854b8-9713-4ff2-9218-6b3784893bff	1993-07-02
Third Eye Blind	92a42e82-b36f-4308-82c1-68bad2e03c89	1993-12-31
Cymande	21c5fb53-6fbc-4080-989a-b26d4540f4fd	1971-12-31
MisterWives	5b6bac92-9b60-4e96-ac13-935bb6941b96	2012-12-31
Clutch	0cdb0359-5698-487d-9aae-a25fb4dcdc4d	1990-12-31
GoldLink	7cb6e306-a75b-48b4-be00-2c4aa6bbe3a8	2030-12-31
Lettuce	e88313e2-22f6-4f6d-9656-6d2ad20ea415	1992-12-31
Cashmere Cat	8fbcd70f-bf1e-4624-b94a-fcff6b0c637e	1987-11-29
Goddamn Comedy Jam	\N	\N
FIDLAR	6910222b-74c2-48fc-8c13-a6b88cc28fc0	2009-04-30
Ibeyi	a4e3e7ca-87d7-4d5d-8a36-72e5f043e378	2012-12-31
Keys N Krates	1ed5c328-840d-43b6-8455-8d1b4e7f3080	2008-12-31
Sam Bush Band	9796ebb0-74c6-42ba-b80c-f6dcea0df93a	2030-12-31
The Wood Brothers	2cdd6de7-ccb9-450e-a20d-382407689d6a	2004-12-31
Saint Motel	5c2593bc-1621-4c4d-821b-b7bb6ff213b5	2009-12-31
Daughter	373241ba-2101-429c-a8fc-c3ac4a4245fe	2030-12-31
The Floozies	e6702d37-b826-45d0-95e2-4ac1aad10bb2	2030-12-31
Marian Hill	2ef562e1-17af-495c-9e35-82a329fcf733	2030-12-31
Kamasi Washington	c7a3e868-c6d8-4512-a5ef-f6cbe42899b0	1981-02-18
BØRNS	b2befbb4-c585-4b05-8efa-3deebc8e1385	1992-01-07
Post Malone	b1e26560-60e5-4236-bbdb-9aa5a8d5ee19	2030-12-31
Shamir	44265511-306b-438d-940a-8fb07fba2d88	1994-11-08
Allen Stone	99d79171-66fd-4626-8ba1-9d5862a4a9a5	1987-03-13
Brett Dennen	9960700d-2017-40bd-b2d4-1d365d668c81	1979-10-28
Oh Wonder	aa2c5e55-57f5-42a7-a0e4-4a02cd9399b1	2030-12-31
Boy & Bear	fff936ee-8dbf-4202-9647-410c6b1924a7	2009-12-31
Dungen	25c76eb2-a92d-4624-9e30-093fc16ed5eb	2001-12-31
Judah & The Lion	a71da6f9-655d-4029-8c1c-5dc351632734	2030-12-31
Steve Gunn	a0d05bb8-3ef4-4b70-8992-5da4322afc21	2030-12-31
Steep Canyon Rangers	4b53774a-8c4f-4c58-a4f9-c9d331f6b0a4	2030-12-31
The Oh Hellos	4b85cdd2-3c60-4578-8543-401c02f25756	2030-12-31
The Internet	45804465-4271-4e6a-b881-ce668ef09530	2011-12-31
John Moreland	c62ea4fb-b303-463b-a2a1-ff1cea9b1de5	1985-06-22
Andra Day	802a3ea8-bd1b-4f97-9998-cbdd099d63d9	2030-12-31
Anderson East	16c6cf5a-a493-417d-8afd-7e4e2bc56164	1987-12-31
Twin Peaks	1c97bfa2-edd9-4d4f-9dd7-201b925a4abb	2008-10-31
Bully	82f92c55-753e-45f2-be9d-2c2dcd76fab1	2030-12-31
Natalie Prass	662292bd-8739-4245-b42f-bcb747ce8559	1986-03-15
Chicano Batman	46efbaa6-1bf3-44b5-8838-67f77d77aa96	2030-12-31
GIVERS	b1ed0477-1f0a-41bb-9b8b-2fe8bc2d85aa	2009-12-31
Hermitude	3b8e479e-c3c9-4500-8a8f-394c290afde4	2000-12-31
Jarryd James	d6a1c436-0595-48a2-bc3f-c27962d82ec8	2030-12-31
Lizzo	8fb5370b-9568-4b61-9da5-2aa12c9928db	1988-04-27
Papadosio	1b4a9142-d67b-469f-b992-1469d2e6bf25	2030-12-31
Rayland Baxter	9dd9a2fb-891e-44d8-97ef-ca1d69aa2d7a	2030-12-31
Vulfpeck	7d0e8067-10b9-4069-95dc-1110a0fbb877	2011-12-31
Sara Watkins	e6dbe57d-74cf-4f6e-9e16-ed6cce18baef	1981-06-08
The Knocks	9157ad72-3893-47da-986a-0aa7313f7429	2007-12-31
Waxahatchee	42321e24-42b6-4f08-b0d9-8325ee887a20	2030-12-31
Beach Fossils	3df3818e-7984-4c62-bee3-81f95f8c6651	2009-12-31
Whilk and Misky	f4139c2c-26ef-4e1f-99d5-6e8859ef6c56	2030-12-31
Hundred Waters	49d461f0-3abf-422e-9569-8813e90074d7	2011-12-31
The London Souls	301bf336-0cce-4f35-8bc3-23267033bf6c	2030-12-31
Lolawolf	a6307c9f-69c9-4bc7-b59b-dff485376a0a	2030-12-31
Civil Twilight	36ecdd8b-ed83-4ccf-a930-52cf582d3c9d	2005-12-31
Roman GianArthur Irvin	bf93639c-1d7e-44ff-9331-91d871b6e14b	2030-12-31
LANY	f1cc066a-6dd1-4b18-ae68-3708472ab4b1	2030-12-31
Con Brio	7000122e-215c-4eac-85a4-d3b45a8bbaa5	2008-03-01
Flux Capacitor	91a63f26-1674-43a9-95de-123eb453e36d	2030-12-31
\.


--
-- Data for Name: rating_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY rating_types (name, description) FROM stdin;
hays_nps	on a scale of 0 to 10 would you recommend this artist to family or friends?  (This is the basic Net Promoter Score question)
\.


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY ratings (artist_name, email, rating_type_name, rating, at) FROM stdin;
Pearl Jam	hays@compose.io	hays_nps	7	2016-04-05 14:24:58.304893+00
Dead & Company (2 Sets)	hays@compose.io	hays_nps	9	2016-04-05 14:25:37.4813+00
LCD Soundsystem	hays@compose.io	hays_nps	9	2016-04-05 14:26:19.095068+00
Macklemore & Ryan Lewis	hays@compose.io	hays_nps	5	2016-04-05 14:27:18.509104+00
Tame Impala (Late Night)	hays@compose.io	hays_nps	9	2016-04-05 14:27:53.739315+00
Leon Bridges	hays@compose.io	hays_nps	9	2016-04-05 14:29:07.896479+00
Grace Potter	hays@compose.io	hays_nps	7	2016-04-05 14:29:41.833981+00
Father John Misty	hays@compose.io	hays_nps	9	2016-04-05 14:30:07.175291+00
Lamb of God	hays@compose.io	hays_nps	9	2016-04-05 14:30:38.939218+00
Two Door Cinema Club	hays@compose.io	hays_nps	6	2016-04-05 14:31:18.989772+00
Tyler, the Creator	hays@compose.io	hays_nps	5	2016-04-05 14:32:22.964527+00
Ellie Goulding	hays@compose.io	hays_nps	1	2016-04-05 15:08:02.37567+00
J. Cole	hays@compose.io	hays_nps	6	2016-04-05 15:09:17.427562+00
Death Cab for Cutie	hays@compose.io	hays_nps	8	2016-04-05 15:12:37.911284+00
\.


--
-- Data for Name: sort_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY sort_types (name, description) FROM stdin;
lineup	the festivals lineup order
alphabetical	A to Z
\.


--
-- Data for Name: sorts; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY sorts (artist_name, sort_type_name, ordinal) FROM stdin;
Pearl Jam	lineup	0
Dead & Company (2 Sets)	lineup	1
LCD Soundsystem	lineup	2
J. Cole	lineup	3
Ellie Goulding	lineup	4
Macklemore & Ryan Lewis	lineup	5
Tame Impala (Late Night)	lineup	6
Death Cab for Cutie	lineup	7
M83	lineup	8
Haïm	lineup	9
Halsey	lineup	10
Ween	lineup	11
Jason Isbell	lineup	12
CHVRCHES	lineup	13
Miguel	lineup	14
Chris Stapleton	lineup	15
Judd Apatow & Friends	lineup	16
The Chainsmokers	lineup	17
Bonnaroo Superjam	lineup	18
Big Grams (Big Boi + Phantogram)	lineup	19
Band of Horses	lineup	20
Leon Bridges	lineup	21
Grace Potter	lineup	22
Father John Misty	lineup	23
Adam DeVine	lineup	24
Purity Ring	lineup	25
The Claypool Lennon Delirium	lineup	26
Two Door Cinema Club	lineup	27
Sam Hunt	lineup	28
Flosstradamus	lineup	29
Zeds Dead	lineup	30
Adventure Club	lineup	31
Tyler, the Creator	lineup	32
Bridget Everett	lineup	33
Griz	lineup	34
Touchpants	lineup	35
Lamb of God	lineup	36
Nathaniel Rateliff & the Night Sweats	lineup	37
Kurt Vile & The Violators	lineup	38
Blood Orange	lineup	39
Lord Huron	lineup	40
RL Grime	lineup	41
The Bluegrass Situation SuperJam Featuring Ed Helms and Friends	lineup	42
X Ambassadors	lineup	43
St. Lucia	lineup	44
Piff the Magic Dragon	lineup	45
Lucius	lineup	46
Vince Staples	lineup	47
Third Eye Blind	lineup	48
Cymande	lineup	49
MisterWives	lineup	50
Clutch	lineup	51
GoldLink	lineup	52
Lettuce	lineup	53
Cashmere Cat	lineup	54
Goddamn Comedy Jam	lineup	55
FIDLAR	lineup	56
Ibeyi	lineup	57
Keys N Krates	lineup	58
Sam Bush Band	lineup	59
The Wood Brothers	lineup	60
Saint Motel	lineup	61
Daughter	lineup	62
The Floozies	lineup	63
Marian Hill	lineup	64
Kamasi Washington	lineup	65
BØRNS	lineup	66
Post Malone	lineup	67
Shamir	lineup	68
Allen Stone	lineup	69
Brett Dennen	lineup	70
Oh Wonder	lineup	71
Boy & Bear	lineup	72
Dungen	lineup	73
Judah & The Lion	lineup	74
Steve Gunn	lineup	75
Steep Canyon Rangers	lineup	76
The Oh Hellos	lineup	77
The Internet	lineup	78
John Moreland	lineup	79
Andra Day	lineup	80
Anderson East	lineup	81
Twin Peaks	lineup	82
Bully	lineup	83
Natalie Prass	lineup	84
Chicano Batman	lineup	85
GIVERS	lineup	86
Hermitude	lineup	87
Jarryd James	lineup	88
Lizzo	lineup	89
Papadosio	lineup	90
Rayland Baxter	lineup	91
Vulfpeck	lineup	92
Sara Watkins	lineup	93
The Knocks	lineup	94
Waxahatchee	lineup	95
Beach Fossils	lineup	96
Whilk and Misky	lineup	97
Hundred Waters	lineup	98
The London Souls	lineup	99
Lolawolf	lineup	100
Civil Twilight	lineup	101
Roman GianArthur Irvin	lineup	102
LANY	lineup	103
Con Brio	lineup	104
Flux Capacitor	lineup	105
Adam DeVine	alphabetical	0
Adventure Club	alphabetical	1
Allen Stone	alphabetical	2
Anderson East	alphabetical	3
Andra Day	alphabetical	4
Band of Horses	alphabetical	5
Beach Fossils	alphabetical	6
Big Grams (Big Boi + Phantogram)	alphabetical	7
Blood Orange	alphabetical	8
Bonnaroo Superjam	alphabetical	9
Boy & Bear	alphabetical	10
Brett Dennen	alphabetical	11
Bridget Everett	alphabetical	12
Bully	alphabetical	13
BØRNS	alphabetical	14
CHVRCHES	alphabetical	15
Cashmere Cat	alphabetical	16
Chicano Batman	alphabetical	17
Chris Stapleton	alphabetical	18
Civil Twilight	alphabetical	19
Clutch	alphabetical	20
Con Brio	alphabetical	21
Cymande	alphabetical	22
Daughter	alphabetical	23
Dead & Company (2 Sets)	alphabetical	24
Death Cab for Cutie	alphabetical	25
Dungen	alphabetical	26
Ellie Goulding	alphabetical	27
FIDLAR	alphabetical	28
Father John Misty	alphabetical	29
Flosstradamus	alphabetical	30
Flux Capacitor	alphabetical	31
GIVERS	alphabetical	32
Goddamn Comedy Jam	alphabetical	33
GoldLink	alphabetical	34
Grace Potter	alphabetical	35
Griz	alphabetical	36
Halsey	alphabetical	37
Haïm	alphabetical	38
Hermitude	alphabetical	39
Hundred Waters	alphabetical	40
Ibeyi	alphabetical	41
J. Cole	alphabetical	42
Jarryd James	alphabetical	43
Jason Isbell	alphabetical	44
John Moreland	alphabetical	45
Judah & The Lion	alphabetical	46
Judd Apatow & Friends	alphabetical	47
Kamasi Washington	alphabetical	48
Keys N Krates	alphabetical	49
Kurt Vile & The Violators	alphabetical	50
LANY	alphabetical	51
LCD Soundsystem	alphabetical	52
Lamb of God	alphabetical	53
Leon Bridges	alphabetical	54
Lettuce	alphabetical	55
Lizzo	alphabetical	56
Lolawolf	alphabetical	57
Lord Huron	alphabetical	58
Lucius	alphabetical	59
M83	alphabetical	60
Macklemore & Ryan Lewis	alphabetical	61
Marian Hill	alphabetical	62
Miguel	alphabetical	63
MisterWives	alphabetical	64
Natalie Prass	alphabetical	65
Nathaniel Rateliff & the Night Sweats	alphabetical	66
Oh Wonder	alphabetical	67
Papadosio	alphabetical	68
Pearl Jam	alphabetical	69
Piff the Magic Dragon	alphabetical	70
Post Malone	alphabetical	71
Purity Ring	alphabetical	72
RL Grime	alphabetical	73
Rayland Baxter	alphabetical	74
Roman GianArthur Irvin	alphabetical	75
Saint Motel	alphabetical	76
Sam Bush Band	alphabetical	77
Sam Hunt	alphabetical	78
Sara Watkins	alphabetical	79
Shamir	alphabetical	80
St. Lucia	alphabetical	81
Steep Canyon Rangers	alphabetical	82
Steve Gunn	alphabetical	83
Tame Impala (Late Night)	alphabetical	84
The Bluegrass Situation SuperJam Featuring Ed Helms and Friends	alphabetical	85
The Chainsmokers	alphabetical	86
The Claypool Lennon Delirium	alphabetical	87
The Floozies	alphabetical	88
The Internet	alphabetical	89
The Knocks	alphabetical	90
The London Souls	alphabetical	91
The Oh Hellos	alphabetical	92
The Wood Brothers	alphabetical	93
Third Eye Blind	alphabetical	94
Touchpants	alphabetical	95
Twin Peaks	alphabetical	96
Two Door Cinema Club	alphabetical	97
Tyler, the Creator	alphabetical	98
Vince Staples	alphabetical	99
Vulfpeck	alphabetical	100
Waxahatchee	alphabetical	101
Ween	alphabetical	102
Whilk and Misky	alphabetical	103
X Ambassadors	alphabetical	104
Zeds Dead	alphabetical	105
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY users (email, pass, role) FROM stdin;
hays@compose.io	secret	music_lover
\.


--
-- Name: artists_mb_id_key; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY artists
    ADD CONSTRAINT artists_mb_id_key UNIQUE (mb_id);


--
-- Name: artists_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (name);


--
-- Name: rating_types_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY rating_types
    ADD CONSTRAINT rating_types_pkey PRIMARY KEY (name);


--
-- Name: ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (artist_name, email, rating_type_name);


--
-- Name: sort_types_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY sort_types
    ADD CONSTRAINT sort_types_pkey PRIMARY KEY (name);


--
-- Name: sorts_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY sorts
    ADD CONSTRAINT sorts_pkey PRIMARY KEY (artist_name, sort_type_name);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- Name: ratings_artist_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_artist_name_fkey FOREIGN KEY (artist_name) REFERENCES artists(name);


--
-- Name: ratings_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_email_fkey FOREIGN KEY (email) REFERENCES users(email);


--
-- Name: ratings_rating_type_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_rating_type_name_fkey FOREIGN KEY (rating_type_name) REFERENCES rating_types(name);


--
-- Name: sorts_artist_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY sorts
    ADD CONSTRAINT sorts_artist_name_fkey FOREIGN KEY (artist_name) REFERENCES artists(name);


--
-- Name: sorts_sort_type_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY sorts
    ADD CONSTRAINT sorts_sort_type_name_fkey FOREIGN KEY (sort_type_name) REFERENCES sort_types(name);


--
-- Name: public; Type: ACL; Schema: -; Owner: focker
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM focker;
GRANT ALL ON SCHEMA public TO focker;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: compose_session_replication_role(text); Type: ACL; Schema: public; Owner: focker
--

REVOKE ALL ON FUNCTION compose_session_replication_role(role text) FROM PUBLIC;
REVOKE ALL ON FUNCTION compose_session_replication_role(role text) FROM focker;
GRANT ALL ON FUNCTION compose_session_replication_role(role text) TO focker;
GRANT ALL ON FUNCTION compose_session_replication_role(role text) TO admin;


--
-- Name: artists; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE artists FROM PUBLIC;
REVOKE ALL ON TABLE artists FROM admin;
GRANT ALL ON TABLE artists TO admin;
GRANT SELECT ON TABLE artists TO music_lover;


--
-- Name: rating_types; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE rating_types FROM PUBLIC;
REVOKE ALL ON TABLE rating_types FROM admin;
GRANT ALL ON TABLE rating_types TO admin;
GRANT SELECT ON TABLE rating_types TO music_lover;


--
-- Name: ratings; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE ratings FROM PUBLIC;
REVOKE ALL ON TABLE ratings FROM admin;
GRANT ALL ON TABLE ratings TO admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ratings TO music_lover;


--
-- Name: sort_types; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE sort_types FROM PUBLIC;
REVOKE ALL ON TABLE sort_types FROM admin;
GRANT ALL ON TABLE sort_types TO admin;
GRANT SELECT ON TABLE sort_types TO music_lover;


--
-- Name: sorts; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE sorts FROM PUBLIC;
REVOKE ALL ON TABLE sorts FROM admin;
GRANT ALL ON TABLE sorts TO admin;
GRANT SELECT ON TABLE sorts TO music_lover;


--
-- Name: users; Type: ACL; Schema: public; Owner: admin
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM admin;
GRANT ALL ON TABLE users TO admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE users TO music_lover;


--
-- PostgreSQL database dump complete
--

