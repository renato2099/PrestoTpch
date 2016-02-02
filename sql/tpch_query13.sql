select
	c_count,
	count(*) as custdist
from
	(
		select
			c.custkey,
			count(o.orderkey) as c_count
		from
			customer c left outer join orders o on
				c.custkey = o.custkey
			where o.comment not like '%unusual%accounts%'
		group by
			c.custkey
	) c_orders
group by
	c_count
order by
	custdist desc,
	c_count desc
