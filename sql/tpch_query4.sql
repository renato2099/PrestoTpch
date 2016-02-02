select
	o.orderpriority,
	count(*) as order_count
from
	orders as o,
    lineitem l
where
	o.orderdate >= date '1996-05-01'
	and o.orderdate < date '1996-08-01'
	and l.orderkey = o.orderkey
	and l.commitdate < l.receiptdate
group by
	o.orderpriority
order by
	o.orderpriority
