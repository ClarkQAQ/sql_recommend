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
;


-- 自己查出想要的数据
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
