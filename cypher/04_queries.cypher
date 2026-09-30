// ============================================================
// 04_queries.cypher
// Một số truy vấn demo cho bài quản lý thân nhân
// ============================================================

// 1. Hiển thị toàn bộ thành viên
MATCH (p:Person)
RETURN p
ORDER BY p.birth_year;

// 2. Hiển thị toàn bộ graph
MATCH (a:Person)-[r]->(b:Person)
RETURN a, r, b;

// 3. Tìm cha của Nguyen Kim Long
MATCH (father:Person)-[:FATHER_OF]->(p:Person {full_name:'Nguyen Kim Long'})
RETURN father.full_name AS father;

// 4. Tìm mẹ của Nguyen Kim Long
MATCH (mother:Person)-[:MOTHER_OF]->(p:Person {full_name:'Nguyen Kim Long'})
RETURN mother.full_name AS mother;

// 5. Tìm cả cha và mẹ của Nguyen Kim Long
MATCH (parent:Person)-[:FATHER_OF|MOTHER_OF]->(p:Person {full_name:'Nguyen Kim Long'})
RETURN parent.full_name AS parent;

// 6. Tìm con của Nguyen Van Nam
MATCH (p:Person {full_name:'Nguyen Van Nam'})-[:FATHER_OF|MOTHER_OF]->(child:Person)
RETURN child.full_name AS child;

// 7. Tìm anh/chị/em của Nguyen Kim Long
MATCH (p:Person {full_name:'Nguyen Kim Long'})-[:SIBLING_OF]-(sibling:Person)
RETURN sibling.full_name AS sibling;

// 8. Tìm vợ/chồng của Nguyen Kim Long
MATCH (p:Person {full_name:'Nguyen Kim Long'})-[:SPOUSE_OF]-(spouse:Person)
RETURN spouse.full_name AS spouse;

// 9. Tìm ông bà của Nguyen Kim Long
MATCH (grandparent:Person)-[:FATHER_OF|MOTHER_OF]->(parent:Person)
      -[:FATHER_OF|MOTHER_OF]->(p:Person {full_name:'Nguyen Kim Long'})
RETURN DISTINCT grandparent.full_name AS grandparent;

// 10. Tìm toàn bộ hậu duệ của Nguyen Van Minh
MATCH path=(p:Person {full_name:'Nguyen Van Minh'})
      -[:FATHER_OF|MOTHER_OF*1..]->(descendant:Person)
RETURN path;

// 11. Tìm toàn bộ tổ tiên của Nguyen Duc An
MATCH path=(ancestor:Person)
      -[:FATHER_OF|MOTHER_OF*1..]->(p:Person {full_name:'Nguyen Duc An'})
RETURN path;

// 12. Tìm đường quan hệ ngắn nhất giữa hai người
MATCH (a:Person {full_name:'Nguyen Kim Long'}),
      (b:Person {full_name:'Tran Gia Bao'})
MATCH path = shortestPath((a)-[*..10]-(b))
RETURN path;

// 13. Tìm các thành viên cùng thế hệ sinh từ năm 2000 trở đi
MATCH (p:Person)
WHERE p.birth_year >= 2000
RETURN p.full_name AS full_name, p.birth_year AS birth_year
ORDER BY p.birth_year;

// 14. Đếm số lượng relationship theo loại
MATCH ()-[r]->()
RETURN type(r) AS relationship_type, count(r) AS total
ORDER BY total DESC;

// 15. Tìm người có nhiều kết nối trực tiếp nhất
MATCH (p:Person)-[r]-()
RETURN p.full_name AS full_name, count(r) AS degree
ORDER BY degree DESC;
