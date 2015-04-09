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
    return $('body').append("AJAX Error: " + textStatus);
  },
  success: function(data, textStatus, jqXHR) {
  	return $('div#person_skill').html(data);
  },
  beforeSend: function(){
      $('#ajax-loader').show();
    },
    complete: function(){
      $('#ajax-loader').hide();
    }
});
});