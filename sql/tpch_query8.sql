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
			part p,
			supplier s,
			lineitem l,
			orders o,
			customer c,
			nation n1,
			nation n2,
			region r
		where
			p.partkey = l.partkey
			and s.suppkey = l.suppkey
			and l.orderkey = o.orderkey
			and o.custkey = c.custkey
			and c.nationkey = n1.nationkey
			and n1.regionkey = r.regionkey
			and r.name = 'AMERICA'
			and s.nationkey = n2.nationkey
			and o.orderdate between date '1995-01-01' and date '1996-12-31'
			and p.type = 'ECONOMY BURNISHED NICKEL'
	) as all_nations
group by
	o_year
order by
	o_year
