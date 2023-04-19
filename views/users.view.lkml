view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: is_cancelled {
    type: yesno
    sql: CASE WHEN ${TABLE}.email THEN true ELSE false END;;
  }

  # # measure: testing_liquid {
  # #   type: number
  # #   sql: 0;;
  # #   html: <p>{% assign num = 5 %}
  # #     {% for num in (0..num) %}
  # #       {{num}}
  # #     {% endfor %} </p> ;;
  # }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  filter: testing {
    type: string
  }


  dimension: state {
    label: "{% if _explore._name == 'orders' %} Orders-State {% else %} User-State {% endif %}"
    type: string
    sql: ${TABLE}.state ;;
    drill_fields: [state]
  }

  dimension: state2 {
    type: string
    sql: CASE WHEN ${TABLE}.state LIKE 'M%' THEN 'Some Other Name'
    ELSE ${TABLE}.state END;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: test_measure {
    type: string
    sql: case when ${count} > 500 then "走行が一部表示されていません。"
          else "全ての走行が表示されています。" end;;
    html: {% if count._value > '500' %}
            <p style="color: red; font-size: 50%"> {{rendered_value}} </p>
          {% else %}
            <p style="color: black; font-size: 50%"> {{rendered_value}} </p>
          {% endif %};;
  }

  measure: liquid_test {
    type: number
    sql: ${id} ;;
    html: {% if id._value > 0 %} Yes
          {% else%} No
          {% endif %};;
  }

  measure: count {
    type: count
    # drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      saralooker.count,
      sindhu.count,
      user_data.count
    ]
  }
}
