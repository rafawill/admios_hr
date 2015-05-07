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

$(document).on( 'click', '#message-skill', function(e){
$("#developer-message").html('You already assigned all the available skills');
$("#no-add").modal('show');
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
	  data:{person_has_skill:{skill_id:skill_id, rating:rating, projects:projects, note:note}},
	  async: true,
	  dataType: "html",
	  error: function(request, textStatus, errorThrown) {
	   
	   var error = $.parseJSON(request.responseText);
	   $("#note_person_has_skill").tooltip({trigger: 'focus',placement: "top", title: error.note[0], delay: { show: 500, hide: 100 }});
	   $("#note_person_has_skill").focus();
	  },
	  success: function(data, textStatus, jqXHR) {
	  	var tbody = $(data)
	  	var tbody_id = tbody.filter("tbody").attr('id');
	  	var id = tbody_id.split("_");
	  	var ul = $('#skill_tab').children();
	  	$("#new-developer-skill").modal('hide');
	  	$("#"+id[1]).html(data);

	  	$.each( ul.children(), function( index, anchor ) {
         if(_.includes(id[1],$(anchor).attr('aria-controls'))){
         	$(anchor).parent().addClass('active');
         	$("div#"+$(anchor).attr('aria-controls')).addClass('active in');
         }else{
         	$(anchor).parent().removeClass('active');
         	$("div#"+$(anchor).attr('aria-controls')).removeClass('active in');
         }
        });

	  }
	});	
});	