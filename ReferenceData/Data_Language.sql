
-- List of languages
-- https://www.loc.gov/standards/iso639-2/php/code_list.php
-- ISO 639-2

if object_id('dbo.Language') is not null
	drop table dbo.[Language];
go
create table dbo.[Language](
LanguageCode char(2) not null primary key clustered,
LanguageCodeAlphaThree char(3) not null,
LanguageName varchar(100) not null
);
go

-- Languages

insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('aa', 'aar', 'Afar');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ab', 'abk', 'Abkhazian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ae', 'ave', 'Avestan');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('af', 'afr', 'Afrikaans');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ak', 'aka', 'Akan');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('am', 'amh', 'Amharic');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('an', 'arg', 'Aragonese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ar', 'ara', 'Arabic');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('as', 'asm', 'Assamese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('av', 'ava', 'Avaric');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ay', 'aym', 'Aymara');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('az', 'aze', 'Azerbaijani');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ba', 'bak', 'Bashkir');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('be', 'bel', 'Belarusian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('bg', 'bul', 'Bulgarian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('bh', 'bih', 'Bihari languages');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('bi', 'bis', 'Bislama');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('bm', 'bam', 'Bambara');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('bn', 'ben', 'Bengali');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('bo', 'tib', 'Tibetan');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('br', 'bre', 'Breton');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('bs', 'bos', 'Bosnian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ca', 'cat', 'Catalan; Valencian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ce', 'che', 'Chechen');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ch', 'cha', 'Chamorro');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('co', 'cos', 'Corsican');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('cr', 'cre', 'Cree');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('cs', 'cze', 'Czech');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('cu', 'chu', 'Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('cv', 'chv', 'Chuvash');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('cy', 'wel', 'Welsh');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('da', 'dan', 'Danish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('de', 'ger', 'German');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('dv', 'div', 'Divehi; Dhivehi; Maldivian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('dz', 'dzo', 'Dzongkha');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ee', 'ewe', 'Ewe');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('el', 'gre', 'Greek, Modern (1453-)');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('en', 'eng', 'English');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('eo', 'epo', 'Esperanto');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('es', 'spa', 'Spanish; Castilian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('et', 'est', 'Estonian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('eu', 'baq', 'Basque');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('fa', 'per', 'Persian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ff', 'ful', 'Fulah');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('fi', 'fin', 'Finnish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('fj', 'fij', 'Fijian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('fo', 'fao', 'Faroese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('fr', 'fre', 'French');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('fy', 'fry', 'Western Frisian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ga', 'gle', 'Irish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('gd', 'gla', 'Gaelic; Scottish Gaelic');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('gl', 'glg', 'Galician');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('gn', 'grn', 'Guarani');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('gu', 'guj', 'Gujarati');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('gv', 'glv', 'Manx');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ha', 'hau', 'Hausa');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('he', 'heb', 'Hebrew');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('hi', 'hin', 'Hindi');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ho', 'hmo', 'Hiri Motu');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('hr', 'hrv', 'Croatian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ht', 'hat', 'Haitian; Haitian Creole');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('hu', 'hun', 'Hungarian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('hy', 'arm', 'Armenian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('hz', 'her', 'Herero');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ia', 'ina', 'Interlingua (International Auxiliary Language Association)');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('id', 'ind', 'Indonesian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ie', 'ile', 'Interlingue; Occidental');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ig', 'ibo', 'Igbo');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ii', 'iii', 'Sichuan Yi; Nuosu');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ik', 'ipk', 'Inupiaq');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('io', 'ido', 'Ido');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('is', 'ice', 'Icelandic');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('it', 'ita', 'Italian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('iu', 'iku', 'Inuktitut');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ja', 'jpn', 'Japanese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('jv', 'jav', 'Javanese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ka', 'geo', 'Georgian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('kg', 'kon', 'Kongo');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ki', 'kik', 'Kikuyu; Gikuyu');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('kj', 'kua', 'Kuanyama; Kwanyama');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('kk', 'kaz', 'Kazakh');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('kl', 'kal', 'Kalaallisut; Greenlandic');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('km', 'khm', 'Central Khmer');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('kn', 'kan', 'Kannada');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ko', 'kor', 'Korean');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('kr', 'kau', 'Kanuri');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ks', 'kas', 'Kashmiri');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ku', 'kur', 'Kurdish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('kv', 'kom', 'Komi');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('kw', 'cor', 'Cornish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ky', 'kir', 'Kirghiz; Kyrgyz');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('la', 'lat', 'Latin');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('lb', 'ltz', 'Luxembourgish; Letzeburgesch');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('lg', 'lug', 'Ganda');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('li', 'lim', 'Limburgan; Limburger; Limburgish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ln', 'lin', 'Lingala');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('lo', 'lao', 'Lao');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('lt', 'lit', 'Lithuanian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('lu', 'lub', 'Luba-Katanga');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('lv', 'lav', 'Latvian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('mg', 'mlg', 'Malagasy');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('mh', 'mah', 'Marshallese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('mi', 'mao', 'Maori');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('mk', 'mac', 'Macedonian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ml', 'mal', 'Malayalam');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('mn', 'mon', 'Mongolian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('mr', 'mar', 'Marathi');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ms', 'may', 'Malay');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('mt', 'mlt', 'Maltese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('my', 'bur', 'Burmese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('na', 'nau', 'Nauru');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('nb', 'nob', 'Bokmal, Norwegian; Norwegian Bokmal');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('nd', 'nde', 'Ndebele, North; North Ndebele');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ne', 'nep', 'Nepali');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ng', 'ndo', 'Ndonga');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('nl', 'dut', 'Dutch; Flemish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('nn', 'nno', 'Norwegian Nynorsk; Nynorsk, Norwegian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('no', 'nor', 'Norwegian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('nr', 'nbl', 'Ndebele, South; South Ndebele');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('nv', 'nav', 'Navajo; Navaho');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ny', 'nya', 'Chichewa; Chewa; Nyanja');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('oc', 'oci', 'Occitan (post 1500); Provencal');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('oj', 'oji', 'Ojibwa');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('om', 'orm', 'Oromo');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('or', 'ori', 'Oriya');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('os', 'oss', 'Ossetian; Ossetic');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('pa', 'pan', 'Panjabi; Punjabi');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('pi', 'pli', 'Pali');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('pl', 'pol', 'Polish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ps', 'pus', 'Pushto; Pashto');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('pt', 'por', 'Portuguese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('qu', 'que', 'Quechua');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('rm', 'roh', 'Romansh');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('rn', 'run', 'Rundi');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ro', 'rum', 'Romanian; Moldavian; Moldovan');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ru', 'rus', 'Russian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('rw', 'kin', 'Kinyarwanda');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sa', 'san', 'Sanskrit');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sc', 'srd', 'Sardinian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sd', 'snd', 'Sindhi');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('se', 'sme', 'Northern Sami');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sg', 'sag', 'Sango');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('si', 'sin', 'Sinhala; Sinhalese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sk', 'slo', 'Slovak');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sl', 'slv', 'Slovenian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sm', 'smo', 'Samoan');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sn', 'sna', 'Shona');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('so', 'som', 'Somali');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sq', 'alb', 'Albanian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sr', 'srp', 'Serbian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ss', 'ssw', 'Swati');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('st', 'sot', 'Sotho, Southern');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('su', 'sun', 'Sundanese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sv', 'swe', 'Swedish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('sw', 'swa', 'Swahili');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ta', 'tam', 'Tamil');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('te', 'tel', 'Telugu');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('tg', 'tgk', 'Tajik');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('th', 'tha', 'Thai');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ti', 'tir', 'Tigrinya');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('tk', 'tuk', 'Turkmen');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('tl', 'tgl', 'Tagalog');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('tn', 'tsn', 'Tswana');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('to', 'ton', 'Tonga (Tonga Islands)');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('tr', 'tur', 'Turkish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ts', 'tso', 'Tsonga');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('tt', 'tat', 'Tatar');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('tw', 'twi', 'Twi');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ty', 'tah', 'Tahitian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ug', 'uig', 'Uighur; Uyghur');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('uk', 'ukr', 'Ukrainian');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ur', 'urd', 'Urdu');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('uz', 'uzb', 'Uzbek');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('ve', 'ven', 'Venda');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('vi', 'vie', 'Vietnamese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('vo', 'vol', 'Volapuk');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('wa', 'wln', 'Walloon');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('wo', 'wol', 'Wolof');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('xh', 'xho', 'Xhosa');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('yi', 'yid', 'Yiddish');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('yo', 'yor', 'Yoruba');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('za', 'zha', 'Zhuang; Chuang');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('zh', 'chi', 'Chinese');
insert into [dbo].[Language] ([LanguageCode], [LanguageCodeAlphaThree], [LanguageName]) values ('zu', 'zul', 'Zulu');

go

select * from dbo.Language;

go
