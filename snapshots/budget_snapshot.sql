{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='budget_id',
      strategy='timestamp',
      updated_at= 'date_load',
      invalidate_hard_deletes=True,)
}}

select * from {{ ref('fct_budget') }}

{% endsnapshot %}