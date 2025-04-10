-- 1. إنشاء قاعدة البيانات
CREATE DATABASE Library;

-- استخدام قاعدة البيانات
USE Library;

-- 2. إنشاء جدول الكتب (Books)
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,  -- معرّف فريد للكتاب
    title VARCHAR(100),                      -- عنوان الكتاب
    author VARCHAR(100),                     -- مؤلف الكتاب
    year_published INT,                      -- سنة نشر الكتاب
    copies_available INT                     -- عدد النسخ المتاحة في المكتبة
);

-- 3. إنشاء جدول الأعضاء (Members)
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT, -- معرّف فريد للعضو
    name VARCHAR(100),                        -- اسم العضو
    email VARCHAR(100),                       -- بريد إلكتروني للعضو
    phone_number VARCHAR(15)                  -- رقم الهاتف للعضو
);

-- 4. إنشاء جدول المعاملات (Transactions)
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,  -- معرّف فريد للمعاملة
    member_id INT,                                  -- معرّف العضو (مرجع إلى جدول الأعضاء)
    book_id INT,                                    -- معرّف الكتاب (مرجع إلى جدول الكتب)
    borrow_date DATE,                               -- تاريخ الاستعارة
    return_date DATE,                               -- تاريخ الإرجاع
    FOREIGN KEY (member_id) REFERENCES members(member_id),  -- ربط مع جدول الأعضاء
    FOREIGN KEY (book_id) REFERENCES books(book_id)         -- ربط مع جدول الكتب
);

-- 5. إدخال بيانات الكتب (Books)
INSERT INTO books (title, author, year_published, copies_available)
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 5),
('1984', 'George Orwell', 1949, 3),
('To Kill a Mockingbird', 'Harper Lee', 1960, 4);

-- 6. إدخال بيانات الأعضاء (Members)
INSERT INTO members (name, email, phone_number)
VALUES 
('Alice Johnson', 'alice@example.com', '1234567890'),
('Bob Smith', 'bob@example.com', '9876543210');

-- 7. إدخال بيانات المعاملات (Transactions)
INSERT INTO transactions (member_id, book_id, borrow_date, return_date)
VALUES 
(1, 1, '2025-04-01', '2025-04-15'),
(2, 2, '2025-04-05', '2025-04-12');

-- 8. استعلامات SQL

-- عرض جميع الكتب (Books)
SELECT * FROM books;

-- عرض جميع الأعضاء (Members)
SELECT * FROM members;

-- عرض جميع المعاملات (Transactions)
SELECT * FROM transactions;

-- عرض الكتب المستعارة بواسطة عضو معين (مثلاً العضو "Alice Johnson")
SELECT b.title, t.borrow_date, t.return_date
FROM transactions t
JOIN books b ON t.book_id = b.book_id
JOIN members m ON t.member_id = m.member_id
WHERE m.name = 'Alice Johnson';

-- عرض الكتب المتاحة في المكتبة (التي لم تُستعار)
SELECT title, copies_available
FROM books
WHERE copies_available > 0;
