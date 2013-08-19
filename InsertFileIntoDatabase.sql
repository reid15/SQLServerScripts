

-- Insert an image into the database
-- Image must be on the database server

declare @Image varbinary(max)

-- Update image path
set @Image = (select * from openrowset(bulk N'C:\ApprovedBodyChart_Feb09\GenericBurnsChart.jpg', single_blob) as a)
 
insert into TableName ([Image]) 
values (@Image)

go
