
CREATE TABLE QUANLYSINHVIEN;


USE QUANLYSINHVIEN;








CREATE TABLE Lop(
	lop_id int identity(1,1) primary key,
	ma_lop varchar(10) not null,
)

CREATE TABLE KHOA(
	khoa_id int identity(1,1) primary key,
	name varchar(40) not null,
)
CREATE TABLE SinhVien 
( 
	sv_id varchar(5) primary key,
	ma_sinh_vien varchar(5) not null,
	email varchar(50) unique not null,
	ho_ten varchar(40) not null,
	avatar varchar(255),
	token_device varchar(255),
	create_at date default getdate(),
	id_lop int,
	id_khoa int,
	FOREIGN KEY (id_lop) references Lop(lop_id), 
	FOREIGN KEY (id_khoa) references Khoa(khoa_id), 
);

Create TRIGGER TRG_CUSTOM_ID_MASV 
ON SinhVien INSTEAD OF INSERT
AS
begin 
	SET NOCOUNT ON;
	-- CREATE VAR
	DECLARE @NEWID VARCHAR(5);
	SELECT @NEWID = 'SV' + CAST((SELECT COUNT(*) FROM SINHVIEN) + 1 AS VARCHAR(5)) ;
	DECLARE @NEWMASV VARCHAR(5);
	DECLARE @NAMEKHOA VARCHAR(5);
	DECLARE @IDKHOA INT;
	SET @IDKHOA = (SELECT (id_khoa) from inserted);
	SET @NAMEKHOA = (
		SELECT CASE 
				WHEN @IDKHOA = 1 THEN 'CN'
				WHEN @IDKHOA = 2 THEN 'KT'
				ELSE ''
		END
	)
	SELECT @NEWMASV = @NAMEKHOA + CAST((SELECT COUNT(*) FROM SINHVIEN) + 1 AS varchar);
	INSERT INTO SinhVien(sv_id, ma_sinh_vien, email, ho_ten, avatar, token_device, id_lop)
	select @NEWID,@NEWMASV,email, ho_ten, avatar, token_device, id_lop
	from inserted;
end;

Insert into Lop(ma_lop) values ('CP17037');

INSERT INTO Khoa(name) values ('công nghệ'), ('Kinh tế');


insert into SinhVien(email, ho_ten, id_lop,id_khoa) values ('huynobi@gmail.com', 'phan thanh TEO', 1,2)


select * from SinhVien

