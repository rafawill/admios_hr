$(document).on( 'click', '.delete-developer-skill', function(e){
	var skill_id = $(this).data("id");
	var person_has_skill = $(this).attr('id');
	var developer_id = $( "#developer_id" ).val();
	
	$.ajax({
	  type: "POST",
	  url: "/developer/"+developer_id+"/delete_developer_skill",
	  data:{person_has_skill: person_has_skill},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
		$('tr#edit_'+skill_id).remove();
		$('tr#show_'+skill_id).remove();
	  }
	});	
});	