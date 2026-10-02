// ============================================================
// 04_queries.cypher
// Các truy vấn thường dùng cho bài toán quản lý thân nhân
// Mô hình: Person + FATHER_OF + MOTHER_OF + SPOUSE_OF
// ============================================================


// ============================================================
// A. TRA CỨU CƠ BẢN
// ============================================================

// 1. Hiển thị toàn bộ thành viên
MATCH (p:Person)
RETURN p.person_id AS id,
       p.full_name AS full_name,
       p.gender AS gender,
       p.birth_year AS birth_year
ORDER BY p.birth_year, p.full_name;


// 2. Hiển thị toàn bộ mạng quan hệ
MATCH (a:Person)-[r]->(b:Person)
RETURN a, r, b;


// 3. Tìm một người theo tên chính xác
MATCH (p:Person {full_name:'Nguyễn Kim Long'})
RETURN p;


// 4. Tìm người theo một phần tên
MATCH (p:Person)
WHERE toLower(p.full_name) CONTAINS toLower('Long')
RETURN p.person_id AS id,
       p.full_name AS full_name,
       p.birth_year AS birth_year
ORDER BY p.full_name;


// ============================================================
// B. QUAN HỆ GIA ĐÌNH TRỰC TIẾP
// ============================================================

// 5. Tìm cha và mẹ của Nguyễn Kim Long
MATCH (parent:Person)-[r:FATHER_OF|MOTHER_OF]->
      (p:Person {full_name:'Nguyễn Kim Long'})
RETURN parent.full_name AS parent,
       type(r) AS relationship;


// 6. Tìm các con của Nguyễn Tiến Tài
MATCH (p:Person {full_name:'Nguyễn Tiến Tài'})
      -[:FATHER_OF|MOTHER_OF]->
      (child:Person)
RETURN child.full_name AS child,
       child.birth_year AS birth_year
ORDER BY child.birth_year;


// 7. Tìm vợ/chồng và thông tin hôn nhân của Nguyễn Kim Long
MATCH (p:Person {full_name:'Nguyễn Kim Long'})
      -[r:SPOUSE_OF]-
      (spouse:Person)
RETURN spouse.full_name AS spouse,
       r.since AS married_since,
       r.status AS status,
       r.registered AS registered;


// 8. Tìm anh/chị/em RUỘT của Nguyễn Kim Long
// Cùng cha và cùng mẹ; không cần lưu SIBLING_OF.
MATCH (p:Person {full_name:'Nguyễn Kim Long'})
MATCH (father:Person)-[:FATHER_OF]->(p)
MATCH (mother:Person)-[:MOTHER_OF]->(p)
MATCH (father)-[:FATHER_OF]->(sibling:Person)
MATCH (mother)-[:MOTHER_OF]->(sibling)
WHERE sibling <> p
RETURN DISTINCT sibling.full_name AS sibling,
       sibling.birth_year AS birth_year
ORDER BY sibling.birth_year;


// 9. Tìm ông/bà của Nguyễn Kim Long
MATCH (grandparent:Person)
      -[:FATHER_OF|MOTHER_OF]->
      (parent:Person)
      -[:FATHER_OF|MOTHER_OF]->
      (:Person {full_name:'Nguyễn Kim Long'})
RETURN DISTINCT grandparent.full_name AS grandparent;


// 10. Tìm cháu của Nguyễn Văn Phúc
MATCH (:Person {full_name:'Nguyễn Văn Phúc'})
      -[:FATHER_OF|MOTHER_OF]->
      (:Person)
      -[:FATHER_OF|MOTHER_OF]->
      (grandchild:Person)
RETURN DISTINCT grandchild.full_name AS grandchild
ORDER BY grandchild.full_name;


// ============================================================
// C. QUAN HỆ NHIỀU TẦNG
// ============================================================

// 11. Tìm toàn bộ tổ tiên của Nguyễn Gia Bảo
MATCH path=(ancestor:Person)
      -[:FATHER_OF|MOTHER_OF*1..]->
      (:Person {full_name:'Nguyễn Gia Bảo'})
RETURN path;


// 12. Tìm toàn bộ hậu duệ của Nguyễn Văn Phúc
MATCH path=(:Person {full_name:'Nguyễn Văn Phúc'})
      -[:FATHER_OF|MOTHER_OF*1..]->
      (descendant:Person)
RETURN path;


// 13. Tìm đường quan hệ ngắn nhất giữa hai người
MATCH (a:Person {full_name:'Đào Minh Thuận'}),
      (b:Person {full_name:'Lương Kiến Toàn'})
MATCH path = shortestPath((a)-[*..15]-(b))
RETURN path;


// ============================================================
// D. QUẢN LÝ / KIỂM TRA DỮ LIỆU
// ============================================================

// 14. Liệt kê tất cả cặp vợ/chồng
MATCH (a:Person)-[r:SPOUSE_OF]-(b:Person)
WHERE a.person_id < b.person_id
RETURN a.full_name AS spouse_1,
       b.full_name AS spouse_2,
       r.since AS married_since,
       r.status AS status,
       r.registered AS registered
ORDER BY r.since;


// 15. Tìm những người chưa có quan hệ hôn nhân trong dữ liệu
MATCH (p:Person)
WHERE NOT (p)-[:SPOUSE_OF]-()
RETURN p.full_name AS full_name,
       p.birth_year AS birth_year
ORDER BY p.birth_year;


// 16. Tìm những người chưa có cha/mẹ được khai báo trong database
MATCH (p:Person)
WHERE NOT ()-[:FATHER_OF|MOTHER_OF]->(p)
RETURN p.full_name AS full_name,
       p.birth_year AS birth_year
ORDER BY p.birth_year;


// 17. Tìm node cô lập
MATCH (p:Person)
WHERE NOT (p)--()
RETURN p;


// 18. Đếm relationship theo loại
MATCH ()-[r]->()
RETURN type(r) AS relationship_type,
       count(r) AS total
ORDER BY total DESC;


// 19. Tìm người có nhiều kết nối trực tiếp nhất
MATCH (p:Person)-[r]-()
RETURN p.full_name AS full_name,
       count(r) AS degree
ORDER BY degree DESC;


// 20. Xem thuộc tính relationship
MATCH (a:Person)-[r]->(b:Person)
RETURN a.full_name AS from_person,
       type(r) AS relationship,
       properties(r) AS relationship_properties,
       b.full_name AS to_person
ORDER BY type(r), a.full_name;


// ============================================================
// E. KIỂM TRA HUYẾT THỐNG / CẬN HUYẾT TRONG 3 ĐỜI
// ============================================================

// 21. Kiểm tra HAI NGƯỜI CỤ THỂ có tổ tiên chung trong tối đa 3 bước hay không.
// Ví dụ Nguyễn Kim Long và Bùi Gia Linh.
MATCH (a:Person {full_name:'Nguyễn Kim Long'}),
      (b:Person {full_name:'Bùi Gia Linh'})
MATCH pathA=(ancestor:Person)
      -[:FATHER_OF|MOTHER_OF*1..3]->
      (a)
MATCH pathB=(ancestor)
      -[:FATHER_OF|MOTHER_OF*1..3]->
      (b)
RETURN DISTINCT
       ancestor.full_name AS common_ancestor,
       length(pathA) AS distance_to_person_1,
       length(pathB) AS distance_to_person_2;


// 22. KIỂM TRA TRƯỚC KHI KẾT HÔN.
// Thay hai tên bên dưới bằng hai người cần kiểm tra.
// Cảnh báo nếu:
// - một người là tổ tiên trực tiếp của người kia trong tối đa 3 bước; HOẶC
// - hai người có tổ tiên chung trong tối đa 3 bước.
MATCH (a:Person {full_name:'Nguyễn Kim Long'}),
      (b:Person {full_name:'Bùi Gia Linh'})
WITH a, b,
     EXISTS {
         MATCH (a)-[:FATHER_OF|MOTHER_OF*1..3]->(b)
     }
     OR
     EXISTS {
         MATCH (b)-[:FATHER_OF|MOTHER_OF*1..3]->(a)
     } AS direct_blood_relation
OPTIONAL MATCH (ancestor:Person)
      -[:FATHER_OF|MOTHER_OF*1..3]->
      (a)
WHERE EXISTS {
    MATCH (ancestor)-[:FATHER_OF|MOTHER_OF*1..3]->(b)
}
WITH a,
     b,
     direct_blood_relation,
     collect(DISTINCT ancestor.full_name) AS common_ancestors
RETURN a.full_name AS person_1,
       b.full_name AS person_2,
       common_ancestors,
       CASE
           WHEN direct_blood_relation
               THEN 'CẢNH BÁO: QUAN HỆ HUYẾT THỐNG TRỰC HỆ TRONG 3 ĐỜI'
           WHEN size(common_ancestors) > 0
               THEN 'CẢNH BÁO: CÓ TỔ TIÊN CHUNG TRONG 3 ĐỜI'
           ELSE 'KHÔNG PHÁT HIỆN QUAN HỆ HUYẾT THỐNG TRONG 3 ĐỜI'
       END AS result;


// 23. QUÉT TẤT CẢ CÁC CẶP ĐÃ KẾT HÔN VÀ CHỈ TRẢ VỀ CẶP CÓ NGUY CƠ CẬN HUYẾT.
// Nếu query trả 0 rows: không phát hiện cặp SPOUSE_OF nào vi phạm
// điều kiện huyết thống đang kiểm tra trên dữ liệu hiện có.
MATCH (a:Person)-[marriage:SPOUSE_OF]-(b:Person)
WHERE a.person_id < b.person_id

WITH a,
     b,
     marriage,
     EXISTS {
         MATCH (a)-[:FATHER_OF|MOTHER_OF*1..3]->(b)
     }
     OR
     EXISTS {
         MATCH (b)-[:FATHER_OF|MOTHER_OF*1..3]->(a)
     } AS direct_blood_relation

OPTIONAL MATCH (ancestor:Person)
      -[:FATHER_OF|MOTHER_OF*1..3]->
      (a)
WHERE EXISTS {
    MATCH (ancestor)-[:FATHER_OF|MOTHER_OF*1..3]->(b)
}

WITH a,
     b,
     marriage,
     direct_blood_relation,
     collect(DISTINCT ancestor.full_name) AS common_ancestors

WHERE direct_blood_relation = true
   OR size(common_ancestors) > 0

RETURN a.full_name AS spouse_1,
       b.full_name AS spouse_2,
       marriage.since AS married_since,
       common_ancestors,
       CASE
           WHEN direct_blood_relation
               THEN 'CẬN HUYẾT: QUAN HỆ TRỰC HỆ TRONG 3 ĐỜI'
           ELSE 'CẬN HUYẾT: CÓ TỔ TIÊN CHUNG TRONG 3 ĐỜI'
       END AS warning
ORDER BY married_since;


// 24. QUÉT TẤT CẢ CẶP NGƯỜI CÓ TỔ TIÊN CHUNG TRONG 3 ĐỜI.
// Query này không giới hạn ở các cặp đã kết hôn.
MATCH (a:Person), (b:Person)
WHERE a.person_id < b.person_id
MATCH (ancestor:Person)-[:FATHER_OF|MOTHER_OF*1..3]->(a)
MATCH (ancestor)-[:FATHER_OF|MOTHER_OF*1..3]->(b)
RETURN a.full_name AS person_1,
       b.full_name AS person_2,
       collect(DISTINCT ancestor.full_name) AS common_ancestors
ORDER BY person_1, person_2;


// ============================================================
// LƯU Ý
// ============================================================
// Phạm vi "*1..3" ở đây là tối đa 3 cạnh cha/mẹ trong graph.
// Đây là kiểm tra kỹ thuật trên dữ liệu mô phỏng phục vụ bài tập Neo4j.
// Muốn dùng cho nghiệp vụ hộ tịch/pháp lý thực tế cần xác định và triển khai
// chính xác quy tắc pháp luật tương ứng.
// ============================================================
