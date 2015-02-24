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
-- Name: blueforest; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA blueforest;


--
-- Name: carbon; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA carbon;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = blueforest, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admins; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE admins (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: areas_of_interest; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE areas_of_interest (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    workspace_id integer NOT NULL,
    is_summary boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    properties json
);


--
-- Name: areas_of_interest_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE areas_of_interest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: areas_of_interest_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE areas_of_interest_id_seq OWNED BY areas_of_interest.id;


--
-- Name: polygon_uploads; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE polygon_uploads (
    id integer NOT NULL,
    filename text,
    state character varying(255),
    message text,
    area_of_interest_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    table_name character varying(255)
);


--
-- Name: polygon_uploads_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE polygon_uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: polygon_uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE polygon_uploads_id_seq OWNED BY polygon_uploads.id;


--
-- Name: polygons; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE polygons (
    id integer NOT NULL,
    geometry text NOT NULL,
    area_of_interest_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: polygons_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE polygons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: polygons_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE polygons_id_seq OWNED BY polygons.id;


--
-- Name: project_layers; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE project_layers (
    id integer NOT NULL,
    display_name character varying(255),
    type character varying(255),
    tile_url character varying(255),
    is_displayed boolean,
    provider_id integer DEFAULT 1,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_layers_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE project_layers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_layers_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE project_layers_id_seq OWNED BY project_layers.id;


--
-- Name: projects; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: results; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE results (
    id integer NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    area_of_interest_id integer,
    statistic_id integer,
    type character varying(255),
    error_message character varying(255),
    error_stack text,
    value_updated_at timestamp without time zone
);


--
-- Name: results_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE results_id_seq OWNED BY results.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: statistics; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE statistics (
    id integer NOT NULL,
    display_name character varying(255) NOT NULL,
    unit character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    project_layer_id integer,
    operation character varying(255)
);


--
-- Name: statistics_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE statistics_id_seq OWNED BY statistics.id;


--
-- Name: workspaces; Type: TABLE; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE TABLE workspaces (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: workspaces_id_seq; Type: SEQUENCE; Schema: blueforest; Owner: -
--

CREATE SEQUENCE workspaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspaces_id_seq; Type: SEQUENCE OWNED BY; Schema: blueforest; Owner: -
--

ALTER SEQUENCE workspaces_id_seq OWNED BY workspaces.id;


SET search_path = carbon, pg_catalog;

--
-- Name: admins; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE admins (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: areas_of_interest; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE areas_of_interest (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    workspace_id integer NOT NULL,
    is_summary boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    properties json
);


--
-- Name: areas_of_interest_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE areas_of_interest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: areas_of_interest_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE areas_of_interest_id_seq OWNED BY areas_of_interest.id;


--
-- Name: polygon_uploads; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE polygon_uploads (
    id integer NOT NULL,
    filename text,
    state character varying(255),
    message text,
    area_of_interest_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    table_name character varying(255)
);


--
-- Name: polygon_uploads_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE polygon_uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: polygon_uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE polygon_uploads_id_seq OWNED BY polygon_uploads.id;


--
-- Name: polygons; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE polygons (
    id integer NOT NULL,
    geometry text NOT NULL,
    area_of_interest_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: polygons_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE polygons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: polygons_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE polygons_id_seq OWNED BY polygons.id;


--
-- Name: project_layers; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE project_layers (
    id integer NOT NULL,
    display_name character varying(255),
    type character varying(255),
    tile_url character varying(255),
    is_displayed boolean,
    provider_id integer DEFAULT 1,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_layers_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE project_layers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_layers_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE project_layers_id_seq OWNED BY project_layers.id;


--
-- Name: projects; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: results; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE results (
    id integer NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    area_of_interest_id integer,
    statistic_id integer,
    type character varying(255),
    error_message character varying(255),
    error_stack text,
    value_updated_at timestamp without time zone
);


--
-- Name: results_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE results_id_seq OWNED BY results.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: statistics; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE statistics (
    id integer NOT NULL,
    display_name character varying(255) NOT NULL,
    unit character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    project_layer_id integer,
    operation character varying(255)
);


--
-- Name: statistics_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE statistics_id_seq OWNED BY statistics.id;


--
-- Name: workspaces; Type: TABLE; Schema: carbon; Owner: -; Tablespace: 
--

CREATE TABLE workspaces (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: workspaces_id_seq; Type: SEQUENCE; Schema: carbon; Owner: -
--

CREATE SEQUENCE workspaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspaces_id_seq; Type: SEQUENCE OWNED BY; Schema: carbon; Owner: -
--

ALTER SEQUENCE workspaces_id_seq OWNED BY workspaces.id;


SET search_path = public, pg_catalog;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admins (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: areas_of_interest; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE areas_of_interest (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    workspace_id integer NOT NULL,
    is_summary boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    properties hstore
);


--
-- Name: areas_of_interest_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE areas_of_interest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: areas_of_interest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE areas_of_interest_id_seq OWNED BY areas_of_interest.id;


--
-- Name: polygon_uploads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE polygon_uploads (
    id integer NOT NULL,
    filename text,
    state character varying(255),
    message text,
    area_of_interest_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    table_name character varying(255)
);


--
-- Name: polygon_uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE polygon_uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: polygon_uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE polygon_uploads_id_seq OWNED BY polygon_uploads.id;


--
-- Name: polygons; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE polygons (
    id integer NOT NULL,
    geometry text NOT NULL,
    area_of_interest_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: polygons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE polygons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: polygons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE polygons_id_seq OWNED BY polygons.id;


--
-- Name: project_layers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_layers (
    id integer NOT NULL,
    display_name character varying(255),
    type character varying(255),
    tile_url character varying(255),
    is_displayed boolean,
    provider_id integer DEFAULT 1,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_layers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_layers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_layers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_layers_id_seq OWNED BY project_layers.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: results; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE results (
    id integer NOT NULL,
    value text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    area_of_interest_id integer,
    statistic_id integer,
    type character varying(255),
    error_message character varying(255),
    error_stack text,
    value_updated_at timestamp without time zone
);


--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE results_id_seq OWNED BY results.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: statistics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE statistics (
    id integer NOT NULL,
    display_name character varying(255) NOT NULL,
    unit character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    project_layer_id integer,
    operation character varying(255)
);


--
-- Name: statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE statistics_id_seq OWNED BY statistics.id;


--
-- Name: workspaces; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE workspaces (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: workspaces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE workspaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE workspaces_id_seq OWNED BY workspaces.id;


SET search_path = blueforest, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY areas_of_interest ALTER COLUMN id SET DEFAULT nextval('areas_of_interest_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY polygon_uploads ALTER COLUMN id SET DEFAULT nextval('polygon_uploads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY polygons ALTER COLUMN id SET DEFAULT nextval('polygons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY project_layers ALTER COLUMN id SET DEFAULT nextval('project_layers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY statistics ALTER COLUMN id SET DEFAULT nextval('statistics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: blueforest; Owner: -
--

ALTER TABLE ONLY workspaces ALTER COLUMN id SET DEFAULT nextval('workspaces_id_seq'::regclass);


SET search_path = carbon, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY areas_of_interest ALTER COLUMN id SET DEFAULT nextval('areas_of_interest_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY polygon_uploads ALTER COLUMN id SET DEFAULT nextval('polygon_uploads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY polygons ALTER COLUMN id SET DEFAULT nextval('polygons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY project_layers ALTER COLUMN id SET DEFAULT nextval('project_layers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY statistics ALTER COLUMN id SET DEFAULT nextval('statistics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: carbon; Owner: -
--

ALTER TABLE ONLY workspaces ALTER COLUMN id SET DEFAULT nextval('workspaces_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY areas_of_interest ALTER COLUMN id SET DEFAULT nextval('areas_of_interest_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY polygon_uploads ALTER COLUMN id SET DEFAULT nextval('polygon_uploads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY polygons ALTER COLUMN id SET DEFAULT nextval('polygons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_layers ALTER COLUMN id SET DEFAULT nextval('project_layers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY statistics ALTER COLUMN id SET DEFAULT nextval('statistics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY workspaces ALTER COLUMN id SET DEFAULT nextval('workspaces_id_seq'::regclass);


SET search_path = blueforest, pg_catalog;

--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: areas_of_interest_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY areas_of_interest
    ADD CONSTRAINT areas_of_interest_pkey PRIMARY KEY (id);


--
-- Name: polygon_uploads_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY polygon_uploads
    ADD CONSTRAINT polygon_uploads_pkey PRIMARY KEY (id);


--
-- Name: polygons_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY polygons
    ADD CONSTRAINT polygons_pkey PRIMARY KEY (id);


--
-- Name: project_layers_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_layers
    ADD CONSTRAINT project_layers_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: results_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: statistics_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY statistics
    ADD CONSTRAINT statistics_pkey PRIMARY KEY (id);


--
-- Name: workspaces_pkey; Type: CONSTRAINT; Schema: blueforest; Owner: -; Tablespace: 
--

ALTER TABLE ONLY workspaces
    ADD CONSTRAINT workspaces_pkey PRIMARY KEY (id);


SET search_path = carbon, pg_catalog;

--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: areas_of_interest_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY areas_of_interest
    ADD CONSTRAINT areas_of_interest_pkey PRIMARY KEY (id);


--
-- Name: polygon_uploads_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY polygon_uploads
    ADD CONSTRAINT polygon_uploads_pkey PRIMARY KEY (id);


--
-- Name: polygons_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY polygons
    ADD CONSTRAINT polygons_pkey PRIMARY KEY (id);


--
-- Name: project_layers_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_layers
    ADD CONSTRAINT project_layers_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: results_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: statistics_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY statistics
    ADD CONSTRAINT statistics_pkey PRIMARY KEY (id);


--
-- Name: workspaces_pkey; Type: CONSTRAINT; Schema: carbon; Owner: -; Tablespace: 
--

ALTER TABLE ONLY workspaces
    ADD CONSTRAINT workspaces_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: areas_of_interest_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY areas_of_interest
    ADD CONSTRAINT areas_of_interest_pkey PRIMARY KEY (id);


--
-- Name: calculations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY statistics
    ADD CONSTRAINT calculations_pkey PRIMARY KEY (id);


--
-- Name: polygon_uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY polygon_uploads
    ADD CONSTRAINT polygon_uploads_pkey PRIMARY KEY (id);


--
-- Name: polygons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY polygons
    ADD CONSTRAINT polygons_pkey PRIMARY KEY (id);


--
-- Name: project_layers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_layers
    ADD CONSTRAINT project_layers_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: results_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: workspaces_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY workspaces
    ADD CONSTRAINT workspaces_pkey PRIMARY KEY (id);


SET search_path = blueforest, pg_catalog;

--
-- Name: index_admins_on_email; Type: INDEX; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_email ON admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: blueforest; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = carbon, pg_catalog;

--
-- Name: index_admins_on_email; Type: INDEX; Schema: carbon; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_email ON admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: carbon; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: carbon; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = public, pg_catalog;

--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_email ON admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20121115131429');

INSERT INTO schema_migrations (version) VALUES ('20121115131838');

INSERT INTO schema_migrations (version) VALUES ('20121115132543');

INSERT INTO schema_migrations (version) VALUES ('20121115132606');

INSERT INTO schema_migrations (version) VALUES ('20121115132726');

INSERT INTO schema_migrations (version) VALUES ('20121115133145');

INSERT INTO schema_migrations (version) VALUES ('20121115133343');

INSERT INTO schema_migrations (version) VALUES ('20121115133632');

INSERT INTO schema_migrations (version) VALUES ('20121115142727');

INSERT INTO schema_migrations (version) VALUES ('20121115143216');

INSERT INTO schema_migrations (version) VALUES ('20121115180223');

INSERT INTO schema_migrations (version) VALUES ('20121115180841');

INSERT INTO schema_migrations (version) VALUES ('20121127091704');

INSERT INTO schema_migrations (version) VALUES ('20121127093942');

INSERT INTO schema_migrations (version) VALUES ('20121127094233');

INSERT INTO schema_migrations (version) VALUES ('20121129103640');

INSERT INTO schema_migrations (version) VALUES ('20121129154436');

INSERT INTO schema_migrations (version) VALUES ('20121129155311');

INSERT INTO schema_migrations (version) VALUES ('20130116095605');

INSERT INTO schema_migrations (version) VALUES ('20130130112158');

INSERT INTO schema_migrations (version) VALUES ('20130130143830');

INSERT INTO schema_migrations (version) VALUES ('20130416125917');

INSERT INTO schema_migrations (version) VALUES ('20130416130419');

INSERT INTO schema_migrations (version) VALUES ('20130418093957');

INSERT INTO schema_migrations (version) VALUES ('20130418094204');

INSERT INTO schema_migrations (version) VALUES ('20130425103904');

INSERT INTO schema_migrations (version) VALUES ('20130529130446');

INSERT INTO schema_migrations (version) VALUES ('20150223180549');

INSERT INTO schema_migrations (version) VALUES ('20150224110229');

INSERT INTO schema_migrations (version) VALUES ('20150224110631');