{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='budget_id',
      strategy='check',
      check_cols=['quantity'],
      invalidate_hard_deletes=True,)
}}

select * from {{ source('google_sheets', 'budget') }}

{% endsnapshot %}

