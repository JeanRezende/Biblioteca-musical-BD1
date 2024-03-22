--genero mais escutado pelo usuario

SELECT u.id_usuario, m.genero, COUNT(m.genero) as quantidade
FROM usuario_musica as u, musica as m
WHERE u.id_musica = m.id_musica
GROUP BY u.id_usuario, m.genero
ORDER BY u.id_usuario;

--lista de playlists do user

SELECT u.id_usuario, p.id_playlist
FROM usuario as u, playlist as p
WHERE u.id_usuario = p.id_usuario
ORDER BY u.id_usuario;

--musicas dentro dessas playlists

SELECT  p.id_playlist, u.id_usuario, pm.id_musica, m.nome
FROM usuario as u, playlist as p, playlist_musica as pm, musica as m
WHERE u.id_usuario = p.id_usuario
AND p.id_playlist = pm.id_playlist
AND pm.id_musica = m.id_musica
ORDER BY p.id_playlist;

--albuns de um artista
SELECT ar.id_artista, ar.nome, al.id_album, al.nome
FROM artista as ar, album as al
WHERE ar.id_artista = al.id_artista
ORDER BY ar.id_artista;

--musicas no album do artista

SELECT ar.id_artista, ar.nome as artista, al.id_album, al.nome as album, m.nome as musica
FROM artista as ar, album as al, musica as m
WHERE ar.id_artista = al.id_artista
AND m.id_album = al.id_album
ORDER BY ar.id_artista;

--lista de musicas mais tocadas de um artista

SELECT ma.id_artista, m.id_musica, m.nome, COUNT(um.id_musica) as quantidade
FROM musica_artista as ma, musica as m, usuario_musica as um
WHERE um.id_musica = m.id_musica
AND m.id_musica = ma.id_musica
GROUP BY ma.id_artista, m.id_musica, m.nome
ORDER BY ma.id_artista;

--usuario e seus historicos de pagamento

SELECT u.id_usuario, i.id_inscricao, p.id_pagamento,  p.data, plano.preco
FROM usuario as u, inscricao as i, pagamento as p, plano
WHERE u.id_usuario = i.id_usuario
AND i.id_inscricao = p.id_inscricao
AND i.id_plano = plano.id_plano
ORDER BY u.id_usuario;

--musicas por estilo
SELECT m.genero, m.id_musica, m.nome 
FROM musica as m
ORDER BY m.genero;

--musicas por nome
SELECT * from musica WHERE nome LIKE 'S%';


--mostrar todos os planos disponiveis
SELECT * from plano;

---buscas
SELECT * from musica WHERE nome LIKE 'S%';
SELECT * from musica WHERE genero LIKE 'pop%';

SELECT COUNT(um.id_musica) as quantidade, m.nome, m.id_musica
FROM musica_artista as ma, musica as m, usuario_musica as um
WHERE um.id_musica = m.id_musica
AND m.id_musica = ma.id_musica
AND id_artista = 1
GROUP BY m.id_musica, m.nome
ORDER BY quantidade DESC;