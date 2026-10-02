# Mô hình dữ liệu quản lý thân nhân

## 1. Mục tiêu mô hình

Hệ thống quản lý **mạng lưới thân nhân** thay vì chỉ một gia phả cùng họ. Vì vậy, nhiều gia đình có thể được kết nối thông qua:

- quan hệ cha/mẹ - con;
- quan hệ hôn nhân;
- các quan hệ gián tiếp được suy ra như anh/chị/em, ông/bà, cháu, cô/dì/chú/bác và thông gia.

Cây dữ liệu cuối cùng gồm **37 người và 58 relationship**, tạo thành một mạng thân nhân liên thông.

## 2. Vì sao dùng Neo4j

Dữ liệu thân nhân có đặc trưng là quan hệ người-người và thường phải duyệt qua nhiều tầng. Neo4j lưu relationship trực tiếp trong graph nên phù hợp với các truy vấn như:

- tìm tổ tiên/hậu duệ nhiều cấp;
- tìm quan hệ giữa hai người;
- tìm tổ tiên chung;
- kiểm tra quan hệ huyết thống trước hoặc sau khi kết hôn.

## 3. Node Person

Mỗi thành viên là một node:

```cypher
(:Person {
  person_id: 'P017',
  full_name: 'Nguyễn Kim Long',
  gender: 'Nam',
  birth_year: 2000
})
```

### Thuộc tính

| Thuộc tính | Ý nghĩa |
|---|---|
| `person_id` | Mã định danh duy nhất |
| `full_name` | Họ tên |
| `gender` | Giới tính |
| `birth_year` | Năm sinh |

Không lưu `generation`. Khái niệm thế hệ được suy ra từ số bước trên đường `FATHER_OF/MOTHER_OF`.

## 4. Relationship gốc

Hệ thống chỉ lưu ba loại relationship gốc.

### FATHER_OF

```text
(Cha)-[:FATHER_OF]->(Con)
```

Thuộc tính:

```text
{
  since: <năm sinh của con>,
  parent_type: 'biological',
  verified: true
}
```

### MOTHER_OF

```text
(Mẹ)-[:MOTHER_OF]->(Con)
```

Sử dụng cùng nhóm thuộc tính với `FATHER_OF`.

### SPOUSE_OF

```text
(Người A)-[:SPOUSE_OF]->(Người B)
```

Thuộc tính:

```text
{
  since: <năm bắt đầu hôn nhân>,
  status: 'married',
  registered: true
}
```

Về ngữ nghĩa đây là quan hệ hai chiều. Graph chỉ cần lưu một cạnh; khi truy vấn sử dụng:

```cypher
(a)-[:SPOUSE_OF]-(b)
```

## 5. Không lưu SIBLING_OF

Anh/chị/em ruột được suy ra từ cha và mẹ chung:

```cypher
MATCH (father:Person)-[:FATHER_OF]->(p:Person)
MATCH (mother:Person)-[:MOTHER_OF]->(p)
MATCH (father)-[:FATHER_OF]->(sibling:Person)
MATCH (mother)-[:MOTHER_OF]->(sibling)
WHERE sibling <> p
RETURN DISTINCT sibling;
```

Cách này giảm dữ liệu dư thừa và tránh tình trạng quan hệ cha/mẹ và `SIBLING_OF` mâu thuẫn nhau.

## 6. Quan hệ nhiều tầng

### Tổ tiên

```cypher
MATCH path=(ancestor:Person)
  -[:FATHER_OF|MOTHER_OF*1..]->
  (person:Person)
RETURN path;
```

### Hậu duệ

```cypher
MATCH path=(person:Person)
  -[:FATHER_OF|MOTHER_OF*1..]->
  (descendant:Person)
RETURN path;
```

### Đường quan hệ giữa hai người

```cypher
MATCH path = shortestPath((a)-[*..15]-(b))
RETURN path;
```

## 7. Kiểm tra huyết thống trong 3 đời

Một cặp được cảnh báo nếu dữ liệu graph cho thấy:

1. một người là tổ tiên trực tiếp của người còn lại trong tối đa 3 bước cha/mẹ; hoặc
2. hai người có ít nhất một tổ tiên chung mà mỗi người cách tổ tiên đó tối đa 3 bước cha/mẹ.

Các query cụ thể nằm trong `cypher/04_queries.cypher`.

Đây là quy tắc kiểm tra kỹ thuật phục vụ bài tập trên dữ liệu mô phỏng, không phải kết luận pháp lý.

## 8. Cây cuối cùng

File trực quan chính thức:

```text
docs/2001230451_NguyenKimLong.svg
```

Cây hiện tại có:

- 37 `Person`;
- 14 cặp `SPOUSE_OF`;
- 22 `FATHER_OF`;
- 22 `MOTHER_OF`.

Các gia đình khác họ được nối thông qua hôn nhân giữa các thế hệ, vì vậy toàn bộ dữ liệu tạo thành một mạng thân nhân chung thay vì các cụm gia đình rời rạc.
