$(document).on 'turbolinks:load', ->
  $('#member_email, #member_name').keypress (e) ->
    if e.which == 13 && valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('#member_email, #member_name').bind 'blur', ->
    if valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('body').on 'click', 'a.remove_member', (e) ->
    $.ajax '/members/'+ e.currentTarget.id,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          bulmaToast.toast({message:'Membro removido', type: 'is-success', position: 'is-bottom'})
          $('#member_' + e.currentTarget.id).remove()
        error: (jqXHR, textStatus, errorThrown) ->
          bulmaToast.toast({message:'Problema na remoção do Membro', type: 'is-danger', position: 'is-bottom'})
    return false

  $('.new_member').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: $(".new_member").serialize()
        success: (data, text, jqXHR) ->
          insert_member(data['id'], data['name'],  data['email'])
          $('#member_name, #member_email').val("")
          $('#member_name').focus()
          bulmaToast.toast({message:'Membro adicionado!', type: 'is-success', position: 'is-bottom'})
        error: (jqXHR, textStatus, errorThrown) ->
          bulmaToast.toast({message:'Problema na inclusão de Membro', type: 'is-danger', position: 'is-bottom'})
    return false


valid_email = (email) ->
  /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)

insert_member = (id, name, email) ->
  $('.member_list').append(
    '<div class="member" id="member_' + id + '">'+
        '<div class="field is-horizontal mt">'+
          '<div class="field-label is-normal"><label class="label has-text-warning ">Nome / E-mail</label></div>'+
          '<div class="field-body">'+
            '<div class="field">'+
              '<p class="control is-expanded has-icons-left">'+
                '<input id="name" class="validate input is-rounded is-warning" type="text" value="' + name + '">'+
                '<span class="icon is-small is-left">'+
                  '<i class="fas fa-user"></i>'+
                '</span>'+
              '</p>'+
            '</div>'+
            '<div class="field">'+
              '<p class="control is-expanded has-icons-left">'+
                '<input class="input is-rounded is-warning" type="email" value="' + email + '">'+
                '<span class="icon is-small is-left">'+
                  '<i class="fas fa-envelope"></i>'+
                '</span>'+
              '</p>'+
            '</div>'+
              '<div class="icons is-flex">'+
                '<span class="icon is-normal">'+
                  '<i class="fas fa-eye"></i>'+
                '</span>'+   
                '<a href="#" class="remove_member" id="' + id + '">'+
                  '<span class="icon is-normal">'+
                    '<i class="fas fa-trash"></i>'+
                  '</span>'+
                '</a>'+
            '</div>'+   
          '</div>'+
        '</div>'+      
      '</div>'
    )