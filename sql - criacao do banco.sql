
\connect postgres;

DROP DATABASE IF EXISTS biblimusical;

CREATE DATABASE biblimusical;

\connect biblimusical;


CREATE TABLE artista (
  id_artista SERIAL NOT NULL,
  nome VARCHAR(45) NOT NULL,
  CONSTRAINT artista_pk PRIMARY KEY (id_artista)
);


CREATE TABLE album (
  id_album SERIAL NOT NULL,
  nome VARCHAR(45) NOT NULL,
  lancamento DATE NOT NULL,
  id_artista INT NOT NULL,
  CONSTRAINT album_pk PRIMARY KEY (id_album),
  CONSTRAINT album_fk_artista FOREIGN KEY (id_artista) REFERENCES artista(id_artista)
);


CREATE TABLE musica (
  id_musica SERIAL NOT NULL,
  duracao CHAR(5) NOT NULL,
  genero VARCHAR(20) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  id_album INT NOT NULL,
  CONSTRAINT musica_pk PRIMARY KEY (id_musica),
  CONSTRAINT musica_fk_album FOREIGN KEY (id_album) REFERENCES album(id_album)
);


CREATE TABLE usuario (
  id_usuario SERIAL NOT NULL,
  email VARCHAR(45) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  CONSTRAINT usuario_pk PRIMARY KEY (id_usuario)
);


CREATE TABLE playlist(
  id_playlist SERIAL NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT playlist_pk PRIMARY KEY (id_playlist),
  CONSTRAINT playlist_fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);


CREATE TABLE playlist_musica (
  id_musica INT NOT NULL,
  id_playlist INT NOT NULL,
  CONSTRAINT playlist_musica_pk PRIMARY KEY (id_musica, id_playlist),
  CONSTRAINT playlist_musica_fk_musica FOREIGN KEY (id_musica) REFERENCES musica(id_musica),
  CONSTRAINT playlist_musica_fk_playlist FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist)
);


CREATE TABLE usuario_musica (
  id_usuario INT NOT NULL,
  id_musica INT NOT NULL,
  CONSTRAINT usuario_musica_pk PRIMARY KEY (id_usuario, id_musica),
  CONSTRAINT usuario_musica_fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT usuario_musica_fk_musica FOREIGN KEY (id_musica) REFERENCES musica(id_musica)
);


CREATE TABLE plano (
  id_plano SERIAL NOT NULL,
  nome VARCHAR(45) NOT NULL,
  preco MONEY NOT NULL,
  descricao VARCHAR(100) NOT NULL,
  CONSTRAINT plano_pk PRIMARY KEY (id_plano)
);


CREATE TABLE inscricao (
  id_inscricao SERIAL NOT NULL,
  cpf CHAR(11) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  id_plano INT NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT inscricao_pk PRIMARY KEY (id_inscricao),
  CONSTRAINT inscricao_fk_plano FOREIGN KEY (id_plano) REFERENCES plano(id_plano),
  CONSTRAINT inscricao_fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT inscricao_cpf_key UNIQUE (cpf)
);


CREATE TABLE endereco (
  id_endereco SERIAL NOT NULL,
  numero CHAR(10) NOT NULL,
  rua VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  cep CHAR(8) NOT NULL,
  CONSTRAINT endereco_pk PRIMARY KEY (id_endereco)
);


CREATE TABLE pagamento (
  id_pagamento SERIAL NOT NULL,
  tipo_pagamento CHAR(1) NOT NULL,
  data DATE NOT NULL,
  pagamentoconfirmado CHAR(1) NOT NULL,
  numerocartao CHAR(20) ,
  codigosegurancacartao CHAR(5) ,
  nome_titular VARCHAR(45),
  id_inscricao INT NOT NULL,
  id_endereco INT NOT NULL,
  CONSTRAINT pagamento_pk PRIMARY KEY (id_pagamento),
  CONSTRAINT pagamento_fk_inscricao FOREIGN KEY (id_inscricao) REFERENCES inscricao(id_inscricao),
  CONSTRAINT pagamento_fk_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco) 
);


CREATE TABLE musica_artista (
  id_musica INT NOT NULL,
  id_artista INT NOT NULL,
  CONSTRAINT musica_artista_pk PRIMARY KEY (id_musica, id_artista),
  CONSTRAINT musica_artista_fk_musica FOREIGN KEY (id_musica) REFERENCES musica(id_musica),
  CONSTRAINT musica_artista_fk_artista FOREIGN KEY (id_artista) REFERENCES artista(id_artista)
);