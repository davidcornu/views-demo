with
    listing_properties as (
        select
            products.listing_id,
            array_agg(distinct product_properties.property_id) as property_ids
        from product_properties
        inner join products
            on product_properties.product_id = products.id
        group by products.listing_id
    ),

    listing_in_stock as (
        select distinct
            products.listing_id
        from products
        where inventory > 0
    )

select
    listings.id as listing_id,
    listings.name as listing_name,
    listing_properties.property_ids,
    (listing_in_stock.listing_id is not null) as in_stock
from listings
left outer join listing_properties
    on listing_properties.listing_id = listings.id
left outer join listing_in_stock
    on listing_in_stock.listing_id = listings.id