select
	s.name,
	s.address
from
	supplier s,
	nation n,
	(select
		suppkey
	from
		(select
				ps.suppkey,
				ps.availqty,
				sum_quantity
			from
				partsupp ps, 
				(select distinct p.partkey from part p where p.name like 'forest%')q20_tmp1_cached, 
				(select l.partkey, l.suppkey, 0.5 * sum(l.quantity) as sum_quantity
				from lineitem l
				where l.shipdate >= date '1994-01-01' and l.shipdate < date '1995-01-01'
				group by l.partkey, l.suppkey)q20_tmp2_cached
			where
				ps.partkey = q20_tmp1_cached.partkey
				and ps.partkey = q20_tmp2_cached.partkey
				and ps.suppkey = q20_tmp2_cached.suppkey)q20_tmp3_cached
	where
		availqty > sum_quantity
	group by suppkey)q20_tmp4_cached
where
	s.nationkey = n.nationkey
	and n.name = 'CANADA'
	and s.suppkey = q20_tmp4_cached.suppkey
order by s.name
