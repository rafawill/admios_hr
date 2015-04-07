var skill = [];
$(document).on( 'click', '.toggle-boton', function(e){
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
  dataType: "html",
  error: function(jqXHR, textStatus, errorThrown) {
    return $('body').append("AJAX Error: " + textStatus);
  },
  success: function(data, textStatus, jqXHR) {
  	$('div#person_skill').html(data);
  }
});
});