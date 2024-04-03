


CREATE TRIGGER trg_CustomID
ON SINHVIEN
INSTEAD OF INSERT 
AS 
BEGIN 
	SET NOCOUNT ON;
	-- cái này là biến
	DECLARE @NewCustomerID NVARCHAR(10);
	SELECT @NewCustomerID = 'C' + CAST((SELECT COUNT(*) FROM SINHVIEN) + 1 AS NVARCHAR(10));
	INSERT INTO SINHVIEN (ID,NAME)
	SELECT @NewCustomerID, NAME
	FROM inserted;
	-- lấy dữ liệu name từ inserted là data ảo được tạo ra khi insert

END;

INSERT INTO SINHVIEN(NAME) VALUES ('iphone 15');
