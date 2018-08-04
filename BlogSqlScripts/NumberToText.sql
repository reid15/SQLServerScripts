
-- Convert a number to its text representation - 1 = one, 15 = fifteen, etc
-- Handle any positive int (up to 2,147,483,647)

-- Table of numeric text

drop table if exists dbo.NumberText;

create table dbo.NumberText(
Number char(1) not null primary key,
NumberText varchar(10) not null,
NumberTeenText varchar(10) not null,
NumberTenText varchar(10) not null
);

insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('0', '', 'ten', '');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('1', 'one', 'eleven', '');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('2', 'two', 'twelve', 'twenty');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('3', 'three', 'thirteen', 'thirty');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('4', 'four', 'fourteen', 'forty');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('5', 'five', 'fifteen', 'fifty');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('6', 'six', 'sixteen', 'sixty');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('7', 'seven', 'seventeen', 'seventy');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('8', 'eight', 'eighteen', 'eighty');
insert into dbo.NumberText(Number, NumberText, NumberTeenText, NumberTenText) values ('9', 'nine', 'nineteen', 'ninety');

--select * from #Number;

-- Function

drop function if exists dbo.ReturnNumberText;
go
create function dbo.ReturnNumberText(
	@InputNumber int
)
returns varchar(150)
as
begin

if (@InputNumber < 0)
	return 'Error - Negative number';

if (@InputNumber = 0)
	return 'zero';

declare @InputNumberText varchar(10) = cast(@InputNumber as varchar(20));

declare @NumberLength tinyint = len(@InputNumberText);
declare @Counter tinyint = 1;
declare @NumberText varchar(150) = '';
declare @LastThreeDigits char(3) = '';

while @Counter <= @NumberLength
  begin
	declare @InputNumberTextLocal varchar(100) = substring(@InputNumberText, @Counter, 1);
	declare @NumberTextLocal varchar(100) = '';
	declare @DistanceFromEnd tinyint = (@NumberLength - @Counter);

	-- Handle teens
	if (@DistanceFromEnd in (1,4,7))
		if @InputNumberTextLocal = '1'
		  begin
			set @Counter += 1;
			set @InputNumberTextLocal = substring(@InputNumberText, @Counter, 1)
			select @NumberTextLocal = NumberTeenText from dbo.NumberText where Number = @InputNumberTextLocal;
		  end
		else
			select @NumberTextLocal = NumberTenText from dbo.NumberText where Number = @InputNumberTextLocal;
	else
	-- Regular path
		select @NumberTextLocal = NumberText from dbo.NumberText where Number = @InputNumberTextLocal;
		
	-- Handle hundreds 
	if (@NumberTextLocal <> '') and (((@DistanceFromEnd + 1) % 3) = 0)
		set @NumberTextLocal = @NumberTextLocal + ' hundred';

	if @NumberText <> '' set @NumberText = @NumberText + ' ';
	set @NumberText = rtrim(@NumberText + @NumberTextLocal);

	set @LastThreeDigits = substring(@InputNumberText, @Counter - 2, 3);
	set @DistanceFromEnd = (@NumberLength - @Counter);

	if ((@DistanceFromEnd % 3) = 0) and (cast(@LastThreeDigits as smallint) <> 0)
	begin
		if (@DistanceFromEnd / 3 = 3) 
			set @NumberText = @NumberText + ' billion';
		else if (@DistanceFromEnd / 3 = 2) 
			set @NumberText = @NumberText + ' million';
		else if (@DistanceFromEnd / 3 = 1) 
			set @NumberText = @NumberText + ' thousand';
	end

	set @Counter += 1;
  end

return @NumberText;
end

go

-- Tests

if dbo.ReturnNumberText(0) <> 'zero' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(1) <> 'one' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(5) <> 'five' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(10) <> 'ten' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(11) <> 'eleven' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(16) <> 'sixteen' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(20) <> 'twenty ' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(34) <> 'thirty four' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(100) <> 'one hundred  ' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(225) <> 'two hundred twenty five' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(1000) <> 'one thousand' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(6457) <> 'six thousand four hundred fifty seven' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(10000) <> 'ten thousand' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(16827) <> 'sixteen thousand eight hundred twenty seven' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(99999) <> 'ninety nine thousand nine hundred ninety nine' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(100000) <> 'one hundred thousand' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(100578) <> 'one hundred thousand five hundred seventy eight' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(756993) <> 'seven hundred fifty six thousand nine hundred ninety three' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(1000000) <> 'one million' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(1342975) <> 'one million three hundred forty two thousand nine hundred seventy five' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(1000000000) <> 'one billion' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(1234567890) <> 'one billion two hundred thirty four million five hundred sixty seven thousand eight hundred ninety' throw 50000, 'Test failed', 1;
if dbo.ReturnNumberText(2147483647) <> 'two billion one hundred forty seven million four hundred eighty three thousand six hundred forty seven' throw 50000, 'Test failed', 1;

go

