select
    partkey, part_value as value
from (
    select
        partkey,
        part_value,
        total_value
    from
        (select
                ps.partkey,
                sum(ps.supplycost * ps.availqty) as part_value
            from
                partsupp ps,
                supplier s,
                nation n
            where
                ps.suppkey = s.suppkey
                and s.nationkey = n.nationkey
                and n.name = 'GERMANY'
            group by ps.partkey) q11_part_tmp_cached 
        CROSS JOIN (select
                sum(part_value) as total_value
            from
                (select
                    ps.partkey,
                    sum(ps.supplycost * ps.availqty) as part_value
                from
                partsupp ps,
                supplier s,
                nation n
            where
                ps.suppkey = s.suppkey
                and s.nationkey = n.nationkey
                and n.name = 'GERMANY'
                group by ps.partkey))q11_sum_tmp_cached
) a
where
    part_value > total_value * 0.0001
order by
    value desc
