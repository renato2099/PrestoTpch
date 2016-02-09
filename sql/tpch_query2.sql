select
 s.acctbal,
 s.name,
 n.name,
 p.partkey,
 p.mfgr,
 s.address,
 s.phone,
 s.comment
from 
(select * from part p where p.size = 37 and p.type like '%COPPER') p
inner join partsupp ps on p.partkey = ps.partkey
inner join supplier s on s.suppkey = ps.suppkey 
inner join (
    select p.partkey as min_p_partkey, min(ps.supplycost) as min_ps_supplycost from part p
    inner join partsupp ps on p.partkey = ps.partkey 
    inner join supplier s on s.suppkey = ps.suppkey 
    inner join nation n on s.nationkey = n.nationkey 
    inner join region r on n.regionkey = r.regionkey and r.name = 'EUROPE'
    group by p.partkey
)A on ps.supplycost = A.min_ps_supplycost and p.partkey =A.min_p_partkey
inner join nation n on s.nationkey = n.nationkey 
inner join region r on n.regionkey = r.regionkey  and r.name = 'EUROPE'
order by
	s.acctbal desc,
	n.name,
	s.name,
	p.partkey
limit 100
