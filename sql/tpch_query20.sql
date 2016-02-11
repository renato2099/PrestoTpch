select
	s_name,
	s_address
from
	supplier s,
	nation n,
	(select
		ps_suppkey
	from
		(select
				ps_suppkey,
				ps_availqty,
				sum_quantity
			from
				partsupp ps, 
				(select distinct p_partkey from part p where p_name like 'forest%')q20_tmp1_cached, 
				(select l_partkey, l_suppkey, 0.5 * sum(l_quantity) as sum_quantity
				from lineitem l
				where l_shipdate >= date '1994-01-01' and l_shipdate < date '1995-01-01'
				group by l_partkey, l_suppkey)q20_tmp2_cached
			where
				ps_partkey = q20_tmp1_cached.p_partkey
				and ps_partkey = q20_tmp2_cached.l_partkey
				and ps_suppkey = q20_tmp2_cached.l_suppkey)q20_tmp3_cached
	where
		ps_availqty > sum_quantity
	group by ps_suppkey)q20_tmp4_cached
where
	s_nationkey = n_nationkey
	and n_name = 'CANADA'
	and s_suppkey = q20_tmp4_cached.ps_suppkey
order by s_name
