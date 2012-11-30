jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('tr').find('input[type=hidden]').val('1')
    $(this).closest('tr').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("table.#{$(this).data('target')} tbody").append($(this).data('fields').replace(regexp, time))
    event.preventDefault()
