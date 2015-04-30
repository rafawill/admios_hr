$(document).on( 'click', '.delete-developer-project', function(e){
	var person_has_project = $(this).attr('id');
	var developer_id = $( "#developer_id" ).val();
	
	$.ajax({
	  type: "POST",
	  url: "/developer/"+developer_id+"/delete_developer_project",
	  data:{person_has_project: person_has_project},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
		$('tr#project_show'+person_has_project).remove();
		$('tr#project_edit'+person_has_project).remove();
	  }
	});	
});	