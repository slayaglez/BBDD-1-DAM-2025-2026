-- ============================================================
-- SEED DATA - Plataforma de ROMs/Videojuegos
-- ============================================================

-- ------------------------------------------------------------
-- USERS (10 usuarios)
-- ------------------------------------------------------------
INSERT INTO public.users (nickname, first_name, email, password_hash, pfp, color, tags, last_online, created_in) VALUES
('retrogamer99',  'Carlos',   'carlos@mail.com',   'hash_a1b2c3', 'avatar1.png', 16711680, 'rpg,aventura',       '2025-03-08 21:00:00', '2022-01-15 10:30:00'),
('pixelqueen',   'Laura',    'laura@mail.com',    'hash_d4e5f6', 'avatar2.png', 255,      'plataformas,puzzle', '2025-03-07 18:45:00', '2022-03-20 09:15:00'),
('nintendork',   'Miguel',   'miguel@mail.com',   'hash_g7h8i9', 'avatar3.png', 65280,    'accion,rpg',         '2025-03-09 08:00:00', '2021-11-05 14:00:00'),
('segafanatic',  'Ana',      'ana@mail.com',      'hash_j1k2l3', 'avatar4.png', 16776960, 'accion,deportes',    '2025-02-28 20:10:00', '2023-06-01 11:00:00'),
('arcadeking',   'Pedro',    'pedro@mail.com',    'hash_m4n5o6', 'avatar5.png', 8388736,  'arcade,lucha',       '2025-03-01 15:30:00', '2022-09-10 16:45:00'),
('zeldafan',     'Sofia',    'sofia@mail.com',    'hash_p7q8r9', 'avatar6.png', 4235519,  'aventura,rpg',       '2025-03-06 22:00:00', '2023-01-18 08:30:00'),
('megadriver',   'Javier',   'javier@mail.com',   'hash_s1t2u3', 'avatar7.png', 16744448, 'accion,plataformas', '2025-03-05 19:15:00', '2021-07-22 13:20:00'),
('gbamaster',    'Elena',    'elena@mail.com',    'hash_v4w5x6', 'avatar8.png', 12583104, 'puzzle,rpg',         '2025-03-04 10:00:00', '2022-12-03 17:55:00'),
('neogeobro',    'Raúl',     'raul@mail.com',     'hash_y7z8a1', 'avatar9.png', 3407872,  'lucha,arcade',       '2025-03-03 14:20:00', '2023-04-14 12:10:00'),
('sneskid',      'Marta',    'marta@mail.com',    'hash_b2c3d4', 'avatar10.png',16711935, 'plataformas,accion', '2025-03-02 09:50:00', '2021-05-30 10:05:00');


-- ------------------------------------------------------------
-- ADMIN (3 admins, referenciando usuarios existentes)
-- ------------------------------------------------------------
INSERT INTO public.admin (id_users_fk) VALUES
(1),  -- Carlos es admin
(3),  -- Miguel es admin
(7);  -- Javier es admin


-- ------------------------------------------------------------
-- CONSOLE (8 consolas)
-- ------------------------------------------------------------
INSERT INTO public.console (name, hash, manufacter, launch_date) VALUES
('Super Nintendo Entertainment System', 'hash_snes_001', 'Nintendo',  '1990-11-21'),
('Sega Mega Drive',                     'hash_smd_002',  'Sega',      '1988-10-29'),
('Game Boy Advance',                    'hash_gba_003',  'Nintendo',  '2001-03-21'),
('PlayStation',                         'hash_psx_004',  'Sony',      '1994-12-03'),
('Nintendo 64',                         'hash_n64_005',  'Nintendo',  '1996-06-23'),
('Sega Saturn',                         'hash_ss_006',   'Sega',      '1994-11-22'),
('Neo Geo',                             'hash_ng_007',   'SNK',       '1990-01-31'),
('Game Boy Color',                      'hash_gbc_008',  'Nintendo',  '1998-10-21');


-- ------------------------------------------------------------
-- GAME (12 juegos, añadidos por distintos usuarios)
-- ------------------------------------------------------------
INSERT INTO public.game (title, description, added_by, overall_rate) VALUES
('Super Mario World',          'Plataformas 2D icónico de SNES con Mario y Yoshi.',             1, 10),
('The Legend of Zelda: LTTP',  'Aventura de acción top-down ambientada en Hyrule.',             3, 10),
('Sonic the Hedgehog 2',       'El erizo azul a máxima velocidad en Mega Drive.',               4,  9),
('Chrono Trigger',             'RPG de viajes en el tiempo con sistema ATB mejorado.',          1,  10),
('Street Fighter II',          'El beat em up que definió el género de lucha.',                 5,  9),
('Final Fantasy VI',           'Épica RPG con un elenco de 14 personajes jugables.',            3,  10),
('Donkey Kong Country',        'Plataformas con gráficos pre-renderizados impresionantes.',     7,  8),
('Castlevania: Symphony',      'Metroidvania clásico para PlayStation.',                        2,  10),
('Super Metroid',              'Exploración atmosférica en el planeta Zebes.',                  6,  10),
('Mega Man X',                 'Plataformas de acción con sistema de habilidades robadas.',     7,   9),
('Pokémon Rojo Fuego',         'RPG de colección y batallas Pokémon para GBA.',                 8,   8),
('Metal Slug 3',               'Run and gun arcade con humor y acción frenética.',              9,   9);


-- ------------------------------------------------------------
-- ROMS (cada juego tiene al menos una ROM en su consola)
-- ------------------------------------------------------------
INSERT INTO public.roms (id_game_fk, id_console_fk, url, hash) VALUES
(1,  1, 'roms/snes/super_mario_world.sfc',         'romhash_smw_001'),
(2,  1, 'roms/snes/zelda_lttp.sfc',                'romhash_zlttp_002'),
(3,  2, 'roms/smd/sonic2.md',                      'romhash_s2_003'),
(4,  1, 'roms/snes/chrono_trigger.sfc',            'romhash_ct_004'),
(5,  1, 'roms/snes/street_fighter2.sfc',           'romhash_sf2_005'),
(5,  2, 'roms/smd/street_fighter2.md',             'romhash_sf2_006'),  -- SF2 en dos consolas
(6,  1, 'roms/snes/final_fantasy6.sfc',            'romhash_ff6_007'),
(7,  1, 'roms/snes/donkey_kong_country.sfc',       'romhash_dkc_008'),
(8,  4, 'roms/psx/castlevania_sotn.bin',           'romhash_sotn_009'),
(9,  1, 'roms/snes/super_metroid.sfc',             'romhash_sm_010'),
(10, 1, 'roms/snes/mega_man_x.sfc',                'romhash_mmx_011'),
(11, 3, 'roms/gba/pokemon_firered.gba',            'romhash_pfr_012'),
(12, 7, 'roms/neogeo/metal_slug_3.neo',            'romhash_ms3_013');


-- ------------------------------------------------------------
-- PROGRESS (usuarios con distintos estados en distintos juegos)
-- ------------------------------------------------------------
INSERT INTO public.progress (id_users_fk, id_game_fk, state) VALUES
-- Carlos
(1,  1,  'completado'),
(1,  4,  'completado'),
(1,  9,  'en_progreso'),
-- Laura
(2,  2,  'completado'),
(2,  11, 'en_progreso'),
(2,  7,  'pendiente_de_jugar'),
-- Miguel
(3,  6,  'completado'),
(3,  4,  'completado'),
(3,  10, 'en_progreso'),
-- Ana
(4,  3,  'completado'),
(4,  5,  'en_progreso'),
(4,  12, 'pendiente_de_jugar'),
-- Pedro
(5,  5,  'completado'),
(5,  12, 'completado'),
(5,  8,  'pendiente_de_jugar'),
-- Sofia
(6,  2,  'completado'),
(6,  9,  'completado'),
(6,  6,  'en_progreso'),
-- Javier
(7,  10, 'completado'),
(7,  3,  'en_progreso'),
(7,  1,  'pendiente_de_jugar'),
-- Elena
(8,  11, 'completado'),
(8,  4,  'en_progreso'),
(8,  2,  'pendiente_de_jugar'),
-- Raúl
(9,  12, 'en_progreso'),
(9,  5,  'completado'),
(9,  8,  'pendiente_de_jugar'),
-- Marta
(10, 1,  'completado'),
(10, 7,  'completado'),
(10, 10, 'en_progreso');


-- ------------------------------------------------------------
-- RATING (valoraciones de usuarios sobre juegos)
-- ------------------------------------------------------------
INSERT INTO public.rating (id_game_fk, id_users_fk, tags, rate) VALUES
(1,  1,  'clasico,nostalgia,imprescindible', 10),
(1,  2,  'divertido,plataformas',            9),
(1,  10, 'perfecto,rejugable',               10),
(2,  3,  'obra-maestra,aventura',            10),
(2,  6,  'imprescindible,epico',             10),
(2,  8,  'largo,entretenido',                9),
(3,  4,  'rapido,divertido',                 9),
(3,  7,  'clasico,velocidad',                8),
(4,  1,  'rpg,viajes-en-el-tiempo,epico',    10),
(4,  3,  'obra-maestra,historia',            10),
(4,  8,  'largo,complejo',                   9),
(5,  5,  'lucha,competitivo',                9),
(5,  9,  'arcade,clasico',                   8),
(6,  3,  'rpg,historia,personajes',          10),
(6,  6,  'complejo,largo,epico',             10),
(7,  2,  'visual,plataformas',               8),
(7,  10, 'divertido,coop',                   8),
(8,  5,  'metroidvania,atmosfera',           10),
(8,  9,  'exploracion,dificil',              9),
(9,  1,  'atmosfera,soledad,clasico',        10),
(9,  6,  'exploracion,misterio',             10),
(10, 7,  'accion,habilidad',                 9),
(10, 3,  'plataformas,desafiante',           9),
(11, 2,  'pokemon,rpg,coleccion',            8),
(11, 8,  'nostalgia,rpg',                    9),
(12, 9,  'arcade,frenético,coop',            9),
(12, 5,  'humor,accion',                     9);


-- ------------------------------------------------------------
-- PENDING_GAMES (juegos pendientes de revisión por admins)
-- ------------------------------------------------------------
INSERT INTO public.pending_games (id_game_fk, added_in, report) VALUES
(1,  '2024-11-10 10:00:00', 'ROM verificada, hash correcto.'),
(2,  '2024-11-12 11:30:00', 'ROM verificada, sin problemas.'),
(3,  '2024-11-15 09:45:00', 'Revisar región: versión europea.'),
(4,  '2024-11-20 14:00:00', 'ROM verificada, hash correcto.'),
(5,  '2024-12-01 16:20:00', 'Dos versiones disponibles (SNES y MD).'),
(6,  '2024-12-05 10:10:00', 'ROM verificada, sin problemas.'),
(7,  '2024-12-10 13:00:00', 'Posible problema con traducción al español.'),
(8,  '2025-01-03 08:30:00', 'ROM verificada, versión NTSC.'),
(9,  '2025-01-07 09:00:00', 'ROM verificada, hash correcto.'),
(10, '2025-01-15 11:45:00', 'Revisar: archivo corrupto reportado por 1 usuario.'),
(11, '2025-02-01 12:00:00', 'ROM verificada, parche de traducción incluido.'),
(12, '2025-02-20 17:30:00', 'ROM verificada, versión MVS arcade.');
