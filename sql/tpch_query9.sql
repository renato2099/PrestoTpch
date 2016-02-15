select
        nation,
        o_year,
        sum(amount) as sum_profit
from
        (
                select
                        nation,
                        year(o_orderdate) as o_year,
                        l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
                from
                        orders o 
                        inner join (
                        select * from lineitem l
                        inner join (select * from part p where p_name like '%green%')p on p_partkey = l_partkey
                        inner join (select s_suppkey, n_name as nation  from supplier s inner join nation n on s_nationkey = n_nationkey)s on s_suppkey = l_suppkey
                        inner join partsupp ps on ps_suppkey = l_suppkey and ps_partkey = l_partkey)l
                        on o_orderkey = l_orderkey
        ) as profit
group by
        nation,
        o_year
order by
        nation,
        o_year desc
