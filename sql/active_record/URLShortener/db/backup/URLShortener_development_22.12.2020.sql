PGDMP     '                    x            URLShortener_development    13.1    13.1 3    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    25583    URLShortener_development    DATABASE     o   CREATE DATABASE "URLShortener_development" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
 *   DROP DATABASE "URLShortener_development";
                jakubrupinski    false            �            1259    25584    ar_internal_metadata    TABLE     �   CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
 (   DROP TABLE public.ar_internal_metadata;
       public         heap    jakubrupinski    false            �            1259    25590    schema_migrations    TABLE     R   CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         heap    jakubrupinski    false            �            1259    25596    shortened_urls    TABLE     3  CREATE TABLE public.shortened_urls (
    id bigint NOT NULL,
    short_url character varying NOT NULL,
    long_url character varying NOT NULL,
    user_id integer,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT now() NOT NULL
);
 "   DROP TABLE public.shortened_urls;
       public         heap    jakubrupinski    false            �            1259    25604    shortened_urls_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.shortened_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.shortened_urls_id_seq;
       public          jakubrupinski    false    202                        0    0    shortened_urls_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.shortened_urls_id_seq OWNED BY public.shortened_urls.id;
          public          jakubrupinski    false    203            �            1259    25606 
   tag_topics    TABLE     �   CREATE TABLE public.tag_topics (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
    DROP TABLE public.tag_topics;
       public         heap    jakubrupinski    false            �            1259    25612    tag_topics_id_seq    SEQUENCE     z   CREATE SEQUENCE public.tag_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.tag_topics_id_seq;
       public          jakubrupinski    false    204                       0    0    tag_topics_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.tag_topics_id_seq OWNED BY public.tag_topics.id;
          public          jakubrupinski    false    205            �            1259    25614    taggings    TABLE     �   CREATE TABLE public.taggings (
    id bigint NOT NULL,
    tag_topic_id integer NOT NULL,
    shortened_url_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
    DROP TABLE public.taggings;
       public         heap    jakubrupinski    false            �            1259    25617    taggings_id_seq    SEQUENCE     x   CREATE SEQUENCE public.taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.taggings_id_seq;
       public          jakubrupinski    false    206                       0    0    taggings_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.taggings_id_seq OWNED BY public.taggings.id;
          public          jakubrupinski    false    207            �            1259    25619    users    TABLE     �   CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    premium boolean DEFAULT false NOT NULL
);
    DROP TABLE public.users;
       public         heap    jakubrupinski    false            �            1259    25626    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          jakubrupinski    false    208                       0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          jakubrupinski    false    209            �            1259    25628    visits    TABLE     �   CREATE TABLE public.visits (
    id bigint NOT NULL,
    shortened_url_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
    DROP TABLE public.visits;
       public         heap    jakubrupinski    false            �            1259    25631    visits_id_seq    SEQUENCE     v   CREATE SEQUENCE public.visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.visits_id_seq;
       public          jakubrupinski    false    210                       0    0    visits_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.visits_id_seq OWNED BY public.visits.id;
          public          jakubrupinski    false    211            R           2604    25633    shortened_urls id    DEFAULT     v   ALTER TABLE ONLY public.shortened_urls ALTER COLUMN id SET DEFAULT nextval('public.shortened_urls_id_seq'::regclass);
 @   ALTER TABLE public.shortened_urls ALTER COLUMN id DROP DEFAULT;
       public          jakubrupinski    false    203    202            S           2604    25634    tag_topics id    DEFAULT     n   ALTER TABLE ONLY public.tag_topics ALTER COLUMN id SET DEFAULT nextval('public.tag_topics_id_seq'::regclass);
 <   ALTER TABLE public.tag_topics ALTER COLUMN id DROP DEFAULT;
       public          jakubrupinski    false    205    204            T           2604    25635    taggings id    DEFAULT     j   ALTER TABLE ONLY public.taggings ALTER COLUMN id SET DEFAULT nextval('public.taggings_id_seq'::regclass);
 :   ALTER TABLE public.taggings ALTER COLUMN id DROP DEFAULT;
       public          jakubrupinski    false    207    206            V           2604    25636    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          jakubrupinski    false    209    208            W           2604    25637 	   visits id    DEFAULT     f   ALTER TABLE ONLY public.visits ALTER COLUMN id SET DEFAULT nextval('public.visits_id_seq'::regclass);
 8   ALTER TABLE public.visits ALTER COLUMN id DROP DEFAULT;
       public          jakubrupinski    false    211    210            �          0    25584    ar_internal_metadata 
   TABLE DATA           R   COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
    public          jakubrupinski    false    200   ?:       �          0    25590    schema_migrations 
   TABLE DATA           4   COPY public.schema_migrations (version) FROM stdin;
    public          jakubrupinski    false    201   �:       �          0    25596    shortened_urls 
   TABLE DATA           b   COPY public.shortened_urls (id, short_url, long_url, user_id, created_at, updated_at) FROM stdin;
    public          jakubrupinski    false    202   �:       �          0    25606 
   tag_topics 
   TABLE DATA           F   COPY public.tag_topics (id, name, created_at, updated_at) FROM stdin;
    public          jakubrupinski    false    204   �=       �          0    25614    taggings 
   TABLE DATA           ^   COPY public.taggings (id, tag_topic_id, shortened_url_id, created_at, updated_at) FROM stdin;
    public          jakubrupinski    false    206   
>       �          0    25619    users 
   TABLE DATA           K   COPY public.users (id, email, created_at, updated_at, premium) FROM stdin;
    public          jakubrupinski    false    208   �>       �          0    25628    visits 
   TABLE DATA           W   COPY public.visits (id, shortened_url_id, user_id, created_at, updated_at) FROM stdin;
    public          jakubrupinski    false    210   ?                  0    0    shortened_urls_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.shortened_urls_id_seq', 26, true);
          public          jakubrupinski    false    203                       0    0    tag_topics_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.tag_topics_id_seq', 3, true);
          public          jakubrupinski    false    205                       0    0    taggings_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.taggings_id_seq', 5, true);
          public          jakubrupinski    false    207                       0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 3, true);
          public          jakubrupinski    false    209            	           0    0    visits_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.visits_id_seq', 10, true);
          public          jakubrupinski    false    211            Y           2606    25639 .   ar_internal_metadata ar_internal_metadata_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);
 X   ALTER TABLE ONLY public.ar_internal_metadata DROP CONSTRAINT ar_internal_metadata_pkey;
       public            jakubrupinski    false    200            [           2606    25641 (   schema_migrations schema_migrations_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 R   ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       public            jakubrupinski    false    201            _           2606    25643 "   shortened_urls shortened_urls_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.shortened_urls
    ADD CONSTRAINT shortened_urls_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.shortened_urls DROP CONSTRAINT shortened_urls_pkey;
       public            jakubrupinski    false    202            a           2606    25645    tag_topics tag_topics_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.tag_topics
    ADD CONSTRAINT tag_topics_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.tag_topics DROP CONSTRAINT tag_topics_pkey;
       public            jakubrupinski    false    204            e           2606    25647    taggings taggings_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.taggings DROP CONSTRAINT taggings_pkey;
       public            jakubrupinski    false    206            h           2606    25649    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            jakubrupinski    false    208            k           2606    25651    visits visits_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.visits DROP CONSTRAINT visits_pkey;
       public            jakubrupinski    false    210            \           1259    25652 !   index_shortened_urls_on_short_url    INDEX     h   CREATE UNIQUE INDEX index_shortened_urls_on_short_url ON public.shortened_urls USING btree (short_url);
 5   DROP INDEX public.index_shortened_urls_on_short_url;
       public            jakubrupinski    false    202            ]           1259    25653    index_shortened_urls_on_user_id    INDEX     ]   CREATE INDEX index_shortened_urls_on_user_id ON public.shortened_urls USING btree (user_id);
 3   DROP INDEX public.index_shortened_urls_on_user_id;
       public            jakubrupinski    false    202            b           1259    25654 "   index_taggings_on_shortened_url_id    INDEX     c   CREATE INDEX index_taggings_on_shortened_url_id ON public.taggings USING btree (shortened_url_id);
 6   DROP INDEX public.index_taggings_on_shortened_url_id;
       public            jakubrupinski    false    206            c           1259    25655 3   index_taggings_on_tag_topic_id_and_shortened_url_id    INDEX     �   CREATE UNIQUE INDEX index_taggings_on_tag_topic_id_and_shortened_url_id ON public.taggings USING btree (tag_topic_id, shortened_url_id);
 G   DROP INDEX public.index_taggings_on_tag_topic_id_and_shortened_url_id;
       public            jakubrupinski    false    206    206            f           1259    25656    index_users_on_email    INDEX     N   CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);
 (   DROP INDEX public.index_users_on_email;
       public            jakubrupinski    false    208            i           1259    25657 ,   index_visits_on_shortened_url_id_and_user_id    INDEX     t   CREATE INDEX index_visits_on_shortened_url_id_and_user_id ON public.visits USING btree (shortened_url_id, user_id);
 @   DROP INDEX public.index_visits_on_shortened_url_id_and_user_id;
       public            jakubrupinski    false    210    210            �   ?   x�K�+�,���M�+�LI-K��/ ���t�tM-�L�,��M�Hq��qqq �*:      �   E   x�M��	�0Dѻ�	�DX�%��,��x��i1C���J��p��̛�!����ޕu��,������,�      �   �  x���[��0���+�@�B9x�(�(2U<M61���� ���Mf\w/����ۯ� �}�^�36O7[��6���˼�&(87� b�"�"��-Ai!��ȋ�Nt�u��&I�*�;��t��UO�4�2.= �΃:����Í�z9��ݹ�/xՄI�a��ȍ�yO�� �����>��n���]$�7fC��Y�˒�4P~���[���Z�Iʢt�o�"��+8�Y���p�)g%�����ؕ�7t	�"O�p�uc/:Y(�u�U=�/��?�ˠyy�'	YW��[$���a��v���aS8h��z���)]���?>,�`�wpn��s��T�~�	4�bٴ�y��aґ�󀯞�G�86j6�����Q{�~σ�y-/WZwG�U/���ڳx��*��1�l���]/+��I<�Y>#�mNm�f��O�o�g�"��P�"�F��?N�h��'�X����a�F����[b��ޏ��p�o�/�[�p��������d�iH�^��r�ҏ3�T��+�ON�d^��Ο#) �����Nb+x#�N�fz����]�ܯ����)P����L�?�2i�����1C�=4W?O�"�6wN@-[Hሌ�,�'b���Ӎ�Nn���^]�N�s�
vl7�����"�1{���c� ��      �   a   x�}�=
�0@�99��4i�gq)�P�����.v�<��L)nM^��-ۖ�%m(��O�=W߂ԨH�P!t���L?�vJ�K�p4�� ��*�      �   i   x�}���0�s��J
�R:���!^�5�x?T(��J\il�Ky��������O��	u�!���`�fC�e�",) �u�̴�F��� ;Fo�!� ћ7o      �   r   x�}�1�0�9>E/P�ߎ�8S��JTE%�?#���4���M����x޷��2BG�^M�G�	�GY��9���:��q��u�i��9e@�|PT�
�(��х��J2r      �   �   x�}���0ߢ�4` P-ș�Ǳ��V��.BB������*Ֆ�@ ���Fh�A=�I@Q9�&�'-u�:��{[ �?3'f��Y�����IЈC�Aw���c�h1qOQ>�Ր�5l� ����P�1X�ǵi,0݋�Dvb� ��|A�# �[�o�     