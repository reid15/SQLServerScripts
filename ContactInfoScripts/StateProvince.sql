

-- Table for US States and Canadian Provinces

if object_id('dbo.StateProvince') is not null
	drop table dbo.StateProvince;
go

create table dbo.StateProvince (
CountryCode	char(2) not null,
StateProvinceCode char(2) not null,
StateProvinceName varchar(30) not null,
primary key (CountryCode, StateProvinceCode)
);

-- US States

insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'AK', 'Alaska');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'AL', 'Alabama');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'AR', 'Arkansas');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'AZ', 'Arizona');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'CA', 'California');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'CO', 'Colorado');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'CT', 'Connecticut');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'DC', 'District of Columbia');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'DE', 'Delaware');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'FL', 'Florida');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'GA', 'Georgia');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'HI', 'Hawaii');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'IA', 'Iowa');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'ID', 'Idaho');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'IL', 'Illinois');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'IN', 'Indiana');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'KS', 'Kansas');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'KY', 'Kentucky');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'LA', 'Louisiana');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MA', 'Massachusetts');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MD', 'Maryland');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'ME', 'Maine');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MI', 'Michigan');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MN', 'Minnesota');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MO', 'Missouri');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MS', 'Mississippi');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MT', 'Montana');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'NC', 'North Carolina');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'ND', 'North Dakota');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'NE', 'Nebraska');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'NH', 'New Hampshire');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'NJ', 'New Jersey');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'NM', 'New Mexico');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'NV', 'Nevada');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'NY', 'New York');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'OH', 'Ohio');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'OK', 'Oklahoma');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'OR', 'Oregon');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'PA', 'Pennsylvania');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'RI', 'Rhode Island');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'SC', 'South Carolina');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'SD', 'South Dakota');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'TN', 'Tennessee');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'TX', 'Texas');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'UT', 'Utah');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'VA', 'Virginia');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'VT', 'Vermont');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'WA', 'Washington');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'WI', 'Wisconsin');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'WV', 'West Virginia');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'WY', 'Wyoming');

insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'AP', 'Armed Forces Pacific');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'AA', 'Armed Forces Americas');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'AE', 'Armed Forces Europe');

insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'AS', 'American Samoa');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'GU', 'Guam');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MP', 'Northern Mariana Islands');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'PR', 'Puerto Rico');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'VI', 'Virgin Islands'); 
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'FM', 'Federated States of Micronesia');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'MH', 'Marshall Islands');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('US', 'PW', 'Palau');

-- Canada

insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'AB', 'Alberta');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'BC', 'British Columbia');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'MB', 'Manitoba');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'NB', 'New Brunswick');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'NL', 'Newfoundland and Labrador');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'NS', 'Nova Scotia');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'NT', 'Northwest Territories');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'NU', 'Nunavut');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'ON', 'Ontario');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'PE', 'Prince Edward Island');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'QC', 'Quebec');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'SK', 'Saskatchewan');
insert into dbo.StateProvince(CountryCode, StateProvinceCode, StateProvinceName) values ('CA', 'YT', 'Yukon');

go

select * from dbo.StateProvince;
