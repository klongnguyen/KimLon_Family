// ============================================================
// 03_relationships.cypher
// Tạo các relationship cho dữ liệu mẫu
// ============================================================

// --------------------
// Vợ chồng
// --------------------
MATCH (a:Person {person_id:'P01'}), (b:Person {person_id:'P02'})
MERGE (a)-[:SPOUSE_OF {since:1970}]->(b);

MATCH (a:Person {person_id:'P03'}), (b:Person {person_id:'P04'})
MERGE (a)-[:SPOUSE_OF {since:1998}]->(b);

MATCH (a:Person {person_id:'P05'}), (b:Person {person_id:'P06'})
MERGE (a)-[:SPOUSE_OF {since:1999}]->(b);

MATCH (a:Person {person_id:'P07'}), (b:Person {person_id:'P08'})
MERGE (a)-[:SPOUSE_OF {since:2000}]->(b);

MATCH (a:Person {person_id:'P19'}), (b:Person {person_id:'P20'})
MERGE (a)-[:SPOUSE_OF {since:1977}]->(b);

MATCH (a:Person {person_id:'P09'}), (b:Person {person_id:'P16'})
MERGE (a)-[:SPOUSE_OF {since:2024}]->(b);

MATCH (a:Person {person_id:'P14'}), (b:Person {person_id:'P15'})
MERGE (a)-[:SPOUSE_OF {since:2025}]->(b);

// --------------------
// Thế hệ 1 -> thế hệ 2
// P01 + P02 là cha mẹ của P03, P05, P07
// --------------------
MATCH (father:Person {person_id:'P01'}), (child:Person {person_id:'P03'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P02'}), (child:Person {person_id:'P03'})
MERGE (mother)-[:MOTHER_OF]->(child);

MATCH (father:Person {person_id:'P01'}), (child:Person {person_id:'P05'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P02'}), (child:Person {person_id:'P05'})
MERGE (mother)-[:MOTHER_OF]->(child);

MATCH (father:Person {person_id:'P01'}), (child:Person {person_id:'P07'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P02'}), (child:Person {person_id:'P07'})
MERGE (mother)-[:MOTHER_OF]->(child);

// P19 + P20 là cha mẹ của P04
MATCH (father:Person {person_id:'P19'}), (child:Person {person_id:'P04'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P20'}), (child:Person {person_id:'P04'})
MERGE (mother)-[:MOTHER_OF]->(child);

// --------------------
// Thế hệ 2 -> thế hệ 3
// --------------------
// P03 + P04 -> P09, P10
MATCH (father:Person {person_id:'P03'}), (child:Person {person_id:'P09'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P04'}), (child:Person {person_id:'P09'})
MERGE (mother)-[:MOTHER_OF]->(child);

MATCH (father:Person {person_id:'P03'}), (child:Person {person_id:'P10'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P04'}), (child:Person {person_id:'P10'})
MERGE (mother)-[:MOTHER_OF]->(child);

// P05 + P06 -> P11, P12
MATCH (father:Person {person_id:'P05'}), (child:Person {person_id:'P11'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P06'}), (child:Person {person_id:'P11'})
MERGE (mother)-[:MOTHER_OF]->(child);

MATCH (father:Person {person_id:'P05'}), (child:Person {person_id:'P12'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P06'}), (child:Person {person_id:'P12'})
MERGE (mother)-[:MOTHER_OF]->(child);

// P07 + P08 -> P13, P14
MATCH (mother:Person {person_id:'P07'}), (child:Person {person_id:'P13'})
MERGE (mother)-[:MOTHER_OF]->(child);
MATCH (father:Person {person_id:'P08'}), (child:Person {person_id:'P13'})
MERGE (father)-[:FATHER_OF]->(child);

MATCH (mother:Person {person_id:'P07'}), (child:Person {person_id:'P14'})
MERGE (mother)-[:MOTHER_OF]->(child);
MATCH (father:Person {person_id:'P08'}), (child:Person {person_id:'P14'})
MERGE (father)-[:FATHER_OF]->(child);

// --------------------
// Thế hệ 3 -> thế hệ 4
// P09 + P16 -> P17, P18
// --------------------
MATCH (father:Person {person_id:'P09'}), (child:Person {person_id:'P17'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P16'}), (child:Person {person_id:'P17'})
MERGE (mother)-[:MOTHER_OF]->(child);

MATCH (father:Person {person_id:'P09'}), (child:Person {person_id:'P18'})
MERGE (father)-[:FATHER_OF]->(child);
MATCH (mother:Person {person_id:'P16'}), (child:Person {person_id:'P18'})
MERGE (mother)-[:MOTHER_OF]->(child);

// --------------------
// Anh/chị/em ruột
// Relationship chỉ cần lưu một chiều; khi truy vấn dùng -[:SIBLING_OF]-
// --------------------
MATCH (a:Person {person_id:'P03'}), (b:Person {person_id:'P05'})
MERGE (a)-[:SIBLING_OF]->(b);
MATCH (a:Person {person_id:'P03'}), (b:Person {person_id:'P07'})
MERGE (a)-[:SIBLING_OF]->(b);
MATCH (a:Person {person_id:'P05'}), (b:Person {person_id:'P07'})
MERGE (a)-[:SIBLING_OF]->(b);

MATCH (a:Person {person_id:'P09'}), (b:Person {person_id:'P10'})
MERGE (a)-[:SIBLING_OF]->(b);

MATCH (a:Person {person_id:'P11'}), (b:Person {person_id:'P12'})
MERGE (a)-[:SIBLING_OF]->(b);

MATCH (a:Person {person_id:'P13'}), (b:Person {person_id:'P14'})
MERGE (a)-[:SIBLING_OF]->(b);

MATCH (a:Person {person_id:'P17'}), (b:Person {person_id:'P18'})
MERGE (a)-[:SIBLING_OF]->(b);

// Kiểm tra toàn bộ graph
MATCH (a:Person)-[r]->(b:Person)
RETURN a, r, b;
