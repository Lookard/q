--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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
-- Name: city; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    name character varying(30) NOT NULL,
    pop_in_mil integer,
    planet_id integer,
    has_cool_photos boolean
);


ALTER TABLE public.city OWNER TO freecodecamp;

--
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_city_id_seq OWNER TO freecodecamp;

--
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.city.city_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(40) NOT NULL,
    distance_in_kpc numeric(40,2),
    has_cool_photos boolean,
    has_humans boolean
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(40) NOT NULL,
    mass integer,
    planet_id integer,
    has_cool_photos boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(40) NOT NULL,
    mass integer,
    has_moons boolean,
    is_habitable boolean,
    discovered_by text,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(40) NOT NULL,
    mass integer,
    galaxy_id integer,
    has_cool_photos boolean
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.cities_city_id_seq'::regclass);


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.city VALUES (1, 'Moscow', 17, 1, true);
INSERT INTO public.city VALUES (3, 'Berlin', 2, 1, true);
INSERT INTO public.city VALUES (2, 'Voskresensk', 0, 1, false);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (2, 'Large Magellanic Cloud', 49.40, true, false);
INSERT INTO public.galaxy VALUES (3, 'Small Magellanic Cloud', 203.70, true, false);
INSERT INTO public.galaxy VALUES (4, 'Andromeda', 752.00, true, false);
INSERT INTO public.galaxy VALUES (5, 'Messier 82', 3500.00, true, false);
INSERT INTO public.galaxy VALUES (6, 'Sombrero', 9550.00, true, false);
INSERT INTO public.galaxy VALUES (1, 'Milky Way', 7.90, true, true);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (4, 'CorMoon1', NULL, 10, false);
INSERT INTO public.moon VALUES (5, 'CorMoon2', NULL, 10, false);
INSERT INTO public.moon VALUES (6, 'CorMoon3', NULL, 10, false);
INSERT INTO public.moon VALUES (7, 'CorMoon4', NULL, 10, false);
INSERT INTO public.moon VALUES (8, 'CorMoon5', NULL, 10, false);
INSERT INTO public.moon VALUES (9, 'CorMoon6', NULL, 10, false);
INSERT INTO public.moon VALUES (10, 'CorMoon7', NULL, 10, false);
INSERT INTO public.moon VALUES (11, 'CorMoon8', NULL, 10, false);
INSERT INTO public.moon VALUES (12, 'CorMoon9', NULL, 10, false);
INSERT INTO public.moon VALUES (13, 'CorMoon10', NULL, 10, false);
INSERT INTO public.moon VALUES (14, 'CorMoon11', NULL, 10, false);
INSERT INTO public.moon VALUES (15, 'CorMoon12', NULL, 10, false);
INSERT INTO public.moon VALUES (16, 'CorMoon13', NULL, 10, false);
INSERT INTO public.moon VALUES (17, 'CorMoon14', NULL, 10, false);
INSERT INTO public.moon VALUES (18, 'CorMoon15', NULL, 10, false);
INSERT INTO public.moon VALUES (19, 'CorMoon16', NULL, 10, false);
INSERT INTO public.moon VALUES (20, 'CorMoon17', NULL, 10, false);
INSERT INTO public.moon VALUES (21, 'CorMoon18', NULL, 10, false);
INSERT INTO public.moon VALUES (1, 'Phobos', 80, 2, true);
INSERT INTO public.moon VALUES (2, 'Deimos', 81, 2, true);
INSERT INTO public.moon VALUES (3, 'Moon', 82, 1, true);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 76, true, true, 'n/a', 1);
INSERT INTO public.planet VALUES (2, 'Mars', 77, true, false, 'Some dude', 1);
INSERT INTO public.planet VALUES (3, 'Venus', 78, false, false, 'Some dude(2)', 1);
INSERT INTO public.planet VALUES (4, 'Jupiter', 79, true, false, 'Some dude(3)', 1);
INSERT INTO public.planet VALUES (5, 'Saturn', 80, true, false, 'Some dude(4)', 1);
INSERT INTO public.planet VALUES (6, 'Mercury', 81, true, false, 'Some dude(5)', 1);
INSERT INTO public.planet VALUES (7, 'Uranus', 82, true, false, 'Some dude(6)', 1);
INSERT INTO public.planet VALUES (8, 'Neptune', 83, true, false, 'Some dude(7)', 1);
INSERT INTO public.planet VALUES (9, 'Krypton', NULL, true, true, NULL, NULL);
INSERT INTO public.planet VALUES (10, 'Corusant', NULL, true, true, NULL, NULL);
INSERT INTO public.planet VALUES (11, 'Naboo', NULL, true, true, NULL, NULL);
INSERT INTO public.planet VALUES (12, 'Tatooine', NULL, true, true, NULL, NULL);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 73, 1, true);
INSERT INTO public.star VALUES (2, 'Antares', 74, 1, true);
INSERT INTO public.star VALUES (3, 'VV Cephei', 75, 1, true);
INSERT INTO public.star VALUES (4, 'Betelgeuse', 76, 1, true);
INSERT INTO public.star VALUES (5, 'S Persei', 77, 1, true);
INSERT INTO public.star VALUES (6, 'Alpha Lyrae', 78, 1, true);


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.cities_city_id_seq', 3, true);


--
-- Name: city cities_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: city unique_city; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT unique_city UNIQUE (name);


--
-- Name: galaxy unique_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- Name: moon unique_name_moon; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT unique_name_moon UNIQUE (name);


--
-- Name: planet unique_name_planet; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT unique_name_planet UNIQUE (name);


--
-- Name: star unique_name_star; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT unique_name_star UNIQUE (name);


--
-- Name: city fk_city_of_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT fk_city_of_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: moon fk_moon_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_moon_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_planet_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_planet_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star fk_star_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_star_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--
