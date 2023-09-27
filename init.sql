-- public.authors definition

CREATE TABLE public.authors (
	author_id serial4 NOT NULL,
	surname varchar NOT NULL,
	firstname varchar NOT NULL,
	lastname varchar NULL,
	country varchar NULL,
	CONSTRAINT author_pk PRIMARY KEY (author_id)
);
CREATE INDEX authors_country_idx ON public.authors USING btree (country);
CREATE INDEX authors_firstname_idx ON public.authors USING btree (firstname);
CREATE INDEX authors_lastname_idx ON public.authors USING btree (lastname);
CREATE INDEX authors_surname_idx ON public.authors USING btree (surname);


-- public.publishers definition

CREATE TABLE public.publishers (
	publisher_id serial4 NOT NULL,
	"name" varchar NOT NULL,
	city varchar NOT NULL,
	CONSTRAINT publishers_pk PRIMARY KEY (publisher_id)
);
CREATE INDEX publishers_name_idx ON public.publishers USING btree (name);


-- public.readers definition

CREATE TABLE public.readers (
	reader_id serial4 NOT NULL,
	ticket_no varchar NOT NULL,
	surname varchar NOT NULL,
	firstname varchar NOT NULL,
	lastname varchar NULL,
	phone varchar NOT NULL,
	address varchar NULL,
	ristration_date date NOT NULL,
	CONSTRAINT readers_pk PRIMARY KEY (reader_id)
);
CREATE INDEX readers_firstname_idx ON public.readers USING btree (firstname);
CREATE INDEX readers_ristration_date_idx ON public.readers USING btree (ristration_date);
CREATE INDEX readers_surname_idx ON public.readers USING btree (surname);
CREATE INDEX readers_ticket_no_idx ON public.readers USING btree (ticket_no);


-- public.books definition

CREATE TABLE public.books (
	book_id serial4 NOT NULL,
	isbn varchar NULL,
	"name" varchar NOT NULL,
	public_year date NOT NULL,
	pages int2 NOT NULL,
	prce money NULL,
	copies varchar NULL,
	pubisher_id int4 NOT NULL,
	CONSTRAINT books_pk PRIMARY KEY (book_id),
	CONSTRAINT books_fk FOREIGN KEY (pubisher_id) REFERENCES public.publishers(publisher_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE INDEX books_isbn_idx ON public.books USING btree (isbn);
CREATE INDEX books_name_idx ON public.books USING btree (name);
CREATE INDEX books_prce_idx ON public.books USING btree (prce, isbn);
CREATE INDEX books_public_year_idx ON public.books USING btree (public_year);


-- public.cardfiles definition

CREATE TABLE public.cardfiles (
	reader_id int4 NOT NULL,
	book_id int4 NOT NULL,
	get_date date NOT NULL,
	return_date date NULL,
	delay_days int4 NULL,
	CONSTRAINT cardfiles_fk FOREIGN KEY (reader_id) REFERENCES public.readers(reader_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT cardfiles_fk_1 FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE INDEX cardfiles_get_date_idx ON public.cardfiles USING btree (get_date);


-- public.authorlist definition

CREATE TABLE public.authorlist (
	book_id int4 NOT NULL,
	author_id int4 NOT NULL,
	CONSTRAINT authorlist_fk FOREIGN KEY (author_id) REFERENCES public.authors(author_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT authorlist_fk_1 FOREIGN KEY (book_id) REFERENCES public.books(book_id) ON DELETE CASCADE ON UPDATE CASCADE
);