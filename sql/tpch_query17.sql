select
	sum(extendedprice) / 7.0 as avg_yearly
from (
	select
		quantity,
		extendedprice,
		t_avg_quantity
	from
		(select
			l.partkey as t_partkey,
			0.2 * avg(l.quantity) as t_avg_quantity
		from
			lineitem l
		group by l.partkey)q17_lineitem_tmp_cached JOIN
		(select
			l.quantity,
			l.partkey,
			l.extendedprice
		from
			part p,
			lineitem l
		where
			p.partkey = l.partkey
			and p.brand = 'Brand#23'
			and p.container = 'MED BOX'
		) l1 on l1.partkey = t_partkey
) a 
where quantity < t_avg_quantity
