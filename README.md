# KimLon_Family

Bài tập **Quản lý thân nhân bằng Neo4j Graph Database**.

## 1. Mục tiêu

Dự án mô hình hóa các thành viên trong gia đình dưới dạng **Node** và các mối quan hệ thân nhân dưới dạng **Relationship**. Neo4j được sử dụng để biểu diễn và truy vấn các quan hệ nhiều tầng như cha mẹ, con cái, anh chị em, vợ chồng, ông bà và hậu duệ.

## 2. Công nghệ

- Neo4j
- Cypher Query Language
- Neo4j Browser / Neo4j Bloom

## 3. Mô hình dữ liệu

### Node

```text
(:Person)
```

Thuộc tính chính:

- `person_id`: mã định danh
- `full_name`: họ tên
- `gender`: giới tính
- `birth_year`: năm sinh
- `phone`: số điện thoại
- `address`: địa chỉ

### Relationship

```text
(:Person)-[:FATHER_OF]->(:Person)
(:Person)-[:MOTHER_OF]->(:Person)
(:Person)-[:SPOUSE_OF]->(:Person)
(:Person)-[:SIBLING_OF]->(:Person)
```

## 4. Cấu trúc repository

```text
KimLon_Family/
├── README.md
├── cypher/
│   ├── 01_constraints.cypher
│   ├── 02_seed_people.cypher
│   ├── 03_relationships.cypher
│   └── 04_queries.cypher
└── docs/
    └── MO_HINH_DU_LIEU.md
```

## 5. Thứ tự chạy

Chạy lần lượt các file trong thư mục `cypher`:

1. `01_constraints.cypher` – tạo constraint/index.
2. `02_seed_people.cypher` – tạo 20 node `Person` mẫu.
3. `03_relationships.cypher` – tạo các quan hệ gia đình.
4. `04_queries.cypher` – các truy vấn dùng để kiểm tra và demo.

## 6. Một số bài toán có thể truy vấn

- Tìm cha/mẹ của một người.
- Tìm con của một người.
- Tìm anh/chị/em.
- Tìm ông bà.
- Tìm toàn bộ hậu duệ.
- Tìm đường quan hệ ngắn nhất giữa hai thành viên.
- Hiển thị toàn bộ cây quan hệ trong Neo4j Bloom.

## 7. Ghi chú

Dữ liệu trong repository là **dữ liệu mẫu phục vụ bài tập**. Có thể thay thế các node trong `02_seed_people.cypher` bằng thông tin gia đình thực tế mà không cần thay đổi mô hình tổng thể.
