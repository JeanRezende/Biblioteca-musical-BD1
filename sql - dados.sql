
INSERT INTO artista (nome) VALUES
('Drake'),
('Khalid'),
('The Wekeend'),
('Calvin Harris'),
('Justin Timberlake'),
('Rihanna'),
('ACDC'),
('Artic Monkeys'),
('Henrique e Juliano'),
('Banda DJavu');


INSERT INTO album (nome, lancamento, id_artista) VALUES
('Views', '2016-01-01', 1),
('Suncity', '2018-01-01', 2),
('After Hours', '2020-01-01', 3),
('Motion', '2014-01-01', 4),
('Man of the woods', '2018-01-01', 5),
('Back In Black', '1980-06-10', 7),
('AM', '2013-08-10', 8),
('Ao vivo no Ibirapuera', '2020-01-10', 9),
('O furacao e show', '2009-01-10', 10);


INSERT INTO musica (duracao, genero, nome, id_album) VALUES

('4:27', 'pop', 'Hotline Bling', 1),
('3:09', 'pop', 'Suncity', 2),
('3:20', 'pop', 'Blinding Lights', 3),
('3:43', 'pop', 'Summer', 4),
('4:39', 'pop', 'Say Something', 5),
('5:12', 'pop', 'Views', 1),
('4:23', 'pop', 'Too Good', 1),
('4:15', 'rock', 'Back In Black', 6),
('4:32', 'rock', 'Do I Wanna Know?', 7),
('2:49', 'Sertanejo', 'Alô Bebê', 8),
('3:52', 'Tecno Brega', 'Me Libera', 9);



INSERT INTO musica_artista (id_musica, id_artista) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 1),
(7,6),
(8,8),
(8,9);

INSERT INTO usuario (email, senha) VALUES
('felipe.freitas@gmail.com', 'felipe1'),
('jean.gustavo@gmail.com', 'jean2'),
('carlos.silva@gmail.com', 'carlos3'),
('gabriel.sousa@gmail.com', 'gabriel4'),
('guilherme.ferreira@gmail.com', 'guilherme5'),
('pedro@gmail.com', 'pedro6'),
('izadora@gmail.com', 'izadora7'),
('cleiton@gmail.com', 'kratos8'),
('isabela@gmail.com', 'isa12345');



INSERT INTO usuario_musica (id_usuario, id_musica) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 2),
(2, 7),
(2, 5),
(3, 3),
(3, 4),
(4, 4),
(4, 6),
(5, 5),
(5, 6),
(5, 7),
(7, 6),
(8, 8),
(8, 9);


INSERT INTO playlist (id_usuario) VALUES
(1),
(1),
(3),
(4),
(2),
(3),
(1),
(5);

INSERT INTO playlist_musica (id_musica, id_playlist) VALUES
(1, 1),
(2, 1),
(3, 1),

(4, 2),
(1, 2),
(2, 2),
(3, 2),

(4, 3),
(1, 3),
(2, 3),
(3, 3),

(4, 4),
(3, 4),
(1, 4),

(5, 5),
(4, 5),
(3, 5),
(2, 5),
(1, 5),

(7, 6),
(8, 6),
(9, 6),
(5, 6),
(1, 6),

(7, 7),
(5, 7),

(7, 8),
(5, 8),
(9, 8),
(10, 8),
(1, 8);


INSERT INTO plano (nome, preco, descricao) VALUES
('premium', '15,90', 'Direito a dois usarios cadastrados e dowload de musicas ilimitado'),
('premium family', '24,90', 'Direito a quatro usarios cadastrados e dowload de musicas ilimitado'),
('estudante', '7,90', 'Direito a um usario cadastrados e dowload de musicas ilimitado'),
('plus', '69,90', 'Direito a dez usarios cadastrados e dowload de musicas ilimitado');


INSERT INTO inscricao (cpf, nome, id_plano, id_usuario) VALUES
('12345678901', 'Felipe', 3, 1),
('12345678902', 'Jean', 4, 2),
('12345678903', 'Carlos', 1, 3),
('12345678904', 'Gabriel', 1, 4),
('12345678905', 'Guilherme', 2, 5);


INSERT INTO endereco (numero, rua, bairro, cep) VALUES
('700', 'Rua Honduras', 'Santo Andre', '84637958'),
('700', 'Rua Alemanha', 'Araxa City', '84637798'),
('700', 'Rua Brazil', 'Blumenau', '84637987'),
('700', 'Rua Espanha', 'Porto Seguro', '84637654'),
('700', 'Rua Portugal', 'Uberaba', '84637321');


INSERT INTO pagamento (tipo_pagamento, data, pagamentoconfirmado, numerocartao, codigosegurancacartao, nome_titular, id_inscricao, id_endereco) VALUES
('B', '2020-01-01', 'S', '1234587890', '789', 'Felipe de Freitas', 1, 1),
('D', '2020-02-08', 'N', '7894587890', '456', 'Jean Gustavo', 2, 2),
('C', '2020-05-07', 'S', '4564587890', '123', 'Carlos Silva', 3, 3),
('B', '2020-04-09', 'N', '3214587890', '963', 'Gabriel Ferreira', 4, 4),
('C', '2020-02-01', 'N', '9634587890', '852', 'Guilherme Rezende', 5, 5);