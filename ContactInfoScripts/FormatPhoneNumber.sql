
-- Return a telephone number in (XXX) XXX-XXXX format.
-- If less than 10 digits, return empty length string
-- If more than 10 digits, make no changes to string - To allow for extensions.

if object_Id('dbo.FormatPhoneNumber') is not null
	drop function dbo.FormatPhoneNumber;
go
create function dbo.FormatPhoneNumber(
	@PhoneNumber varchar(50)
)
returns varchar(50)
as
begin
	declare @PhoneNumberLength tinyint = len(isnull(@PhoneNumber, ''));
	declare @Counter tinyint = 0;
	declare @DigitsOnly varchar(50) = '';
	while @Counter < @PhoneNumberLength
	begin
		set @Counter = @Counter + 1;
		declare @Character char(1) = substring(@PhoneNumber, @Counter, 1);
		if @Character like '[0-9]' set @DigitsOnly = @DigitsOnly + @Character;
	end
	if len(@DigitsOnly) < 10
		return '';
	if len(@DigitsOnly) = 10
		return '(' + left(@DigitsOnly, 3) + ') ' + substring(@DigitsOnly, 4, 3) + '-' + right(@DigitsOnly, 4);

	return @PhoneNumber;
end
go

-- Tests

if dbo.FormatPhoneNumber('(123) 456-7890') <> '(123) 456-7890' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('1234567890') <> '(123) 456-7890' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('123-456-7890') <> '(123) 456-7890' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('123.456.7890') <> '(123) 456-7890' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('123 456 7890') <> '(123) 456-7890' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('123-456-7890 ext 111') <> '123-456-7890 ext 111' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('123 4567890') <> '(123) 456-7890' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber(null) <> '' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('') <> '' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('asdf') <> '' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('asdf123') <> '' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('123456789') <> '' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('1234 dff 567') <> '' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('1234 dff 567 rewerwer 890') <> '(123) 456-7890' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber(' 123-456-7890') <> '(123) 456-7890' throw 50000, 'Test failed', 1;
if dbo.FormatPhoneNumber('123-456-7890 ') <> '(123) 456-7890' throw 50000, 'Test failed', 1;

go

