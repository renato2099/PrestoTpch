select
        o_year,
        sum(case
                when nation = 'PERU' then volume
                else 0
        end) / sum(volume) as mkt_share
from
        (
                select
                        year(o_orderdate) as o_year,
                        l_extendedprice * (1 - l_discount) as volume,
                        n2.n_name as nation
                from
                        (select * from orders o where o_orderdate between date '1995-01-01' and date '1996-12-31')o
                        inner join (
                                    select * from customer c 
                                    where c_nationkey IN (
                                        select n1.n_nationkey from nation n1 
                                        inner join (select * from region r where r_name = 'AMERICA')r on n1.n_regionkey = r_regionkey)
                                    )c on c_custkey = o_custkey
                        inner join lineitem l on l_orderkey = o_orderkey
                        inner join (select * from part p where p_type = 'ECONOMY BURNISHED NICKEL' )p on p_partkey = l_partkey
                        inner join supplier s on s_suppkey = l_suppkey
                        inner join nation n2 on s_nationkey = n2.n_nationkey
        ) as all_nations
group by
        o_year
order by
        o_year

