--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    is_spiral boolean,
    planet_pop integer,
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    name character varying(30),
    planet_id integer NOT NULL,
    grav_eff boolean,
    moon_id numeric NOT NULL,
    orbit_dist integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_dist integer NOT NULL,
    con_life boolean NOT NULL,
    planet_id integer NOT NULL,
    name character varying(30),
    size numeric,
    species text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: solar_system; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.solar_system (
    name character varying(30),
    solar_system_id integer NOT NULL,
    contains_life boolean NOT NULL
);


ALTER TABLE public.solar_system OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    planet_dist integer NOT NULL,
    is_neutron boolean,
    brightness_nits numeric,
    name character varying(30) NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (true, 300000, 1, 1, 'ANDRO');
INSERT INTO public.galaxy VALUES (true, 6582463, 2, 2, 'hama');
INSERT INTO public.galaxy VALUES (false, 185000, 3, 3, 'x-112');
INSERT INTO public.galaxy VALUES (true, 186800987, 4, 4, 'Sequia');
INSERT INTO public.galaxy VALUES (true, 986754335, 5, 5, 'Dormon');
INSERT INTO public.galaxy VALUES (true, 8976543, 6, 6, 'C-6691');
INSERT INTO public.galaxy VALUES (false, 225436, 7, 7, 'Milky Way');
INSERT INTO public.galaxy VALUES (false, 0, 8, 8, 'Galax');
INSERT INTO public.galaxy VALUES (false, 8975568, 9, 9, 'Chingo');
INSERT INTO public.galaxy VALUES (false, 25563, 10, 10, 'Planto');
INSERT INTO public.galaxy VALUES (true, 18, 11, 11, 'Polari');
INSERT INTO public.galaxy VALUES (false, 4528956, 12, 12, 'Firefly');
INSERT INTO public.galaxy VALUES (true, 5556545, 13, 13, 'x1897');
INSERT INTO public.galaxy VALUES (true, 1025987, 14, 14, 'Sigma');
INSERT INTO public.galaxy VALUES (true, 56, 15, 15, 'Creole');
INSERT INTO public.galaxy VALUES (false, 7605321, 16, 16, 'Truncite');
INSERT INTO public.galaxy VALUES (true, 88124, 17, 17, 'Diamonda');
INSERT INTO public.galaxy VALUES (false, 552869, 18, 18, 'Florian');
INSERT INTO public.galaxy VALUES (true, 7748965, 19, 19, 'Ice bely');
INSERT INTO public.galaxy VALUES (true, 1123215, 20, 20, 'Trovial');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES ('Titus', 1, true, 1, 65000);
INSERT INTO public.moon VALUES ('Moon', 2, false, 2, 856000);
INSERT INTO public.moon VALUES ('Titan', 3, true, 3, 87654329);
INSERT INTO public.moon VALUES ('Trioma', 4, false, 4, 2256986);
INSERT INTO public.moon VALUES ('Vaspa', 5, false, 5, 882569);
INSERT INTO public.moon VALUES ('Trillium', 6, false, 6, 3382);
INSERT INTO public.moon VALUES ('Borax', 7, false, 7, 876695);
INSERT INTO public.moon VALUES ('Clond', 8, false, 8, 1121564);
INSERT INTO public.moon VALUES ('Kliona', 9, false, 9, 2256986);
INSERT INTO public.moon VALUES ('Intursa', 10, false, 10, 6986);
INSERT INTO public.moon VALUES ('Minerva', 11, false, 11, 50442);
INSERT INTO public.moon VALUES ('Proto', 12, false, 12, 88184);
INSERT INTO public.moon VALUES ('Prisma', 13, false, 13, 66251);
INSERT INTO public.moon VALUES ('Glavoid', 14, false, 14, 33086);
INSERT INTO public.moon VALUES ('Exeron', 15, false, 15, 85469);
INSERT INTO public.moon VALUES ('Chevala', 16, false, 16, 25);
INSERT INTO public.moon VALUES ('Primoda', 17, false, 17, 11156);
INSERT INTO public.moon VALUES ('Lerpoin', 18, false, 18, 33286);
INSERT INTO public.moon VALUES ('Wringo', 19, false, 19, 875596);
INSERT INTO public.moon VALUES ('Plomint', 20, false, 20, 80665);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (3450, true, 1, 'Mercury', 65000, 'Bugs');
INSERT INTO public.planet VALUES (2564378, false, 2, 'Alpha', 86000000, 'Bionic');
INSERT INTO public.planet VALUES (500000, false, 3, 'Earth', 800000000, 'Human');
INSERT INTO public.planet VALUES (65000, false, 4, 'Jupiter', 45676, 'None');
INSERT INTO public.planet VALUES (8574432, false, 5, 'Saturn', 12325, 'None');
INSERT INTO public.planet VALUES (1134657234, true, 6, 'Uranus', 2433567, 'Iceman');
INSERT INTO public.planet VALUES (2546689, false, 7, 'Pluto', 8234553, 'None');
INSERT INTO public.planet VALUES (55648, true, 8, 'Alpha', 665982, 'None');
INSERT INTO public.planet VALUES (2265987, false, 9, 'Varmin', 4553, 'None');
INSERT INTO public.planet VALUES (1145698, true, 10, 'Ringot', 8255, 'None');
INSERT INTO public.planet VALUES (23780, true, 11, 'Plainlo', 55928, 'None');
INSERT INTO public.planet VALUES (66598, true, 12, 'Porridium', 22, 'None');
INSERT INTO public.planet VALUES (1458, false, 13, 'Uranipoil', 361115, 'None');
INSERT INTO public.planet VALUES (32123, true, 14, 'Planama', 882963, 'None');
INSERT INTO public.planet VALUES (58965, true, 15, 'Halo', 5587954, 'None');
INSERT INTO public.planet VALUES (4421, false, 16, 'B-365', 6221548, 'None');
INSERT INTO public.planet VALUES (54234, false, 17, 'China', 300659, 'None');
INSERT INTO public.planet VALUES (8794, true, 18, 'Crandoid', 1023320, 'None');
INSERT INTO public.planet VALUES (11625, true, 19, 'Purinium', 2265985, 'None');
INSERT INTO public.planet VALUES (22136, false, 20, 'Repollip', 8062, 'None');


--
-- Data for Name: solar_system; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.solar_system VALUES ('MILKY WAY', 1, true);
INSERT INTO public.solar_system VALUES ('Diales', 2, false);
INSERT INTO public.solar_system VALUES ('Ganjo', 3, false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 3450, true, 4500, 'Beetlejuice');
INSERT INTO public.star VALUES (2, 2564378, false, 867934, 'Leo');
INSERT INTO public.star VALUES (3, 500000, false, 6500, 'Alpha centauri');
INSERT INTO public.star VALUES (4, 65000, true, 547, 'Cancer');
INSERT INTO public.star VALUES (5, 8574432, true, 2, 'Virgo');
INSERT INTO public.star VALUES (6, 1134657234, false, 89007, 'X-123');
INSERT INTO public.star VALUES (7, 2546689, true, 22658, 'w234');
INSERT INTO public.star VALUES (8, 55648, false, 3312, 'Polaris');
INSERT INTO public.star VALUES (9, 2265987, true, 2654, 'Primus');
INSERT INTO public.star VALUES (10, 1145698, false, 58976, 'Titan');
INSERT INTO public.star VALUES (11, 23780, true, 12558, 'Sullo');
INSERT INTO public.star VALUES (12, 66598, true, 662, 'Granx');
INSERT INTO public.star VALUES (13, 1458, false, 3, 'Flash');
INSERT INTO public.star VALUES (14, 32123, true, 82569, 'Brillium');
INSERT INTO public.star VALUES (15, 58965, false, 10011, 'Minota');
INSERT INTO public.star VALUES (16, 4421, true, 623, 'Tauro');
INSERT INTO public.star VALUES (17, 54234, false, 812, 'Flipp');
INSERT INTO public.star VALUES (18, 8794, false, 33691, 'Charter');
INSERT INTO public.star VALUES (19, 11625, true, 80225, 'Endes');
INSERT INTO public.star VALUES (20, 22136, true, 51, 'Rackpo');


--
-- Name: galaxy galaxy_galaxy_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_galaxy_id_key UNIQUE (galaxy_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: galaxy galaxy_star_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_star_id_key UNIQUE (star_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: moon moon_planet_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_key UNIQUE (planet_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet planet_planet_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_id_key UNIQUE (planet_id);


--
-- Name: solar_system solar_system_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.solar_system
    ADD CONSTRAINT solar_system_name_key UNIQUE (name);


--
-- Name: solar_system solar_system_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.solar_system
    ADD CONSTRAINT solar_system_pkey PRIMARY KEY (solar_system_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star star_planet_dist_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_planet_dist_key UNIQUE (planet_dist);


--
-- Name: planet fk_planet_dist; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_planet_dist FOREIGN KEY (planet_dist) REFERENCES public.star(planet_dist);


--
-- Name: star fk_star_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_star_id FOREIGN KEY (star_id) REFERENCES public.galaxy(star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- PostgreSQL database dump complete
--

