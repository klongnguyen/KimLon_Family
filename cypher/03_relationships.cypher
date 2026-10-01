// ============================================================
// 03_relationships.cypher
// Quan hệ cho mạng lưới thân nhân liên thông
// Quan hệ gốc: SPOUSE_OF, FATHER_OF, MOTHER_OF
// Các quan hệ như anh/chị/em, ông/bà, cô/dì/chú/bác... được suy ra khi truy vấn
// ============================================================

// ------------------------------------------------------------
// 1. QUAN HỆ VỢ CHỒNG
// Thuộc tính:
// - since: năm bắt đầu hôn nhân
// - status: tình trạng hôn nhân hiện tại
// - registered: có đăng ký kết hôn trong dữ liệu mô phỏng
// ------------------------------------------------------------
UNWIND [
    {a:'P001', b:'P002', since:1970},
    {a:'P003', b:'P004', since:1972},
    {a:'P005', b:'P006', since:1973},
    {a:'P007', b:'P008', since:1974},

    {a:'P009', b:'P010', since:1998},
    {a:'P011', b:'P012', since:1998},
    {a:'P013', b:'P014', since:2000},
    {a:'P015', b:'P016', since:2000},

    {a:'P017', b:'P025', since:2024},
    {a:'P018', b:'P027', since:2025},
    {a:'P019', b:'P023', since:2025},
    {a:'P020', b:'P028', since:2023},
    {a:'P037', b:'P029', since:2025},
    {a:'P022', b:'P030', since:2025}
] AS rel
MATCH (a:Person {person_id:rel.a}), (b:Person {person_id:rel.b})
MERGE (a)-[r:SPOUSE_OF]->(b)
SET r.since = rel.since,
    r.status = 'married',
    r.registered = true;

// ------------------------------------------------------------
// 2. QUAN HỆ CHA -> CON
// Thuộc tính:
// - since: năm sinh của người con
// - parent_type: biological = cha ruột
// - verified: quan hệ đã được xác nhận trong dữ liệu bài tập
// ------------------------------------------------------------
UNWIND [
    {parent:'P001', child:'P009', since:1974},
    {parent:'P001', child:'P011', since:1977},
    {parent:'P003', child:'P010', since:1976},
    {parent:'P005', child:'P013', since:1978},
    {parent:'P007', child:'P015', since:1979},

    {parent:'P009', child:'P017', since:2000},
    {parent:'P009', child:'P018', since:2002},
    {parent:'P009', child:'P019', since:2004},

    {parent:'P012', child:'P020', since:1999},
    {parent:'P012', child:'P021', since:2002},
    {parent:'P012', child:'P022', since:2005},

    {parent:'P013', child:'P023', since:2001},
    {parent:'P013', child:'P024', since:2005},

    {parent:'P015', child:'P025', since:2000},
    {parent:'P015', child:'P026', since:2003},
    {parent:'P015', child:'P037', since:2002},

    {parent:'P017', child:'P031', since:2025},
    {parent:'P027', child:'P032', since:2026},
    {parent:'P019', child:'P033', since:2026},
    {parent:'P028', child:'P034', since:2025},
    {parent:'P029', child:'P035', since:2026},
    {parent:'P030', child:'P036', since:2026}
] AS rel
MATCH (parent:Person {person_id:rel.parent}), (child:Person {person_id:rel.child})
MERGE (parent)-[r:FATHER_OF]->(child)
SET r.since = rel.since,
    r.parent_type = 'biological',
    r.verified = true;

// ------------------------------------------------------------
// 3. QUAN HỆ MẸ -> CON
// Thuộc tính tương tự FATHER_OF
// ------------------------------------------------------------
UNWIND [
    {parent:'P002', child:'P009', since:1974},
    {parent:'P002', child:'P011', since:1977},
    {parent:'P004', child:'P010', since:1976},
    {parent:'P006', child:'P013', since:1978},
    {parent:'P008', child:'P015', since:1979},

    {parent:'P010', child:'P017', since:2000},
    {parent:'P010', child:'P018', since:2002},
    {parent:'P010', child:'P019', since:2004},

    {parent:'P011', child:'P020', since:1999},
    {parent:'P011', child:'P021', since:2002},
    {parent:'P011', child:'P022', since:2005},

    {parent:'P014', child:'P023', since:2001},
    {parent:'P014', child:'P024', since:2005},

    {parent:'P016', child:'P025', since:2000},
    {parent:'P016', child:'P026', since:2003},
    {parent:'P016', child:'P037', since:2002},

    {parent:'P025', child:'P031', since:2025},
    {parent:'P018', child:'P032', since:2026},
    {parent:'P023', child:'P033', since:2026},
    {parent:'P020', child:'P034', since:2025},
    {parent:'P037', child:'P035', since:2026},
    {parent:'P022', child:'P036', since:2026}
] AS rel
MATCH (parent:Person {person_id:rel.parent}), (child:Person {person_id:rel.child})
MERGE (parent)-[r:MOTHER_OF]->(child)
SET r.since = rel.since,
    r.parent_type = 'biological',
    r.verified = true;

// ------------------------------------------------------------
// 4. KIỂM TRA TOÀN BỘ GRAPH
// ------------------------------------------------------------
MATCH (a:Person)-[r]->(b:Person)
RETURN a, r, b;
