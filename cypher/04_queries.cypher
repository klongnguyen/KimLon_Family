// ============================================================
// 04_queries.cypher
// Truy vấn demo cho mạng lưới quản lý thân nhân
// ============================================================

// 1. Hiển thị toàn bộ thành viên
MATCH (p:Person)
RETURN p.person_id AS id,
       p.full_name AS full_name,
       p.gender AS gender,
       p.birth_year AS birth_year
ORDER BY p.birth_year, p.full_name;

// 2. Hiển thị toàn bộ graph
MATCH (a:Person)-[r]->(b:Person)
RETURN a, r, b;

// 3. Tìm cha của Nguyễn Kim Long
MATCH (father:Person)-[:FATHER_OF]->(:Person {full_name:'Nguyễn Kim Long'})
RETURN father.full_name AS father;

// 4. Tìm mẹ của Nguyễn Kim Long
MATCH (mother:Person)-[:MOTHER_OF]->(:Person {full_name:'Nguyễn Kim Long'})
RETURN mother.full_name AS mother;

// 5. Tìm cả cha và mẹ của Nguyễn Kim Long
MATCH (parent:Person)-[:FATHER_OF|MOTHER_OF]->(:Person {full_name:'Nguyễn Kim Long'})
RETURN parent.full_name AS parent;

// 6. Tìm con của Nguyễn Tiến Tài
MATCH (:Person {full_name:'Nguyễn Tiến Tài'})-[:FATHER_OF|MOTHER_OF]->(child:Person)
RETURN child.full_name AS child
ORDER BY child.birth_year;

// 7. Tìm anh/chị/em ruột của Nguyễn Kim Long
// Không lưu SIBLING_OF; quan hệ anh/chị/em được suy ra từ cha/mẹ chung.
MATCH (parent:Person)-[:FATHER_OF|MOTHER_OF]->(p:Person {full_name:'Nguyễn Kim Long'})
MATCH (parent)-[:FATHER_OF|MOTHER_OF]->(sibling:Person)
WHERE sibling <> p
RETURN DISTINCT sibling.full_name AS sibling;

// 8. Tìm vợ/chồng của Nguyễn Kim Long và thông tin hôn nhân
MATCH (p:Person {full_name:'Nguyễn Kim Long'})-[r:SPOUSE_OF]-(spouse:Person)
RETURN spouse.full_name AS spouse,
       r.since AS married_since,
       r.status AS marriage_status,
       r.registered AS registered;

// 9. Tìm ông bà của Nguyễn Kim Long
MATCH (grandparent:Person)-[:FATHER_OF|MOTHER_OF]->(parent:Person)
      -[:FATHER_OF|MOTHER_OF]->(:Person {full_name:'Nguyễn Kim Long'})
RETURN DISTINCT grandparent.full_name AS grandparent;

// 10. Tìm toàn bộ hậu duệ của Nguyễn Văn Phúc
MATCH path=(:Person {full_name:'Nguyễn Văn Phúc'})
      -[:FATHER_OF|MOTHER_OF*1..]->(descendant:Person)
RETURN path;

// 11. Tìm toàn bộ tổ tiên của Nguyễn Gia Bảo
MATCH path=(ancestor:Person)
      -[:FATHER_OF|MOTHER_OF*1..]->(:Person {full_name:'Nguyễn Gia Bảo'})
RETURN path;

// 12. Tìm đường quan hệ ngắn nhất giữa Đào Minh Thuận và Lương Kiến Toàn
MATCH (a:Person {full_name:'Đào Minh Thuận'}),
      (b:Person {full_name:'Lương Kiến Toàn'})
MATCH path = shortestPath((a)-[*..15]-(b))
RETURN path;

// 13. Tìm các thành viên sinh trong giai đoạn 1999-2005
MATCH (p:Person)
WHERE p.birth_year >= 1999 AND p.birth_year <= 2005
RETURN p.full_name AS full_name,
       p.birth_year AS birth_year
ORDER BY p.birth_year, p.full_name;

// 14. Đếm số relationship theo loại
MATCH ()-[r]->()
RETURN type(r) AS relationship_type,
       count(r) AS total
ORDER BY total DESC;

// 15. Tìm người có nhiều kết nối trực tiếp nhất
MATCH (p:Person)-[r]-()
RETURN p.full_name AS full_name,
       count(r) AS degree
ORDER BY degree DESC;

// 16. Xem thông tin chi tiết các quan hệ cha/mẹ -> con
MATCH (parent:Person)-[r:FATHER_OF|MOTHER_OF]->(child:Person)
RETURN parent.full_name AS parent,
       type(r) AS relationship,
       child.full_name AS child,
       r.parent_type AS parent_type,
       r.since AS since,
       r.verified AS verified
ORDER BY r.since;

// 17. Liệt kê toàn bộ các cặp vợ chồng và năm kết hôn
MATCH (a:Person)-[r:SPOUSE_OF]-(b:Person)
WHERE a.person_id < b.person_id
RETURN a.full_name AS person_a,
       b.full_name AS person_b,
       r.since AS married_since,
       r.status AS status,
       r.registered AS registered
ORDER BY r.since;

// ============================================================
// TRUY VẤN KIỂM TRA QUAN HỆ HUYẾT THỐNG / CẬN HUYẾT
// ============================================================

// 18. Kiểm tra hai người có tổ tiên chung trong tối đa 4 đời hay không.
// Thay tên a và b để kiểm tra cặp bất kỳ.
MATCH (a:Person {full_name:'Nguyễn Kim Long'}),
      (b:Person {full_name:'Bùi Gia Linh'})
MATCH (ancestor:Person)-[:FATHER_OF|MOTHER_OF*1..4]->(a)
MATCH (ancestor)-[:FATHER_OF|MOTHER_OF*1..4]->(b)
RETURN DISTINCT ancestor.full_name AS common_ancestor;

// Với dữ liệu hiện tại, Nguyễn Kim Long và Bùi Gia Linh có tổ tiên chung
// là Nguyễn Văn Phúc và Trần Thị Mai.

// 19. Kiểm tra một cặp vợ chồng có tổ tiên chung trong tối đa 4 đời.
MATCH (a:Person {full_name:'Nguyễn Kim Long'})-[:SPOUSE_OF]-(b:Person {full_name:'Chu Gia Hân'})
OPTIONAL MATCH (ancestor:Person)-[:FATHER_OF|MOTHER_OF*1..4]->(a)
WHERE EXISTS {
    MATCH (ancestor)-[:FATHER_OF|MOTHER_OF*1..4]->(b)
}
RETURN a.full_name AS person_a,
       b.full_name AS person_b,
       collect(DISTINCT ancestor.full_name) AS common_ancestors;

// common_ancestors = [] nghĩa là không phát hiện tổ tiên chung
// trong phạm vi dữ liệu và số đời đang kiểm tra.
