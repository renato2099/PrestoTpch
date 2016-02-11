select
        nation,
        o_year,
        sum(amount) as sum_profit
from
        (
                select
                        nation,
                        year(o.orderdate) as o_year,
                        l.extendedprice * (1 - l.discount) - l.supplycost * l.quantity as amount
                from
                        orders o 
                        inner join (
                        select * from lineitem l
                        inner join (select * from part p where p.name like '%plum%')p on p.partkey = l.partkey
                        inner join (select s.suppkey, n.name as nation  from supplier s inner join nation n on s.nationkey = n.nationkey)s on s.suppkey = l.suppkey
                        inner join partsupp ps on ps.suppkey = l.suppkey and ps.partkey = l.partkey)l
                        on o.orderkey = l.orderkey
        ) as profit
group by
        nation,
        o_year
order by
        nation,
        o_year desc
