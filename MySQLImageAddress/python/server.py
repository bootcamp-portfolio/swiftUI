import pymysql
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List, Optional

app = FastAPI()

# 1. MySQL 연결 설정
def get_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='qwer1234',  # <--- 본인의 비밀번호로 수정!
        db='ios',
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

# 2. 데이터 모델 (앱 UI에 있는 모든 필드 포함)
class Address(BaseModel):
    name: str
    phone: str
    address: str
    relation: str
    imageName: str  # 이미지 파일명 (예: "dog", "fox" 등)

# 3. API 엔드포인트

# [GET] 주소록 목록 조회
@app.get("/addresses")
def get_addresses():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            cursor.execute("SELECT id, name, phone, address, relation, imageName FROM address")
            result = cursor.fetchall()
        return result
    finally:
        conn.close()

# [POST] 주소록 추가
@app.post("/addresses")
def add_address(address: Address):
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = """
            INSERT INTO address (name, phone, address, relation, imageName) 
            VALUES (%s, %s, %s, %s, %s)
            """
            cursor.execute(sql, (
                address.name, 
                address.phone, 
                address.address, 
                address.relation,
                address.imageName
            ))
        conn.commit()
        return {"message": "입력 되었습니다."} # 앱 UI 문구와 통일
    finally:
        conn.close()

# [PUT] 주소록 수정
@app.put("/addresses/{address_id}")
def update_address(address_id: int, address: Address):
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = """
            UPDATE address 
            SET name=%s, phone=%s, address=%s, relation=%s, imageName=%s 
            WHERE id=%s
            """
            cursor.execute(sql, (
                address.name, 
                address.phone, 
                address.address, 
                address.relation,
                address.imageName,
                address_id
            ))
        conn.commit()
        return {"message": "수정 되었습니다."}
    finally:
        conn.close()

# [DELETE] 주소록 삭제
@app.delete("/addresses/{address_id}")
def delete_address(address_id: int):
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "DELETE FROM address WHERE id=%s"
            cursor.execute(sql, (address_id,))
        conn.commit()
        return {"message": "삭제 되었습니다."}
    finally:
        conn.close()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001)
    