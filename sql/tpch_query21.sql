select
	name,
	count(1) as numwait
from (
	select name from (
		select
			name,
			t2.orderkey,
			suppkey,
			count_suppkey,
			max_suppkey
		from
			(select l.orderkey, count(distinct l.suppkey) count_suppkey, max(l.suppkey) as max_suppkey
			from lineitem l
			where l.receiptdate > l.commitdate and l.orderkey is not null
			group by l.orderkey) t2 
		right outer join (
			select
				name,
				orderkey,
				suppkey from (
				select
					name,
					t1.orderkey,
					suppkey,
					count_suppkey,
					max_suppkey
				from
					(select l.orderkey, count(distinct l.suppkey) as count_suppkey, max(l.suppkey) as max_suppkey
					from lineitem l where l.orderkey is not null group by l.orderkey) t1 
					join (
						select
							name, o.orderkey, suppkey
						from orders o join (
							select s.name, l.orderkey, l.suppkey
							from nation n 
							join supplier s on s.nationkey = n.nationkey and n.name = 'SAUDI ARABIA'
							join lineitem l on s.suppkey = l.suppkey
							where l.receiptdate > l.commitdate and l.orderkey is not null
						) l1 on o.orderkey = l1.orderkey and o.orderstatus = 'F'
					) l2 on l2.orderkey = t1.orderkey
				) a
			where
				(count_suppkey > 1)
				or ((count_suppkey=1)
				and (suppkey <> max_suppkey))	
		) l3 on l3.orderkey = t2.orderkey
	) b
	where
		(count_suppkey is null)
		or ((count_suppkey=1)
		and (suppkey = max_suppkey))
) c
group by
	name
order by
	numwait desc,
	name 
limit 100
