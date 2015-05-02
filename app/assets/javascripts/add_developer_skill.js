$(document).on( 'click', '#add-skill', function(e){
	
	var developer_id = $( "#developer_id" ).val();
	$.ajax({
	  type: "GET",
	  url: "/developer/"+developer_id+"/new_developer_skill",
	  data:{id:developer_id},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
	  	 $("#show-new-developer-skill").html(data);
	  	 $("#new-developer-skill").modal('show');
	  }
	});	
});	


$(document).on( 'click', '#save-developer-skill', function(e){
	var id = $("#developer_id").val();
	var skill_id = $("#skill_id").val();
	var rating = $("#rating").val();
	var projects = $("#projects").val();
	var note = $("#note_person_has_skill").val();
	$.ajax({
	  type: "POST",
	  url: "/developer/"+id+"/create_developer_skill",
	  data:{id:id,skill_id:skill_id, rating:rating, projects:projects, note:note},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
	  	var tbody = $(data)
	  	var tbody_id = tbody.filter("tbody").attr('id');
	  	var id = tbody_id.split("_");
	  	$("#new-developer-skill").modal('hide');
	  	 $("#"+id[1]).html(data);
	  }
	});	
});	