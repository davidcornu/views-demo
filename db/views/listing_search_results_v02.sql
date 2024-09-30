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

    listing_inventory_and_pricing as (
        select
            products.listing_id,
            sum(products.inventory) as inventory,
            min(products.price_cents_usd) as min_price_cents_usd,
            max(products.price_cents_usd) as max_price_cents_usd
        from products
        group by products.listing_id
    )

select
    listings.id as listing_id,
    listings.name as listing_name,
    listing_properties.property_ids,
    listing_inventory_and_pricing.inventory > 0 as in_stock,
    listing_inventory_and_pricing.min_price_cents_usd,
    listing_inventory_and_pricing.max_price_cents_usd
from listings
left outer join listing_properties
    on listing_properties.listing_id = listings.id
left outer join listing_inventory_and_pricing
    on listing_inventory_and_pricing.listing_id = listings.id