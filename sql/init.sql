-- 删除之前的数据
DROP TABLE "like";

-- 创建一张 收藏 表 u_id 是账户ID, m_id 是具体模型, 可以是产品或者其他
CREATE TABLE "like" (
	"id"	INTEGER NOT NULL UNIQUE,
	"u_id"	INTEGER NOT NULL,
	"m_id"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

-- 他们共同都有的收藏
-- 创建数据 用户[1] 收藏[1] 
INSERT INTO like(u_id,m_id) VALUES(1, 1);
-- 创建数据 用户[2] 收藏[2] 
INSERT INTO like(u_id,m_id) VALUES(2, 1);
-- 创建数据 用户[3] 收藏[3] 
INSERT INTO like(u_id,m_id) VALUES(3, 1);

-- 1和2 共同有的收藏
-- 创建数据 用户[1] 收藏[2] 
INSERT INTO like(u_id,m_id) VALUES(1, 2);
-- 创建数据 用户[2] 收藏[2] 
INSERT INTO like(u_id,m_id) VALUES(2, 2);

-- 1 独有的收藏
-- 创建数据 用户[1] 收藏[3] 
INSERT INTO like(u_id,m_id) VALUES(1, 3);

-- 2 独有的收藏
-- 创建数据 用户[2] 收藏[4] 
INSERT INTO like(u_id,m_id) VALUES(2, 4);

-- 3 独有的收藏
-- 创建数据 用户[3] 收藏[5] 
INSERT INTO like(u_id,m_id) VALUES(3, 5);

-- 1和3 共同有的收藏
-- 创建数据 用户[1] 收藏[6] 
INSERT INTO like(u_id,m_id) VALUES(1, 6);
-- 创建数据 用户[3] 收藏[6] 
INSERT INTO like(u_id,m_id) VALUES(3, 6);
