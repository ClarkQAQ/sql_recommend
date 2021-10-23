### SQL Recommend

> 今天在看推荐算法找Golang推荐库的时候突然想到能不能直接用SQL实现一种简单并且满意度高的推荐算法, 然后便有了这个项目, 基于SQL的简单推荐, 按照网易云音乐的日推来模仿实现的基于数据驱动的推荐算法, 并且不挑数据音乐视频文本文件都可以推荐的算法, 应该不能算算法了只是一种方法, 并且写的稀烂(SQL当上手), 但是又还行(, 后面会更多黑魔法了再来改改吧

在一个上午没刷无聊图后做了出来, 实际查询代码不超过27行, 在万条数据下 sqlite 查询一次也就几毫秒, 还行, 自己写的小项目可以用用, 毕竟不是所有项目用户都能上万hhhhh

数据库基础结构:

```sql
CREATE TABLE "like" (
	"id"	INTEGER NOT NULL UNIQUE,
	"u_id"	INTEGER NOT NULL, -- 账户ID
	"m_id"	INTEGER NOT NULL, -- 模型ID
	PRIMARY KEY("id" AUTOINCREMENT)
);
```


主要的查询代码如下:

```sql
SELECT
    lk.m_id, -- 模型ID
    count(lk.u_id) AS 'u_num' -- 有多少人推荐
FROM 
    `like` lk
INNER JOIN (
    SELECT
        lk.u_id, -- 账户ID
        count(lk.m_id) AS 'num' -- 共同收藏数量, 可用于后期筛选
    FROM 
        `like` lk
    INNER JOIN `like` lkk ON (lkk.m_id = lk.m_id)
    WHERE
        lkk.u_id = 3 -- "被害人"账户ID
        AND lk.u_id != lkk.u_id
    GROUP BY
        lk.u_id
    -- HAVING -- 筛选最低共同收藏数量
    --     num >= 2
) lu ON (lu.u_id = lk.u_id) -- 这里Gorm可以传参进去, Gf的gdb不行
LEFT JOIN `like` nlk ON (nlk.m_id = lk.m_id AND nlk.u_id = 3) -- 配合WHERE排除自己以及收藏的
WHERE nlk.id IS NULL
GROUP BY
    lk.m_id
-- HAVING -- 筛选最低推荐人数
--     u_num >= 2
;

```

使用方法

先执行 `init.sql` 创建表和基础数据
然后用 `query.sql` 里面的查询sql查就行了 