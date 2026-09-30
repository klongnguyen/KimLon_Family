// ============================================================
// 02_seed_people.cypher
// Dữ liệu mẫu gồm 20 thành viên
// ============================================================

CREATE
(p01:Person {person_id:'P01', full_name:'Nguyen Van Minh', gender:'Nam', birth_year:1948, phone:'0901000001', address:'Ho Chi Minh City'}),
(p02:Person {person_id:'P02', full_name:'Tran Thi Hoa', gender:'Nu', birth_year:1950, phone:'0901000002', address:'Ho Chi Minh City'}),
(p03:Person {person_id:'P03', full_name:'Nguyen Van Nam', gender:'Nam', birth_year:1972, phone:'0901000003', address:'Ho Chi Minh City'}),
(p04:Person {person_id:'P04', full_name:'Le Thi Lan', gender:'Nu', birth_year:1975, phone:'0901000004', address:'Ho Chi Minh City'}),
(p05:Person {person_id:'P05', full_name:'Nguyen Van Hung', gender:'Nam', birth_year:1976, phone:'0901000005', address:'Dong Nai'}),
(p06:Person {person_id:'P06', full_name:'Pham Thi Mai', gender:'Nu', birth_year:1978, phone:'0901000006', address:'Dong Nai'}),
(p07:Person {person_id:'P07', full_name:'Nguyen Thi Huong', gender:'Nu', birth_year:1980, phone:'0901000007', address:'Can Tho'}),
(p08:Person {person_id:'P08', full_name:'Tran Van Son', gender:'Nam', birth_year:1978, phone:'0901000008', address:'Can Tho'}),
(p09:Person {person_id:'P09', full_name:'Nguyen Kim Long', gender:'Nam', birth_year:2003, phone:'0901000009', address:'Ho Chi Minh City'}),
(p10:Person {person_id:'P10', full_name:'Nguyen Thi Linh', gender:'Nu', birth_year:2006, phone:'0901000010', address:'Ho Chi Minh City'}),
(p11:Person {person_id:'P11', full_name:'Nguyen Minh Khoa', gender:'Nam', birth_year:2001, phone:'0901000011', address:'Dong Nai'}),
(p12:Person {person_id:'P12', full_name:'Nguyen Thu Trang', gender:'Nu', birth_year:2004, phone:'0901000012', address:'Dong Nai'}),
(p13:Person {person_id:'P13', full_name:'Tran Gia Bao', gender:'Nam', birth_year:2002, phone:'0901000013', address:'Can Tho'}),
(p14:Person {person_id:'P14', full_name:'Tran Ngoc Anh', gender:'Nu', birth_year:2005, phone:'0901000014', address:'Can Tho'}),
(p15:Person {person_id:'P15', full_name:'Vo Thanh Dat', gender:'Nam', birth_year:2002, phone:'0901000015', address:'Ho Chi Minh City'}),
(p16:Person {person_id:'P16', full_name:'Nguyen Bao Chau', gender:'Nu', birth_year:2003, phone:'0901000016', address:'Ho Chi Minh City'}),
(p17:Person {person_id:'P17', full_name:'Nguyen Duc An', gender:'Nam', birth_year:2025, phone:'', address:'Ho Chi Minh City'}),
(p18:Person {person_id:'P18', full_name:'Nguyen Gia Han', gender:'Nu', birth_year:2026, phone:'', address:'Ho Chi Minh City'}),
(p19:Person {person_id:'P19', full_name:'Nguyen Thanh Tung', gender:'Nam', birth_year:1955, phone:'0901000019', address:'Vinh Long'}),
(p20:Person {person_id:'P20', full_name:'Do Thi Nga', gender:'Nu', birth_year:1958, phone:'0901000020', address:'Vinh Long'});

// Kiểm tra đủ 20 node
MATCH (p:Person)
RETURN count(p) AS total_people;
