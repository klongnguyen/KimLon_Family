// ============================================================
// 01_constraints.cypher
// Ràng buộc và index cho bài toán quản lý thân nhân
// ============================================================

// Mỗi person_id phải là duy nhất
CREATE CONSTRAINT person_id_unique IF NOT EXISTS
FOR (p:Person)
REQUIRE p.person_id IS UNIQUE;

// Index hỗ trợ tìm kiếm theo họ tên
CREATE INDEX person_full_name_index IF NOT EXISTS
FOR (p:Person)
ON (p.full_name);

// Index hỗ trợ lọc theo năm sinh
CREATE INDEX person_birth_year_index IF NOT EXISTS
FOR (p:Person)
ON (p.birth_year);
