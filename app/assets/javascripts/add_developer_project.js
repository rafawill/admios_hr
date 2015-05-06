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
	var current_project = $('#current_project_person_has_project').is(':checked');
	var note = $("#note_person_has_project").val();
	var developer_condition = $("#developer_condition").val();

	$.ajax({
	  type: "POST",
	  url: "/developer/"+id+"/create_developer_project",
	  data:{id: id, project_id:project_id, start_date: start_date, finish_date: finish_date, note: note, current_project: current_project, developer_condition: developer_condition},
	  async: true,
	  dataType: "html",
	  error: function(request, textStatus, errorThrown) {
	   var error = $.parseJSON(request.responseText);

	   if (!_.isUndefined(error.note)){
	   	$("#note_person_has_project").tooltip({trigger: 'focus',placement: "top", title: error.note[0], delay: { show: 500, hide: 100 }});
	    $("#note_person_has_project").focus();
	   }
	   if (!_.isUndefined(error.start_date)){
	   	$("#start_date_start_date").tooltip({trigger: 'focus',placement: "top", title: error.start_date[0], delay: { show: 500, hide: 100 }});
	    $("#start_date_start_date").focus();
	   }
	   if (!_.isUndefined(error.finish_date)){
	   	$("#finish_date_finish_date").tooltip({trigger: 'focus',placement: "top", title: error.finish_date[0], delay: { show: 500, hide: 100 }});
	    $("#finish_date_finish_date").focus();
	   }
	  },
	  success: function(data, textStatus, jqXHR) {
	  	$("#new-developer-project").modal('hide');
	  	$("#project-projets").html(data);
	  }
	});	
});	