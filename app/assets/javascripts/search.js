var skill = [];
$(document).on( 'click', '.toggle-boton', function(e){
	e.preventDefault();
 if(_.includes(skill,this.id)){
 	var num = this.id
   _.remove(skill, function(n) {return n==num.toString()});
 }else{
 	skill.push(this.id);
 }  
 $.ajax({
  type: "POST",
  url: "search_skills/search",
  data:{id:skill},
  async: true,
  dataType: "html",
  error: function(jqXHR, textStatus, errorThrown) {
    //return $('body').append("AJAX Error: " + textStatus);
  },
  success: function(data, textStatus, jqXHR) {
  	 $('div#person_skill').html(data);
    if($("label#available").hasClass( "active" )){
     $('.inproject').hide();
     $('.available').show();
     $( "#all-developer" ).removeClass( "active" )
   
    }else if($("label#in-project").hasClass( "active" )){
      $('.available').hide();
      $('.inproject').show();
      $( "#all-developer" ).removeClass( "active" )
    }else{
       $('.developer-container').show();
    }

  },
  beforeSend: function(){
      $('#ajax-loader').show();
    },
    complete: function(){
      $('#ajax-loader').hide();
      $('div#filter-project').show();
    }
});
});

$(document).on( 'click', '#all-developer', function(e){
  $('.developer-container').show();
});

$(document).on( 'click', '#available', function(e){
 if($("div.developer-container").hasClass( "available" )){
  $('.inproject').hide();
  $('.available').show();
  $( "#all-developer" ).removeClass( "active" )
 }
});

$(document).on( 'click', '#in-project', function(e){
  if($("div.developer-container").hasClass( "inproject" )){
  $('.available').hide();
  $('.inproject').show();
  $( "#all-developer" ).removeClass( "active" )
 }
});
