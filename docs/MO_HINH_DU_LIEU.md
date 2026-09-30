# Mô hình dữ liệu quản lý thân nhân

## 1. Lý do chọn Neo4j

Bài toán quản lý thân nhân có đặc trưng là dữ liệu liên kết chặt chẽ giữa người với người. Mỗi thành viên có thể có nhiều mối quan hệ như cha, mẹ, con, vợ/chồng, anh/chị/em và các quan hệ gián tiếp như ông bà, cháu hoặc họ hàng nhiều thế hệ.

Neo4j phù hợp vì các mối quan hệ được lưu trực tiếp trong graph và có thể được duyệt qua nhiều cấp bằng Cypher mà không cần thực hiện nhiều phép JOIN như trong cơ sở dữ liệu quan hệ.

## 2. Node Person

Mỗi thành viên được biểu diễn bằng một node có label `Person`.

```cypher
(:Person {
  person_id: 'P09',
  full_name: 'Nguyen Kim Long',
  gender: 'Nam',
  birth_year: 2003,
  phone: '0901000009',
  address: 'Ho Chi Minh City'
})
```

`person_id` là khóa định danh duy nhất cho mỗi người.

## 3. Các loại relationship

### FATHER_OF

```text
(Cha)-[:FATHER_OF]->(Con)
```

Biểu diễn quan hệ cha - con.

### MOTHER_OF

```text
(Mẹ)-[:MOTHER_OF]->(Con)
```

Biểu diễn quan hệ mẹ - con.

### SPOUSE_OF

```text
(Người A)-[:SPOUSE_OF]->(Người B)
```

Biểu diễn quan hệ vợ/chồng. Trong graph chỉ cần lưu một cạnh và khi truy vấn sử dụng relationship không định hướng `-[:SPOUSE_OF]-`.

### SIBLING_OF

```text
(Người A)-[:SIBLING_OF]->(Người B)
```

Biểu diễn quan hệ anh/chị/em. Tương tự `SPOUSE_OF`, khi truy vấn có thể dùng `-[:SIBLING_OF]-` để xét cả hai hướng.

## 4. Quan hệ nhiều thế hệ

Ví dụ:

```text
Ông/Bà
  ↓
Cha/Mẹ
  ↓
Con
  ↓
Cháu
```

Cypher cho phép duyệt quan hệ cha/mẹ qua nhiều cấp:

```cypher
MATCH path=(ancestor:Person)-[:FATHER_OF|MOTHER_OF*1..]->(person:Person)
RETURN path;
```

Nhờ đó hệ thống có thể tìm tổ tiên hoặc hậu duệ mà không cần biết trước chính xác số thế hệ.

## 5. Các chức năng có thể triển khai

- Quản lý hồ sơ thành viên.
- Thêm/xóa/cập nhật quan hệ thân nhân.
- Tìm cha, mẹ, con, anh/chị/em, vợ/chồng.
- Tìm ông bà và cháu.
- Tìm toàn bộ tổ tiên hoặc hậu duệ.
- Tìm đường quan hệ ngắn nhất giữa hai người.
- Trực quan hóa cây gia đình trên Neo4j Bloom.

## 6. Dữ liệu mẫu

Repository hiện có 20 node `Person` mẫu, được chia thành nhiều thế hệ để phục vụ việc kiểm thử các truy vấn graph. Dữ liệu này chỉ dùng cho mục đích học tập và có thể thay bằng dữ liệu thực tế sau này.
