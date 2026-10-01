// ============================================================
// 03_relationships.cypher
// Quan hệ cho mạng lưới thân nhân liên thông
// Chỉ lưu quan hệ gốc: SPOUSE_OF, FATHER_OF, MOTHER_OF
// Quan hệ anh/chị/em, ông/bà, cô/dì/chú/bác... được suy ra bằng truy vấn
// ============================================================

// ------------------------------------------------------------
// 1. HÔN NHÂN - THẾ HỆ 1
// ------------------------------------------------------------
MATCH (a:Person {person_id:'P001'}), (b:Person {person_id:'P002'})
MERGE (a)-[:SPOUSE_OF {since:1970}]->(b);

MATCH (a:Person {person_id:'P003'}), (b:Person {person_id:'P004'})
MERGE (a)-[:SPOUSE_OF {since:1972}]->(b);

MATCH (a:Person {person_id:'P005'}), (b:Person {person_id:'P006'})
MERGE (a)-[:SPOUSE_OF {since:1973}]->(b);

MATCH (a:Person {person_id:'P007'}), (b:Person {person_id:'P008'})
MERGE (a)-[:SPOUSE_OF {since:1974}]->(b);

// ------------------------------------------------------------
// 2. CHA/MẸ -> CON - THẾ HỆ 1 -> THẾ HỆ 2
// ------------------------------------------------------------
// Nguyễn Văn Phúc + Trần Thị Mai -> Nguyễn Tiến Tài, Nguyễn Thị Thùy Linh
MATCH (f:Person {person_id:'P001'}), (c:Person {person_id:'P009'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P002'}), (c:Person {person_id:'P009'})
MERGE (m)-[:MOTHER_OF]->(c);
MATCH (f:Person {person_id:'P001'}), (c:Person {person_id:'P011'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P002'}), (c:Person {person_id:'P011'})
MERGE (m)-[:MOTHER_OF]->(c);

// Hồ Đức Bình + Lê Ngọc Minh Nguyên -> Hồ Thị Thanh Nhã
MATCH (f:Person {person_id:'P003'}), (c:Person {person_id:'P010'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P004'}), (c:Person {person_id:'P010'})
MERGE (m)-[:MOTHER_OF]->(c);

// Lương Kiến Toàn + Trần Thị Mỹ Hạnh -> Lương Tấn Hùng
MATCH (f:Person {person_id:'P005'}), (c:Person {person_id:'P013'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P006'}), (c:Person {person_id:'P013'})
MERGE (m)-[:MOTHER_OF]->(c);

// Chu Văn Hải + Phan Mỹ Hạnh -> Chu Thế Long
MATCH (f:Person {person_id:'P007'}), (c:Person {person_id:'P015'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P008'}), (c:Person {person_id:'P015'})
MERGE (m)-[:MOTHER_OF]->(c);

// ------------------------------------------------------------
// 3. HÔN NHÂN - THẾ HỆ 2
// ------------------------------------------------------------
MATCH (a:Person {person_id:'P009'}), (b:Person {person_id:'P010'})
MERGE (a)-[:SPOUSE_OF {since:1998}]->(b);

MATCH (a:Person {person_id:'P011'}), (b:Person {person_id:'P012'})
MERGE (a)-[:SPOUSE_OF {since:1998}]->(b);

// Hai quan hệ đã được xác nhận ban đầu
MATCH (a:Person {person_id:'P013'}), (b:Person {person_id:'P014'})
MERGE (a)-[:SPOUSE_OF {since:2000}]->(b);

MATCH (a:Person {person_id:'P015'}), (b:Person {person_id:'P016'})
MERGE (a)-[:SPOUSE_OF {since:2000}]->(b);

// ------------------------------------------------------------
// 4. CHA/MẸ -> CON - THẾ HỆ 2 -> THẾ HỆ 3
// ------------------------------------------------------------
// Nguyễn Tiến Tài + Hồ Thị Thanh Nhã
MATCH (f:Person {person_id:'P009'}), (c:Person {person_id:'P017'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P010'}), (c:Person {person_id:'P017'})
MERGE (m)-[:MOTHER_OF]->(c);

MATCH (f:Person {person_id:'P009'}), (c:Person {person_id:'P018'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P010'}), (c:Person {person_id:'P018'})
MERGE (m)-[:MOTHER_OF]->(c);

MATCH (f:Person {person_id:'P009'}), (c:Person {person_id:'P019'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P010'}), (c:Person {person_id:'P019'})
MERGE (m)-[:MOTHER_OF]->(c);

// Nguyễn Thị Thùy Linh + Bùi Quang Long
MATCH (m:Person {person_id:'P011'}), (c:Person {person_id:'P020'})
MERGE (m)-[:MOTHER_OF]->(c);
MATCH (f:Person {person_id:'P012'}), (c:Person {person_id:'P020'})
MERGE (f)-[:FATHER_OF]->(c);

MATCH (m:Person {person_id:'P011'}), (c:Person {person_id:'P021'})
MERGE (m)-[:MOTHER_OF]->(c);
MATCH (f:Person {person_id:'P012'}), (c:Person {person_id:'P021'})
MERGE (f)-[:FATHER_OF]->(c);

MATCH (m:Person {person_id:'P011'}), (c:Person {person_id:'P022'})
MERGE (m)-[:MOTHER_OF]->(c);
MATCH (f:Person {person_id:'P012'}), (c:Person {person_id:'P022'})
MERGE (f)-[:FATHER_OF]->(c);

// Lương Tấn Hùng + Đỗ Võ Kim Nhi
MATCH (f:Person {person_id:'P013'}), (c:Person {person_id:'P023'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P014'}), (c:Person {person_id:'P023'})
MERGE (m)-[:MOTHER_OF]->(c);

MATCH (f:Person {person_id:'P013'}), (c:Person {person_id:'P024'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P014'}), (c:Person {person_id:'P024'})
MERGE (m)-[:MOTHER_OF]->(c);

// Chu Thế Long + Chung Nhã Quỳnh
MATCH (f:Person {person_id:'P015'}), (c:Person {person_id:'P025'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P016'}), (c:Person {person_id:'P025'})
MERGE (m)-[:MOTHER_OF]->(c);

MATCH (f:Person {person_id:'P015'}), (c:Person {person_id:'P026'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P016'}), (c:Person {person_id:'P026'})
MERGE (m)-[:MOTHER_OF]->(c);

// ------------------------------------------------------------
// 5. HÔN NHÂN - THẾ HỆ 3
// Các cuộc hôn nhân này nối các nhánh thành một mạng liên thông
// ------------------------------------------------------------
// Nguyễn <-> Chu
MATCH (a:Person {person_id:'P017'}), (b:Person {person_id:'P025'})
MERGE (a)-[:SPOUSE_OF {since:2024}]->(b);

// Nguyễn <-> Phạm (quan hệ đã xác nhận ban đầu)
MATCH (a:Person {person_id:'P018'}), (b:Person {person_id:'P027'})
MERGE (a)-[:SPOUSE_OF {since:2025}]->(b);

// Nguyễn <-> Lương
MATCH (a:Person {person_id:'P019'}), (b:Person {person_id:'P023'})
MERGE (a)-[:SPOUSE_OF {since:2025}]->(b);

// Bùi <-> Đào
MATCH (a:Person {person_id:'P020'}), (b:Person {person_id:'P028'})
MERGE (a)-[:SPOUSE_OF {since:2023}]->(b);

// Bùi <-> Vũ
MATCH (a:Person {person_id:'P022'}), (b:Person {person_id:'P029'})
MERGE (a)-[:SPOUSE_OF {since:2025}]->(b);

// Chu <-> Trần
MATCH (a:Person {person_id:'P026'}), (b:Person {person_id:'P030'})
MERGE (a)-[:SPOUSE_OF {since:2025}]->(b);

// ------------------------------------------------------------
// 6. CHA/MẸ -> CON - THẾ HỆ 3 -> THẾ HỆ 4
// ------------------------------------------------------------
// Nguyễn Kim Long + Chu Gia Hân -> Nguyễn Gia Bảo
MATCH (f:Person {person_id:'P017'}), (c:Person {person_id:'P031'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P025'}), (c:Person {person_id:'P031'})
MERGE (m)-[:MOTHER_OF]->(c);

// Nguyễn Hữu Mẫn Nghi + Phạm Gia Khang -> Phạm Ngọc Hân
MATCH (m:Person {person_id:'P018'}), (c:Person {person_id:'P032'})
MERGE (m)-[:MOTHER_OF]->(c);
MATCH (f:Person {person_id:'P027'}), (c:Person {person_id:'P032'})
MERGE (f)-[:FATHER_OF]->(c);

// Nguyễn Hoàng Long + Lương Bảo Ngọc -> Nguyễn Minh Quân
MATCH (f:Person {person_id:'P019'}), (c:Person {person_id:'P033'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P023'}), (c:Person {person_id:'P033'})
MERGE (m)-[:MOTHER_OF]->(c);

// Bùi Gia Linh + Đào Minh Thuận -> Đào Khánh Linh
MATCH (m:Person {person_id:'P020'}), (c:Person {person_id:'P034'})
MERGE (m)-[:MOTHER_OF]->(c);
MATCH (f:Person {person_id:'P028'}), (c:Person {person_id:'P034'})
MERGE (f)-[:FATHER_OF]->(c);

// Bùi Khánh An + Vũ Anh Khoa -> Vũ Gia An
MATCH (m:Person {person_id:'P022'}), (c:Person {person_id:'P035'})
MERGE (m)-[:MOTHER_OF]->(c);
MATCH (f:Person {person_id:'P029'}), (c:Person {person_id:'P035'})
MERGE (f)-[:FATHER_OF]->(c);

// Chu Gia Minh + Trần Minh Hiếu -> Trần Gia Hưng
MATCH (f:Person {person_id:'P026'}), (c:Person {person_id:'P036'})
MERGE (f)-[:FATHER_OF]->(c);
MATCH (m:Person {person_id:'P030'}), (c:Person {person_id:'P036'})
MERGE (m)-[:MOTHER_OF]->(c);

// ------------------------------------------------------------
// 7. KIỂM TRA GRAPH
// ------------------------------------------------------------
MATCH (a:Person)-[r]->(b:Person)
RETURN a, r, b;
