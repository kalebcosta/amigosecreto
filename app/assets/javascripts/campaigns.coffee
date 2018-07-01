$(document).on 'turbolinks:load', ->

  $('.update_campaign input').bind 'blur', ->
    $('.update_campaign').submit()

  $('.update_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'PUT'
        dataType: 'json',
        data: $(".update_campaign").serialize()
        success: (data, text, jqXHR) ->
          # bulmaToast.toast({message:'Campanha atualizada', type: 'is-success', position: 'is-bottom'})
        error: (jqXHR, textStatus, errorThrown) ->
          bulmaToast.toast({message:'Problema na atualização da Campanha', type: 'is-danger', position: 'is-bottom'})
    return false

  $('.remove_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          $(location).attr('href','/campaigns');
        error: (jqXHR, textStatus, errorThrown) ->
          bulmaToast.toast({message:'Problema na remoção da Campanha', type: 'is-danger', position: 'is-bottom'})
    return false

  $('.raffle_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          bulmaToast.toast({message:'Tudo certo, em breve os participantes receberão um email!', type: 'is-success', position: 'is-bottom'})
        error: (jqXHR, textStatus, errorThrown) ->
          bulmaToast.toast({message: jqXHR.responseText, type: 'is-danger'})
    return false
