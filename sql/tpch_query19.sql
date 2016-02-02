select
	sum(l.extendedprice* (1 - l.discount)) as revenue
from
	lineitem l,
	part p
where
	p.partkey = l.partkey
	and (
	(
		p.brand = 'Brand#32'
		and p.container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
		and l.quantity >= 7 and l.quantity <= 7 + 10
		and p.size between 1 and 5
		and l.shipmode in ('AIR', 'AIR REG')
		and l.shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		p.brand = 'Brand#35'
		and p.container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
		and l.quantity >= 15 and l.quantity <= 15 + 10
		and p.size between 1 and 10
		and l.shipmode in ('AIR', 'AIR REG')
		and l.shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		p.brand = 'Brand#24'
		and p.container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		and l.quantity >= 26 and l.quantity <= 26 + 10
		and p.size between 1 and 15
		and l.shipmode in ('AIR', 'AIR REG')
		and l.shipinstruct = 'DELIVER IN PERSON'
	))
