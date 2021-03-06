
-- List of countries

set ansi_nulls on
set quoted_identifier on 
go

-- Table 

if object_id('dbo.Country') is not null
	drop table dbo.Country;
go
create table [dbo].[Country](
	[Code] [char](2) NOT NULL,
	[CountryName] [nvarchar](60) NOT NULL,
	[CodeAlpha3] [char](3) NOT NULL,
	[DomainCode] [char](2) NOT NULL,
 constraint [PK_Country] primary key clustered ([Code])
);

alter table [dbo].[Country] add constraint [IX_Country_CodeAlpha3] 
unique nonclustered ([CodeAlpha3]);

alter table [dbo].[Country] add constraint [IX_Country_DomainCode] 
unique nonclustered ([DomainCode]);

alter table [dbo].[Country] add constraint [IX_Country_CountryName] 
unique nonclustered ([CountryName]);

alter table [dbo].[Country] with check 
add constraint [CK_Country_CodeAlpha3] check ((len([CodeAlpha3])=(3)));

alter table [dbo].[Country] with check 
add constraint [CK_Country_DomainCode] check ((len([DomainCode])=(2)));

alter table [dbo].[Country] with check 
add constraint [CK_Country_Code] check ((len([Code])=(2)));

go

-- Descriptions

execute sp_addextendedproperty N'MS_Description', 'ISO 3166-1 alpha-2 country code', 'SCHEMA', 'dbo', 'TABLE', 'Country', 'COLUMN', 'Code';
execute sp_addextendedproperty N'MS_Description', 'ISO 3166-1 alpha-3 country code', 'SCHEMA', 'dbo', 'TABLE', 'Country', 'COLUMN', 'CodeAlpha3';
execute sp_addextendedproperty N'MS_Description', '2 character top level domain code for the country', 'SCHEMA', 'dbo', 'TABLE', 'Country', 'COLUMN', 'DomainCode';
execute sp_addextendedproperty N'MS_Description', 'The official name of the country', 'SCHEMA', 'dbo', 'TABLE', 'Country', 'COLUMN', 'CountryName';

go

-- Data

insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AD', N'Andorra', 'AND', 'ad');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AE', N'United Arab Emirates', 'ARE', 'ae');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AF', N'Afghanistan', 'AFG', 'af');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AG', N'Antigua and Barbuda', 'ATG', 'ag');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AI', N'Anguilla', 'AIA', 'ai');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AL', N'Albania', 'ALB', 'al');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AM', N'Armenia', 'ARM', 'am');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AO', N'Angola', 'AGO', 'ao');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AQ', N'Antarctica', 'ATA', 'aq');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AR', N'Argentina', 'ARG', 'ar');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AS', N'American Samoa', 'ASM', 'as');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AT', N'Austria', 'AUT', 'at');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AU', N'Australia', 'AUS', 'au');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AW', N'Aruba', 'ABW', 'aw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AX', N'Åland Islands', 'ALA', 'ax');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('AZ', N'Azerbaijan', 'AZE', 'az');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BA', N'Bosnia and Herzegovina', 'BIH', 'ba');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BB', N'Barbados', 'BRB', 'bb');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BD', N'Bangladesh', 'BGD', 'bd');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BE', N'Belgium', 'BEL', 'be');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BF', N'Burkina Faso', 'BFA', 'bf');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BG', N'Bulgaria', 'BGR', 'bg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BH', N'Bahrain', 'BHR', 'bh');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BI', N'Burundi', 'BDI', 'bi');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BJ', N'Benin', 'BEN', 'bj');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BL', N'Saint Barthélemy', 'BLM', 'bl');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BM', N'Bermuda', 'BMU', 'bm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BN', N'Brunei Darussalam', 'BRN', 'bn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BO', N'Bolivia, Plurinational State of', 'BOL', 'bo');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BQ', N'Bonaire, Sint Eustatius and Saba', 'BES', 'bq');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BR', N'Brazil', 'BRA', 'br');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BS', N'Bahamas', 'BHS', 'bs');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BT', N'Bhutan', 'BTN', 'bt');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BV', N'Bouvet Island', 'BVT', 'bv');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BW', N'Botswana', 'BWA', 'bw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BY', N'Belarus', 'BLR', 'by');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('BZ', N'Belize', 'BLZ', 'bz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CA', N'Canada', 'CAN', 'ca');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CC', N'Cocos (Keeling) Islands', 'CCK', 'cc');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CD', N'Congo, the Democratic Republic of the', 'COD', 'cd');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CF', N'Central African Republic', 'CAF', 'cf');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CG', N'Congo', 'COG', 'cg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CH', N'Switzerland', 'CHE', 'ch');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CI', N'Côte d''Ivoire', 'CIV', 'ci');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CK', N'Cook Islands', 'COK', 'ck');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CL', N'Chile', 'CHL', 'cl');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CM', N'Cameroon', 'CMR', 'cm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CN', N'China', 'CHN', 'cn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CO', N'Colombia', 'COL', 'co');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CR', N'Costa Rica', 'CRI', 'cr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CU', N'Cuba', 'CUB', 'cu');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CV', N'Cabo Verde', 'CPV', 'cv');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CW', N'Curaçao', 'CUW', 'cw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CX', N'Christmas Island', 'CXR', 'cx');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CY', N'Cyprus', 'CYP', 'cy');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('CZ', N'Czech Republic', 'CZE', 'cz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('DE', N'Germany', 'DEU', 'de');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('DJ', N'Djibouti', 'DJI', 'dj');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('DK', N'Denmark', 'DNK', 'dk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('DM', N'Dominica', 'DMA', 'dm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('DO', N'Dominican Republic', 'DOM', 'do');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('DZ', N'Algeria', 'DZA', 'dz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('EC', N'Ecuador', 'ECU', 'ec');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('EE', N'Estonia', 'EST', 'ee');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('EG', N'Egypt', 'EGY', 'eg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('EH', N'Western Sahara', 'ESH', 'eh');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ER', N'Eritrea', 'ERI', 'er');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ES', N'Spain', 'ESP', 'es');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ET', N'Ethiopia', 'ETH', 'et');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('FI', N'Finland', 'FIN', 'fi');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('FJ', N'Fiji', 'FJI', 'fj');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('FK', N'Falkland Islands (Malvinas)', 'FLK', 'fk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('FM', N'Micronesia, Federated States of', 'FSM', 'fm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('FO', N'Faroe Islands', 'FRO', 'fo');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('FR', N'France', 'FRA', 'fr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GA', N'Gabon', 'GAB', 'ga');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GB', N'United Kingdom of Great Britain and Northern Ireland', 'GBR', 'uk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GD', N'Grenada', 'GRD', 'gd');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GE', N'Georgia', 'GEO', 'ge');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GF', N'French Guiana', 'GUF', 'gf');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GG', N'Guernsey', 'GGY', 'gg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GH', N'Ghana', 'GHA', 'gh');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GI', N'Gibraltar', 'GIB', 'gi');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GL', N'Greenland', 'GRL', 'gl');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GM', N'Gambia', 'GMB', 'gm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GN', N'Guinea', 'GIN', 'gn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GP', N'Guadeloupe', 'GLP', 'gp');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GQ', N'Equatorial Guinea', 'GNQ', 'gq');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GR', N'Greece', 'GRC', 'gr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GS', N'South Georgia and the South Sandwich Islands', 'SGS', 'gs');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GT', N'Guatemala', 'GTM', 'gt');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GU', N'Guam', 'GUM', 'gu');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GW', N'Guinea-Bissau', 'GNB', 'gw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('GY', N'Guyana', 'GUY', 'gy');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('HK', N'Hong Kong', 'HKG', 'hk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('HM', N'Heard Island and McDonald Islands', 'HMD', 'hm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('HN', N'Honduras', 'HND', 'hn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('HR', N'Croatia', 'HRV', 'hr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('HT', N'Haiti', 'HTI', 'ht');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('HU', N'Hungary', 'HUN', 'hu');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ID', N'Indonesia', 'IDN', 'id');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IE', N'Ireland', 'IRL', 'ie');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IL', N'Israel', 'ISR', 'il');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IM', N'Isle of Man', 'IMN', 'im');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IN', N'India', 'IND', 'in');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IO', N'British Indian Ocean Territory', 'IOT', 'io');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IQ', N'Iraq', 'IRQ', 'iq');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IR', N'Iran, Islamic Republic of', 'IRN', 'ir');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IS', N'Iceland', 'ISL', 'is');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('IT', N'Italy', 'ITA', 'it');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('JE', N'Jersey', 'JEY', 'je');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('JM', N'Jamaica', 'JAM', 'jm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('JO', N'Jordan', 'JOR', 'jo');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('JP', N'Japan', 'JPN', 'jp');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KE', N'Kenya', 'KEN', 'ke');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KG', N'Kyrgyzstan', 'KGZ', 'kg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KH', N'Cambodia', 'KHM', 'kh');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KI', N'Kiribati', 'KIR', 'ki');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KM', N'Comoros', 'COM', 'km');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KN', N'Saint Kitts and Nevis', 'KNA', 'kn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KP', N'Korea, Democratic People''s Republic of', 'PRK', 'kp');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KR', N'Korea, Republic of', 'KOR', 'kr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KW', N'Kuwait', 'KWT', 'kw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KY', N'Cayman Islands', 'CYM', 'ky');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('KZ', N'Kazakhstan', 'KAZ', 'kz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LA', N'Lao People''s Democratic Republic', 'LAO', 'la');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LB', N'Lebanon', 'LBN', 'lb');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LC', N'Saint Lucia', 'LCA', 'lc');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LI', N'Liechtenstein', 'LIE', 'li');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LK', N'Sri Lanka', 'LKA', 'lk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LR', N'Liberia', 'LBR', 'lr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LS', N'Lesotho', 'LSO', 'ls');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LT', N'Lithuania', 'LTU', 'lt');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LU', N'Luxembourg', 'LUX', 'lu');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LV', N'Latvia', 'LVA', 'lv');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('LY', N'Libya', 'LBY', 'ly');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MA', N'Morocco', 'MAR', 'ma');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MC', N'Monaco', 'MCO', 'mc');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MD', N'Moldova, Republic of', 'MDA', 'md');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ME', N'Montenegro', 'MNE', 'me');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MF', N'Saint Martin (French part)', 'MAF', 'mf');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MG', N'Madagascar', 'MDG', 'mg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MH', N'Marshall Islands', 'MHL', 'mh');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MK', N'Macedonia, the former Yugoslav Republic of', 'MKD', 'mk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ML', N'Mali', 'MLI', 'ml');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MM', N'Myanmar', 'MMR', 'mm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MN', N'Mongolia', 'MNG', 'mn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MO', N'Macao', 'MAC', 'mo');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MP', N'Northern Mariana Islands', 'MNP', 'mp');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MQ', N'Martinique', 'MTQ', 'mq');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MR', N'Mauritania', 'MRT', 'mr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MS', N'Montserrat', 'MSR', 'ms');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MT', N'Malta', 'MLT', 'mt');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MU', N'Mauritius', 'MUS', 'mu');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MV', N'Maldives', 'MDV', 'mv');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MW', N'Malawi', 'MWI', 'mw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MX', N'Mexico', 'MEX', 'mx');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MY', N'Malaysia', 'MYS', 'my');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('MZ', N'Mozambique', 'MOZ', 'mz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NA', N'Namibia', 'NAM', 'na');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NC', N'New Caledonia', 'NCL', 'nc');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NE', N'Niger', 'NER', 'ne');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NF', N'Norfolk Island', 'NFK', 'nf');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NG', N'Nigeria', 'NGA', 'ng');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NI', N'Nicaragua', 'NIC', 'ni');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NL', N'Netherlands', 'NLD', 'nl');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NO', N'Norway', 'NOR', 'no');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NP', N'Nepal', 'NPL', 'np');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NR', N'Nauru', 'NRU', 'nr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NU', N'Niue', 'NIU', 'nu');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('NZ', N'New Zealand', 'NZL', 'nz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('OM', N'Oman', 'OMN', 'om');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PA', N'Panama', 'PAN', 'pa');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PE', N'Peru', 'PER', 'pe');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PF', N'French Polynesia', 'PYF', 'pf');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PG', N'Papua New Guinea', 'PNG', 'pg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PH', N'Philippines', 'PHL', 'ph');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PK', N'Pakistan', 'PAK', 'pk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PL', N'Poland', 'POL', 'pl');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PM', N'Saint Pierre and Miquelon', 'SPM', 'pm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PN', N'Pitcairn', 'PCN', 'pn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PR', N'Puerto Rico', 'PRI', 'pr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PS', N'Palestine, State of', 'PSE', 'ps');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PT', N'Portugal', 'PRT', 'pt');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PW', N'Palau', 'PLW', 'pw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('PY', N'Paraguay', 'PRY', 'py');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('QA', N'Qatar', 'QAT', 'qa');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('RE', N'Réunion', 'REU', 're');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('RO', N'Romania', 'ROU', 'ro');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('RS', N'Serbia', 'SRB', 'rs');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('RU', N'Russian Federation', 'RUS', 'ru');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('RW', N'Rwanda', 'RWA', 'rw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SA', N'Saudi Arabia', 'SAU', 'sa');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SB', N'Solomon Islands', 'SLB', 'sb');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SC', N'Seychelles', 'SYC', 'sc');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SD', N'Sudan', 'SDN', 'sd');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SE', N'Sweden', 'SWE', 'se');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SG', N'Singapore', 'SGP', 'sg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SH', N'Saint Helena, Ascension and Tristan da Cunha', 'SHN', 'sh');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SI', N'Slovenia', 'SVN', 'si');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SJ', N'Svalbard and Jan Mayen', 'SJM', 'sj');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SK', N'Slovakia', 'SVK', 'sk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SL', N'Sierra Leone', 'SLE', 'sl');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SM', N'San Marino', 'SMR', 'sm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SN', N'Senegal', 'SEN', 'sn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SO', N'Somalia', 'SOM', 'so');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SR', N'Suriname', 'SUR', 'sr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SS', N'South Sudan', 'SSD', 'ss');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ST', N'Sao Tome and Principe', 'STP', 'st');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SV', N'El Salvador', 'SLV', 'sv');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SX', N'Sint Maarten (Dutch part)', 'SXM', 'sx');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SY', N'Syrian Arab Republic', 'SYR', 'sy');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('SZ', N'Swaziland', 'SWZ', 'sz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TC', N'Turks and Caicos Islands', 'TCA', 'tc');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TD', N'Chad', 'TCD', 'td');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TF', N'French Southern Territories', 'ATF', 'tf');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TG', N'Togo', 'TGO', 'tg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TH', N'Thailand', 'THA', 'th');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TJ', N'Tajikistan', 'TJK', 'tj');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TK', N'Tokelau', 'TKL', 'tk');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TL', N'Timor-Leste', 'TLS', 'tl');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TM', N'Turkmenistan', 'TKM', 'tm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TN', N'Tunisia', 'TUN', 'tn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TO', N'Tonga', 'TON', 'to');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TR', N'Turkey', 'TUR', 'tr');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TT', N'Trinidad and Tobago', 'TTO', 'tt');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TV', N'Tuvalu', 'TUV', 'tv');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TW', N'Taiwan, Province of China', 'TWN', 'tw');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('TZ', N'Tanzania, United Republic of', 'TZA', 'tz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('UA', N'Ukraine', 'UKR', 'ua');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('UG', N'Uganda', 'UGA', 'ug');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('UM', N'United States Minor Outlying Islands', 'UMI', 'um');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('US', N'United States of America', 'USA', 'us');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('UY', N'Uruguay', 'URY', 'uy');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('UZ', N'Uzbekistan', 'UZB', 'uz');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('VA', N'Holy See', 'VAT', 'va');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('VC', N'Saint Vincent and the Grenadines', 'VCT', 'vc');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('VE', N'Venezuela, Bolivarian Republic of', 'VEN', 've');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('VG', N'Virgin Islands, British', 'VGB', 'vg');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('VI', N'Virgin Islands, U.S.', 'VIR', 'vi');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('VN', N'Viet Nam', 'VNM', 'vn');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('VU', N'Vanuatu', 'VUT', 'vu');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('WF', N'Wallis and Futuna', 'WLF', 'wf');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('WS', N'Samoa', 'WSM', 'ws');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('YE', N'Yemen', 'YEM', 'ye');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('YT', N'Mayotte', 'MYT', 'yt');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ZA', N'South Africa', 'ZAF', 'za');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ZM', N'Zambia', 'ZMB', 'zm');
insert [dbo].[Country] ([Code], [CountryName], [CodeAlpha3], [DomainCode]) values ('ZW', N'Zimbabwe', 'ZWE', 'zw');

go

select * from [dbo].[Country];