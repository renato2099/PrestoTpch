select
        o_year,
        sum(case
                when nation = 'PERU' then volume
                else 0
        end) / sum(volume) as mkt_share
from
        (
                select
                        year(o.orderdate) as o_year,
                        l.extendedprice * (1 - l.discount) as volume,
                        n2.name as nation
                from
                        (select * from orders o where o.orderdate between date '1995-01-01' and date '1996-12-31')o
                        inner join (
                                    select * from customer c 
                                    where c.nationkey IN (
                                        select n1.nationkey from nation n1 
                                        inner join (select * from region r where r.name = 'AMERICA')r on n1.regionkey = r.regionkey)
                                    )c on c.custkey = o.custkey
                        inner join lineitem l on l.orderkey = o.orderkey
                        inner join (select * from part p where p.type = 'ECONOMY BURNISHED NICKEL' )p on p.partkey = l.partkey
                        inner join supplier s on s.suppkey = l.suppkey
                        inner join nation n2 on s.nationkey = n2.nationkey
        ) as all_nations
group by
        o_year
order by
        o_year

