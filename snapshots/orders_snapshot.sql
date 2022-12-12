{% snapshot orders_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='check',
      check_cols=['quantity'],
      invalidate_hard_deletes=True,)
}}

select * from {{ source('sql_server__dbo', 'orders') }}

{% endsnapshot %}

