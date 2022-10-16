create database QuanLyCHTienLoi
use QuanLyCHTienLoi

/*CREATE TABLE NHANVIEN*/
/*Nhân viên : mã nv, tên nv, giới tính, quê quán, ngày sinh, ngày vào làm,sdt chức vụ*/
create table tblNhanVien(
	iMaNV int identity(1,1) primary key(iMaNV),
	sTenNV nvarchar(70),
	iGioiTinh int,
	sQueQuan nvarchar(255),
	dNgaySinh date,
	dNgayVaoLam date,
	sSDT varchar(15),
	trangthai bit null
);

--drop table tblNhanVien
-- CREATE TABLE CATEGORY ACCOUNT
/*+ Loại tài khoản: mã loại tk, tên loạitk.*/
create table tblLoaiTaiKhoan(
	iMaLoaiTK int identity(1,1) primary key (iMaLoaiTK),
	sTenLoaiTK nvarchar(100)
) 

-- CREATE TABLE ACCOUNT
/* Tài khoản:mã tk, tên đăng nhập, mật khẩu, mã loại tk, mã nv.*/
create table tblTaiKhoan(
	iMaTK int identity(1,1) primary key (iMaTK),
	STenDangNhap nvarchar(50),
	sMatKhau varchar(50),
	iMaLoaiTK int,
	iMaNV int
)
-- khóa ngoại cho bảng tài khoản
alter table tblTaiKhoan 
 add constraint fk_TK_tblLoaiTK foreign key (iMaLoaiTK) references tblLoaiTaiKhoan(iMaLoaiTK)
 alter table tblTaiKhoan 
 add constraint fk_TK_tblNhanVien foreign key (iMaNV) references tblNhanVien(iMaNV)

 -- CREATE TABLE NHACUNGCAP
 /*Nhà cung cấp: mã ncc, tên ncc, địa chỉ, sdt*/
 create table tblNhaCC(
	iMaNCC int identity(1,1) primary key (iMaNCC),
	sTenNCC nvarchar(255),
	sDiaChi nvarchar(255),
	sSdt varchar(20)
 )
-- CREATE TABLE LOAISANPHAM
/*loại sản phẩm : mã loại sp, tên loại sản phẩm.*/
create table tblLoaiSanPham(
   iMaLoaiSP int identity(1,1) primary key(iMaLoaiSP),
   sTenLoaiSP nvarchar(100)
)
--CREATE TABLE SANPHAM
/*sản phẩm: mã sp,tên sp,mã loại sp,mã ncc, giá, số lượng, đơn vị tính, ngày sản xuất, hạn sử dụng.*/
create table tblSanPham (
  iMaSP int identity(1,1) primary key(iMaSP),
  sTenSP nvarchar(100),
  iMaLoaiSP int,
  iMaNCC int,
  fGia float,
  iSoLuong int,
  sDonViTinh nvarchar(10),
  dNgaySX date,
  dHanSD date,
  sHinhAnh nvarchar(50) null
)  
/* tạo khóa ngoại bảng sản phẩm */
alter table tblSanPham
add constraint fk_SP_LoaiSP foreign key(iMaLoaiSP) references tblLoaiSanPham(iMaLoaiSP)
alter table tblSanPham
add constraint fk_SP_NCC foreign key(iMaNCC) references tblNhaCC(iMaNCC)

-- CREATE TABLE HÓA ĐƠN BÁN HÀNG
/*Hóa đơn bán hàng: mã hd,mã nv bán, ngày lập, tổng tiền*/
create table tblHoaDonBan(
  iMaHDB int identity(1,1) primary key(iMaHDB),
  iMaNV  int,
  dNgayLap date,
  fTongTien float,
  iTrangThai int
)

-- CREATE TABLE CHI TIẾT HÓA ĐƠN BÁN HÀNG
/*Chi tiết hóa đơn bán : mã hd, mã sp, số lượng bán*/
create table tblChiTietHDB(
	iMaHDB int,
	iMaSP int primary key (iMaHDB,iMaSP),
	iSoLuongBan int
)
/*tạo liên kết khóa ngoại cho tbl chi tiết đơn mua hàng*/
 alter table tblChiTietHDB
 add constraint fk_CTHDB_HDB foreign key(iMaHDB) references tblHoaDonBan(iMaHDB)
 alter table tblChiTietHDB
 add constraint fk_CTHDB_SP foreign key(iMaSP) references tblSanPham(iMaSP)
 /*tạo liên kết khóa ngoại cho tbl Hóa Đơn Bán*/
 alter table tblHoaDonBan
 add constraint fk_HDB_NV foreign key(iMaNV) references tblNhanVien(iMaNV)

 -- CREATE TABLE HÓA ĐƠN NHẬP HÀNG
/*Hóa đơn bán hàng: mã hd,mã nv nhập, ngày lập,tổng tiền nhập*/
create table tblHoaDonNhap(
  iMaHDN int identity(1,1) primary key(iMaHDN),
  iMaNV  int,
  dNgayLap date,
  fTongTien float,
  iTrangThai bit null
)

-- CREATE TABLE CHI TIẾT HÓA ĐƠN NHẬP HÀNG
/*Chi tiết hóa đơn Nhập : mã hd, mã sp, số lượng nhập*/
create table tblChiTietHDN(
	iMaHDN int,
	iMaSP int primary key (iMaHDN,iMaSP),
	iSoLuongNhap int,
	fGiaNhap float null
)
/*tạo liên kết khóa ngoại cho tbl chi tiết đơn nhập hàng*/
 alter table tblChiTietHDN
 add constraint fk_CTHDN_HDN foreign key(iMaHDN) references tblHoaDonNhap(iMaHDN)
 alter table tblChiTietHDN
 add constraint fk_CTHDN_SP foreign key(iMaSP) references tblSanPham(iMaSP)
 /*tạo liên kết khóa ngoại cho tbl Hóa Đơn Nhập*/
 alter table tblHoaDonNhap
 add constraint fk_HDN_NV foreign key(iMaNV) references tblNhanVien(iMaNV)
 -- thêm thông tin
 insert into tblLoaiTaiKhoan
 values('chusohuu');
  insert into tblLoaiTaiKhoan
 values('quanly');
  insert into tblLoaiTaiKhoan
 values('nhanvienbanhang');
   insert into tblLoaiTaiKhoan
 values('nhanvienkho');


  -- thêm nhân viên
 insert into tblNhanVien values(N'Nguyễn Văn Đoàn',1,N'Hà Nội','2000-06-26','2020-10-19','0352337342',0);
 -- thêm tài khoản
 insert into tblTaiKhoan values('vandoan','123',2,1);



-- thêm NCC 
insert into tblNhaCC values (N'VinCommerce',N'20 Lý Thường Kiệt, Hoàn Kiếm, Hà Nội','04.3934 7628')
insert into tblNhaCC values (N'KFC',N'Số 1, Lô 13B, KĐT Mới Trung Yên,  Quận Cầu Giấy, Hà Nội','04.3935 6578')
insert into tblNhaCC values (N'Vifoodshop',N'164 Vương Thừa Vũ, Thanh Xuân, Hà Nội','0342.387.630')

insert into tblNhaCC values (N'Công ty cổ phần Bia - Rượu - Nước giải khát Hà Nội',N'83 Hoàng Hoa Thám, Ba Đình, Hà Nội.','0243 845 843')
-- thêm Loai SanPham
insert into tblLoaiSanPham values(N'Rau-Củ-Qủa') -- VinCommerce /1 
insert into tblLoaiSanPham values(N'Bánh Mì')    -- VinCommerce /2
insert into tblLoaiSanPham values(N'Sữa')		 -- VinCommerce /3
insert into tblLoaiSanPham values(N'Bim Bim')    -- KFC /4
insert into tblLoaiSanPham values(N'Mì Tôm')     -- KFC /5
insert into tblLoaiSanPham values(N'Nước Ngọt')  --  Nước giải khát Hà Nội /6
insert into tblLoaiSanPham values(N'Rượu')       --  Nước giải khát Hà Nội /7
insert into tblLoaiSanPham values(N'Bia')        --  Nước giải khát Hà Nội /8
insert into tblLoaiSanPham values(N'Chocolate')  -- Vifoodshop /9
insert into tblLoaiSanPham values(N'Xà Phòng')   -- -- Vifoodshop /10
go
-- thêm SanPham
-- Rau củ quả
insert into tblSanPham values(N'Rau Cải Ngồng',1,1,10000,50,'VND','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Táo',1,1,20000,50,'KG','2021-09-23','2021-10-23',null)
-- Bánh Mì
insert into tblSanPham values(N'Bánh Mì Cháy',2,1,20000,50,'Cái','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Bánh Mì Ruốc',2,1,20000,50,'Cái','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Bánh Mì Bơ',2,1,20000,50,'Cái','2021-09-23','2021-10-23',null)
-- Sữa
insert into tblSanPham values(N'Sữa Bò',3,1,30000,50,N'Hộp','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Sữa Ông Thọ',3,1,30000,50,N'Hộp','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Sữa MiLo',3,1,20000,50,N'Hộp','2021-09-23','2021-10-23',null)
-- Bim Bim
insert into tblSanPham values(N'Bim Bim khoai Tây',4,2,10000,50,'Gói','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Bim Bim Chuối',4,2,10000,50,'Gói','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Bim Bim Cà Chua',4,2,10000,50,'Gói','2021-09-23','2021-10-23',null)
-- mÌ tÔM
insert into tblSanPham values(N'Mì Tôm',5,2,5000,50,'Gói','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Bim Bim Cà Chua',5,2,5000,50,'Gói','2021-09-23','2021-10-23',null)
-- Nước Ngọt
insert into tblSanPham values(N'CoCa',6,4,10000,50,'Chai','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'FanTa',6,4,10000,50,'Chai','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Sprite',6,4,10000,50,'Chai','2021-09-23','2021-10-23',null)
-- -- Rượu
insert into tblSanPham values(N'Vodka 500ml',7,4,80000,50,'Chai','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Men 500ml',7,4,80000,50,'Chai','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'SoJu 100 ml',7,4,50000,50,'Chai','2021-09-23','2021-10-23',null)
-- Bia 
insert into tblSanPham values(N'Bia Hà Nội',8,4,20000,50,'Chai','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Bia Sài Gòn',8,4,20000,50,'Chai','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'Bia Haniken',8,4,20000,50,'Chai','2021-09-23','2021-10-23',null)
-- Chocolate
insert into tblSanPham values(N'KitKat',9,3,10000,50,'Thanh','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'MentyKit',9,3,50000,50,'Hộp','2021-09-23','2021-10-23',null)
-- Xà Phong
insert into tblSanPham values(N'O Mô',10,3,20000,50,'Gói','2021-09-23','2021-10-23',null)
insert into tblSanPham values(N'ABa',10,3,50000,50,'Gói','2021-09-23','2021-10-23',null)


-- procedure kiểm tra tài khoản bằng tendangnhap và matkhau trả về 1 tài khoản duy nhất or null
go
create proc sp_checklogin @tendangnhap nvarchar(50),@matkhau nvarchar(50)
as
begin
	select * from tblTaiKhoan
	where STenDangNhap = @tendangnhap and sMatKhau = @matkhau
end
go
