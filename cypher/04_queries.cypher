// ============================================================
// 04_queries.cypher
// Truy vấn demo cho mạng lưới quản lý thân nhân
// ============================================================

// 1. Hiển thị toàn bộ thành viên
MATCH (p:Person)
RETURN p.person_id AS id,
       p.full_name AS full_name,
       p.gender AS gender,
       p.birth_year AS birth_year,
       p.generation AS generation
ORDER BY p.generation, p.birth_year;

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
// Không cần lưu SIBLING_OF vì có thể suy ra từ cha/mẹ chung.
MATCH (parent:Person)-[:FATHER_OF|MOTHER_OF]->(p:Person {full_name:'Nguyễn Kim Long'})
MATCH (parent)-[:FATHER_OF|MOTHER_OF]->(sibling:Person)
WHERE sibling <> p
RETURN DISTINCT sibling.full_name AS sibling;

// 8. Tìm vợ/chồng của Nguyễn Kim Long
MATCH (:Person {full_name:'Nguyễn Kim Long'})-[:SPOUSE_OF]-(spouse:Person)
RETURN spouse.full_name AS spouse;

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

// 13. Tìm các thành viên thuộc thế hệ 3
MATCH (p:Person {generation:3})
RETURN p.full_name AS full_name,
       p.birth_year AS birth_year
ORDER BY p.birth_year;

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

// ============================================================
// TRUY VẤN KIỂM TRA QUAN HỆ HUYẾT THỐNG / CẬN HUYẾT
// ============================================================

// 16. Kiểm tra hai người có tổ tiên chung trong tối đa 4 thế hệ hay không.
// Thay tên a và b để kiểm tra cặp bất kỳ.
MATCH (a:Person {full_name:'Nguyễn Kim Long'}),
      (b:Person {full_name:'Bùi Gia Linh'})
MATCH (ancestor:Person)-[:FATHER_OF|MOTHER_OF*1..4]->(a)
MATCH (ancestor)-[:FATHER_OF|MOTHER_OF*1..4]->(b)
RETURN DISTINCT ancestor.full_name AS common_ancestor;

// Với dữ liệu hiện tại, Nguyễn Kim Long và Bùi Gia Linh là anh/chị/em họ:
// tổ tiên chung là Nguyễn Văn Phúc và Trần Thị Mai.

// 17. Kiểm tra một cặp vợ/chồng cụ thể có tổ tiên chung trong tối đa 4 thế hệ.
MATCH (a:Person {full_name:'Nguyễn Kim Long'})-[:SPOUSE_OF]-(b:Person {full_name:'Chu Gia Hân'})
OPTIONAL MATCH (ancestor:Person)-[:FATHER_OF|MOTHER_OF*1..4]->(a)
WHERE EXISTS {
    MATCH (ancestor)-[:FATHER_OF|MOTHER_OF*1..4]->(b)
}
RETURN a.full_name AS person_a,
       b.full_name AS person_b,
       collect(DISTINCT ancestor.full_name) AS common_ancestors;

// common_ancestors = [] nghĩa là không phát hiện tổ tiên chung
// trong phạm vi dữ liệu và số thế hệ đang kiểm tra.
