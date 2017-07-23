$(document).on 'turbolinks:load', ->
  $(".add_user").on 'click', (e) =>
    $('#invite_user_modal').modal('open')
    $('#invitation_team_id').val(e.target.id)
    return false

  $('.invite_user_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {
          invitation: {
            user_email: $('#invitation_user_email').val()
            team_id: $('#invitation_team_id').val()
          }
        }
        success: (data, text, jqXHR) ->
          Materialize.toast('The user was successfully invited &nbsp;', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('There was a problem with the invitation;<b>:(</b>', 4000, 'red')

    $('#invite_user_modal').modal('close')
    return false
