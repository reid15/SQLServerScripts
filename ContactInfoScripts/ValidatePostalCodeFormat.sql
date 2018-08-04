
-- Postal code format validation
 
if object_Id('dbo.ValidatePostalCodeFormat') is not null
	drop function dbo.ValidatePostalCodeFormat;
go
create function dbo.ValidatePostalCodeFormat(
	@CountryCode char(3),
	@PostalCode varchar(25)
)
returns bit
as
begin
	set @PostalCode = replace(@PostalCode, ' ', '');
	set @PostalCode = rtrim(ltrim((@PostalCode)));
	if len(isnull(@PostalCode, '')) = 0 return 1;
	if @CountryCode = 'US'
	begin
		if @PostalCode not like '[0-9][0-9][0-9][0-9][0-9]' and
			@PostalCode not like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' and
			@PostalCode not like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
				return 0
	end
	-- Canadian Postal codes do not include the letters D, F, I, O, Q or U
	-- Codes don't start with W or Z
	else if @CountryCode = 'CA'
	begin
		if @PostalCode not like '[A-Z][0-9][A-Z][0-9][A-Z][0-9]'
			return 0
		if @PostalCode like '[WZ]%'
			return 0
		if @PostalCode like '%[DFIOQU]%'
			return 0
	end
	return 1
end
go

-- Tests

if dbo.ValidatePostalCodeFormat('US', '10101') <> 1 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('US', '10101-1111') <> 1 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('US', '101011111') <> 1 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('US', '101011') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('US', '1010A') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('US', '10101 ') <> 1 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('US', 'A1A 1A1') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('US', '10101-') <> 0 throw 50000, 'Test failed', 1;

if dbo.ValidatePostalCodeFormat('CA', 'A1A1A1') <> 1 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'A1A 1A1') <> 1 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'A1A1AA') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'a1a1a1') <> 1 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', '10101') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'W1A1A1') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'Z1A1A1') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'A1D1A1') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'F1A1A1') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'A1A1I1') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'O1A1A1') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'A1Q1A1') <> 0 throw 50000, 'Test failed', 1;
if dbo.ValidatePostalCodeFormat('CA', 'A1A1U1') <> 0 throw 50000, 'Test failed', 1;

go

