select
 s_acctbal,
 s_name,
 n_name,
 p_partkey,
 p_mfgr,
 s_address,
 s_phone,
 s_comment
from 
(select * from part p where p_size = 15 and p_type like '%BRASS') p
inner join partsupp ps on p_partkey = ps_partkey
inner join supplier s on s_suppkey = ps_suppkey 
inner join (
    select p_partkey as min_p_partkey, min(ps_supplycost) as min_ps_supplycost from part p
    inner join partsupp ps on p_partkey = ps_partkey 
    inner join supplier s on s_suppkey = ps_suppkey 
    inner join nation n on s_nationkey = n_nationkey 
    inner join region r on n_regionkey = r_regionkey and r_name = 'EUROPE'
    group by p_partkey
)A on ps_supplycost = A.min_ps_supplycost and p_partkey =A.min_p_partkey
inner join nation n on s_nationkey = n_nationkey 
inner join region r on n_regionkey = r_regionkey  and r_name = 'EUROPE'
order by
	s_acctbal desc,
	n_name,
	s_name,
	p_partkey
limit 100
;
