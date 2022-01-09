--
-- PostgreSQL database cluster dump
--

-- SET default_transaction_read_only = off;

-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;

-- --
-- -- Drop databases
-- --





-- --
-- -- Drop roles
-- --

-- DROP ROLE postgres;


-- --
-- -- Roles
-- --

-- CREATE ROLE postgres;
-- ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md543225d7c19e7b7bd74e416fe9566a7f9';






-- --
-- -- Database creation
-- --

-- REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
-- GRANT CONNECT ON DATABASE template1 TO PUBLIC;


-- \connect postgres

-- SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.18 (Debian 10.18-1.pgdg90+1)
-- Dumped by pg_dump version 10.18 (Debian 10.18-1.pgdg90+1)

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Seasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Seasons" (
    season_id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort integer,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    title character varying(255),
    belongs_to_series uuid
);


ALTER TABLE public."Seasons" OWNER TO postgres;

--
-- Name: Series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Series" (
    series_id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort integer,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    title character varying(255)
);


ALTER TABLE public."Series" OWNER TO postgres;

--
-- Name: Series_seasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Series_seasons" (
    id integer NOT NULL,
    "Series_series_id" uuid,
    item character varying(255),
    collection character varying(255)
);


ALTER TABLE public."Series_seasons" OWNER TO postgres;

--
-- Name: Series_seasons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Series_seasons_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Series_seasons_id_seq" OWNER TO postgres;

--
-- Name: Series_seasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Series_seasons_id_seq" OWNED BY public."Series_seasons".id;


--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50) NOT NULL,
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text
);


ALTER TABLE public.directus_activity OWNER TO postgres;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO postgres;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO postgres;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_dashboards OWNER TO postgres;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64)
);


ALTER TABLE public.directus_fields OWNER TO postgres;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO postgres;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO postgres;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO postgres;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO postgres;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid NOT NULL,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO postgres;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO postgres;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(30) DEFAULT 'insert_chart'::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO postgres;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text
);


ALTER TABLE public.directus_permissions OWNER TO postgres;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO postgres;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json
);


ALTER TABLE public.directus_presets OWNER TO postgres;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO postgres;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO postgres;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO postgres;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO postgres;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO postgres;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO postgres;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid NOT NULL,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255),
    data json
);


ALTER TABLE public.directus_sessions OWNER TO postgres;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(10) DEFAULT '#00C897'::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json
);


ALTER TABLE public.directus_settings OWNER TO postgres;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO postgres;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(8) DEFAULT 'en-US'::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true
);


ALTER TABLE public.directus_users OWNER TO postgres;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url text NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections text NOT NULL,
    headers json
);


ALTER TABLE public.directus_webhooks OWNER TO postgres;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO postgres;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.migrations_lock OWNER TO postgres;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_lock_index_seq OWNER TO postgres;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_lock_index_seq OWNED BY public.migrations_lock.index;


--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movie_id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort integer,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    movie_name character varying(255) DEFAULT NULL::character varying,
    movie_delivery_url json,
    movie_raw uuid,
    video_type character varying(255) DEFAULT 'movie'::character varying,
    episode_sequence_number character varying(255),
    season_sequence_number character varying(255),
    custom_upload uuid,
    featured_image uuid,
    belongs_to_season uuid
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: movies_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_files (
    id integer NOT NULL,
    movies_movie_id uuid,
    directus_files_id uuid
);


ALTER TABLE public.movies_files OWNER TO postgres;

--
-- Name: movies_files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_files_id_seq OWNER TO postgres;

--
-- Name: movies_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_files_id_seq OWNED BY public.movies_files.id;


--
-- Name: movies_undefined; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_undefined (
    id integer NOT NULL,
    movies_movie_id uuid,
    item character varying(255),
    collection character varying(255)
);


ALTER TABLE public.movies_undefined OWNER TO postgres;

--
-- Name: movies_undefined_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_undefined_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_undefined_id_seq OWNER TO postgres;

--
-- Name: movies_undefined_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_undefined_id_seq OWNED BY public.movies_undefined.id;


--
-- Name: test_movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_movies (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort integer,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    title character varying(255),
    models_testing uuid
);


ALTER TABLE public.test_movies OWNER TO postgres;

--
-- Name: testmodel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.testmodel (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort integer,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    title character varying(255)
);


ALTER TABLE public.testmodel OWNER TO postgres;

--
-- Name: Series_seasons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Series_seasons" ALTER COLUMN id SET DEFAULT nextval('public."Series_seasons_id_seq"'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: migrations_lock index; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.migrations_lock_index_seq'::regclass);


--
-- Name: movies_files id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_files ALTER COLUMN id SET DEFAULT nextval('public.movies_files_id_seq'::regclass);


--
-- Name: movies_undefined id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_undefined ALTER COLUMN id SET DEFAULT nextval('public.movies_undefined_id_seq'::regclass);


--
-- Data for Name: Seasons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Seasons" (season_id, status, sort, user_created, date_created, user_updated, date_updated, title, belongs_to_series) FROM stdin;
e88d880b-7add-4260-abda-0fb211623bb3	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.864+00	\N	\N	Witcher Season 1	eabcb137-667b-40b1-b472-0344e31a6fd3
05a4d7e4-c266-450e-b270-84f0ff3cc16e	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:58.36+00	\N	\N	Witcher Season 2	eabcb137-667b-40b1-b472-0344e31a6fd3
363e7496-4bb9-47ba-9120-ff8f12363f5c	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:11:00.858+00	\N	\N	wire season 1	0bd3ff80-5270-4839-867b-817b42cff869
\.


--
-- Data for Name: Series; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Series" (series_id, status, sort, user_created, date_created, user_updated, date_updated, title) FROM stdin;
eabcb137-667b-40b1-b472-0344e31a6fd3	published	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.857+00	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:58.353+00	Witcher TV Series
0bd3ff80-5270-4839-867b-817b42cff869	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:11:00.854+00	\N	\N	the wire
\.


--
-- Data for Name: Series_seasons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Series_seasons" (id, "Series_series_id", item, collection) FROM stdin;
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) FROM stdin;
1	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-14 10:09:36.396167+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
2	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-14 10:10:44.197078+00	::ffff:127.0.0.1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:95.0) Gecko/20100101 Firefox/95.0	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
4	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-14 11:47:29.974498+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
5	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-14 12:05:37.541302+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
6	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-14 12:30:54.073252+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
7	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-14 12:55:17.53098+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
8	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-14 13:06:06.928193+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
9	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:38:18.591813+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	projects	\N
10	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:38:26.348618+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	1	\N
11	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:38:46.459702+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	1	\N
12	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:38:53.101544+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	2	\N
13	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:39:00.664843+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	2	\N
14	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:39:03.953598+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	3	\N
15	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:39:09.665287+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	3	\N
16	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:39:13.217915+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	4	\N
17	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:39:22.39463+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	5	\N
18	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:39:25.274285+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	6	\N
19	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:40:03.246405+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	7	\N
20	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:40:22.935656+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	8	\N
21	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:40:26.10773+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	9	\N
22	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:40:28.382951+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	10	\N
23	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:40:37.123184+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	11	\N
24	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:40:57.608025+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	12	\N
25	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:40:59.989128+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	13	\N
26	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:41:03.868648+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	14	\N
29	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:14.050224+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	projects	\N
30	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:54.345961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	movies	\N
31	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:54.345961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	15	\N
32	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:54.345961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	16	\N
33	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:54.345961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	17	\N
34	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:54.345961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	18	\N
35	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:54.345961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	19	\N
36	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:54.345961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	20	\N
37	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:47:54.345961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	21	\N
38	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:48:48.63965+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	22	\N
39	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:49:38.832796+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	23	\N
40	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:49:39.008441+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	movies_files	\N
41	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:49:39.008441+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	24	\N
42	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:49:39.191741+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	25	\N
43	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:49:39.324299+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	26	\N
44	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:50:19.515723+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	22	\N
45	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:51:16.144765+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	movies	\N
46	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:52:31.768097+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	c03f958e-872e-4b12-914a-4350b9074b28	\N
49	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:52:54.646636+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	3faabca9-0406-4ef6-be23-c1ca857ebdfe	\N
47	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:52:31.770507+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	0b144a82-e3ed-438a-8756-51a99497f692	\N
48	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:52:54.644666+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	d80cc677-8481-4923-825c-fecf5b342ceb	\N
50	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:53:00.227726+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies_files	1	\N
51	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:53:00.227726+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies_files	2	\N
52	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:53:00.227726+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e	\N
53	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 07:09:35.939424+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	916779e3-b8e4-4895-90b8-81e11df23ee6	\N
54	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 07:11:31.514519+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	916779e3-b8e4-4895-90b8-81e11df23ee6	\N
55	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 07:19:14.244759+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	1	\N
56	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 07:19:17.183161+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	2	\N
57	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 07:19:25.076118+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	2	\N
58	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 07:19:34.712454+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	3	\N
59	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:32:06.29299+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
60	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.826673+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	cca744c1-a78b-44e1-a83f-4a62fc954734	\N
61	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	4	\N
62	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	5	\N
63	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	6	\N
64	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	7	\N
65	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	8	\N
66	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	9	\N
67	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	10	\N
68	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	11	\N
69	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	12	\N
70	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	13	\N
71	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	14	\N
72	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	15	\N
73	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	16	\N
74	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	17	\N
75	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	18	\N
76	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	19	\N
77	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	20	\N
78	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	21	\N
79	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:17.893066+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	22	\N
80	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:27.989346+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	23	\N
81	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:30.915836+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	23	\N
82	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:33.10091+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	24	\N
83	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:36:34.494361+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	25	\N
84	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:37:05.461074+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	a224d75d-5da8-4450-9e66-f9ef53a16e45	\N
85	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:37:05.461074+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	cca744c1-a78b-44e1-a83f-4a62fc954734	\N
86	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:37:32.048889+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
87	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:38:13.372441+00	::1	PostmanRuntime/7.26.8	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	\N
88	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:39:12.971261+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	\N
89	login	49eab1e1-ec46-41da-a5e7-92ad20d5e045	2021-12-15 08:41:15.460186+00	::1	PostmanRuntime/7.26.8	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	\N
90	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:42:29.253423+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	a224d75d-5da8-4450-9e66-f9ef53a16e45	\N
91	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 08:42:29.253423+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	cca744c1-a78b-44e1-a83f-4a62fc954734	\N
92	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.828358+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	40d68c4a-50d1-4129-b669-7ddade995171	\N
93	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	26	\N
94	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	27	\N
95	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	28	\N
96	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	29	\N
97	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	30	\N
98	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	31	\N
99	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	32	\N
100	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	33	\N
101	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	34	\N
102	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	35	\N
103	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	36	\N
104	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	37	\N
105	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	38	\N
106	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	39	\N
107	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	40	\N
108	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	41	\N
109	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	42	\N
110	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	43	\N
111	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:29:58.879058+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	44	\N
112	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	26	\N
113	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	27	\N
114	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	28	\N
115	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	29	\N
116	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	30	\N
117	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	31	\N
118	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	32	\N
119	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	33	\N
120	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	34	\N
121	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	35	\N
122	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	36	\N
123	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	37	\N
124	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	38	\N
125	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	39	\N
126	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	40	\N
127	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	41	\N
128	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	42	\N
129	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	43	\N
130	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	44	\N
131	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:30:12.613117+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	40d68c4a-50d1-4129-b669-7ddade995171	\N
132	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	4	\N
133	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	5	\N
134	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	6	\N
135	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	7	\N
136	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	8	\N
137	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	9	\N
138	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	10	\N
139	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	11	\N
140	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	12	\N
141	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	13	\N
142	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	14	\N
143	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	15	\N
144	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	16	\N
145	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	17	\N
146	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	18	\N
147	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	19	\N
148	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	20	\N
149	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	21	\N
150	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	22	\N
151	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	24	\N
152	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	25	\N
153	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	\N
154	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:31:22.999182+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	cca744c1-a78b-44e1-a83f-4a62fc954734	\N
155	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.847064+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	dc6978e7-d62a-4b2a-82a3-990d72087461	\N
156	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	45	\N
157	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	46	\N
158	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	47	\N
159	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	48	\N
160	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	49	\N
161	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	50	\N
162	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	51	\N
163	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	52	\N
164	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	53	\N
165	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	54	\N
166	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	55	\N
167	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	56	\N
168	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	57	\N
169	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	58	\N
170	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	59	\N
171	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	60	\N
172	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	61	\N
173	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	62	\N
174	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:29.90676+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	63	\N
175	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	45	\N
176	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	46	\N
177	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	47	\N
178	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	48	\N
179	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	49	\N
180	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	50	\N
181	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	51	\N
182	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	52	\N
183	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	53	\N
184	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	54	\N
185	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	55	\N
186	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	56	\N
187	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	57	\N
188	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	58	\N
189	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	59	\N
190	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	60	\N
191	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	61	\N
192	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	62	\N
193	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	63	\N
194	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 11:32:34.159059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	dc6978e7-d62a-4b2a-82a3-990d72087461	\N
195	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.76527+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	537e43d3-2620-4e81-9aa0-ccfe797a87e8	\N
196	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	64	\N
197	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	65	\N
198	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	66	\N
199	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	67	\N
200	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	68	\N
201	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	69	\N
202	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	70	\N
203	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	71	\N
204	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	72	\N
205	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	73	\N
206	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	74	\N
207	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	75	\N
208	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	76	\N
209	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	77	\N
210	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	78	\N
211	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	79	\N
212	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	80	\N
213	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	81	\N
214	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:47:58.965375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	82	\N
215	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:50:31.242392+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	14812d91-421e-438c-a5f5-58bcd87bf218	\N
216	login	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 10:50:54.901811+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	14812d91-421e-438c-a5f5-58bcd87bf218	\N
217	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:51:58.815185+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
218	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:52:51.929036+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	83	\N
219	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:52:58.470033+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	84	\N
220	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:53:14.558587+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	85	\N
221	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:53:15.991082+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	86	\N
222	update	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 10:53:33.046915+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e	\N
223	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:53:45.488718+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	87	\N
224	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:53:47.052101+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	88	\N
225	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:53:48.281891+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	89	\N
226	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:53:49.337279+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	90	\N
227	create	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 10:54:19.768932+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	2dc325d0-7998-43bd-884f-f98d8e293ecf	\N
228	create	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 10:54:22.597751+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies_files	3	\N
229	create	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 10:54:22.597751+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	424d878d-7c64-4dfb-b5fc-b472f22d9a74	\N
230	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:56:51.334634+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	80	\N
231	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.720253+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	39e1d541-89d9-4e3e-99d4-d34516cdedf1	\N
232	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	91	\N
233	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	92	\N
234	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	93	\N
235	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	94	\N
236	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	95	\N
237	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	96	\N
238	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	97	\N
239	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	98	\N
240	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	99	\N
241	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	100	\N
242	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	101	\N
243	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	102	\N
244	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	103	\N
245	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	104	\N
246	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	105	\N
247	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	106	\N
248	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	107	\N
249	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	108	\N
250	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:52.773192+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	109	\N
251	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:57:59.394723+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	110	\N
252	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 10:58:00.656923+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	111	\N
253	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:00:16.036827+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	107	\N
254	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:04.070001+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	107	\N
255	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	91	\N
256	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	92	\N
257	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	93	\N
258	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	94	\N
259	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	95	\N
260	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	96	\N
261	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	97	\N
262	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	98	\N
263	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	99	\N
264	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	100	\N
265	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	101	\N
266	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	102	\N
267	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	103	\N
268	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	104	\N
269	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	105	\N
270	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	106	\N
271	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	107	\N
272	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	108	\N
273	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	109	\N
274	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	110	\N
275	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	111	\N
276	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:26.463841+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	39e1d541-89d9-4e3e-99d4-d34516cdedf1	\N
277	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.583048+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	\N
278	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	112	\N
279	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	113	\N
280	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	114	\N
281	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	115	\N
282	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	116	\N
283	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	117	\N
284	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	118	\N
285	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	119	\N
286	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	120	\N
287	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	121	\N
288	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	122	\N
289	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	123	\N
290	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	124	\N
291	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	125	\N
292	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	126	\N
293	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	127	\N
294	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	128	\N
295	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	129	\N
296	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:32.643599+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	130	\N
297	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:38.788925+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	131	\N
298	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:42.294546+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	132	\N
299	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:01:56.039942+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	\N
300	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:02:13.046582+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	133	\N
301	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:02:53.556742+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	133	\N
302	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:03:01.421655+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	133	\N
303	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:03:41.457524+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	2b8f7583-40f0-4b4c-a8fc-c606533a736a	\N
304	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:04:13.011135+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	a224d75d-5da8-4450-9e66-f9ef53a16e45	\N
305	login	2b8f7583-40f0-4b4c-a8fc-c606533a736a	2021-12-16 11:07:10.458488+00	::1	PostmanRuntime/7.26.8	directus_users	2b8f7583-40f0-4b4c-a8fc-c606533a736a	\N
306	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:08:17.178787+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	projects	\N
307	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:08:42.944524+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	\N
308	login	2b8f7583-40f0-4b4c-a8fc-c606533a736a	2021-12-16 11:09:17.449326+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	2b8f7583-40f0-4b4c-a8fc-c606533a736a	\N
309	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:09:48.09497+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	116	\N
310	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:09:49.469617+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	117	\N
311	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:09:50.771433+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	118	\N
312	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:09:51.93861+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	119	\N
313	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:10:00.293911+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	120	\N
314	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:10:01.371383+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	121	\N
315	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:10:02.59803+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	122	\N
316	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:10:03.951934+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	123	\N
317	login	2b8f7583-40f0-4b4c-a8fc-c606533a736a	2021-12-16 11:10:32.551788+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	2b8f7583-40f0-4b4c-a8fc-c606533a736a	\N
318	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:11:13.173041+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	\N
319	login	a224d75d-5da8-4450-9e66-f9ef53a16e45	2021-12-16 11:11:38.337489+00	::1	PostmanRuntime/7.26.8	directus_users	a224d75d-5da8-4450-9e66-f9ef53a16e45	\N
320	login	2b8f7583-40f0-4b4c-a8fc-c606533a736a	2021-12-16 11:17:20.462088+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	2b8f7583-40f0-4b4c-a8fc-c606533a736a	\N
321	login	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 11:17:55.739073+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	14812d91-421e-438c-a5f5-58bcd87bf218	\N
322	create	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 11:18:37.883352+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	dcc177dc-d8bf-4017-b859-dcc887a6f40c	\N
323	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:20:16.469234+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	134	\N
324	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:20:17.704082+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	135	\N
325	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:20:19.136825+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	136	\N
326	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:20:20.27869+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	137	\N
327	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:21:30.303449+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	537e43d3-2620-4e81-9aa0-ccfe797a87e8	\N
328	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:21:46.813672+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_roles	537e43d3-2620-4e81-9aa0-ccfe797a87e8	\N
329	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:22:26.812504+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_webhooks	1	\N
330	login	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 11:24:04.334688+00	::1	PostmanRuntime/7.26.8	directus_users	14812d91-421e-438c-a5f5-58bcd87bf218	\N
331	create	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 11:25:06.402034+00	::1	PostmanRuntime/7.26.8	directus_webhooks	2	\N
332	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:26:53.952154+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_settings	1	\N
333	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:28:01.83752+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_settings	1	\N
334	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:28:49.006027+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	e9147cba-4198-4ac5-a149-94ce6b9b206d	\N
335	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:28:51.831798+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_settings	1	\N
336	login	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 13:20:36.645402+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	14812d91-421e-438c-a5f5-58bcd87bf218	\N
337	login	2b8f7583-40f0-4b4c-a8fc-c606533a736a	2021-12-16 13:21:26.338821+00	::1	PostmanRuntime/7.26.8	directus_users	2b8f7583-40f0-4b4c-a8fc-c606533a736a	\N
338	create	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 13:22:02.507059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	aee6278e-7de7-41a8-bf7f-f3b93ffe6990	\N
339	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-17 07:01:54.727586+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
340	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-17 07:45:44.494931+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
341	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-17 07:52:19.591257+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	d64359fd-9ad2-44bb-8e99-245182d32366	\N
342	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-17 11:35:39.215137+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
343	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 06:47:23.549534+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
344	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 06:55:47.388793+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
345	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 07:02:35.339977+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
346	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 11:30:39.644384+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	27	\N
347	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 11:30:39.796299+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	movies_undefined	\N
348	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 11:30:39.796299+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	28	\N
349	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 11:30:40.123356+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	29	\N
350	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 11:30:40.234132+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	30	\N
351	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 11:30:40.374378+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	31	\N
352	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 11:32:31.74033+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	32	\N
353	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-20 11:33:15.203705+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	32	\N
354	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 07:55:08.46237+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	33	\N
355	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 08:02:43.8429+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	30183811-6618-4f0c-90b3-337ca1e5bd48	\N
356	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 08:04:52.380478+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	9dd7400f-6808-48e9-b678-9071769ad251	\N
357	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 08:08:59.019829+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	ef36ba3f-6640-4afa-9be9-3076158cc088	\N
358	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 10:28:58.124919+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	d7bc9733-2ca6-42c8-aaeb-aa07d0fa9114	\N
359	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 06:55:58.266115+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
360	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:38:16.562827+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	a0d9f25e-aca5-478f-a653-a8c131e93af7	\N
361	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:40:23.28886+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	d64359fd-9ad2-44bb-8e99-245182d32366	\N
362	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:40:23.28886+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	dcc177dc-d8bf-4017-b859-dcc887a6f40c	\N
363	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:40:23.28886+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	aee6278e-7de7-41a8-bf7f-f3b93ffe6990	\N
364	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:40:23.28886+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	424d878d-7c64-4dfb-b5fc-b472f22d9a74	\N
365	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:41:05.243111+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	37827f87-7636-41da-9fd6-4681e3ab1e6c	\N
366	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:42:02.089051+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	ea7079e7-bb67-4829-90a3-a82401680a4c	\N
367	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:43:01.821226+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	migrations	\N
368	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:43:24.676643+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	migrations_lock	\N
369	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:43:29.01601+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	migrations_lock	\N
370	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:43:47.030345+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	projects	\N
371	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:54:45.442413+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	6e9ac6ff-a7c1-456f-bd8c-a824073bd244	\N
372	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:55:05.124125+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	578206c0-4323-495c-8fc5-374ea322f2c2	\N
373	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:55:36.822897+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	2bb7896d-ffe5-41ce-9fb5-7a09d563085f	\N
374	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:55:45.55855+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	829a716a-715d-4e80-939f-e4e94de06476	\N
375	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:56:13.936375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	916779e3-b8e4-4895-90b8-81e11df23ee6	\N
376	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:56:13.936375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	a0d9f25e-aca5-478f-a653-a8c131e93af7	\N
377	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:56:13.936375+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e	\N
378	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:56:27.436887+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b	\N
379	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:56:44.370795+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	e86e5d68-3d9b-466e-b8bd-7486f0a0f082	\N
380	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 06:58:33.198866+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	578206c0-4323-495c-8fc5-374ea322f2c2	\N
381	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 06:59:10.377191+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	578206c0-4323-495c-8fc5-374ea322f2c2	\N
382	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:01:11.516326+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	e86e5d68-3d9b-466e-b8bd-7486f0a0f082	\N
383	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:02:08.289896+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	e86e5d68-3d9b-466e-b8bd-7486f0a0f082	\N
384	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:03:27.782961+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	e86e5d68-3d9b-466e-b8bd-7486f0a0f082	\N
385	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:14:25.111977+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	bfcbe12e-b226-42f3-8c9d-bc29eb2638c3	\N
386	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:14:35.118461+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	\N
387	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:23:50.384186+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
388	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:26:26.493393+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	83708ad1-7763-4ac9-8d17-6ffb4a3de293	\N
389	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:26:40.588644+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	dd703c7c-3aae-4d0c-883d-dd6b199939e3	\N
390	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 08:47:04.566259+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	41b17364-9a34-48f0-afcc-e78bd8d43cfb	\N
391	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 08:47:13.713075+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	aa71595e-cda1-400a-9c4b-748b17ac976d	\N
392	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 08:47:36.832719+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
393	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 10:22:09.783996+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	\N
394	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 10:24:58.047243+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	\N
395	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 10:25:27.675278+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	\N
396	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:15:00.334697+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	ee64a57e-c550-46e4-bace-74860f357ef3	\N
397	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:15:16.374682+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies_files	4	\N
398	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:15:16.374682+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	\N
399	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:18:28.484867+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
400	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:52:36.653071+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	ec3c78b3-6f11-4116-b01f-c3e59fabc8d3	\N
401	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:53:15.168437+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	48e4683f-2c0e-4e07-87f1-1e4b02ab2eae	\N
402	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:53:38.686358+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	2285246a-e785-41b2-b12d-551291be126f	\N
403	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:54:02.102495+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
404	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:01:28.172377+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	34f3088c-f1db-4ad4-bb0b-440ee962e3a9	\N
405	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:01:59.05302+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	f7391c37-5612-4fe8-8bf0-bb0aa72685f1	\N
406	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:25:09.429644+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	1c2b532c-f15a-4868-a335-96b4ece15a41	\N
407	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:25:33.386391+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	72e3eb36-64a6-441a-898b-bfbf1c376159	\N
408	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:26:33.608383+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_webhooks	1	\N
409	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:26:37.088941+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_webhooks	2	\N
410	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 06:25:55.465231+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	6932a039-7c61-4d56-abc9-d54b3bf3c4f8	\N
411	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:19.120453+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	Series	\N
412	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:19.120453+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	34	\N
413	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:19.120453+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	35	\N
414	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:19.120453+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	36	\N
415	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:19.120453+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	37	\N
416	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:19.120453+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	38	\N
417	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:19.120453+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	39	\N
418	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:19.120453+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	40	\N
419	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:14:38.747535+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	41	\N
420	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:33:16.711103+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	42	\N
421	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:35:17.375056+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	43	\N
422	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:36:08.837345+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	44	\N
423	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:37:19.615451+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	44	\N
424	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:38:21.064861+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	44	\N
425	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:39:40.439613+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	45	\N
426	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:40:44.492214+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	46	\N
427	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:41:43.63083+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	\N
428	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:41:43.63083+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	829a716a-715d-4e80-939f-e4e94de06476	\N
429	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:41:43.63083+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	dd703c7c-3aae-4d0c-883d-dd6b199939e3	\N
430	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:41:43.63083+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	ea7079e7-bb67-4829-90a3-a82401680a4c	\N
431	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:41:43.63083+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	4b98565f-af11-48b6-9338-15b36a07414c	\N
432	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:41:43.63083+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	3f381be8-edeb-4e06-b632-53891f64d617	\N
433	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:41:57.341933+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	4b98565f-af11-48b6-9338-15b36a07414c	\N
434	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:42:07.584902+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	4b98565f-af11-48b6-9338-15b36a07414c	\N
435	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:43:14.432881+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	46	\N
436	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:12.354322+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	\N
437	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:12.354322+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	4b98565f-af11-48b6-9338-15b36a07414c	\N
438	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:12.354322+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	829a716a-715d-4e80-939f-e4e94de06476	\N
439	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:12.354322+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	dd703c7c-3aae-4d0c-883d-dd6b199939e3	\N
440	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:12.354322+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	ea7079e7-bb67-4829-90a3-a82401680a4c	\N
441	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:12.354322+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	3f381be8-edeb-4e06-b632-53891f64d617	\N
442	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:49.865564+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	44	\N
443	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:08:35.304803+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	47	\N
444	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:08:35.441096+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	Series_seasons	\N
445	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:08:35.441096+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	48	\N
446	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:08:35.593476+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	49	\N
447	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:08:35.75813+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	50	\N
448	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:08:35.873817+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	51	\N
449	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:14:43.035785+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
450	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:19:38.08982+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	52	\N
451	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:24:10.135152+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	46	\N
452	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:31:27.332364+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	53	\N
453	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:31:44.159008+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	54	\N
454	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:32:12.658744+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	53	\N
455	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:32:52.458398+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	53	\N
456	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:33:21.725974+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	2285246a-e785-41b2-b12d-551291be126f	\N
457	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:34:24.963809+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	19	\N
458	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:34:28.315465+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	18	\N
459	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:39:25.21532+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	578206c0-4323-495c-8fc5-374ea322f2c2	\N
460	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:40:15.748007+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	53	\N
461	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:41:04.411011+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	54	\N
462	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:41:18.979683+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	44	\N
463	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-28 05:26:59.841522+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	55	\N
464	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-28 05:27:22.121651+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	55	\N
465	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-28 06:19:20.777778+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	56	\N
466	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-28 06:23:04.611006+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	56	\N
467	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-28 07:15:25.503378+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	6214ebfd-f53d-4310-b9f3-a5a2e208dbf0	\N
468	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-28 07:16:04.416361+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	cdf84f22-7f5c-4d58-9593-8558d10d5530	\N
469	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-29 09:42:36.07152+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	139	\N
470	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 07:17:32.229786+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	43	\N
471	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:02:49.879096+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	4a9464b4-49b8-4895-a47c-73b249186b15	\N
472	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:04:13.12301+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	41dabed9-f1f8-41e1-b585-036b54568b49	\N
473	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:09:06.511708+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	57	\N
474	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:09:54.4324+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	57	\N
475	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:10:11.74129+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_files	62d44ac9-4a92-4e21-a655-4a7e296fc933	\N
476	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:10:18.461104+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	2285246a-e785-41b2-b12d-551291be126f	\N
477	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:11:44.752816+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	41dabed9-f1f8-41e1-b585-036b54568b49	\N
478	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:11:53.358275+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	41dabed9-f1f8-41e1-b585-036b54568b49	\N
479	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 12:26:37.02357+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	58	\N
480	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 12:33:45.793295+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	58	\N
481	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 12:34:27.002686+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	58	\N
482	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 12:49:55.731+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	3f381be8-edeb-4e06-b632-53891f64d617	\N
483	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 12:51:57.559502+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	46	\N
484	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:04:55.986401+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	Seasons	\N
485	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:04:55.986401+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	59	\N
486	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:04:55.986401+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	60	\N
487	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:04:55.986401+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	61	\N
488	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:04:55.986401+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	62	\N
489	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:04:55.986401+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	63	\N
490	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:04:55.986401+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	64	\N
491	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:04:55.986401+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	65	\N
492	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:07:35.915634+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	66	\N
493	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:09:58.588877+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	67	\N
494	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:11:36.008956+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	68	\N
495	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:12:39.054954+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	69	\N
496	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:13:08.652201+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	2285246a-e785-41b2-b12d-551291be126f	\N
497	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:13:08.652201+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	\N
498	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:13:08.652201+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	41dabed9-f1f8-41e1-b585-036b54568b49	\N
499	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:13:08.652201+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	4b98565f-af11-48b6-9338-15b36a07414c	\N
500	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:13:08.652201+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	829a716a-715d-4e80-939f-e4e94de06476	\N
501	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:13:08.652201+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	79d1e44b-4286-4402-936d-ff0856ebc204	\N
502	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:13:28.617389+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	70	\N
503	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:13:40.560174+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	79d1e44b-4286-4402-936d-ff0856ebc204	\N
504	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:16:24.379332+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	71	\N
505	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:17:06.211919+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	71	\N
506	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:21:48.609666+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	68	\N
507	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:22:45.874655+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	72	\N
508	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:23:02.509885+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	79d1e44b-4286-4402-936d-ff0856ebc204	\N
509	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:23:45.663982+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	73	\N
510	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:26:57.123062+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	8c5dd6d2-b121-4c78-b160-b4018d65f889	\N
511	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:26:57.123062+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	8cdbb08b-1b50-4f9a-a612-93389be4f389	\N
512	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:27:49.370753+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	74	\N
513	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:40.011507+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	c90ff1c2-7cc0-41e4-ba10-429615e876ce	\N
514	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:40.011507+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	aa448f9d-699a-4d8c-9632-05ab4e3a68dd	\N
515	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:40.011507+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	df1b3b93-9a6f-4d45-8ab6-85ea965ad872	\N
516	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:40.011507+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	35d3490a-9a81-4ab8-8f51-10807e64b667	\N
517	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:40.011507+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	0e8f587c-116f-4055-9503-c3d2ca87057d	\N
518	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:49.792174+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	0e8f587c-116f-4055-9503-c3d2ca87057d	\N
519	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:29:16.31605+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	c792f950-e0fe-494c-b950-76e478130778	\N
520	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:29:16.31605+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	49d75eb7-eadf-4af9-a6de-7b17bfce7504	\N
521	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:29:16.31605+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	b863b678-b037-4f46-9683-b8408984f1c3	\N
522	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:29:16.31605+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	0e8f587c-116f-4055-9503-c3d2ca87057d	\N
523	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:27:58.059389+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	74	\N
524	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:30:20.318948+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	0e8f587c-116f-4055-9503-c3d2ca87057d	\N
525	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:31:14.664147+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	3f381be8-edeb-4e06-b632-53891f64d617	\N
526	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:32:56.42459+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	98de8de0-aa51-48f8-aebd-3112068e441c	\N
527	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:32:56.42459+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	d38e226a-ed8d-4673-8b64-5dc0116e8613	\N
528	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:32:56.42459+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	7bb86a1b-3c88-4c03-86c2-fb838cb4868e	\N
529	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:32:56.42459+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	7ff4d915-f55f-4cf3-a79e-18ccf3072c02	\N
530	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:32:56.42459+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	20bc3149-a384-43c2-a955-d369d13c3ee3	\N
531	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:32:56.42459+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	ff7cb93b-7c87-46cd-a1a2-7d3d7f10bf25	\N
532	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:32:56.42459+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	4eafd382-987c-46be-9c31-5cc570cbe502	\N
533	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:32:56.42459+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	2e1cf223-ea4e-4657-b1cf-6ca5af957b88	\N
534	delete	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:33:42.61054+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	2e1cf223-ea4e-4657-b1cf-6ca5af957b88	\N
535	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.854236+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	5eff00c4-52ad-45c2-8115-6f1990b14c05	\N
536	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.854236+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	e8de4197-1b7a-4250-9c67-324bd41b4a2c	\N
537	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.854236+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	fbc5afe6-417b-4ca8-8fbc-dfbf9b4a326d	\N
538	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.854236+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	e88d880b-7add-4260-abda-0fb211623bb3	\N
539	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.854236+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	eabcb137-667b-40b1-b472-0344e31a6fd3	\N
540	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:58.353188+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	cffc85ac-f978-4fbd-9ec0-847af986a727	\N
541	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:58.353188+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	05a4d7e4-c266-450e-b270-84f0ff3cc16e	\N
542	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:58.353188+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	eabcb137-667b-40b1-b472-0344e31a6fd3	\N
543	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:36:39.681682+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
544	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:37:49.488577+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	140	\N
545	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:37:51.614544+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	141	\N
546	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:37:53.025257+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	142	\N
547	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:38:41.163601+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	143	\N
548	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:38:46.717902+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	144	\N
549	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:38:47.736729+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_permissions	145	\N
550	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:40:51.096797+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
551	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:58:25.007059+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	Series_seasons	\N
552	update	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:58:42.663434+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	Series_seasons	\N
553	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:59:22.491159+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
554	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:07:08.566954+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
555	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:11:00.852564+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	movies	06c2fe5b-f3bc-4b9a-9647-2e697e273177	\N
556	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:11:00.852564+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Seasons	363e7496-4bb9-47ba-9120-ff8f12363f5c	\N
557	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:11:00.852564+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	Series	0bd3ff80-5270-4839-867b-817b42cff869	\N
558	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:28.180918+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	testmodel	\N
559	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:28.180918+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	75	\N
560	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:28.180918+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	76	\N
561	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:28.180918+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	77	\N
562	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:28.180918+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	78	\N
563	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:28.180918+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	79	\N
564	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:28.180918+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	80	\N
565	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:28.180918+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	81	\N
566	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:36.274934+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	82	\N
567	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:46.617631+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	testmodel	b5d18660-7e16-4dff-8bfc-323415eb6f0c	\N
568	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:52.738052+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	testmodel	3cd66cbe-f843-48bd-bbe6-e6abe76b0a11	\N
569	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:59.975656+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
570	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:27:37.112411+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	83	\N
571	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:28:24.166145+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	84	\N
572	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:42.084149+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	test_movies	\N
573	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:42.084149+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	85	\N
574	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:42.084149+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	86	\N
575	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:42.084149+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	87	\N
576	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:42.084149+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	88	\N
577	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:42.084149+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	89	\N
578	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:42.084149+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	90	\N
579	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:42.084149+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	91	\N
580	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:29:55.836006+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	92	\N
581	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:31:12.261525+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	93	\N
582	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:31:43.438951+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	94	\N
583	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:32:27.975533+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	test_movies	11af55ed-8176-4919-86a8-ecf15a0b7eff	\N
584	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:32:32.39232+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
585	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 12:30:53.805134+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	Blog	\N
586	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 12:30:53.805134+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_fields	95	\N
587	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-08 09:18:39.605738+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
588	create	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-08 09:35:26.65038+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	directus_collections	Blog	\N
589	login	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-08 09:40:19.705937+00	::1	PostmanRuntime/7.26.8	directus_users	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse) FROM stdin;
movies_files	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open
movies	local_movies	List of movies	\N	f	f	\N	status	t	archived	draft	sort	all	#B1D06C	\N	\N	\N	open
movies_undefined	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open
migrations	\N	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open
migrations_lock	\N	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open
Series	\N	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	\N	\N	open
Seasons	\N	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	\N	\N	open
Series_seasons	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open
testmodel	\N	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	\N	\N	open
test_movies	\N	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	\N	\N	open
Blog	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group") FROM stdin;
19	movies	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	f	\N	half	\N	\N	\N	f	\N
18	movies	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	f	\N	half	\N	\N	\N	f	\N
15	movies	movie_id	uuid	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N
16	movies	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]}	f	f	\N	full	\N	\N	\N	f	\N
17	movies	sort	\N	input	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
20	movies	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
21	movies	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
23	movies	movie_images	files	files	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
24	movies_files	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
25	movies_files	movies_movie_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
26	movies_files	directus_files_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
22	movies	movie_name	\N	input	{"placeholder":"Movie Name","iconLeft":"movie"}	\N	\N	f	f	\N	full	\N	\N	\N	t	\N
28	movies_undefined	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
29	movies_undefined	movies_movie_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
30	movies_undefined	item	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
31	movies_undefined	collection	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
32	movies	movie_delivery_url	json	list	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
33	movies	movie_raw	file	file	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
34	Series	series_id	uuid	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N
35	Series	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]}	f	f	\N	full	\N	\N	\N	f	\N
36	Series	sort	\N	input	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
37	Series	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
38	Series	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
39	Series	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
40	Series	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
41	Series	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N
53	movies	episode_sequence_number	\N	input	\N	formatted-value	{"icon":true,"formatTitle":true,"bold":true}	f	f	\N	full	\N	\N	[{"name":"sequence number condition","rule":{"video_type":{"_neq":"series"}},"readonly":true,"hidden":true}]	f	\N
54	movies	season_sequence_number	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	[{"name":"season sequence condition","rule":{"video_type":{"_neq":"series"}},"readonly":true,"hidden":true}]	f	\N
74	Series	has_seasons	o2m	list-o2m	{"template":"{{title}}"}	related-values	{"template":"{{title}}{{episodes}}"}	f	f	\N	full	\N	\N	\N	f	\N
75	testmodel	id	uuid	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N
48	Series_seasons	id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
49	Series_seasons	Series_series_id	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
50	Series_seasons	item	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
51	Series_seasons	collection	\N	\N	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
59	Seasons	season_id	uuid	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N
60	Seasons	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]}	f	f	\N	full	\N	\N	\N	f	\N
56	movies	custom_upload	file	file-image	\N	image	\N	f	f	\N	full	\N	\N	\N	f	\N
43	movies	video_type	\N	select-dropdown	{"choices":[{"text":"Movie","value":"movie"},{"text":"Series","value":"series"}]}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
57	movies	featured_image	file	file-image	\N	image	\N	f	f	\N	full	\N	\N	\N	f	\N
61	Seasons	sort	\N	input	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
62	Seasons	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
63	Seasons	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
64	Seasons	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
65	Seasons	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
69	Seasons	episodes	o2m	list-o2m	{"template":"{{movie_name}}"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
70	Seasons	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
76	testmodel	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]}	f	f	\N	full	\N	\N	\N	f	\N
68	movies	belongs_to_season	m2o	select-dropdown-m2o	{"template":"{{episodes}}{{series.title}}{{series.title}}"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
72	Seasons	belongs_to_series	m2o	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
77	testmodel	sort	\N	input	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
78	testmodel	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
79	testmodel	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
80	testmodel	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
81	testmodel	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
82	testmodel	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
85	test_movies	id	uuid	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N
86	test_movies	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]}	f	f	\N	full	\N	\N	\N	f	\N
87	test_movies	sort	\N	input	\N	\N	\N	f	t	\N	full	\N	\N	\N	f	\N
88	test_movies	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
89	test_movies	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
90	test_movies	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	\N	half	\N	\N	\N	f	\N
91	test_movies	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N
92	test_movies	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
93	test_movies	models_testing	m2o	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N	f	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
0b144a82-e3ed-438a-8756-51a99497f692	local	0b144a82-e3ed-438a-8756-51a99497f692.png	nihinoe-min.png	Nihinoe Min	image/png	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:52:31.770507+00	\N	2021-12-15 06:52:31.853+00	\N	768140	3000	3000	\N	\N	\N	\N	\N	{"ihdr":{"ImageWidth":3000,"ImageHeight":3000,"BitDepth":8,"ColorType":"Palette","Compression":"Deflate/Inflate","Filter":"Adaptive","Interlace":"Noninterlaced"}}
c03f958e-872e-4b12-914a-4350b9074b28	local	c03f958e-872e-4b12-914a-4350b9074b28.jpg	adult-background-close-up-1079033_1280x720.jpg	Adult Background Close up 1079033 1280x720	image/jpeg	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:52:31.768097+00	\N	2021-12-15 06:52:31.875+00	\N	90276	1280	720	\N	\N	\N	\N	\N	\N
d80cc677-8481-4923-825c-fecf5b342ceb	local	d80cc677-8481-4923-825c-fecf5b342ceb.jpg	adult-background-close-up-1079033_1280x720.jpg	Adult Background Close up 1079033 1280x720	image/jpeg	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:52:54.644666+00	\N	2021-12-15 06:52:54.696+00	\N	90276	1280	720	\N	\N	\N	\N	\N	\N
3faabca9-0406-4ef6-be23-c1ca857ebdfe	local	3faabca9-0406-4ef6-be23-c1ca857ebdfe.jpg	bg1.jpg	Bg1	image/jpeg	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-15 06:52:54.646636+00	\N	2021-12-15 06:52:54.714+00	\N	69937	1024	683	\N	\N	\N	\N	\N	\N
2dc325d0-7998-43bd-884f-f98d8e293ecf	local	2dc325d0-7998-43bd-884f-f98d8e293ecf.png	dubai.png	Dubai	image/png	\N	14812d91-421e-438c-a5f5-58bcd87bf218	2021-12-16 10:54:19.768932+00	\N	2021-12-16 10:54:19.834+00	\N	274327	400	400	\N	\N	\N	\N	\N	{"ihdr":{"ImageWidth":400,"ImageHeight":400,"BitDepth":8,"ColorType":"RGB with Alpha","Compression":"Deflate/Inflate","Filter":"Adaptive","Interlace":"Noninterlaced","Software":"Adobe ImageReady"}}
e9147cba-4198-4ac5-a149-94ce6b9b206d	local	e9147cba-4198-4ac5-a149-94ce6b9b206d.svg	noun_Hand_22419.svg	Noun Hand 22419	image/svg+xml	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-16 11:28:49.006027+00	\N	2021-12-16 11:28:49.05+00	\N	2314	\N	\N	\N	\N	\N	\N	\N	\N
30183811-6618-4f0c-90b3-337ca1e5bd48	amazon	\N	sample-video.mp4	Sample Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 08:02:43.8429+00	\N	2021-12-22 08:02:43.8429+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9dd7400f-6808-48e9-b678-9071769ad251	amazon	\N	sample-video.mp4	Sample Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 08:04:52.380478+00	\N	2021-12-22 08:04:52.380478+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
ef36ba3f-6640-4afa-9be9-3076158cc088	amazon	ef36ba3f-6640-4afa-9be9-3076158cc088.mp4	sample-video.mp4	Sample Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 08:08:59.019829+00	\N	2021-12-22 08:09:51.997+00	\N	171661603	\N	\N	\N	\N	\N	\N	\N	\N
d7bc9733-2ca6-42c8-aaeb-aa07d0fa9114	amazon	d7bc9733-2ca6-42c8-aaeb-aa07d0fa9114.mp4	sample-video.mp4	Sample Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-22 10:28:58.124919+00	\N	2021-12-22 10:29:36.923+00	\N	171661603	\N	\N	\N	\N	\N	\N	\N	\N
37827f87-7636-41da-9fd6-4681e3ab1e6c	amazon	37827f87-7636-41da-9fd6-4681e3ab1e6c.mp4	sample-video.mp4	Sample Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:41:05.243111+00	\N	2021-12-23 08:41:49.61+00	\N	171661603	\N	\N	\N	\N	\N	\N	\N	\N
6e9ac6ff-a7c1-456f-bd8c-a824073bd244	amazon	6e9ac6ff-a7c1-456f-bd8c-a824073bd244.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:54:45.442413+00	\N	2021-12-23 08:54:53.534+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
2bb7896d-ffe5-41ce-9fb5-7a09d563085f	amazon	2bb7896d-ffe5-41ce-9fb5-7a09d563085f.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:55:36.822897+00	\N	2021-12-23 08:55:44.098+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b	amazon	fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:56:27.436887+00	\N	2021-12-23 08:56:33.84+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
bfcbe12e-b226-42f3-8c9d-bc29eb2638c3	amazon	bfcbe12e-b226-42f3-8c9d-bc29eb2638c3.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:14:25.111977+00	\N	2021-12-24 07:14:32.95+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
83708ad1-7763-4ac9-8d17-6ffb4a3de293	amazon	83708ad1-7763-4ac9-8d17-6ffb4a3de293.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:26:26.493393+00	\N	2021-12-24 07:26:33.56+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
41b17364-9a34-48f0-afcc-e78bd8d43cfb	amazon	41b17364-9a34-48f0-afcc-e78bd8d43cfb.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 08:47:04.566259+00	\N	2021-12-24 08:47:11.468+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
ee64a57e-c550-46e4-bace-74860f357ef3	amazon	ee64a57e-c550-46e4-bace-74860f357ef3.svg	noun_Hand_22419.svg	Noun Hand 22419	image/svg+xml	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:15:00.334697+00	\N	2021-12-25 11:15:02.155+00	\N	2314	\N	\N	\N	\N	\N	\N	\N	\N
ec3c78b3-6f11-4116-b01f-c3e59fabc8d3	amazon	\N	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:52:36.653071+00	\N	2021-12-25 11:52:36.653071+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
48e4683f-2c0e-4e07-87f1-1e4b02ab2eae	amazon2	48e4683f-2c0e-4e07-87f1-1e4b02ab2eae.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 11:53:15.168437+00	\N	2021-12-25 11:53:32.188+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
34f3088c-f1db-4ad4-bb0b-440ee962e3a9	amazon2	34f3088c-f1db-4ad4-bb0b-440ee962e3a9.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:01:28.172377+00	\N	2021-12-25 12:01:41.44+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
1c2b532c-f15a-4868-a335-96b4ece15a41	amazon	1c2b532c-f15a-4868-a335-96b4ece15a41.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:25:09.429644+00	\N	2021-12-25 12:25:17.433+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
6932a039-7c61-4d56-abc9-d54b3bf3c4f8	amazon	6932a039-7c61-4d56-abc9-d54b3bf3c4f8.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 06:25:55.465231+00	\N	2021-12-27 06:26:07.104+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
6214ebfd-f53d-4310-b9f3-a5a2e208dbf0	amazon	6214ebfd-f53d-4310-b9f3-a5a2e208dbf0.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-28 07:15:25.503378+00	\N	2021-12-28 07:15:34.569+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
4a9464b4-49b8-4895-a47c-73b249186b15	amazon	4a9464b4-49b8-4895-a47c-73b249186b15.mp4	video.mp4	Video	video/mp4	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:02:49.879096+00	\N	2022-01-05 10:02:56.099+00	\N	24077062	\N	\N	\N	\N	\N	\N	\N	\N
62d44ac9-4a92-4e21-a655-4a7e296fc933	amazon	62d44ac9-4a92-4e21-a655-4a7e296fc933.jpg	bg1.jpg	Bg1	image/jpeg	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 10:10:11.74129+00	\N	2022-01-05 10:10:13.078+00	\N	69937	1024	683	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2021-12-14 10:08:08.33679+00
20201029A	Remove System Relations	2021-12-14 10:08:08.362012+00
20201029B	Remove System Collections	2021-12-14 10:08:08.414464+00
20201029C	Remove System Fields	2021-12-14 10:08:08.455299+00
20201105A	Add Cascade System Relations	2021-12-14 10:08:08.83476+00
20201105B	Change Webhook URL Type	2021-12-14 10:08:08.905005+00
20210225A	Add Relations Sort Field	2021-12-14 10:08:08.928886+00
20210304A	Remove Locked Fields	2021-12-14 10:08:08.946564+00
20210312A	Webhooks Collections Text	2021-12-14 10:08:08.987271+00
20210331A	Add Refresh Interval	2021-12-14 10:08:09.007664+00
20210415A	Make Filesize Nullable	2021-12-14 10:08:09.058507+00
20210416A	Add Collections Accountability	2021-12-14 10:08:09.176004+00
20210422A	Remove Files Interface	2021-12-14 10:08:09.184964+00
20210506A	Rename Interfaces	2021-12-14 10:08:09.2391+00
20210510A	Restructure Relations	2021-12-14 10:08:09.547461+00
20210518A	Add Foreign Key Constraints	2021-12-14 10:08:09.628477+00
20210519A	Add System Fk Triggers	2021-12-14 10:08:09.842852+00
20210521A	Add Collections Icon Color	2021-12-14 10:08:09.86316+00
20210525A	Add Insights	2021-12-14 10:08:10.15994+00
20210608A	Add Deep Clone Config	2021-12-14 10:08:10.180295+00
20210626A	Change Filesize Bigint	2021-12-14 10:08:10.312855+00
20210716A	Add Conditions to Fields	2021-12-14 10:08:10.333062+00
20210721A	Add Default Folder	2021-12-14 10:08:10.363695+00
20210802A	Replace Groups	2021-12-14 10:08:10.380138+00
20210803A	Add Required to Fields	2021-12-14 10:08:10.486764+00
20210805A	Update Groups	2021-12-14 10:08:10.5001+00
20210805B	Change Image Metadata Structure	2021-12-14 10:08:10.510208+00
20210811A	Add Geometry Config	2021-12-14 10:08:10.526635+00
20210831A	Remove Limit Column	2021-12-14 10:08:10.546916+00
20210903A	Add Auth Provider	2021-12-14 10:08:10.801624+00
20210907A	Webhooks Collections Not Null	2021-12-14 10:08:10.852463+00
20210910A	Move Module Setup	2021-12-14 10:08:10.882923+00
20210920A	Webhooks URL Not Null	2021-12-14 10:08:10.933858+00
20210924A	Add Collection Organization	2021-12-14 10:08:11.044968+00
20210927A	Replace Fields Group	2021-12-14 10:08:11.086613+00
20210927B	Replace M2M Interface	2021-12-14 10:08:11.100376+00
20210929A	Rename Login Action	2021-12-14 10:08:11.110308+00
20211007A	Update Presets	2021-12-14 10:08:11.137475+00
20211009A	Add Auth Data	2021-12-14 10:08:11.157828+00
20211016A	Add Webhook Headers	2021-12-14 10:08:11.178179+00
20211103A	Set Unique to User Token	2021-12-14 10:08:11.249497+00
20211103B	Update Special Geometry	2021-12-14 10:08:11.273393+00
20211104A	Remove Collections Listing	2021-12-14 10:08:11.300332+00
20211118A	Add Notifications	2021-12-14 10:08:11.670736+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields) FROM stdin;
1	\N	movies	read	{}	{}	\N	*
64	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_files	create	{}	\N	\N	*
3	\N	movies_files	read	{}	{}	\N	*
65	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_files	read	{}	\N	\N	*
66	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_files	update	{}	\N	\N	*
67	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_files	delete	{}	\N	\N	*
68	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_dashboards	create	{}	\N	\N	*
69	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_dashboards	read	{}	\N	\N	*
70	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_dashboards	update	{}	\N	\N	*
71	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_dashboards	delete	{}	\N	\N	*
72	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_panels	create	{}	\N	\N	*
73	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_panels	read	{}	\N	\N	*
74	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_panels	update	{}	\N	\N	*
75	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_panels	delete	{}	\N	\N	*
76	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_folders	create	{}	\N	\N	*
77	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_folders	read	{}	\N	\N	*
78	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_folders	update	{}	\N	\N	*
79	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_folders	delete	{}	\N	\N	\N
81	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_users	update	{"id":{"_eq":"$CURRENT_USER"}}	\N	\N	first_name,last_name,email,password,location,title,description,avatar,language,theme
82	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_roles	read	{}	\N	\N	*
83	537e43d3-2620-4e81-9aa0-ccfe797a87e8	movies	read	{}	{}	\N	*
84	537e43d3-2620-4e81-9aa0-ccfe797a87e8	movies_files	read	{}	{}	\N	*
85	537e43d3-2620-4e81-9aa0-ccfe797a87e8	movies	update	{}	{}	\N	*
86	537e43d3-2620-4e81-9aa0-ccfe797a87e8	movies_files	update	{}	{}	\N	*
87	537e43d3-2620-4e81-9aa0-ccfe797a87e8	movies	create	{}	{}	\N	*
88	537e43d3-2620-4e81-9aa0-ccfe797a87e8	movies_files	create	{}	{}	\N	*
89	537e43d3-2620-4e81-9aa0-ccfe797a87e8	movies	delete	{}	{}	\N	*
90	537e43d3-2620-4e81-9aa0-ccfe797a87e8	movies_files	delete	{}	{}	\N	*
140	\N	Seasons	read	{}	{}	\N	*
141	\N	Series	read	{}	{}	\N	*
112	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_files	create	{}	\N	\N	*
113	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_files	read	{}	\N	\N	*
114	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_files	update	{}	\N	\N	*
115	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_files	delete	{}	\N	\N	*
124	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_folders	create	{}	\N	\N	*
125	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_folders	read	{}	\N	\N	*
126	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_folders	update	{}	\N	\N	*
127	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_folders	delete	{}	\N	\N	\N
128	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_users	read	{}	\N	\N	\N
129	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_users	update	{"id":{"_eq":"$CURRENT_USER"}}	\N	\N	first_name,last_name,email,password,location,title,description,avatar,language,theme
130	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	directus_roles	read	{}	\N	\N	*
131	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	movies	read	{}	{}	\N	*
132	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	movies_files	read	{}	{}	\N	*
142	\N	Series_seasons	read	{}	{}	\N	*
133	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_users	read	{"role":{"name":{"_eq":"Subscriber"}}}	\N	\N	\N
134	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_webhooks	create	{}	{}	\N	*
135	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_webhooks	read	{}	{}	\N	*
136	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_webhooks	update	{}	{}	\N	*
137	537e43d3-2620-4e81-9aa0-ccfe797a87e8	directus_webhooks	delete	{}	{}	\N	*
139	\N	directus_notifications	create	{}	{}	\N	*
143	537e43d3-2620-4e81-9aa0-ccfe797a87e8	Seasons	read	{}	{}	\N	*
144	537e43d3-2620-4e81-9aa0-ccfe797a87e8	Series	read	{}	{}	\N	*
145	537e43d3-2620-4e81-9aa0-ccfe797a87e8	Series_seasons	read	{}	{}	\N	*
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter) FROM stdin;
6	\N	14812d91-421e-438c-a5f5-58bcd87bf218	\N	directus_users	\N	cards	{"cards":{"sort":["role"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":3}}	\N	\N
43	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	Series_seasons	\N	\N	{"tabular":{"page":1}}	\N	\N	\N
42	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	Seasons	\N	\N	{"tabular":{"fields":["title","series","status"],"page":1}}	\N	\N	\N
3	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	movies	\N	tabular	{"tabular":{"fields":["movie_name","status","movie_id","date_created","belongs_to_series","featured_image","sort"],"page":1,"sort":["-date_created"]}}	{"tabular":{"spacing":"comfortable","widths":{"belongs_to_series":181}},"calendar":{"viewInfo":{"type":"dayGridMonth","startDateStr":"2021-12-01T00:00:00+05:30"}}}	\N	\N
1	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N
44	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	testmodel	\N	\N	{"tabular":{"page":1}}	\N	\N	\N
45	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	test_movies	\N	\N	{"tabular":{"page":1}}	\N	\N	\N
41	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	directus_activity	\N	tabular	{"tabular":{"sort":["-timestamp"],"fields":["action","collection","timestamp","user"],"page":1}}	{"tabular":{"widths":{"action":100,"collection":210,"timestamp":240,"user":240}}}	\N	\N
40	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	Series	\N	\N	{"tabular":{"page":1,"fields":["title","series_id","date_created","status"]}}	\N	\N	\N
7	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}	\N	\N
5	\N	14812d91-421e-438c-a5f5-58bcd87bf218	\N	movies	\N	\N	{"tabular":{"fields":["movie_name","status","user_created","date_updated"]}}	\N	\N	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	movies	user_created	directus_users	\N	\N	\N	\N	\N	nullify
2	movies	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
3	movies_files	directus_files_id	directus_files	\N	\N	\N	movies_movie_id	\N	nullify
4	movies_files	movies_movie_id	movies	movie_images	\N	\N	directus_files_id	\N	nullify
5	movies	movie_raw	directus_files	\N	\N	\N	\N	\N	nullify
6	Series	user_created	directus_users	\N	\N	\N	\N	\N	nullify
7	Series	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
9	Series_seasons	item	\N	\N	collection	movies	Series_series_id	\N	nullify
11	movies	custom_upload	directus_files	\N	\N	\N	\N	\N	nullify
12	movies	featured_image	directus_files	\N	\N	\N	\N	\N	nullify
13	Seasons	user_created	directus_users	\N	\N	\N	\N	\N	nullify
14	Seasons	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
10	Series_seasons	Series_series_id	Series	\N	\N	\N	item	item	nullify
17	Seasons	belongs_to_series	Series	has_seasons	\N	\N	\N	\N	delete
16	movies	belongs_to_season	Seasons	episodes	\N	\N	\N	\N	delete
18	testmodel	user_created	directus_users	\N	\N	\N	\N	\N	nullify
19	testmodel	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
20	test_movies	user_created	directus_users	\N	\N	\N	\N	\N	nullify
21	test_movies	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
22	test_movies	models_testing	testmodel	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent) FROM stdin;
2	9	directus_collections	projects	{"collection":"projects"}	{"collection":"projects"}	\N
3	10	directus_fields	1	{"collection":"projects","field":"id"}	{"collection":"projects","field":"id"}	\N
4	11	directus_fields	1	{"id":1,"collection":"projects","field":"id","special":["uuid"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"projects","field":"id","special":["uuid"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
5	12	directus_fields	2	{"collection":"projects","field":"created_at"}	{"collection":"projects","field":"created_at"}	\N
6	13	directus_fields	2	{"id":2,"collection":"projects","field":"created_at","special":["date-created"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"projects","field":"created_at","special":["date-created"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
7	14	directus_fields	3	{"collection":"projects","field":"updated_at"}	{"collection":"projects","field":"updated_at"}	\N
8	15	directus_fields	3	{"id":3,"collection":"projects","field":"updated_at","special":["date-created","date-updated"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"projects","field":"updated_at","special":["date-created","date-updated"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
9	16	directus_fields	4	{"collection":"projects","field":"name"}	{"collection":"projects","field":"name"}	\N
10	17	directus_fields	5	{"collection":"projects","field":"description"}	{"collection":"projects","field":"description"}	\N
11	18	directus_fields	6	{"collection":"projects","field":"address"}	{"collection":"projects","field":"address"}	\N
12	19	directus_fields	7	{"collection":"projects","field":"email"}	{"collection":"projects","field":"email"}	\N
13	20	directus_fields	8	{"collection":"projects","field":"phone"}	{"collection":"projects","field":"phone"}	\N
14	21	directus_fields	9	{"collection":"projects","field":"image_url"}	{"collection":"projects","field":"image_url"}	\N
15	22	directus_fields	10	{"collection":"projects","field":"items"}	{"collection":"projects","field":"items"}	\N
16	23	directus_fields	11	{"collection":"projects","field":"insurance_adjuster"}	{"collection":"projects","field":"insurance_adjuster"}	\N
17	24	directus_fields	12	{"collection":"projects","field":"insurance_company"}	{"collection":"projects","field":"insurance_company"}	\N
18	25	directus_fields	13	{"collection":"projects","field":"additional_details"}	{"collection":"projects","field":"additional_details"}	\N
19	26	directus_fields	14	{"collection":"projects","field":"project_tag"}	{"collection":"projects","field":"project_tag"}	\N
22	30	directus_collections	movies	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"movies"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"movies"}	\N
23	31	directus_fields	15	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"movie_id","collection":"movies"}	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"movie_id","collection":"movies"}	\N
24	32	directus_fields	16	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"movies"}	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"movies"}	\N
25	33	directus_fields	17	{"interface":"input","hidden":true,"field":"sort","collection":"movies"}	{"interface":"input","hidden":true,"field":"sort","collection":"movies"}	\N
39	47	directus_files	0b144a82-e3ed-438a-8756-51a99497f692	{"title":"Nihinoe Min","filename_download":"nihinoe-min.png","type":"image/png","storage":"local"}	{"title":"Nihinoe Min","filename_download":"nihinoe-min.png","type":"image/png","storage":"local"}	\N
205	306	directus_collections	projects	{"collection":"projects"}	{"collection":"projects"}	\N
26	34	directus_fields	18	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"movies"}	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"movies"}	\N
27	35	directus_fields	19	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"movies"}	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"movies"}	\N
28	36	directus_fields	20	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"movies"}	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"movies"}	\N
29	37	directus_fields	21	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"movies"}	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"movies"}	\N
30	38	directus_fields	22	{"interface":"input","special":null,"options":{"placeholder":"Movie Name","iconLeft":"movie"},"collection":"movies","field":"movie_name"}	{"interface":"input","special":null,"options":{"placeholder":"Movie Name","iconLeft":"movie"},"collection":"movies","field":"movie_name"}	\N
31	39	directus_fields	23	{"interface":"files","special":"files","collection":"movies","field":"movie_images"}	{"interface":"files","special":"files","collection":"movies","field":"movie_images"}	\N
32	40	directus_collections	movies_files	{"hidden":true,"icon":"import_export","collection":"movies_files"}	{"hidden":true,"icon":"import_export","collection":"movies_files"}	\N
33	41	directus_fields	24	{"hidden":true,"field":"id","collection":"movies_files"}	{"hidden":true,"field":"id","collection":"movies_files"}	\N
34	42	directus_fields	25	{"hidden":true,"collection":"movies_files","field":"movies_movie_id"}	{"hidden":true,"collection":"movies_files","field":"movies_movie_id"}	\N
35	43	directus_fields	26	{"hidden":true,"collection":"movies_files","field":"directus_files_id"}	{"hidden":true,"collection":"movies_files","field":"directus_files_id"}	\N
36	44	directus_fields	22	{"id":22,"collection":"movies","field":"movie_name","special":null,"interface":"input","options":{"placeholder":"Movie Name","iconLeft":"movie"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null}	{"collection":"movies","field":"movie_name","special":null,"interface":"input","options":{"placeholder":"Movie Name","iconLeft":"movie"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null}	\N
37	45	directus_collections	movies	{"collection":"movies","icon":"local_movies","note":"List of movies","display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":"status","archive_app_filter":true,"archive_value":"archived","unarchive_value":"draft","sort_field":"sort","accountability":"all","color":"#B1D06C","item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"icon":"local_movies","note":"List of movies","color":"#B1D06C"}	\N
38	46	directus_files	c03f958e-872e-4b12-914a-4350b9074b28	{"title":"Adult Background Close up 1079033 1280x720","filename_download":"adult-background-close-up-1079033_1280x720.jpg","type":"image/jpeg","storage":"local"}	{"title":"Adult Background Close up 1079033 1280x720","filename_download":"adult-background-close-up-1079033_1280x720.jpg","type":"image/jpeg","storage":"local"}	\N
41	49	directus_files	3faabca9-0406-4ef6-be23-c1ca857ebdfe	{"title":"Bg1","filename_download":"bg1.jpg","type":"image/jpeg","storage":"local"}	{"title":"Bg1","filename_download":"bg1.jpg","type":"image/jpeg","storage":"local"}	\N
40	48	directus_files	d80cc677-8481-4923-825c-fecf5b342ceb	{"title":"Adult Background Close up 1079033 1280x720","filename_download":"adult-background-close-up-1079033_1280x720.jpg","type":"image/jpeg","storage":"local"}	{"title":"Adult Background Close up 1079033 1280x720","filename_download":"adult-background-close-up-1079033_1280x720.jpg","type":"image/jpeg","storage":"local"}	\N
44	52	movies	3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e	{"status":"published","movie_name":"New Bond Movie","movie_images":[{"directus_files_id":"d80cc677-8481-4923-825c-fecf5b342ceb"},{"directus_files_id":"3faabca9-0406-4ef6-be23-c1ca857ebdfe"}]}	{"status":"published","movie_name":"New Bond Movie","movie_images":[{"directus_files_id":"d80cc677-8481-4923-825c-fecf5b342ceb"},{"directus_files_id":"3faabca9-0406-4ef6-be23-c1ca857ebdfe"}]}	\N
42	50	movies_files	1	{"directus_files_id":"d80cc677-8481-4923-825c-fecf5b342ceb","movies_movie_id":"3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e"}	{"directus_files_id":"d80cc677-8481-4923-825c-fecf5b342ceb","movies_movie_id":"3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e"}	44
43	51	movies_files	2	{"directus_files_id":"3faabca9-0406-4ef6-be23-c1ca857ebdfe","movies_movie_id":"3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e"}	{"directus_files_id":"3faabca9-0406-4ef6-be23-c1ca857ebdfe","movies_movie_id":"3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e"}	44
45	53	movies	916779e3-b8e4-4895-90b8-81e11df23ee6	{"movie_name":"Fighter"}	{"movie_name":"Fighter"}	\N
46	54	movies	916779e3-b8e4-4895-90b8-81e11df23ee6	{"movie_id":"916779e3-b8e4-4895-90b8-81e11df23ee6","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-15T07:09:35.950Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-15T07:11:31.514Z","movie_name":"Fighter","movie_images":[]}	{"status":"published","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-15T07:11:31.514Z"}	\N
47	55	directus_permissions	1	{"role":null,"collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
48	56	directus_permissions	2	{"role":null,"collection":"movies_files","action":"read"}	{"role":null,"collection":"movies_files","action":"read"}	\N
49	58	directus_permissions	3	{"role":null,"collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
50	60	directus_roles	cca744c1-a78b-44e1-a83f-4a62fc954734	{"name":"Subscriber","admin_access":false,"app_access":true}	{"name":"Subscriber","admin_access":false,"app_access":true}	\N
51	61	directus_permissions	4	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
52	62	directus_permissions	5	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
53	63	directus_permissions	6	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
54	64	directus_permissions	7	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
55	65	directus_permissions	8	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
56	66	directus_permissions	9	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
57	67	directus_permissions	10	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
58	68	directus_permissions	11	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
59	69	directus_permissions	12	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
60	70	directus_permissions	13	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
61	71	directus_permissions	14	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
62	72	directus_permissions	15	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
63	73	directus_permissions	16	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
64	74	directus_permissions	17	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
65	75	directus_permissions	18	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
66	76	directus_permissions	19	{"collection":"directus_folders","action":"delete","permissions":{},"role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_folders","action":"delete","permissions":{},"role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
67	77	directus_permissions	20	{"collection":"directus_users","action":"read","permissions":{},"role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_users","action":"read","permissions":{},"role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
68	78	directus_permissions	21	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
69	79	directus_permissions	22	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
70	80	directus_permissions	23	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734","collection":"movies","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734","collection":"movies","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
71	82	directus_permissions	24	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734","collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734","collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
72	83	directus_permissions	25	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734","collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734","collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
74	85	directus_roles	cca744c1-a78b-44e1-a83f-4a62fc954734	{"id":"cca744c1-a78b-44e1-a83f-4a62fc954734","name":"Subscriber","icon":"supervised_user_circle","description":"OTT subscriber","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":true,"users":["a224d75d-5da8-4450-9e66-f9ef53a16e45"]}	{"description":"OTT subscriber"}	\N
73	84	directus_users	a224d75d-5da8-4450-9e66-f9ef53a16e45	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	74
75	87	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	{"email":"admin2@flixbox.com","password":"**********"}	{"email":"admin2@flixbox.com","password":"**********"}	\N
76	88	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	{"id":"49eab1e1-ec46-41da-a5e7-92ad20d5e045","first_name":null,"last_name":null,"email":"admin2@flixbox.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":"en-US","theme":"auto","tfa_secret":null,"status":"active","role":"cca744c1-a78b-44e1-a83f-4a62fc954734","token":null,"last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true}	{"role":"cca744c1-a78b-44e1-a83f-4a62fc954734"}	\N
78	91	directus_roles	cca744c1-a78b-44e1-a83f-4a62fc954734	{"id":"cca744c1-a78b-44e1-a83f-4a62fc954734","name":"Subscriber","icon":"supervised_user_circle","description":"OTT subscriber","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":true,"users":["49eab1e1-ec46-41da-a5e7-92ad20d5e045"]}	{}	\N
77	90	directus_users	a224d75d-5da8-4450-9e66-f9ef53a16e45	{"id":"a224d75d-5da8-4450-9e66-f9ef53a16e45","first_name":null,"last_name":null,"email":null,"password":null,"location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":"en-US","theme":"auto","tfa_secret":null,"status":"active","role":null,"token":null,"last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true}	{"role":null}	78
79	92	directus_roles	40d68c4a-50d1-4129-b669-7ddade995171	{"name":"tester","admin_access":false,"app_access":true}	{"name":"tester","admin_access":false,"app_access":true}	\N
80	93	directus_permissions	26	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
81	94	directus_permissions	27	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
82	95	directus_permissions	28	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
83	96	directus_permissions	29	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
84	97	directus_permissions	30	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
85	98	directus_permissions	31	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
86	99	directus_permissions	32	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
87	100	directus_permissions	33	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
88	101	directus_permissions	34	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
89	102	directus_permissions	35	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
90	103	directus_permissions	36	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
91	104	directus_permissions	37	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
92	105	directus_permissions	38	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
93	106	directus_permissions	39	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
94	107	directus_permissions	40	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
95	108	directus_permissions	41	{"collection":"directus_folders","action":"delete","permissions":{},"role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_folders","action":"delete","permissions":{},"role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
96	109	directus_permissions	42	{"collection":"directus_users","action":"read","permissions":{},"role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_users","action":"read","permissions":{},"role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
97	110	directus_permissions	43	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
98	111	directus_permissions	44	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"40d68c4a-50d1-4129-b669-7ddade995171"}	\N
99	153	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	{"id":"49eab1e1-ec46-41da-a5e7-92ad20d5e045","first_name":null,"last_name":null,"email":"admin2@flixbox.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":"en-US","theme":"auto","tfa_secret":null,"status":"suspended","role":null,"token":null,"last_access":"2021-12-15T08:41:15.507Z","last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true}	{"status":"suspended","role":null}	\N
100	155	directus_roles	dc6978e7-d62a-4b2a-82a3-990d72087461	{"name":"Subscriber","admin_access":false,"app_access":true}	{"name":"Subscriber","admin_access":false,"app_access":true}	\N
101	156	directus_permissions	45	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
102	157	directus_permissions	46	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
103	158	directus_permissions	47	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
104	159	directus_permissions	48	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
105	160	directus_permissions	49	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
106	161	directus_permissions	50	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
107	162	directus_permissions	51	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
108	163	directus_permissions	52	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
109	164	directus_permissions	53	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
110	165	directus_permissions	54	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
111	166	directus_permissions	55	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
112	167	directus_permissions	56	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
113	168	directus_permissions	57	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
114	169	directus_permissions	58	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
115	170	directus_permissions	59	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
116	171	directus_permissions	60	{"collection":"directus_folders","action":"delete","permissions":{},"role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_folders","action":"delete","permissions":{},"role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
117	172	directus_permissions	61	{"collection":"directus_users","action":"read","permissions":{},"role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_users","action":"read","permissions":{},"role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
118	173	directus_permissions	62	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
119	174	directus_permissions	63	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"dc6978e7-d62a-4b2a-82a3-990d72087461"}	\N
120	195	directus_roles	537e43d3-2620-4e81-9aa0-ccfe797a87e8	{"name":"Publisher","admin_access":false,"app_access":true}	{"name":"Publisher","admin_access":false,"app_access":true}	\N
121	196	directus_permissions	64	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
122	197	directus_permissions	65	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
123	198	directus_permissions	66	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
124	199	directus_permissions	67	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
125	200	directus_permissions	68	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
126	201	directus_permissions	69	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
127	202	directus_permissions	70	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
128	203	directus_permissions	71	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
129	204	directus_permissions	72	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
130	205	directus_permissions	73	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
131	206	directus_permissions	74	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
132	207	directus_permissions	75	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
133	208	directus_permissions	76	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
134	209	directus_permissions	77	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
135	210	directus_permissions	78	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
136	211	directus_permissions	79	{"collection":"directus_folders","action":"delete","permissions":{},"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_folders","action":"delete","permissions":{},"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
137	212	directus_permissions	80	{"collection":"directus_users","action":"read","permissions":{},"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_users","action":"read","permissions":{},"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
138	213	directus_permissions	81	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
139	214	directus_permissions	82	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
140	215	directus_users	14812d91-421e-438c-a5f5-58bcd87bf218	{"first_name":"Publisher","last_name":"Test","email":"publisher1@skara.live","password":"**********","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	{"first_name":"Publisher","last_name":"Test","email":"publisher1@skara.live","password":"**********","role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8"}	\N
141	218	directus_permissions	83	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
142	219	directus_permissions	84	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
143	220	directus_permissions	85	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies","action":"update","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies","action":"update","fields":["*"],"permissions":{},"validation":{}}	\N
144	221	directus_permissions	86	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies_files","action":"update","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies_files","action":"update","fields":["*"],"permissions":{},"validation":{}}	\N
145	222	movies	3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e	{"movie_id":"3ce326cf-edaf-4fba-a9e1-3cb0c3409a5e","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-15T06:53:00.230Z","user_updated":"14812d91-421e-438c-a5f5-58bcd87bf218","date_updated":"2021-12-16T10:53:33.047Z","movie_name":"New Bond","movie_images":[1,2]}	{"movie_name":"New Bond","user_updated":"14812d91-421e-438c-a5f5-58bcd87bf218","date_updated":"2021-12-16T10:53:33.047Z"}	\N
146	223	directus_permissions	87	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
147	224	directus_permissions	88	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies_files","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies_files","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
148	225	directus_permissions	89	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies","action":"delete","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies","action":"delete","fields":["*"],"permissions":{},"validation":{}}	\N
149	226	directus_permissions	90	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies_files","action":"delete","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"movies_files","action":"delete","fields":["*"],"permissions":{},"validation":{}}	\N
150	227	directus_files	2dc325d0-7998-43bd-884f-f98d8e293ecf	{"title":"Dubai","filename_download":"dubai.png","type":"image/png","storage":"local"}	{"title":"Dubai","filename_download":"dubai.png","type":"image/png","storage":"local"}	\N
152	229	movies	424d878d-7c64-4dfb-b5fc-b472f22d9a74	{"movie_name":"Publisher created 1","movie_images":[{"directus_files_id":"2dc325d0-7998-43bd-884f-f98d8e293ecf"}]}	{"movie_name":"Publisher created 1","movie_images":[{"directus_files_id":"2dc325d0-7998-43bd-884f-f98d8e293ecf"}]}	\N
151	228	movies_files	3	{"directus_files_id":"2dc325d0-7998-43bd-884f-f98d8e293ecf","movies_movie_id":"424d878d-7c64-4dfb-b5fc-b472f22d9a74"}	{"directus_files_id":"2dc325d0-7998-43bd-884f-f98d8e293ecf","movies_movie_id":"424d878d-7c64-4dfb-b5fc-b472f22d9a74"}	152
153	231	directus_roles	39e1d541-89d9-4e3e-99d4-d34516cdedf1	{"name":"Subscriber","admin_access":false,"app_access":true}	{"name":"Subscriber","admin_access":false,"app_access":true}	\N
154	232	directus_permissions	91	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
155	233	directus_permissions	92	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
156	234	directus_permissions	93	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
157	235	directus_permissions	94	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
158	236	directus_permissions	95	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
159	237	directus_permissions	96	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
160	238	directus_permissions	97	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
161	239	directus_permissions	98	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
162	240	directus_permissions	99	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
163	241	directus_permissions	100	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
164	242	directus_permissions	101	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
165	243	directus_permissions	102	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
166	244	directus_permissions	103	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
167	245	directus_permissions	104	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
168	246	directus_permissions	105	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
169	247	directus_permissions	106	{"collection":"directus_folders","action":"delete","permissions":{},"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_folders","action":"delete","permissions":{},"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
170	248	directus_permissions	107	{"collection":"directus_users","action":"read","permissions":{},"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_users","action":"read","permissions":{},"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
171	249	directus_permissions	108	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
172	250	directus_permissions	109	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1"}	\N
173	251	directus_permissions	110	{"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1","collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1","collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
174	252	directus_permissions	111	{"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1","collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1","collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
175	253	directus_permissions	107	{"id":107,"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1","collection":"directus_users","action":"read","permissions":{},"validation":{},"presets":null,"fields":["*"]}	{"permissions":{},"validation":{},"fields":["*"]}	\N
176	254	directus_permissions	107	{"id":107,"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1","collection":"directus_users","action":"read","permissions":{},"validation":{},"presets":null,"fields":["*"]}	{"role":"39e1d541-89d9-4e3e-99d4-d34516cdedf1","collection":"directus_users","action":"read","permissions":{},"validation":{},"presets":null,"fields":["*"]}	\N
177	277	directus_roles	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	{"name":"Subscriber","admin_access":false,"app_access":true}	{"name":"Subscriber","admin_access":false,"app_access":true}	\N
178	278	directus_permissions	112	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_files","action":"create","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
179	279	directus_permissions	113	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_files","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
180	280	directus_permissions	114	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_files","action":"update","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
181	281	directus_permissions	115	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_files","action":"delete","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
182	282	directus_permissions	116	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
338	475	directus_files	62d44ac9-4a92-4e21-a655-4a7e296fc933	{"title":"Bg1","filename_download":"bg1.jpg","type":"image/jpeg","storage":"amazon"}	{"title":"Bg1","filename_download":"bg1.jpg","type":"image/jpeg","storage":"amazon"}	\N
183	283	directus_permissions	117	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
184	284	directus_permissions	118	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
185	285	directus_permissions	119	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
186	286	directus_permissions	120	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_panels","action":"create","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
187	287	directus_permissions	121	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_panels","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
188	288	directus_permissions	122	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_panels","action":"update","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
189	289	directus_permissions	123	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_panels","action":"delete","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
190	290	directus_permissions	124	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_folders","action":"create","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
191	291	directus_permissions	125	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_folders","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
192	292	directus_permissions	126	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_folders","action":"update","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
193	293	directus_permissions	127	{"collection":"directus_folders","action":"delete","permissions":{},"role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_folders","action":"delete","permissions":{},"role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
194	294	directus_permissions	128	{"collection":"directus_users","action":"read","permissions":{},"role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_users","action":"read","permissions":{},"role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
195	295	directus_permissions	129	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":"first_name,last_name,email,password,location,title,description,avatar,language,theme","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
196	296	directus_permissions	130	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"collection":"directus_roles","action":"read","permissions":{},"fields":"*","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
197	297	directus_permissions	131	{"role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48","collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48","collection":"movies","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
198	298	directus_permissions	132	{"role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48","collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48","collection":"movies_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
199	299	directus_roles	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	{"id":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48","name":"Subscriber","icon":"supervised_user_circle","description":"app subscriber","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":true,"users":[]}	{"description":"app subscriber"}	\N
200	300	directus_permissions	133	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_users","action":"read"}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_users","action":"read"}	\N
201	301	directus_permissions	133	{"id":133,"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_users","action":"read","permissions":{"role":{"name":{"_eq":"Subscriber"}}},"validation":null,"presets":null,"fields":null}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_users","action":"read","permissions":{"role":{"name":{"_eq":"Subscriber"}}},"validation":null,"presets":null,"fields":null}	\N
202	302	directus_permissions	133	{"id":133,"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_users","action":"read","permissions":{"role":{"name":{"_eq":"Subscriber"}}},"validation":null,"presets":null,"fields":null}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_users","action":"read","permissions":{"role":{"name":{"_eq":"Subscriber"}}},"validation":null,"presets":null,"fields":null}	\N
203	303	directus_users	2b8f7583-40f0-4b4c-a8fc-c606533a736a	{"first_name":"First","last_name":"Subscriber","email":"subscriber1@skara.live","password":"**********","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	{"first_name":"First","last_name":"Subscriber","email":"subscriber1@skara.live","password":"**********","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
204	304	directus_users	a224d75d-5da8-4450-9e66-f9ef53a16e45	{"id":"a224d75d-5da8-4450-9e66-f9ef53a16e45","first_name":"Second","last_name":"Subscriber","email":"subscriber2@skara.live","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":"en-US","theme":"auto","tfa_secret":null,"status":"active","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48","token":null,"last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true}	{"first_name":"Second","last_name":"Subscriber","email":"subscriber2@skara.live","password":"**********","role":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48"}	\N
206	307	directus_users	49eab1e1-ec46-41da-a5e7-92ad20d5e045	{"id":"49eab1e1-ec46-41da-a5e7-92ad20d5e045","first_name":"Admin","last_name":"User2","email":"admin2@flixbox.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":"en-US","theme":"auto","tfa_secret":null,"status":"suspended","role":null,"token":null,"last_access":"2021-12-15T08:41:15.507Z","last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true}	{"first_name":"Admin","last_name":"User2"}	\N
207	318	directus_roles	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	{"id":"ae207ac2-df88-4c99-98ce-6fcc33fe6f48","name":"Subscriber","icon":"supervised_user_circle","description":"app subscriber","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"users":["2b8f7583-40f0-4b4c-a8fc-c606533a736a","a224d75d-5da8-4450-9e66-f9ef53a16e45"]}	{"app_access":false}	\N
208	322	movies	dcc177dc-d8bf-4017-b859-dcc887a6f40c	{"movie_name":"new movei test"}	{"movie_name":"new movei test"}	\N
209	323	directus_permissions	134	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_webhooks","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_webhooks","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
210	324	directus_permissions	135	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_webhooks","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_webhooks","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
211	325	directus_permissions	136	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_webhooks","action":"update","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_webhooks","action":"update","fields":["*"],"permissions":{},"validation":{}}	\N
212	326	directus_permissions	137	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_webhooks","action":"delete","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"directus_webhooks","action":"delete","fields":["*"],"permissions":{},"validation":{}}	\N
213	327	directus_roles	537e43d3-2620-4e81-9aa0-ccfe797a87e8	{"id":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","name":"Publisher","icon":"supervised_user_circle","description":null,"ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"users":["14812d91-421e-438c-a5f5-58bcd87bf218"]}	{"app_access":false}	\N
214	328	directus_roles	537e43d3-2620-4e81-9aa0-ccfe797a87e8	{"id":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","name":"Publisher","icon":"supervised_user_circle","description":null,"ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":true,"users":["14812d91-421e-438c-a5f5-58bcd87bf218"]}	{"app_access":true}	\N
215	329	directus_webhooks	1	{"name":"Example Webhook","url":"http://google.com","collections":"movies,movies_files","actions":"create,update"}	{"name":"Example Webhook","url":"http://google.com","collections":"movies,movies_files","actions":"create,update"}	\N
216	331	directus_webhooks	2	{"name":"Pub created","actions":"create,update","collections":"movies","url":"https://example.com/publisher-created"}	{"name":"Pub created","actions":"create,update","collections":"movies","url":"https://example.com/publisher-created"}	\N
217	332	directus_settings	1	{"project_color":"#C400C7"}	{"project_color":"#C400C7"}	\N
218	333	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#3A313A","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null}	{"project_color":"#3A313A"}	\N
219	334	directus_files	e9147cba-4198-4ac5-a149-94ce6b9b206d	{"title":"Noun Hand 22419","filename_download":"noun_Hand_22419.svg","type":"image/svg+xml","storage":"local"}	{"title":"Noun Hand 22419","filename_download":"noun_Hand_22419.svg","type":"image/svg+xml","storage":"local"}	\N
220	335	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#3A313A","project_logo":"e9147cba-4198-4ac5-a149-94ce6b9b206d","public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null}	{"project_logo":"e9147cba-4198-4ac5-a149-94ce6b9b206d"}	\N
221	338	movies	aee6278e-7de7-41a8-bf7f-f3b93ffe6990	{"movie_name":"spiderman"}	{"movie_name":"spiderman"}	\N
222	341	movies	d64359fd-9ad2-44bb-8e99-245182d32366	{"status":"published","movie_name":"Latest Movie"}	{"status":"published","movie_name":"Latest Movie"}	\N
223	342	directus_collections	migrations	{"collection":"migrations"}	{"collection":"migrations"}	\N
224	343	directus_permissions	138	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"migrations","action":"create"}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"migrations","action":"create"}	\N
225	346	directus_fields	27	{"interface":"group-raw","special":"alias,no-data,group","collection":"movies","field":"movie_raw_file"}	{"interface":"group-raw","special":"alias,no-data,group","collection":"movies","field":"movie_raw_file"}	\N
226	347	directus_collections	movies_undefined	{"hidden":true,"icon":"import_export","collection":"movies_undefined"}	{"hidden":true,"icon":"import_export","collection":"movies_undefined"}	\N
227	348	directus_fields	28	{"hidden":true,"field":"id","collection":"movies_undefined"}	{"hidden":true,"field":"id","collection":"movies_undefined"}	\N
228	349	directus_fields	29	{"hidden":true,"collection":"movies_undefined","field":"movies_movie_id"}	{"hidden":true,"collection":"movies_undefined","field":"movies_movie_id"}	\N
229	350	directus_fields	30	{"hidden":true,"collection":"movies_undefined","field":"item"}	{"hidden":true,"collection":"movies_undefined","field":"item"}	\N
230	351	directus_fields	31	{"hidden":true,"collection":"movies_undefined","field":"collection"}	{"hidden":true,"collection":"movies_undefined","field":"collection"}	\N
231	352	directus_fields	32	{"interface":"list","special":"json","collection":"movies","field":"movie_delivery_url"}	{"interface":"list","special":"json","collection":"movies","field":"movie_delivery_url"}	\N
365	502	directus_fields	70	{"interface":"input","special":null,"collection":"Seasons","field":"title"}	{"interface":"input","special":null,"collection":"Seasons","field":"title"}	\N
374	511	Seasons	8cdbb08b-1b50-4f9a-a612-93389be4f389	{"title":"season 2","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episodes":[{"movie_name":"new ep1","video_type":"series"}]}	{"title":"season 2","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episodes":[{"movie_name":"new ep1","video_type":"series"}]}	\N
232	353	directus_fields	32	{"id":32,"collection":"movies","field":"movie_delivery_url","special":["json"],"interface":"list","options":null,"display":null,"display_options":null,"readonly":false,"hidden":true,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"movie_delivery_url","special":["json"],"interface":"list","options":null,"display":null,"display_options":null,"readonly":false,"hidden":true,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
233	354	directus_fields	33	{"interface":"file","special":"file","collection":"movies","field":"movie_raw"}	{"interface":"file","special":"file","collection":"movies","field":"movie_raw"}	\N
234	355	directus_files	30183811-6618-4f0c-90b3-337ca1e5bd48	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	\N
235	356	directus_files	9dd7400f-6808-48e9-b678-9071769ad251	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	\N
236	357	directus_files	ef36ba3f-6640-4afa-9be9-3076158cc088	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	\N
237	358	directus_files	d7bc9733-2ca6-42c8-aaeb-aa07d0fa9114	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	\N
238	360	movies	a0d9f25e-aca5-478f-a653-a8c131e93af7	{"status":"published","movie_name":"Latest Movie Test"}	{"status":"published","movie_name":"Latest Movie Test"}	\N
239	365	directus_files	37827f87-7636-41da-9fd6-4681e3ab1e6c	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Sample Video","filename_download":"sample-video.mp4","type":"video/mp4","storage":"amazon"}	\N
240	366	movies	ea7079e7-bb67-4829-90a3-a82401680a4c	{"status":"published","movie_name":"Test Upload 1","movie_raw":"37827f87-7636-41da-9fd6-4681e3ab1e6c"}	{"status":"published","movie_name":"Test Upload 1","movie_raw":"37827f87-7636-41da-9fd6-4681e3ab1e6c"}	\N
241	367	directus_collections	migrations	{"collection":"migrations","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"hidden":true}	\N
242	368	directus_collections	migrations_lock	{"collection":"migrations_lock"}	{"collection":"migrations_lock"}	\N
243	369	directus_collections	migrations_lock	{"collection":"migrations_lock","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"hidden":true}	\N
244	371	directus_files	6e9ac6ff-a7c1-456f-bd8c-a824073bd244	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
245	372	movies	578206c0-4323-495c-8fc5-374ea322f2c2	{"movie_raw":"6e9ac6ff-a7c1-456f-bd8c-a824073bd244","movie_name":"some movie test 2"}	{"movie_raw":"6e9ac6ff-a7c1-456f-bd8c-a824073bd244","movie_name":"some movie test 2"}	\N
246	373	directus_files	2bb7896d-ffe5-41ce-9fb5-7a09d563085f	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
247	374	movies	829a716a-715d-4e80-939f-e4e94de06476	{"movie_name":"movie test 3","movie_raw":"2bb7896d-ffe5-41ce-9fb5-7a09d563085f"}	{"movie_name":"movie test 3","movie_raw":"2bb7896d-ffe5-41ce-9fb5-7a09d563085f"}	\N
248	378	directus_files	fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
249	379	movies	e86e5d68-3d9b-466e-b8bd-7486f0a0f082	{"movie_name":"test 3","movie_raw":"fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b"}	{"movie_name":"test 3","movie_raw":"fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b"}	\N
250	380	movies	578206c0-4323-495c-8fc5-374ea322f2c2	{"movie_id":"578206c0-4323-495c-8fc5-374ea322f2c2","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:55:05.131Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T06:58:33.199Z","movie_name":"some movie test 02","movie_delivery_url":null,"movie_raw":"6e9ac6ff-a7c1-456f-bd8c-a824073bd244","movie_images":[]}	{"movie_name":"some movie test 02","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T06:58:33.199Z"}	\N
251	381	movies	578206c0-4323-495c-8fc5-374ea322f2c2	{"movie_id":"578206c0-4323-495c-8fc5-374ea322f2c2","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:55:05.131Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T06:59:10.378Z","movie_name":"some movie test 002","movie_delivery_url":null,"movie_raw":"6e9ac6ff-a7c1-456f-bd8c-a824073bd244","movie_images":[]}	{"movie_name":"some movie test 002","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T06:59:10.378Z"}	\N
252	382	movies	e86e5d68-3d9b-466e-b8bd-7486f0a0f082	{"movie_id":"e86e5d68-3d9b-466e-b8bd-7486f0a0f082","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:56:44.380Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T07:01:11.517Z","movie_name":"tes333","movie_delivery_url":null,"movie_raw":"fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b","movie_images":[]}	{"movie_name":"tes333","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T07:01:11.517Z"}	\N
253	383	movies	e86e5d68-3d9b-466e-b8bd-7486f0a0f082	{"movie_id":"e86e5d68-3d9b-466e-b8bd-7486f0a0f082","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:56:44.380Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T07:02:08.290Z","movie_name":"tes333asdasd","movie_delivery_url":null,"movie_raw":"fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b","movie_images":[]}	{"movie_name":"tes333asdasd","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T07:02:08.290Z"}	\N
372	509	directus_fields	73	{"interface":"list-o2m","special":"o2m","collection":"Series","field":"seasons"}	{"interface":"list-o2m","special":"o2m","collection":"Series","field":"seasons"}	\N
254	384	movies	e86e5d68-3d9b-466e-b8bd-7486f0a0f082	{"movie_id":"e86e5d68-3d9b-466e-b8bd-7486f0a0f082","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:56:44.380Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T07:03:27.783Z","movie_name":"tes333asdasdasdasd","movie_delivery_url":null,"movie_raw":"fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b","movie_images":[]}	{"movie_name":"tes333asdasdasdasd","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T07:03:27.783Z"}	\N
255	385	directus_files	bfcbe12e-b226-42f3-8c9d-bc29eb2638c3	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
256	386	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	{"status":"published","movie_name":"Test04","movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3"}	{"status":"published","movie_name":"Test04","movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3"}	\N
257	388	directus_files	83708ad1-7763-4ac9-8d17-6ffb4a3de293	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
258	389	movies	dd703c7c-3aae-4d0c-883d-dd6b199939e3	{"status":"published","movie_name":"Movie with url 1","movie_raw":"83708ad1-7763-4ac9-8d17-6ffb4a3de293"}	{"status":"published","movie_name":"Movie with url 1","movie_raw":"83708ad1-7763-4ac9-8d17-6ffb4a3de293"}	\N
259	390	directus_files	41b17364-9a34-48f0-afcc-e78bd8d43cfb	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
260	391	movies	aa71595e-cda1-400a-9c4b-748b17ac976d	{"status":"published","movie_name":"mediaconv test 01","movie_raw":"41b17364-9a34-48f0-afcc-e78bd8d43cfb"}	{"status":"published","movie_name":"mediaconv test 01","movie_raw":"41b17364-9a34-48f0-afcc-e78bd8d43cfb"}	\N
261	393	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	{"movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:14:35.128Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T10:22:09.784Z","movie_name":"Test040","movie_delivery_url":null,"movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3","movie_images":[]}	{"movie_name":"Test040","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T10:22:09.784Z"}	\N
262	394	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	{"movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:14:35.128Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T10:24:58.048Z","movie_name":"Test04","movie_delivery_url":null,"movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3","movie_images":[]}	{"movie_name":"Test04","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T10:24:58.048Z"}	\N
263	395	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	{"movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:14:35.128Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T10:25:27.675Z","movie_name":"Test04a","movie_delivery_url":null,"movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3","movie_images":[]}	{"movie_name":"Test04a","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-24T10:25:27.675Z"}	\N
264	396	directus_files	ee64a57e-c550-46e4-bace-74860f357ef3	{"title":"Noun Hand 22419","filename_download":"noun_Hand_22419.svg","type":"image/svg+xml","storage":"amazon"}	{"title":"Noun Hand 22419","filename_download":"noun_Hand_22419.svg","type":"image/svg+xml","storage":"amazon"}	\N
266	398	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	{"movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:14:35.128Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-25T11:15:16.375Z","movie_name":"Test04a","movie_delivery_url":null,"movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3","movie_images":[4]}	{"user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-25T11:15:16.375Z"}	\N
265	397	movies_files	4	{"directus_files_id":"ee64a57e-c550-46e4-bace-74860f357ef3","movies_movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff"}	{"directus_files_id":"ee64a57e-c550-46e4-bace-74860f357ef3","movies_movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff"}	266
267	400	directus_files	ec3c78b3-6f11-4116-b01f-c3e59fabc8d3	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
268	401	directus_files	48e4683f-2c0e-4e07-87f1-1e4b02ab2eae	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon2"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon2"}	\N
269	402	movies	2285246a-e785-41b2-b12d-551291be126f	{"movie_name":"asdasd","movie_raw":"48e4683f-2c0e-4e07-87f1-1e4b02ab2eae"}	{"movie_name":"asdasd","movie_raw":"48e4683f-2c0e-4e07-87f1-1e4b02ab2eae"}	\N
270	404	directus_files	34f3088c-f1db-4ad4-bb0b-440ee962e3a9	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon2"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon2"}	\N
271	405	movies	f7391c37-5612-4fe8-8bf0-bb0aa72685f1	{"status":"published","movie_name":"create one more"}	{"status":"published","movie_name":"create one more"}	\N
272	406	directus_files	1c2b532c-f15a-4868-a335-96b4ece15a41	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
273	407	movies	72e3eb36-64a6-441a-898b-bfbf1c376159	{"movie_name":"as fnsvSD SGND","status":"published","movie_raw":"1c2b532c-f15a-4868-a335-96b4ece15a41"}	{"movie_name":"as fnsvSD SGND","status":"published","movie_raw":"1c2b532c-f15a-4868-a335-96b4ece15a41"}	\N
274	410	directus_files	6932a039-7c61-4d56-abc9-d54b3bf3c4f8	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
275	411	directus_collections	Series	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"Series"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"Series"}	\N
276	412	directus_fields	34	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"series_id","collection":"Series"}	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"series_id","collection":"Series"}	\N
277	413	directus_fields	35	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"Series"}	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"Series"}	\N
278	414	directus_fields	36	{"interface":"input","hidden":true,"field":"sort","collection":"Series"}	{"interface":"input","hidden":true,"field":"sort","collection":"Series"}	\N
279	415	directus_fields	37	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"Series"}	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"Series"}	\N
280	416	directus_fields	38	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Series"}	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Series"}	\N
281	417	directus_fields	39	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"Series"}	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"Series"}	\N
282	418	directus_fields	40	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"Series"}	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"Series"}	\N
283	419	directus_fields	41	{"interface":"input","special":null,"required":true,"collection":"Series","field":"title"}	{"interface":"input","special":null,"required":true,"collection":"Series","field":"title"}	\N
284	420	directus_fields	42	{"interface":"list-o2m","special":"o2m","collection":"Series","field":"episode"}	{"interface":"list-o2m","special":"o2m","collection":"Series","field":"episode"}	\N
285	421	directus_fields	43	{"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"Movie","value":"movie"},{"text":"Series","value":"series"}]},"collection":"movies","field":"video_type"}	{"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"Movie","value":"movie"},{"text":"Series","value":"series"}]},"collection":"movies","field":"video_type"}	\N
286	422	directus_fields	44	{"interface":"select-dropdown-m2o","special":"m2o","collection":"movies","field":"belongs_to_series"}	{"interface":"select-dropdown-m2o","special":"m2o","collection":"movies","field":"belongs_to_series"}	\N
287	423	directus_fields	44	{"id":44,"collection":"movies","field":"belongs_to_series","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Belongs to series","rule":{"video_type":{"_eq":"series"}}}],"required":false,"group":null}	{"collection":"movies","field":"belongs_to_series","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Belongs to series","rule":{"video_type":{"_eq":"series"}}}],"required":false,"group":null}	\N
288	424	directus_fields	44	{"id":44,"collection":"movies","field":"belongs_to_series","special":["m2o","uuid"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}{{episode}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Belongs to series","rule":{"video_type":{"_eq":"series"}}}],"required":false,"group":null}	{"collection":"movies","field":"belongs_to_series","special":["m2o","uuid"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}{{episode}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Belongs to series","rule":{"video_type":{"_eq":"series"}}}],"required":false,"group":null}	\N
289	425	directus_fields	45	{"interface":"list-o2m-tree-view","special":"o2m","collection":"Series","field":"episodes"}	{"interface":"list-o2m-tree-view","special":"o2m","collection":"Series","field":"episodes"}	\N
290	426	directus_fields	46	{"interface":"list-o2m","special":"o2m","collection":"Series","field":"episodes"}	{"interface":"list-o2m","special":"o2m","collection":"Series","field":"episodes"}	\N
296	432	Series	3f381be8-edeb-4e06-b632-53891f64d617	{"status":"published","title":"New Tv series","episodes":["32cded58-4aa5-4c41-9144-3d507a5a6dff","829a716a-715d-4e80-939f-e4e94de06476","dd703c7c-3aae-4d0c-883d-dd6b199939e3","ea7079e7-bb67-4829-90a3-a82401680a4c",{"movie_name":"EPISODE 5","status":"published","video_type":"series"}]}	{"status":"published","title":"New Tv series","episodes":["32cded58-4aa5-4c41-9144-3d507a5a6dff","829a716a-715d-4e80-939f-e4e94de06476","dd703c7c-3aae-4d0c-883d-dd6b199939e3","ea7079e7-bb67-4829-90a3-a82401680a4c",{"movie_name":"EPISODE 5","status":"published","video_type":"series"}]}	\N
291	427	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	{"movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:14:35.128Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:43.640Z","movie_name":"Test04a","movie_delivery_url":null,"movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3","video_type":"false","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[4]}	{"belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:43.640Z"}	296
292	428	movies	829a716a-715d-4e80-939f-e4e94de06476	{"movie_id":"829a716a-715d-4e80-939f-e4e94de06476","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:55:45.575Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:43.658Z","movie_name":"movie test 3","movie_delivery_url":null,"movie_raw":"2bb7896d-ffe5-41ce-9fb5-7a09d563085f","video_type":"false","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:43.658Z"}	296
293	429	movies	dd703c7c-3aae-4d0c-883d-dd6b199939e3	{"movie_id":"dd703c7c-3aae-4d0c-883d-dd6b199939e3","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:26:40.602Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:43.671Z","movie_name":"Movie with url 1","movie_delivery_url":[{"resolution":"1080","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_3000.m3u8"},{"resolution":"540","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_1500.m3u8"},{"resolution":"480","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_750.m3u8"},{"resolution":"360","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_325.m3u8"}],"movie_raw":"83708ad1-7763-4ac9-8d17-6ffb4a3de293","video_type":"false","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:43.671Z"}	296
294	430	movies	ea7079e7-bb67-4829-90a3-a82401680a4c	{"movie_id":"ea7079e7-bb67-4829-90a3-a82401680a4c","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:42:02.100Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:43.687Z","movie_name":"Test Upload 1","movie_delivery_url":null,"movie_raw":"37827f87-7636-41da-9fd6-4681e3ab1e6c","video_type":"false","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:43.687Z"}	296
295	431	movies	4b98565f-af11-48b6-9338-15b36a07414c	{"movie_name":"EPISODE 5","status":"published","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617"}	{"movie_name":"EPISODE 5","status":"published","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617"}	296
297	433	movies	4b98565f-af11-48b6-9338-15b36a07414c	{"movie_id":"4b98565f-af11-48b6-9338-15b36a07414c","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-27T08:41:43.704Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:57.342Z","movie_name":"EPISODE 5","movie_delivery_url":null,"movie_raw":null,"video_type":"movie","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"video_type":"movie","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:41:57.342Z"}	\N
298	434	movies	4b98565f-af11-48b6-9338-15b36a07414c	{"movie_id":"4b98565f-af11-48b6-9338-15b36a07414c","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-27T08:41:43.704Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:42:07.585Z","movie_name":"EPISODE 5","movie_delivery_url":null,"movie_raw":null,"video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"video_type":"series","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:42:07.585Z"}	\N
299	435	directus_fields	46	{"id":46,"collection":"Series","field":"episodes","special":["o2m"],"interface":"list-o2m","options":null,"display":"related-values","display_options":{"template":"{{movie_name}}{{status}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"Series","field":"episodes","special":["o2m"],"interface":"list-o2m","options":null,"display":"related-values","display_options":{"template":"{{movie_name}}{{status}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
305	441	Series	3f381be8-edeb-4e06-b632-53891f64d617	{"series_id":"3f381be8-edeb-4e06-b632-53891f64d617","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-27T08:41:43.631Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.354Z","title":"New Tv series","episodes":["32cded58-4aa5-4c41-9144-3d507a5a6dff","4b98565f-af11-48b6-9338-15b36a07414c","829a716a-715d-4e80-939f-e4e94de06476","dd703c7c-3aae-4d0c-883d-dd6b199939e3","ea7079e7-bb67-4829-90a3-a82401680a4c"]}	{"user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.354Z"}	\N
300	436	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	{"movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:14:35.128Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.360Z","movie_name":"Test04a","movie_delivery_url":null,"movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[4]}	{"video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.360Z"}	305
301	437	movies	4b98565f-af11-48b6-9338-15b36a07414c	{"movie_id":"4b98565f-af11-48b6-9338-15b36a07414c","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-27T08:41:43.704Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.374Z","movie_name":"EPISODE 5","movie_delivery_url":null,"movie_raw":null,"video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.374Z"}	305
302	438	movies	829a716a-715d-4e80-939f-e4e94de06476	{"movie_id":"829a716a-715d-4e80-939f-e4e94de06476","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:55:45.575Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.384Z","movie_name":"movie test 3","movie_delivery_url":null,"movie_raw":"2bb7896d-ffe5-41ce-9fb5-7a09d563085f","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.384Z"}	305
303	439	movies	dd703c7c-3aae-4d0c-883d-dd6b199939e3	{"movie_id":"dd703c7c-3aae-4d0c-883d-dd6b199939e3","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:26:40.602Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.400Z","movie_name":"Movie with url 1","movie_delivery_url":[{"resolution":"1080","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_3000.m3u8"},{"resolution":"540","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_1500.m3u8"},{"resolution":"480","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_750.m3u8"},{"resolution":"360","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_325.m3u8"}],"movie_raw":"83708ad1-7763-4ac9-8d17-6ffb4a3de293","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.400Z"}	305
304	440	movies	ea7079e7-bb67-4829-90a3-a82401680a4c	{"movie_id":"ea7079e7-bb67-4829-90a3-a82401680a4c","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:42:02.100Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.416Z","movie_name":"Test Upload 1","movie_delivery_url":null,"movie_raw":"37827f87-7636-41da-9fd6-4681e3ab1e6c","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","movie_images":[]}	{"video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T08:44:12.416Z"}	305
306	442	directus_fields	44	{"id":44,"collection":"movies","field":"belongs_to_series","special":["m2o","uuid"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}{{episode}}"},"display":"related-values","display_options":{"template":"{{title}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Belongs to series","rule":{"video_type":{"_eq":"series"}}}],"required":false,"group":null}	{"collection":"movies","field":"belongs_to_series","special":["m2o","uuid"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}{{episode}}"},"display":"related-values","display_options":{"template":"{{title}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Belongs to series","rule":{"video_type":{"_eq":"series"}}}],"required":false,"group":null}	\N
307	443	directus_fields	47	{"interface":"list-m2a","special":"m2a","collection":"Series","field":"seasons"}	{"interface":"list-m2a","special":"m2a","collection":"Series","field":"seasons"}	\N
308	444	directus_collections	Series_seasons	{"hidden":true,"icon":"import_export","collection":"Series_seasons"}	{"hidden":true,"icon":"import_export","collection":"Series_seasons"}	\N
309	445	directus_fields	48	{"hidden":true,"field":"id","collection":"Series_seasons"}	{"hidden":true,"field":"id","collection":"Series_seasons"}	\N
310	446	directus_fields	49	{"hidden":true,"collection":"Series_seasons","field":"Series_series_id"}	{"hidden":true,"collection":"Series_seasons","field":"Series_series_id"}	\N
311	447	directus_fields	50	{"hidden":true,"collection":"Series_seasons","field":"item"}	{"hidden":true,"collection":"Series_seasons","field":"item"}	\N
312	448	directus_fields	51	{"hidden":true,"collection":"Series_seasons","field":"collection"}	{"hidden":true,"collection":"Series_seasons","field":"collection"}	\N
313	450	directus_fields	52	{"interface":"list","special":"json","options":{"fields":[{"field":"season_title","name":"season_title","type":"string","meta":{"field":"season_title","type":"string","interface":"input","options":{"trim":true}}},{"field":"episodes_list","name":"episodes_list","type":"string","meta":{"field":"episodes_list","width":"full","type":"string","interface":"input-autocomplete-api","options":{"choices":[{}],"url":"http://localhost:8055/items/movies","resultsPath":"result.data","valuePath":"movie_name"}}}]},"collection":"Series","field":"volumes"}	{"interface":"list","special":"json","options":{"fields":[{"field":"season_title","name":"season_title","type":"string","meta":{"field":"season_title","type":"string","interface":"input","options":{"trim":true}}},{"field":"episodes_list","name":"episodes_list","type":"string","meta":{"field":"episodes_list","width":"full","type":"string","interface":"input-autocomplete-api","options":{"choices":[{}],"url":"http://localhost:8055/items/movies","resultsPath":"result.data","valuePath":"movie_name"}}}]},"collection":"Series","field":"volumes"}	\N
314	451	directus_fields	46	{"id":46,"collection":"Series","field":"episodes","special":["o2m"],"interface":"list-o2m","options":{"template":"{{movie_name}}"},"display":"related-values","display_options":{"template":"{{movie_name}}{{status}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"Series","field":"episodes","special":["o2m"],"interface":"list-o2m","options":{"template":"{{movie_name}}"},"display":"related-values","display_options":{"template":"{{movie_name}}{{status}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
315	452	directus_fields	53	{"interface":"input","special":null,"required":false,"collection":"movies","field":"episode_sequence_number"}	{"interface":"input","special":null,"required":false,"collection":"movies","field":"episode_sequence_number"}	\N
316	453	directus_fields	54	{"interface":"input","special":null,"collection":"movies","field":"season_sequence_number"}	{"interface":"input","special":null,"collection":"movies","field":"season_sequence_number"}	\N
317	454	directus_fields	53	{"id":53,"collection":"movies","field":"episode_sequence_number","special":null,"interface":"input","options":null,"display":"formatted-value","display_options":{"icon":true,"formatTitle":true,"bold":true},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"episode_sequence_number","special":null,"interface":"input","options":null,"display":"formatted-value","display_options":{"icon":true,"formatTitle":true,"bold":true},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
318	455	directus_fields	53	{"id":53,"collection":"movies","field":"episode_sequence_number","special":null,"interface":"input","options":null,"display":"formatted-value","display_options":{"icon":true,"formatTitle":true,"bold":true},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"sequence number condition","rule":{"video_type":{"_eq":"series"}}}],"required":false,"group":null}	{"collection":"movies","field":"episode_sequence_number","special":null,"interface":"input","options":null,"display":"formatted-value","display_options":{"icon":true,"formatTitle":true,"bold":true},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"sequence number condition","rule":{"video_type":{"_eq":"series"}}}],"required":false,"group":null}	\N
319	456	movies	2285246a-e785-41b2-b12d-551291be126f	{"movie_id":"2285246a-e785-41b2-b12d-551291be126f","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-25T11:53:38.694Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T09:33:21.726Z","movie_name":"asdasd","movie_delivery_url":null,"movie_raw":"48e4683f-2c0e-4e07-87f1-1e4b02ab2eae","video_type":"false","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":null,"season_sequence_number":null,"movie_images":[]}	{"belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T09:33:21.726Z"}	\N
320	457	directus_fields	19	{"id":19,"collection":"movies","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":false,"sort":null,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"date_created","hidden":false}	\N
321	458	directus_fields	18	{"id":18,"collection":"movies","field":"user_created","special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","display_options":null,"readonly":true,"hidden":false,"sort":null,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"user_created","hidden":false}	\N
322	459	movies	578206c0-4323-495c-8fc5-374ea322f2c2	{"movie_id":"578206c0-4323-495c-8fc5-374ea322f2c2","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:55:05.131Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T09:39:25.215Z","movie_name":"some movie test 002","movie_delivery_url":null,"movie_raw":"6e9ac6ff-a7c1-456f-bd8c-a824073bd244","video_type":"movie","belongs_to_series":null,"episode_sequence_number":null,"season_sequence_number":null,"movie_images":[]}	{"video_type":"movie","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2021-12-27T09:39:25.215Z"}	\N
323	460	directus_fields	53	{"id":53,"collection":"movies","field":"episode_sequence_number","special":null,"interface":"input","options":null,"display":"formatted-value","display_options":{"icon":true,"formatTitle":true,"bold":true},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"sequence number condition","rule":{"video_type":{"_neq":"series"}},"readonly":true,"hidden":true}],"required":false,"group":null}	{"collection":"movies","field":"episode_sequence_number","special":null,"interface":"input","options":null,"display":"formatted-value","display_options":{"icon":true,"formatTitle":true,"bold":true},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"sequence number condition","rule":{"video_type":{"_neq":"series"}},"readonly":true,"hidden":true}],"required":false,"group":null}	\N
324	461	directus_fields	54	{"id":54,"collection":"movies","field":"season_sequence_number","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"season sequence condition","rule":{"video_type":{"_neq":"series"}},"readonly":true,"hidden":true}],"required":false,"group":null}	{"collection":"movies","field":"season_sequence_number","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"season sequence condition","rule":{"video_type":{"_neq":"series"}},"readonly":true,"hidden":true}],"required":false,"group":null}	\N
325	462	directus_fields	44	{"id":44,"collection":"movies","field":"belongs_to_series","special":["m2o","uuid"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}{{episode}}"},"display":"related-values","display_options":{"template":"{{title}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Belongs to series","rule":{"video_type":{"_neq":"series"}},"readonly":true,"hidden":true}],"required":false,"group":null}	{"collection":"movies","field":"belongs_to_series","special":["m2o","uuid"],"interface":"select-dropdown-m2o","options":{"template":"{{title}}{{episode}}"},"display":"related-values","display_options":{"template":"{{title}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Belongs to series","rule":{"video_type":{"_neq":"series"}},"readonly":true,"hidden":true}],"required":false,"group":null}	\N
326	463	directus_fields	55	{"interface":"input","special":null,"collection":"movies","field":"asdasdasd"}	{"interface":"input","special":null,"collection":"movies","field":"asdasdasd"}	\N
327	464	directus_fields	55	{"id":55,"collection":"movies","field":"asdasdasd","special":null,"interface":"custom","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"asdasdasd","special":null,"interface":"custom","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
328	465	directus_fields	56	{"interface":"file-image","special":"file","collection":"movies","field":"custom_upload"}	{"interface":"file-image","special":"file","collection":"movies","field":"custom_upload"}	\N
329	466	directus_fields	56	{"id":56,"collection":"movies","field":"custom_upload","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"custom_upload","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
330	467	directus_files	6214ebfd-f53d-4310-b9f3-a5a2e208dbf0	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
331	468	movies	cdf84f22-7f5c-4d58-9593-8558d10d5530	{"status":"published","movie_name":"test09","movie_raw":"6214ebfd-f53d-4310-b9f3-a5a2e208dbf0","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617"}	{"status":"published","movie_name":"test09","movie_raw":"6214ebfd-f53d-4310-b9f3-a5a2e208dbf0","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617"}	\N
332	469	directus_permissions	139	{"role":null,"collection":"directus_notifications","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_notifications","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
333	470	directus_fields	43	{"id":43,"collection":"movies","field":"video_type","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"Movie","value":"movie"},{"text":"Series","value":"series"}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"video_type","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"Movie","value":"movie"},{"text":"Series","value":"series"}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
334	471	directus_files	4a9464b4-49b8-4895-a47c-73b249186b15	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	{"title":"Video","filename_download":"video.mp4","type":"video/mp4","storage":"amazon"}	\N
335	472	movies	41dabed9-f1f8-41e1-b585-036b54568b49	{"movie_raw":"4a9464b4-49b8-4895-a47c-73b249186b15","movie_name":"Taste if resr","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":"1","season_sequence_number":"2"}	{"movie_raw":"4a9464b4-49b8-4895-a47c-73b249186b15","movie_name":"Taste if resr","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":"1","season_sequence_number":"2"}	\N
336	473	directus_fields	57	{"interface":"file-image","special":"file","collection":"movies","field":"featured_image"}	{"interface":"file-image","special":"file","collection":"movies","field":"featured_image"}	\N
337	474	directus_fields	57	{"id":57,"collection":"movies","field":"featured_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"featured_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
339	476	movies	2285246a-e785-41b2-b12d-551291be126f	{"movie_id":"2285246a-e785-41b2-b12d-551291be126f","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-25T11:53:38.694Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T10:10:18.461Z","movie_name":"asdasd","movie_delivery_url":null,"movie_raw":"48e4683f-2c0e-4e07-87f1-1e4b02ab2eae","video_type":"false","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":null,"season_sequence_number":null,"custom_upload":null,"featured_image":"62d44ac9-4a92-4e21-a655-4a7e296fc933","movie_images":[]}	{"featured_image":"62d44ac9-4a92-4e21-a655-4a7e296fc933","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T10:10:18.461Z"}	\N
340	477	movies	41dabed9-f1f8-41e1-b585-036b54568b49	{"movie_id":"41dabed9-f1f8-41e1-b585-036b54568b49","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2022-01-05T10:04:13.124Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T10:11:44.755Z","movie_name":"Taste if resr","movie_delivery_url":null,"movie_raw":"4a9464b4-49b8-4895-a47c-73b249186b15","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":"1","season_sequence_number":"2","custom_upload":null,"featured_image":null,"movie_images":[]}	{"status":"published","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T10:11:44.755Z"}	\N
341	478	movies	41dabed9-f1f8-41e1-b585-036b54568b49	{"movie_id":"41dabed9-f1f8-41e1-b585-036b54568b49","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2022-01-05T10:04:13.124Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T10:11:53.359Z","movie_name":"Taste if resr","movie_delivery_url":null,"movie_raw":"4a9464b4-49b8-4895-a47c-73b249186b15","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":"1","season_sequence_number":"2","custom_upload":null,"featured_image":null,"movie_images":[]}	{"status":"draft","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T10:11:53.359Z"}	\N
342	479	directus_fields	58	{"interface":"list","special":"json","options":{"addLabel":"Season"},"display":"labels","collection":"Series","field":"season_info"}	{"interface":"list","special":"json","options":{"addLabel":"Season"},"display":"labels","collection":"Series","field":"season_info"}	\N
343	480	directus_fields	58	{"id":58,"collection":"Series","field":"season_info","special":["json"],"interface":"list","options":{"addLabel":null,"choices":null,"template":null,"fields":[{"field":"season_title","name":"season_title","type":"string","meta":{"field":"season_title","width":"half","type":"string","interface":"input","note":"Season Title(like season 1 or part 1 etc.)","options":{"placeholder":"Season Title"}}},{"field":"season_sequence_number","name":"season_sequence_number","type":"integer","meta":{"field":"season_sequence_number","width":"half","type":"integer","interface":"input","note":"Season or Part Number of the series"}},{"field":"season_description","name":"season_description","type":"text","meta":{"field":"season_description","width":"full","type":"text","interface":"input-multiline"}},{"field":"publish_date_time","name":"publish_date_time","type":"dateTime","meta":{"field":"publish_date_time","width":"full","type":"dateTime","interface":"datetime","note":"Date and Time for the season to go live for users."}}]},"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"Series","field":"season_info","special":["json"],"interface":"list","options":{"addLabel":null,"choices":null,"template":null,"fields":[{"field":"season_title","name":"season_title","type":"string","meta":{"field":"season_title","width":"half","type":"string","interface":"input","note":"Season Title(like season 1 or part 1 etc.)","options":{"placeholder":"Season Title"}}},{"field":"season_sequence_number","name":"season_sequence_number","type":"integer","meta":{"field":"season_sequence_number","width":"half","type":"integer","interface":"input","note":"Season or Part Number of the series"}},{"field":"season_description","name":"season_description","type":"text","meta":{"field":"season_description","width":"full","type":"text","interface":"input-multiline"}},{"field":"publish_date_time","name":"publish_date_time","type":"dateTime","meta":{"field":"publish_date_time","width":"full","type":"dateTime","interface":"datetime","note":"Date and Time for the season to go live for users."}}]},"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
344	481	directus_fields	58	{"id":58,"collection":"Series","field":"season_info","special":["json"],"interface":"list","options":{"addLabel":"Add New Season/Part","choices":null,"template":null,"fields":[{"field":"season_title","name":"season_title","type":"string","meta":{"field":"season_title","width":"half","type":"string","interface":"input","note":"Season Title(like season 1 or part 1 etc.)","options":{"placeholder":"Season Title"}}},{"field":"season_sequence_number","name":"season_sequence_number","type":"integer","meta":{"field":"season_sequence_number","width":"half","type":"integer","interface":"input","note":"Season or Part Number of the series"}},{"field":"season_description","name":"season_description","type":"text","meta":{"field":"season_description","width":"full","type":"text","interface":"input-multiline"}},{"field":"publish_date_time","name":"publish_date_time","type":"dateTime","meta":{"field":"publish_date_time","width":"full","type":"dateTime","interface":"datetime","note":"Date and Time for the season to go live for users."}}]},"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"Series","field":"season_info","special":["json"],"interface":"list","options":{"addLabel":"Add New Season/Part","choices":null,"template":null,"fields":[{"field":"season_title","name":"season_title","type":"string","meta":{"field":"season_title","width":"half","type":"string","interface":"input","note":"Season Title(like season 1 or part 1 etc.)","options":{"placeholder":"Season Title"}}},{"field":"season_sequence_number","name":"season_sequence_number","type":"integer","meta":{"field":"season_sequence_number","width":"half","type":"integer","interface":"input","note":"Season or Part Number of the series"}},{"field":"season_description","name":"season_description","type":"text","meta":{"field":"season_description","width":"full","type":"text","interface":"input-multiline"}},{"field":"publish_date_time","name":"publish_date_time","type":"dateTime","meta":{"field":"publish_date_time","width":"full","type":"dateTime","interface":"datetime","note":"Date and Time for the season to go live for users."}}]},"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
345	482	Series	3f381be8-edeb-4e06-b632-53891f64d617	{"series_id":"3f381be8-edeb-4e06-b632-53891f64d617","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-27T08:41:43.631Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T12:49:55.732Z","title":"New Tv series","season_info":[{"season_title":"Season 1","season_sequence_number":1,"season_description":"New season. Very nice. Good job.","publish_date_time":"2022-02-06T18:05:00"}],"seasons":[],"episodes":["2285246a-e785-41b2-b12d-551291be126f","32cded58-4aa5-4c41-9144-3d507a5a6dff","41dabed9-f1f8-41e1-b585-036b54568b49","4b98565f-af11-48b6-9338-15b36a07414c","829a716a-715d-4e80-939f-e4e94de06476","cdf84f22-7f5c-4d58-9593-8558d10d5530","dd703c7c-3aae-4d0c-883d-dd6b199939e3","ea7079e7-bb67-4829-90a3-a82401680a4c"]}	{"season_info":[{"season_title":"Season 1","season_sequence_number":1,"season_description":"New season. Very nice. Good job.","publish_date_time":"2022-02-06T18:05:00"}],"user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T12:49:55.732Z"}	\N
346	483	directus_fields	46	{"id":46,"collection":"Series","field":"episodes","special":["o2m"],"interface":"list-o2m","options":{"template":"{{movie_name}}"},"display":"related-values","display_options":{"template":"{{movie_name}}{{status}}{{season_sequence_number}}{{episode_sequence_number}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Episode inside series","rule":{"episodes":{"video_type":{"_eq":"series"}}}}],"required":false,"group":null}	{"collection":"Series","field":"episodes","special":["o2m"],"interface":"list-o2m","options":{"template":"{{movie_name}}"},"display":"related-values","display_options":{"template":"{{movie_name}}{{status}}{{season_sequence_number}}{{episode_sequence_number}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":[{"name":"Episode inside series","rule":{"episodes":{"video_type":{"_eq":"series"}}}}],"required":false,"group":null}	\N
347	484	directus_collections	Seasons	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"Seasons"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"Seasons"}	\N
348	485	directus_fields	59	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"season_id","collection":"Seasons"}	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"season_id","collection":"Seasons"}	\N
349	486	directus_fields	60	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"Seasons"}	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"Seasons"}	\N
350	487	directus_fields	61	{"interface":"input","hidden":true,"field":"sort","collection":"Seasons"}	{"interface":"input","hidden":true,"field":"sort","collection":"Seasons"}	\N
351	488	directus_fields	62	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"Seasons"}	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"Seasons"}	\N
352	489	directus_fields	63	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Seasons"}	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Seasons"}	\N
353	490	directus_fields	64	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"Seasons"}	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"Seasons"}	\N
354	491	directus_fields	65	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"Seasons"}	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"Seasons"}	\N
355	492	directus_fields	66	{"interface":"select-dropdown-m2o","special":"m2o","options":{"template":"{{title}}"},"collection":"Seasons","field":"series"}	{"interface":"select-dropdown-m2o","special":"m2o","options":{"template":"{{title}}"},"collection":"Seasons","field":"series"}	\N
356	493	directus_fields	67	{"interface":"list-o2m","special":"o2m","options":{"template":"{{movie_name}}{{episode_sequence_number}}"},"collection":"Seasons","field":"episodes"}	{"interface":"list-o2m","special":"o2m","options":{"template":"{{movie_name}}{{episode_sequence_number}}"},"collection":"Seasons","field":"episodes"}	\N
357	494	directus_fields	68	{"interface":"select-dropdown-m2o","special":"m2o","options":{"template":"{{episodes}}{{series.title}}"},"collection":"movies","field":"belongs_to_season"}	{"interface":"select-dropdown-m2o","special":"m2o","options":{"template":"{{episodes}}{{series.title}}"},"collection":"movies","field":"belongs_to_season"}	\N
358	495	directus_fields	69	{"interface":"list-o2m","special":"o2m","options":{"template":"{{movie_name}}"},"collection":"Seasons","field":"episodes"}	{"interface":"list-o2m","special":"o2m","options":{"template":"{{movie_name}}"},"collection":"Seasons","field":"episodes"}	\N
364	501	Seasons	79d1e44b-4286-4402-936d-ff0856ebc204	{"series":"3f381be8-edeb-4e06-b632-53891f64d617","episodes":["2285246a-e785-41b2-b12d-551291be126f","32cded58-4aa5-4c41-9144-3d507a5a6dff","41dabed9-f1f8-41e1-b585-036b54568b49","4b98565f-af11-48b6-9338-15b36a07414c","829a716a-715d-4e80-939f-e4e94de06476"]}	{"series":"3f381be8-edeb-4e06-b632-53891f64d617","episodes":["2285246a-e785-41b2-b12d-551291be126f","32cded58-4aa5-4c41-9144-3d507a5a6dff","41dabed9-f1f8-41e1-b585-036b54568b49","4b98565f-af11-48b6-9338-15b36a07414c","829a716a-715d-4e80-939f-e4e94de06476"]}	\N
359	496	movies	2285246a-e785-41b2-b12d-551291be126f	{"movie_id":"2285246a-e785-41b2-b12d-551291be126f","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-25T11:53:38.694Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.675Z","movie_name":"asdasd","movie_delivery_url":null,"movie_raw":"48e4683f-2c0e-4e07-87f1-1e4b02ab2eae","video_type":"false","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":null,"season_sequence_number":null,"custom_upload":null,"featured_image":"62d44ac9-4a92-4e21-a655-4a7e296fc933","belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","movie_images":[]}	{"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.675Z"}	364
360	497	movies	32cded58-4aa5-4c41-9144-3d507a5a6dff	{"movie_id":"32cded58-4aa5-4c41-9144-3d507a5a6dff","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-24T07:14:35.128Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.694Z","movie_name":"Test04a","movie_delivery_url":null,"movie_raw":"bfcbe12e-b226-42f3-8c9d-bc29eb2638c3","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":null,"season_sequence_number":null,"custom_upload":null,"featured_image":null,"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","movie_images":[4]}	{"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.694Z"}	364
361	498	movies	41dabed9-f1f8-41e1-b585-036b54568b49	{"movie_id":"41dabed9-f1f8-41e1-b585-036b54568b49","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2022-01-05T10:04:13.124Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.712Z","movie_name":"Taste if resr","movie_delivery_url":null,"movie_raw":"4a9464b4-49b8-4895-a47c-73b249186b15","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":"1","season_sequence_number":"2","custom_upload":null,"featured_image":null,"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","movie_images":[]}	{"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.712Z"}	364
362	499	movies	4b98565f-af11-48b6-9338-15b36a07414c	{"movie_id":"4b98565f-af11-48b6-9338-15b36a07414c","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-27T08:41:43.704Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.729Z","movie_name":"EPISODE 5","movie_delivery_url":null,"movie_raw":null,"video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":null,"season_sequence_number":null,"custom_upload":null,"featured_image":null,"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","movie_images":[]}	{"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.729Z"}	364
363	500	movies	829a716a-715d-4e80-939f-e4e94de06476	{"movie_id":"829a716a-715d-4e80-939f-e4e94de06476","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2021-12-23T08:55:45.575Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.745Z","movie_name":"movie test 3","movie_delivery_url":null,"movie_raw":"2bb7896d-ffe5-41ce-9fb5-7a09d563085f","video_type":"series","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episode_sequence_number":null,"season_sequence_number":null,"custom_upload":null,"featured_image":null,"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","movie_images":[]}	{"belongs_to_season":"79d1e44b-4286-4402-936d-ff0856ebc204","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:08.745Z"}	364
366	503	Seasons	79d1e44b-4286-4402-936d-ff0856ebc204	{"season_id":"79d1e44b-4286-4402-936d-ff0856ebc204","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2022-01-05T13:13:08.654Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:40.560Z","series":"3f381be8-edeb-4e06-b632-53891f64d617","title":"Season 1","episodes":["2285246a-e785-41b2-b12d-551291be126f","32cded58-4aa5-4c41-9144-3d507a5a6dff","41dabed9-f1f8-41e1-b585-036b54568b49","4b98565f-af11-48b6-9338-15b36a07414c","829a716a-715d-4e80-939f-e4e94de06476"]}	{"title":"Season 1","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:13:40.560Z"}	\N
367	504	directus_fields	71	{"interface":"list-o2m","special":"o2m","collection":"Series","field":"series_seasons"}	{"interface":"list-o2m","special":"o2m","collection":"Series","field":"series_seasons"}	\N
368	505	directus_fields	71	{"id":71,"collection":"Series","field":"series_seasons","special":["o2m"],"interface":"list-o2m","options":{"template":"{{title}}"},"display":"related-values","display_options":{"template":"{{series.title}}{{episodes.movie_name}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"Series","field":"series_seasons","special":["o2m"],"interface":"list-o2m","options":{"template":"{{title}}"},"display":"related-values","display_options":{"template":"{{series.title}}{{episodes.movie_name}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
369	506	directus_fields	68	{"id":68,"collection":"movies","field":"belongs_to_season","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{episodes}}{{series.title}}{{series.title}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"movies","field":"belongs_to_season","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{episodes}}{{series.title}}{{series.title}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
370	507	directus_fields	72	{"interface":"select-dropdown-m2o","special":"m2o","options":{"template":"{{title}}"},"collection":"Seasons","field":"belongs_to_series"}	{"interface":"select-dropdown-m2o","special":"m2o","options":{"template":"{{title}}"},"collection":"Seasons","field":"belongs_to_series"}	\N
371	508	Seasons	79d1e44b-4286-4402-936d-ff0856ebc204	{"season_id":"79d1e44b-4286-4402-936d-ff0856ebc204","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2022-01-05T13:13:08.654Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:23:02.510Z","title":"Season 1","belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","episodes":["2285246a-e785-41b2-b12d-551291be126f","32cded58-4aa5-4c41-9144-3d507a5a6dff","41dabed9-f1f8-41e1-b585-036b54568b49","4b98565f-af11-48b6-9338-15b36a07414c","829a716a-715d-4e80-939f-e4e94de06476"]}	{"belongs_to_series":"3f381be8-edeb-4e06-b632-53891f64d617","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:23:02.510Z"}	\N
373	510	movies	8c5dd6d2-b121-4c78-b160-b4018d65f889	{"movie_name":"new ep1","video_type":"series","belongs_to_season":"8cdbb08b-1b50-4f9a-a612-93389be4f389"}	{"movie_name":"new ep1","video_type":"series","belongs_to_season":"8cdbb08b-1b50-4f9a-a612-93389be4f389"}	374
375	512	directus_fields	74	{"interface":"list-o2m","special":"o2m","options":{"template":"{{title}}"},"collection":"Series","field":"has_seasons"}	{"interface":"list-o2m","special":"o2m","options":{"template":"{{title}}"},"collection":"Series","field":"has_seasons"}	\N
376	513	movies	c90ff1c2-7cc0-41e4-ba10-429615e876ce	{"movie_name":"episode 1","belongs_to_season":"35d3490a-9a81-4ab8-8f51-10807e64b667"}	{"movie_name":"episode 1","belongs_to_season":"35d3490a-9a81-4ab8-8f51-10807e64b667"}	379
377	514	movies	aa448f9d-699a-4d8c-9632-05ab4e3a68dd	{"movie_name":"episode 2","belongs_to_season":"35d3490a-9a81-4ab8-8f51-10807e64b667"}	{"movie_name":"episode 2","belongs_to_season":"35d3490a-9a81-4ab8-8f51-10807e64b667"}	379
378	515	movies	df1b3b93-9a6f-4d45-8ab6-85ea965ad872	{"movie_name":"episode 3","belongs_to_season":"35d3490a-9a81-4ab8-8f51-10807e64b667"}	{"movie_name":"episode 3","belongs_to_season":"35d3490a-9a81-4ab8-8f51-10807e64b667"}	379
380	517	Series	0e8f587c-116f-4055-9503-c3d2ca87057d	{"title":"new tv series","has_seasons":[{"title":"season 1","episodes":[{"movie_name":"episode 1"},{"movie_name":"episode 2"},{"movie_name":"episode 3"}]}]}	{"title":"new tv series","has_seasons":[{"title":"season 1","episodes":[{"movie_name":"episode 1"},{"movie_name":"episode 2"},{"movie_name":"episode 3"}]}]}	\N
379	516	Seasons	35d3490a-9a81-4ab8-8f51-10807e64b667	{"title":"season 1","episodes":[{"movie_name":"episode 1"},{"movie_name":"episode 2"},{"movie_name":"episode 3"}],"belongs_to_series":"0e8f587c-116f-4055-9503-c3d2ca87057d"}	{"title":"season 1","episodes":[{"movie_name":"episode 1"},{"movie_name":"episode 2"},{"movie_name":"episode 3"}],"belongs_to_series":"0e8f587c-116f-4055-9503-c3d2ca87057d"}	380
381	518	Series	0e8f587c-116f-4055-9503-c3d2ca87057d	{"series_id":"0e8f587c-116f-4055-9503-c3d2ca87057d","status":"draft","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2022-01-05T13:28:40.012Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:28:49.794Z","title":"Witcher","has_seasons":["35d3490a-9a81-4ab8-8f51-10807e64b667"]}	{"title":"Witcher","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:28:49.794Z"}	\N
382	519	movies	c792f950-e0fe-494c-b950-76e478130778	{"movie_name":"season2ep2","belongs_to_season":"b863b678-b037-4f46-9683-b8408984f1c3"}	{"movie_name":"season2ep2","belongs_to_season":"b863b678-b037-4f46-9683-b8408984f1c3"}	384
383	520	movies	49d75eb7-eadf-4af9-a6de-7b17bfce7504	{"movie_name":"season2epi3","belongs_to_season":"b863b678-b037-4f46-9683-b8408984f1c3"}	{"movie_name":"season2epi3","belongs_to_season":"b863b678-b037-4f46-9683-b8408984f1c3"}	384
385	522	Series	0e8f587c-116f-4055-9503-c3d2ca87057d	{"series_id":"0e8f587c-116f-4055-9503-c3d2ca87057d","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2022-01-05T13:28:40.012Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:29:16.317Z","title":"Witcher","has_seasons":["35d3490a-9a81-4ab8-8f51-10807e64b667","b863b678-b037-4f46-9683-b8408984f1c3"]}	{"status":"published","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-05T13:29:16.317Z"}	\N
384	521	Seasons	b863b678-b037-4f46-9683-b8408984f1c3	{"title":"Season 2","episodes":[{"movie_name":"season2ep2"},{"movie_name":"season2epi3"}],"belongs_to_series":"0e8f587c-116f-4055-9503-c3d2ca87057d"}	{"title":"Season 2","episodes":[{"movie_name":"season2ep2"},{"movie_name":"season2epi3"}],"belongs_to_series":"0e8f587c-116f-4055-9503-c3d2ca87057d"}	385
386	523	directus_fields	74	{"id":74,"collection":"Series","field":"has_seasons","special":["o2m"],"interface":"list-o2m","options":{"template":"{{title}}"},"display":"related-values","display_options":{"template":"{{title}}{{episodes}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	{"collection":"Series","field":"has_seasons","special":["o2m"],"interface":"list-o2m","options":{"template":"{{title}}"},"display":"related-values","display_options":{"template":"{{title}}{{episodes}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null}	\N
387	526	movies	98de8de0-aa51-48f8-aebd-3112068e441c	{"movie_name":"e01","belongs_to_season":"7ff4d915-f55f-4cf3-a79e-18ccf3072c02"}	{"movie_name":"e01","belongs_to_season":"7ff4d915-f55f-4cf3-a79e-18ccf3072c02"}	390
388	527	movies	d38e226a-ed8d-4673-8b64-5dc0116e8613	{"movie_name":"e02","belongs_to_season":"7ff4d915-f55f-4cf3-a79e-18ccf3072c02"}	{"movie_name":"e02","belongs_to_season":"7ff4d915-f55f-4cf3-a79e-18ccf3072c02"}	390
389	528	movies	7bb86a1b-3c88-4c03-86c2-fb838cb4868e	{"movie_name":"e03","belongs_to_season":"7ff4d915-f55f-4cf3-a79e-18ccf3072c02"}	{"movie_name":"e03","belongs_to_season":"7ff4d915-f55f-4cf3-a79e-18ccf3072c02"}	390
391	530	movies	20bc3149-a384-43c2-a955-d369d13c3ee3	{"movie_name":"wS02e01","belongs_to_season":"4eafd382-987c-46be-9c31-5cc570cbe502"}	{"movie_name":"wS02e01","belongs_to_season":"4eafd382-987c-46be-9c31-5cc570cbe502"}	393
392	531	movies	ff7cb93b-7c87-46cd-a1a2-7d3d7f10bf25	{"movie_name":"wS02e02","belongs_to_season":"4eafd382-987c-46be-9c31-5cc570cbe502"}	{"movie_name":"wS02e02","belongs_to_season":"4eafd382-987c-46be-9c31-5cc570cbe502"}	393
394	533	Series	2e1cf223-ea4e-4657-b1cf-6ca5af957b88	{"title":"The Witcher","has_seasons":[{"title":"Witcher S1","episodes":[{"movie_name":"e01"},{"movie_name":"e02"},{"movie_name":"e03"}]},{"title":"Witcher S2","episodes":[{"movie_name":"wS02e01"},{"movie_name":"wS02e02"}]}]}	{"title":"The Witcher","has_seasons":[{"title":"Witcher S1","episodes":[{"movie_name":"e01"},{"movie_name":"e02"},{"movie_name":"e03"}]},{"title":"Witcher S2","episodes":[{"movie_name":"wS02e01"},{"movie_name":"wS02e02"}]}]}	\N
390	529	Seasons	7ff4d915-f55f-4cf3-a79e-18ccf3072c02	{"title":"Witcher S1","episodes":[{"movie_name":"e01"},{"movie_name":"e02"},{"movie_name":"e03"}],"belongs_to_series":"2e1cf223-ea4e-4657-b1cf-6ca5af957b88"}	{"title":"Witcher S1","episodes":[{"movie_name":"e01"},{"movie_name":"e02"},{"movie_name":"e03"}],"belongs_to_series":"2e1cf223-ea4e-4657-b1cf-6ca5af957b88"}	394
393	532	Seasons	4eafd382-987c-46be-9c31-5cc570cbe502	{"title":"Witcher S2","episodes":[{"movie_name":"wS02e01"},{"movie_name":"wS02e02"}],"belongs_to_series":"2e1cf223-ea4e-4657-b1cf-6ca5af957b88"}	{"title":"Witcher S2","episodes":[{"movie_name":"wS02e01"},{"movie_name":"wS02e02"}],"belongs_to_series":"2e1cf223-ea4e-4657-b1cf-6ca5af957b88"}	394
395	535	movies	5eff00c4-52ad-45c2-8115-6f1990b14c05	{"movie_name":"witcher s01e01","belongs_to_season":"e88d880b-7add-4260-abda-0fb211623bb3"}	{"movie_name":"witcher s01e01","belongs_to_season":"e88d880b-7add-4260-abda-0fb211623bb3"}	398
396	536	movies	e8de4197-1b7a-4250-9c67-324bd41b4a2c	{"movie_name":"witcher s01e02","belongs_to_season":"e88d880b-7add-4260-abda-0fb211623bb3"}	{"movie_name":"witcher s01e02","belongs_to_season":"e88d880b-7add-4260-abda-0fb211623bb3"}	398
397	537	movies	fbc5afe6-417b-4ca8-8fbc-dfbf9b4a326d	{"movie_name":"witcher s01e03","belongs_to_season":"e88d880b-7add-4260-abda-0fb211623bb3"}	{"movie_name":"witcher s01e03","belongs_to_season":"e88d880b-7add-4260-abda-0fb211623bb3"}	398
399	539	Series	eabcb137-667b-40b1-b472-0344e31a6fd3	{"status":"published","title":"Witcher TV Series","has_seasons":[{"title":"Witcher Season 1","episodes":[{"movie_name":"witcher s01e01"},{"movie_name":"witcher s01e02"},{"movie_name":"witcher s01e03"}]}]}	{"status":"published","title":"Witcher TV Series","has_seasons":[{"title":"Witcher Season 1","episodes":[{"movie_name":"witcher s01e01"},{"movie_name":"witcher s01e02"},{"movie_name":"witcher s01e03"}]}]}	\N
398	538	Seasons	e88d880b-7add-4260-abda-0fb211623bb3	{"title":"Witcher Season 1","episodes":[{"movie_name":"witcher s01e01"},{"movie_name":"witcher s01e02"},{"movie_name":"witcher s01e03"}],"belongs_to_series":"eabcb137-667b-40b1-b472-0344e31a6fd3"}	{"title":"Witcher Season 1","episodes":[{"movie_name":"witcher s01e01"},{"movie_name":"witcher s01e02"},{"movie_name":"witcher s01e03"}],"belongs_to_series":"eabcb137-667b-40b1-b472-0344e31a6fd3"}	399
400	540	movies	cffc85ac-f978-4fbd-9ec0-847af986a727	{"movie_name":"witcher s0201","belongs_to_season":"05a4d7e4-c266-450e-b270-84f0ff3cc16e"}	{"movie_name":"witcher s0201","belongs_to_season":"05a4d7e4-c266-450e-b270-84f0ff3cc16e"}	401
402	542	Series	eabcb137-667b-40b1-b472-0344e31a6fd3	{"series_id":"eabcb137-667b-40b1-b472-0344e31a6fd3","status":"published","sort":null,"user_created":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_created":"2022-01-06T06:35:12.857Z","user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-06T06:35:58.353Z","title":"Witcher TV Series","has_seasons":["05a4d7e4-c266-450e-b270-84f0ff3cc16e","e88d880b-7add-4260-abda-0fb211623bb3"]}	{"user_updated":"98a497c1-4bd6-422d-aca0-bda2dd5b6aea","date_updated":"2022-01-06T06:35:58.353Z"}	\N
401	541	Seasons	05a4d7e4-c266-450e-b270-84f0ff3cc16e	{"title":"Witcher Season 2","episodes":[{"movie_name":"witcher s0201"}],"belongs_to_series":"eabcb137-667b-40b1-b472-0344e31a6fd3"}	{"title":"Witcher Season 2","episodes":[{"movie_name":"witcher s0201"}],"belongs_to_series":"eabcb137-667b-40b1-b472-0344e31a6fd3"}	402
403	544	directus_permissions	140	{"role":null,"collection":"Seasons","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Seasons","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
404	545	directus_permissions	141	{"role":null,"collection":"Series","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Series","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
405	546	directus_permissions	142	{"role":null,"collection":"Series_seasons","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Series_seasons","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
406	547	directus_permissions	143	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"Seasons","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"Seasons","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
407	548	directus_permissions	144	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"Series","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"Series","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
408	549	directus_permissions	145	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"Series_seasons","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":"537e43d3-2620-4e81-9aa0-ccfe797a87e8","collection":"Series_seasons","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
409	551	directus_collections	Series_seasons	{"collection":"Series_seasons","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"hidden":false}	\N
410	552	directus_collections	Series_seasons	{"collection":"Series_seasons","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open"}	{"hidden":true}	\N
411	555	movies	06c2fe5b-f3bc-4b9a-9647-2e697e273177	{"movie_name":"episode 1 wire","belongs_to_season":"363e7496-4bb9-47ba-9120-ff8f12363f5c"}	{"movie_name":"episode 1 wire","belongs_to_season":"363e7496-4bb9-47ba-9120-ff8f12363f5c"}	412
413	557	Series	0bd3ff80-5270-4839-867b-817b42cff869	{"title":"the wire","has_seasons":[{"title":"wire season 1","episodes":[{"movie_name":"episode 1 wire"}]}]}	{"title":"the wire","has_seasons":[{"title":"wire season 1","episodes":[{"movie_name":"episode 1 wire"}]}]}	\N
412	556	Seasons	363e7496-4bb9-47ba-9120-ff8f12363f5c	{"title":"wire season 1","episodes":[{"movie_name":"episode 1 wire"}],"belongs_to_series":"0bd3ff80-5270-4839-867b-817b42cff869"}	{"title":"wire season 1","episodes":[{"movie_name":"episode 1 wire"}],"belongs_to_series":"0bd3ff80-5270-4839-867b-817b42cff869"}	413
414	558	directus_collections	testmodel	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"testmodel"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"testmodel"}	\N
415	559	directus_fields	75	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"id","collection":"testmodel"}	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"id","collection":"testmodel"}	\N
416	560	directus_fields	76	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"testmodel"}	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"testmodel"}	\N
417	561	directus_fields	77	{"interface":"input","hidden":true,"field":"sort","collection":"testmodel"}	{"interface":"input","hidden":true,"field":"sort","collection":"testmodel"}	\N
418	562	directus_fields	78	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"testmodel"}	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"testmodel"}	\N
419	563	directus_fields	79	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"testmodel"}	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"testmodel"}	\N
420	564	directus_fields	80	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"testmodel"}	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"testmodel"}	\N
421	565	directus_fields	81	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"testmodel"}	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"testmodel"}	\N
422	566	directus_fields	82	{"interface":"input","special":null,"collection":"testmodel","field":"title"}	{"interface":"input","special":null,"collection":"testmodel","field":"title"}	\N
423	567	testmodel	b5d18660-7e16-4dff-8bfc-323415eb6f0c	{"title":"testmo1"}	{"title":"testmo1"}	\N
424	568	testmodel	3cd66cbe-f843-48bd-bbe6-e6abe76b0a11	{"title":"testmo2"}	{"title":"testmo2"}	\N
425	570	directus_fields	83	{"interface":"list-o2m","special":"o2m","options":{"template":"{{movie_name}}"},"collection":"testmodel","field":"tes_moviesrel"}	{"interface":"list-o2m","special":"o2m","options":{"template":"{{movie_name}}"},"collection":"testmodel","field":"tes_moviesrel"}	\N
426	571	directus_fields	84	{"interface":"list-o2m","special":"o2m","options":{"template":"{{movie_name}}"},"collection":"testmodel","field":"moies_test"}	{"interface":"list-o2m","special":"o2m","options":{"template":"{{movie_name}}"},"collection":"testmodel","field":"moies_test"}	\N
427	572	directus_collections	test_movies	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"test_movies"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"test_movies"}	\N
428	573	directus_fields	85	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"id","collection":"test_movies"}	{"hidden":true,"readonly":true,"interface":"input","special":"uuid","field":"id","collection":"test_movies"}	\N
429	574	directus_fields	86	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"test_movies"}	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#00C897","value":"published"},{"background":"#D3DAE4","value":"draft"},{"background":"#F7971C","value":"archived"}]},"field":"status","collection":"test_movies"}	\N
430	575	directus_fields	87	{"interface":"input","hidden":true,"field":"sort","collection":"test_movies"}	{"interface":"input","hidden":true,"field":"sort","collection":"test_movies"}	\N
431	576	directus_fields	88	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"test_movies"}	{"special":"user-created","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"test_movies"}	\N
432	577	directus_fields	89	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"test_movies"}	{"special":"date-created","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"test_movies"}	\N
433	578	directus_fields	90	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"test_movies"}	{"special":"user-updated","interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"test_movies"}	\N
434	579	directus_fields	91	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"test_movies"}	{"special":"date-updated","interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"test_movies"}	\N
435	580	directus_fields	92	{"interface":"input","special":null,"collection":"test_movies","field":"title"}	{"interface":"input","special":null,"collection":"test_movies","field":"title"}	\N
436	581	directus_fields	93	{"interface":"select-dropdown-m2o","special":"m2o","options":{"template":"{{title}}"},"collection":"test_movies","field":"models_testing"}	{"interface":"select-dropdown-m2o","special":"m2o","options":{"template":"{{title}}"},"collection":"test_movies","field":"models_testing"}	\N
437	582	directus_fields	94	{"interface":"list-o2m","special":"o2m","options":{"template":"{{title}}"},"collection":"testmodel","field":"models_movies_test"}	{"interface":"list-o2m","special":"o2m","options":{"template":"{{title}}"},"collection":"testmodel","field":"models_movies_test"}	\N
438	583	test_movies	11af55ed-8176-4919-86a8-ecf15a0b7eff	{"title":"testing movie 1","models_testing":"b5d18660-7e16-4dff-8bfc-323415eb6f0c"}	{"title":"testing movie 1","models_testing":"b5d18660-7e16-4dff-8bfc-323415eb6f0c"}	\N
439	585	directus_collections	Blog	{"singleton":false,"collection":"Blog"}	{"singleton":false,"collection":"Blog"}	\N
440	586	directus_fields	95	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Blog"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Blog"}	\N
441	588	directus_collections	Blog	{"collection":"Blog"}	{"collection":"Blog"}	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
4d5db58f-f81f-4a31-8898-89164ebadfcd	Administrator	verified	Initial administrative role with unrestricted App/API access	\N	f	t	t
ae207ac2-df88-4c99-98ce-6fcc33fe6f48	Subscriber	supervised_user_circle	app subscriber	\N	f	f	f
537e43d3-2620-4e81-9aa0-ccfe797a87e8	Publisher	supervised_user_circle	\N	\N	f	f	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, data) FROM stdin;
kJcaDpHctWJD2zMEKuIY5TyNNBpJiM7XKOzcHBi_mGpXeOGDDuRRUsqCgS7beKDJ	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-13 06:36:39.584+00	::1	PostmanRuntime/7.26.8	\N
sK_lcw7XEgipWfx8vdedo7Sb55WRu3wLyclC3Bum6xZQ-b2lqyrH-PFp9RguuOPB	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-13 06:59:22.476+00	::1	PostmanRuntime/7.26.8	\N
VB3j1jP8owd4lNVPORjqT53XilQT09CgYAwOwhQPbs5qgbhLns6vCQSWsarnUKSq	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-13 07:07:08.533+00	::1	PostmanRuntime/7.26.8	\N
VR-LeUIGXgLAcfOBHXPIZADsBfAw8gLIS4iixzBPiQod4wndORwG1E-CG9H8epy1	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-13 07:25:59.955+00	::1	PostmanRuntime/7.26.8	\N
D0IfSLLNNVvjOQRsuGvnDJrEBHW7eXDRsBqiMu8ob6MXoRhEXWdHpAOQXa5MgJ7n	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-13 07:32:32.37+00	::1	PostmanRuntime/7.26.8	\N
Tjlu4f-PBDMORp0RCuXtElixTyeP27LG6gBImVDYI2GEMsKiN_mK_O7oK8Unr9wg	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-15 09:40:19.692+00	::1	PostmanRuntime/7.26.8	\N
QJY3QqxHS6LmZJz-aiK6pB6CGwYQODYGiapJxkOzGyHXyJNNHhg79izGzSFEmtUx	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-15 09:58:12.345+00	::1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar) FROM stdin;
1	Directus	\N	#3A313A	e9147cba-4198-4ac5-a149-94ce6b9b206d	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications) FROM stdin;
14812d91-421e-438c-a5f5-58bcd87bf218	Publisher	Test	publisher1@skara.live	$argon2i$v=19$m=4096,t=3,p=1$TbmpCOG5ix3guDcsnfNzxA$5ypouEXyvsbDMhnm+YgOYA8xHD0u1lV4LMejW6Kc9tE	\N	\N	\N	\N	\N	en-US	auto	\N	active	537e43d3-2620-4e81-9aa0-ccfe797a87e8	\N	2021-12-20 06:55:22.089+00	/docs/app/overview	default	\N	\N	t
a224d75d-5da8-4450-9e66-f9ef53a16e45	Second	Subscriber	subscriber2@skara.live	$argon2i$v=19$m=4096,t=3,p=1$mLa3w1hWM0OaXvPgZW7GTQ$WvBPfHX4T99iclByOXkBNgZiP6K+rCYPiIfJW/PGe7A	\N	\N	\N	\N	\N	en-US	auto	\N	active	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	\N	2021-12-16 11:11:38.346+00	\N	default	\N	\N	t
49eab1e1-ec46-41da-a5e7-92ad20d5e045	Admin	User2	admin2@flixbox.com	$argon2i$v=19$m=4096,t=3,p=1$6TPcDhg2agY0PVkTzhF8Qg$h46tFy+p5FBconTs2sr88knNZycTVc9G1wYedO3huRU	\N	\N	\N	\N	\N	en-US	auto	\N	suspended	\N	\N	2021-12-15 08:41:15.507+00	\N	default	\N	\N	t
98a497c1-4bd6-422d-aca0-bda2dd5b6aea	Admin	User	admin@flixbox.com	$argon2i$v=19$m=4096,t=3,p=1$XhL7dNOohTY0KOU4vB+aGg$In29apQnXfDZ5nGH6B4clALyQYoGBE1YQfgX6zMPuas	\N	\N	\N	\N	\N	en-US	auto	\N	active	4d5db58f-f81f-4a31-8898-89164ebadfcd	\N	2022-01-08 09:58:12.365+00	/settings/roles/537e43d3-2620-4e81-9aa0-ccfe797a87e8	default	\N	\N	t
2b8f7583-40f0-4b4c-a8fc-c606533a736a	First	Subscriber	subscriber1@skara.live	$argon2i$v=19$m=4096,t=3,p=1$034L05ououxXjQ4+hrYlWw$Qr/7RoXoBeNRVNAiZ2DqeDErRZ/TFeZ4mwxk+u+iIEA	\N	\N	\N	\N	\N	en-US	auto	\N	active	ae207ac2-df88-4c99-98ce-6fcc33fe6f48	\N	2021-12-16 13:21:26.347+00	/content	default	\N	\N	t
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, name, batch, migration_time) FROM stdin;
1	20211024080314_CreateProjects.ts	1	2021-10-28 09:10:02.376+00
2	20211024080428_CreateItems.ts	1	2021-10-28 09:10:02.469+00
3	20211027084953_02-dropProjectTagColumn.ts	1	2021-10-28 09:10:02.471+00
4	20211027085759_03-addProjectTags.ts	1	2021-10-28 09:10:02.477+00
5	20211027090252_04-removeProjectTag.ts	1	2021-10-28 09:10:02.48+00
6	20211027091241_05-phoneTypeNumber.ts	1	2021-10-28 09:10:02.655+00
\.


--
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (movie_id, status, sort, user_created, date_created, user_updated, date_updated, movie_name, movie_delivery_url, movie_raw, video_type, episode_sequence_number, season_sequence_number, custom_upload, featured_image, belongs_to_season) FROM stdin;
e86e5d68-3d9b-466e-b8bd-7486f0a0f082	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:56:44.38+00	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:03:27.783+00	tes333asdasdasdasd	\N	fcb5c6c9-ee19-4f12-ac74-d7edc1ac7b7b	false	\N	\N	\N	\N	\N
aa71595e-cda1-400a-9c4b-748b17ac976d	published	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 08:47:13.715+00	\N	\N	mediaconv test 01	[{"resolution":"1080","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/41b17364-9a34-48f0-afcc-e78bd8d43cfb/41b17364-9a34-48f0-afcc-e78bd8d43cfb_3000.m3u8"},{"resolution":"540","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/41b17364-9a34-48f0-afcc-e78bd8d43cfb/41b17364-9a34-48f0-afcc-e78bd8d43cfb_1500.m3u8"},{"resolution":"480","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/41b17364-9a34-48f0-afcc-e78bd8d43cfb/41b17364-9a34-48f0-afcc-e78bd8d43cfb_750.m3u8"},{"resolution":"360","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/41b17364-9a34-48f0-afcc-e78bd8d43cfb/41b17364-9a34-48f0-afcc-e78bd8d43cfb_325.m3u8"}]	41b17364-9a34-48f0-afcc-e78bd8d43cfb	false	\N	\N	\N	\N	\N
f7391c37-5612-4fe8-8bf0-bb0aa72685f1	published	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:01:59.055+00	\N	\N	create one more	\N	\N	false	\N	\N	\N	\N	\N
72e3eb36-64a6-441a-898b-bfbf1c376159	published	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-25 12:25:33.39+00	\N	\N	as fnsvSD SGND	\N	1c2b532c-f15a-4868-a335-96b4ece15a41	false	\N	\N	\N	\N	\N
06c2fe5b-f3bc-4b9a-9647-2e697e273177	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:11:00.863+00	\N	\N	episode 1 wire	\N	\N	movie	\N	\N	\N	\N	363e7496-4bb9-47ba-9120-ff8f12363f5c
dd703c7c-3aae-4d0c-883d-dd6b199939e3	published	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-24 07:26:40.602+00	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:12.4+00	Movie with url 1	[{"resolution":"1080","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_3000.m3u8"},{"resolution":"540","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_1500.m3u8"},{"resolution":"480","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_750.m3u8"},{"resolution":"360","url":"https://myvodservice-dev-output-tmoou92z.s3.ap-south-1.amazonaws.com/83708ad1-7763-4ac9-8d17-6ffb4a3de293/83708ad1-7763-4ac9-8d17-6ffb4a3de293_325.m3u8"}]	83708ad1-7763-4ac9-8d17-6ffb4a3de293	series	\N	\N	\N	\N	\N
ea7079e7-bb67-4829-90a3-a82401680a4c	published	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:42:02.1+00	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 08:44:12.416+00	Test Upload 1	\N	37827f87-7636-41da-9fd6-4681e3ab1e6c	series	\N	\N	\N	\N	\N
578206c0-4323-495c-8fc5-374ea322f2c2	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-23 08:55:05.131+00	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-27 09:39:25.215+00	some movie test 002	\N	6e9ac6ff-a7c1-456f-bd8c-a824073bd244	movie	\N	\N	\N	\N	\N
cdf84f22-7f5c-4d58-9593-8558d10d5530	published	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2021-12-28 07:16:04.418+00	\N	\N	test09	\N	6214ebfd-f53d-4310-b9f3-a5a2e208dbf0	series	\N	\N	\N	\N	\N
c90ff1c2-7cc0-41e4-ba10-429615e876ce	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:40.022+00	\N	\N	episode 1	\N	\N	movie	\N	\N	\N	\N	\N
aa448f9d-699a-4d8c-9632-05ab4e3a68dd	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:40.032+00	\N	\N	episode 2	\N	\N	movie	\N	\N	\N	\N	\N
df1b3b93-9a6f-4d45-8ab6-85ea965ad872	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:28:40.042+00	\N	\N	episode 3	\N	\N	movie	\N	\N	\N	\N	\N
c792f950-e0fe-494c-b950-76e478130778	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:29:16.329+00	\N	\N	season2ep2	\N	\N	movie	\N	\N	\N	\N	\N
49d75eb7-eadf-4af9-a6de-7b17bfce7504	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-05 13:29:16.338+00	\N	\N	season2epi3	\N	\N	movie	\N	\N	\N	\N	\N
5eff00c4-52ad-45c2-8115-6f1990b14c05	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.869+00	\N	\N	witcher s01e01	\N	\N	movie	\N	\N	\N	\N	e88d880b-7add-4260-abda-0fb211623bb3
e8de4197-1b7a-4250-9c67-324bd41b4a2c	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.884+00	\N	\N	witcher s01e02	\N	\N	movie	\N	\N	\N	\N	e88d880b-7add-4260-abda-0fb211623bb3
fbc5afe6-417b-4ca8-8fbc-dfbf9b4a326d	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:12.89+00	\N	\N	witcher s01e03	\N	\N	movie	\N	\N	\N	\N	e88d880b-7add-4260-abda-0fb211623bb3
cffc85ac-f978-4fbd-9ec0-847af986a727	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 06:35:58.364+00	\N	\N	witcher s0201	\N	\N	movie	\N	\N	\N	\N	05a4d7e4-c266-450e-b270-84f0ff3cc16e
\.


--
-- Data for Name: movies_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies_files (id, movies_movie_id, directus_files_id) FROM stdin;
1	\N	d80cc677-8481-4923-825c-fecf5b342ceb
2	\N	3faabca9-0406-4ef6-be23-c1ca857ebdfe
3	\N	2dc325d0-7998-43bd-884f-f98d8e293ecf
4	\N	ee64a57e-c550-46e4-bace-74860f357ef3
\.


--
-- Data for Name: movies_undefined; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies_undefined (id, movies_movie_id, item, collection) FROM stdin;
\.


--
-- Data for Name: test_movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_movies (id, status, sort, user_created, date_created, user_updated, date_updated, title, models_testing) FROM stdin;
11af55ed-8176-4919-86a8-ecf15a0b7eff	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:32:27.977+00	\N	\N	testing movie 1	b5d18660-7e16-4dff-8bfc-323415eb6f0c
\.


--
-- Data for Name: testmodel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testmodel (id, status, sort, user_created, date_created, user_updated, date_updated, title) FROM stdin;
b5d18660-7e16-4dff-8bfc-323415eb6f0c	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:46.618+00	\N	\N	testmo1
3cd66cbe-f843-48bd-bbe6-e6abe76b0a11	draft	\N	98a497c1-4bd6-422d-aca0-bda2dd5b6aea	2022-01-06 07:25:52.741+00	\N	\N	testmo2
\.


--
-- Name: Series_seasons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Series_seasons_id_seq"', 1, false);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 589, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 95, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 145, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 45, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 22, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 441, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 2, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 33, true);


--
-- Name: migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_lock_index_seq', 33, true);


--
-- Name: movies_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_files_id_seq', 4, true);


--
-- Name: movies_undefined_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_undefined_id_seq', 1, false);


--
-- Name: Seasons Seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seasons"
    ADD CONSTRAINT "Seasons_pkey" PRIMARY KEY (season_id);


--
-- Name: Series Series_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Series"
    ADD CONSTRAINT "Series_pkey" PRIMARY KEY (series_id);


--
-- Name: Series_seasons Series_seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Series_seasons"
    ADD CONSTRAINT "Series_seasons_pkey" PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (index);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: movies_files movies_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_files
    ADD CONSTRAINT movies_files_pkey PRIMARY KEY (id);


--
-- Name: movies movies_movie_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_movie_name_unique UNIQUE (movie_name);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movie_id);


--
-- Name: movies_undefined movies_undefined_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_undefined
    ADD CONSTRAINT movies_undefined_pkey PRIMARY KEY (id);


--
-- Name: test_movies test_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_movies
    ADD CONSTRAINT test_movies_pkey PRIMARY KEY (id);


--
-- Name: testmodel testmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testmodel
    ADD CONSTRAINT testmodel_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: movies movies_belongs_to_season_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_belongs_to_season_foreign FOREIGN KEY (belongs_to_season) REFERENCES public."Seasons"(season_id) ON DELETE CASCADE;


--
-- Name: movies movies_custom_upload_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_custom_upload_foreign FOREIGN KEY (custom_upload) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: movies movies_featured_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_featured_image_foreign FOREIGN KEY (featured_image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: movies_files movies_files_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_files
    ADD CONSTRAINT movies_files_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: movies_files movies_files_movies_movie_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_files
    ADD CONSTRAINT movies_files_movies_movie_id_foreign FOREIGN KEY (movies_movie_id) REFERENCES public.movies(movie_id) ON DELETE SET NULL;


--
-- Name: movies movies_movie_raw_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_movie_raw_foreign FOREIGN KEY (movie_raw) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: movies movies_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: movies movies_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: Seasons seasons_belongs_to_series_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seasons"
    ADD CONSTRAINT seasons_belongs_to_series_foreign FOREIGN KEY (belongs_to_series) REFERENCES public."Series"(series_id) ON DELETE CASCADE;


--
-- Name: Seasons seasons_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seasons"
    ADD CONSTRAINT seasons_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: Seasons seasons_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seasons"
    ADD CONSTRAINT seasons_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: Series_seasons series_seasons_series_series_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Series_seasons"
    ADD CONSTRAINT series_seasons_series_series_id_foreign FOREIGN KEY ("Series_series_id") REFERENCES public."Series"(series_id) ON DELETE SET NULL;


--
-- Name: Series series_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Series"
    ADD CONSTRAINT series_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: Series series_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Series"
    ADD CONSTRAINT series_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: test_movies test_movies_models_testing_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_movies
    ADD CONSTRAINT test_movies_models_testing_foreign FOREIGN KEY (models_testing) REFERENCES public.testmodel(id) ON DELETE SET NULL;


--
-- Name: test_movies test_movies_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_movies
    ADD CONSTRAINT test_movies_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: test_movies test_movies_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_movies
    ADD CONSTRAINT test_movies_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: testmodel testmodel_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testmodel
    ADD CONSTRAINT testmodel_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: testmodel testmodel_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testmodel
    ADD CONSTRAINT testmodel_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.18 (Debian 10.18-1.pgdg90+1)
-- Dumped by pg_dump version 10.18 (Debian 10.18-1.pgdg90+1)

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

