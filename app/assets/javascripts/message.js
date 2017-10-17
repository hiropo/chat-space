$(function(){
  function buildHTML(message){
    var insertImage = message.image ? `<img src="${message.image.url}">` : '' ;
    var html = `<div class = "chat__messages__output-upper">
                  <div class = "chat__messages__output-upper-name">
                    <p>${message.name}</p>
                  </div>
                  <div class = "chat__messages__output-upper-date">
                    <p>${message.created_at}</p>
                  </div>
                </div>
                <div class = "chat__messages__output-lower">
                  <div class = "chat__messages__output-lower-message">
                    <p>${message.body}</p>
                    <p>${insertImage}</p>
                  </div>
                </div>`
    return html;
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.chat__messages').append(html)
      $('.chat__form__message').val('')
      $('.chat__form__icon__filed').val('')
      $('.chat__messages').animate( {scrollTop: $('.chat__messages__output')[0].scrollHeight} );
    })
    .fail(function(){
      alert('error');
    })
})
})
