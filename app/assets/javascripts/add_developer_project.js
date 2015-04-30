$(document).on( 'click', '#add-developer-project', function(e){
	
	var developer_id = $( "#developer_id" ).val();
	$.ajax({
	  type: "GET",
	  url: "/developer/"+developer_id+"/new_developer_project",
	  data:{id:developer_id},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
	  	 $("#show-new-developer-project").html(data);
	  	 $("#new-developer-project").modal('show');
	  }
	});	
});


$(document).on( 'click', '#save-developer-project', function(e){
	var id = $("#developer_id").val();
	var project_id = $("#project_id").val();
	var start_date = $("#start_date_start_date").val();
	var finish_date = $("#finish_date_finish_date").val();
	var current_project = $("#current_project_person_has_project").val();
	var note = $("#note_person_has_project").val();

	$.ajax({
	  type: "POST",
	  url: "/developer/"+id+"/create_developer_project",
	  data:{id: id, project_id:project_id, start_date: start_date, finish_date: finish_date, note: note, current_project: current_project},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
	  	$("#new-developer-project").modal('hide');
	  	$("#project-projets").html(data);
	  }
	});	
});	