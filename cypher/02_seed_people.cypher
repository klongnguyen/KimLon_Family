// ============================================================
// 02_seed_people.cypher
// Seed dữ liệu cho bài toán quản lý thân nhân bằng Neo4j
// Tổng cộng: 37 thành viên, gồm 17 tên ban đầu + các thành viên bổ sung
// Không lưu thuộc tính generation; thế hệ được suy ra từ quan hệ cha/mẹ -> con
// ============================================================

// Nếu muốn xóa dữ liệu Person cũ trước khi seed lại, chạy thủ công:
// MATCH (p:Person) DETACH DELETE p;

UNWIND [
    {person_id:'P001', full_name:'Nguyễn Văn Phúc',       gender:'Nam', birth_year:1948},
    {person_id:'P002', full_name:'Trần Thị Mai',          gender:'Nữ',  birth_year:1950},

    {person_id:'P003', full_name:'Hồ Đức Bình',           gender:'Nam', birth_year:1950},
    {person_id:'P004', full_name:'Lê Ngọc Minh Nguyên',   gender:'Nữ',  birth_year:1952},

    {person_id:'P005', full_name:'Lương Kiến Toàn',       gender:'Nam', birth_year:1951},
    {person_id:'P006', full_name:'Trần Thị Mỹ Hạnh',      gender:'Nữ',  birth_year:1953},

    {person_id:'P007', full_name:'Chu Văn Hải',           gender:'Nam', birth_year:1952},
    {person_id:'P008', full_name:'Phan Mỹ Hạnh',          gender:'Nữ',  birth_year:1954},

    {person_id:'P009', full_name:'Nguyễn Tiến Tài',       gender:'Nam', birth_year:1974},
    {person_id:'P010', full_name:'Hồ Thị Thanh Nhã',      gender:'Nữ',  birth_year:1976},
    {person_id:'P011', full_name:'Nguyễn Thị Thùy Linh',  gender:'Nữ',  birth_year:1977},
    {person_id:'P012', full_name:'Bùi Quang Long',         gender:'Nam', birth_year:1975},

    {person_id:'P013', full_name:'Lương Tấn Hùng',         gender:'Nam', birth_year:1978},
    {person_id:'P014', full_name:'Đỗ Võ Kim Nhi',          gender:'Nữ',  birth_year:1980},

    {person_id:'P015', full_name:'Chu Thế Long',           gender:'Nam', birth_year:1979},
    {person_id:'P016', full_name:'Chung Nhã Quỳnh',        gender:'Nữ',  birth_year:1981},

    {person_id:'P017', full_name:'Nguyễn Kim Long',        gender:'Nam', birth_year:2000},
    {person_id:'P018', full_name:'Nguyễn Hữu Mẫn Nghi',   gender:'Nữ',  birth_year:2002},
    {person_id:'P019', full_name:'Nguyễn Hoàng Long',      gender:'Nam', birth_year:2004},

    {person_id:'P020', full_name:'Bùi Gia Linh',           gender:'Nữ',  birth_year:1999},
    {person_id:'P021', full_name:'Bùi Minh Kha',           gender:'Nam', birth_year:2002},
    {person_id:'P022', full_name:'Bùi Khánh An',           gender:'Nữ',  birth_year:2005},

    {person_id:'P023', full_name:'Lương Bảo Ngọc',         gender:'Nữ',  birth_year:2001},
    {person_id:'P024', full_name:'Lương Minh Khôi',        gender:'Nam', birth_year:2005},

    {person_id:'P025', full_name:'Chu Gia Hân',            gender:'Nữ',  birth_year:2000},
    {person_id:'P026', full_name:'Chu Gia Minh',           gender:'Nam', birth_year:2003},
    {person_id:'P037', full_name:'Chu Gia My',             gender:'Nữ',  birth_year:2002},

    {person_id:'P027', full_name:'Phạm Gia Khang',         gender:'Nam', birth_year:2001},
    {person_id:'P028', full_name:'Đào Minh Thuận',         gender:'Nam', birth_year:1999},
    {person_id:'P029', full_name:'Vũ Anh Khoa',            gender:'Nam', birth_year:2002},
    {person_id:'P030', full_name:'Trần Minh Hiếu',         gender:'Nam', birth_year:2003},

    {person_id:'P031', full_name:'Nguyễn Gia Bảo',         gender:'Nam', birth_year:2025},
    {person_id:'P032', full_name:'Phạm Ngọc Hân',          gender:'Nữ',  birth_year:2026},
    {person_id:'P033', full_name:'Nguyễn Minh Quân',       gender:'Nam', birth_year:2026},
    {person_id:'P034', full_name:'Đào Khánh Linh',         gender:'Nữ',  birth_year:2025},
    {person_id:'P035', full_name:'Vũ Gia An',              gender:'Nam', birth_year:2026},
    {person_id:'P036', full_name:'Trần Gia Hưng',          gender:'Nam', birth_year:2026}
] AS person

MERGE (p:Person {person_id: person.person_id})
SET p.full_name  = person.full_name,
    p.gender     = person.gender,
    p.birth_year = person.birth_year
REMOVE p.generation;

// Kiểm tra kết quả seed
MATCH (p:Person)
RETURN p.person_id AS id,
       p.full_name AS full_name,
       p.gender AS gender,
       p.birth_year AS birth_year
ORDER BY p.birth_year, p.full_name;
