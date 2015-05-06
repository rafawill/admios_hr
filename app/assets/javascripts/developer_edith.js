$(document).on( 'click', '.developer_edit', function(e){
	$('tr#show_'+this.id).hide();
	$('tr#edit_'+this.id).removeClass('hide');
	$('tr#edit_'+this.id).show();
});

$(document).on( 'click', '.btn-cancel', function(e){
	$('tr#edit_'+$(this).data("id")).hide();
	$('tr#edit_'+$(this).data("id")).addClass('hide');
	$('tr#show_'+$(this).data("id")).show();	
});

$(document).on( 'click', '.update-developer-skill', function(e){
	e.preventDefault();
	var skill_id = $(this).data("id");
	var developer_id = $( "#developer_id" ).val();
	var rating = $( "#rating"+skill_id ).val();
	var person_has_skill = $( "#person_has_skill_id"+skill_id ).val();

	var table_id = $('tr#edit_'+skill_id ).parent().parent().attr('id');


	$.ajax({
	  type: "POST",
	  url: "/developer/"+developer_id+"/edit_skill",
	  data:{id:developer_id, skill_id:skill_id, rating: rating, person_has_skill: person_has_skill},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
	  	 
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#edit_'+skill_id ).index()+')').remove();
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#show_'+skill_id ).index()+')').remove()
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#show_'+skill_id ).index()+')').after(data);

	  	 var tbody = $("#tbody_"+table_id).children();
	  	 tbody.sort(function(a, b) {
		        var keyA = $(a).data('rating');
				var keyB = $(b).data('rating');
				if (keyA < keyB) return 1;
				if (keyA > keyB) return -1;
				return 0;
		});
	  	 $('#tbody_'+table_id).html(tbody);
	  }
	});
});	

$(document).on( 'click', '.project_edit', function(e){
	$('tr#project_show'+this.id).hide();
	$('tr#project_edit'+this.id).removeClass('hide');
	$('tr#project_edit'+this.id).show();
});

$(document).on( 'click', '.btn-project-cancel', function(e){
	$('tr#project_edit'+$(this).data("id")).hide();
	$('tr#project_edit'+$(this).data("id")).addClass('hide');
	$('tr#project_show'+$(this).data("id")).show();	
});

$(document).on( 'click', '.update-developer-project', function(e){
	e.preventDefault();
	var person_has_project = $(this).data("id");
	var developer_id = $( "#developer_id" ).val()
	var start_date = $( "#project_has_skill"+person_has_project+"_start_date" ).val()
	var finish_date = $( "#project_has_skill"+person_has_project+"_finish_date" ).val()
    var current_project = $('#current_project'+person_has_project).is(':checked');
	var table_id = $('tr#project_edit'+person_has_project ).parent().parent().attr('id');


	$.ajax({
	  type: "POST",
	  url: "/developer/"+developer_id+"/edit_project",
	  data:{id:developer_id, start_date:start_date, finish_date: finish_date, person_has_project_id: person_has_project,current_project: current_project},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
	  	 
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#project_edit'+person_has_project ).index()+')').remove();
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#project_show'+person_has_project ).index()+')').remove();
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#project_show'+person_has_project ).index()+')').after(data);
	  	 var tbody = $("#tbody_"+table_id).children();
	  	 tbody.sort(function(a, b) {
		        var keyA = new Date($(a).data('date'));
				var keyB = new Date($(b).data('date'));
				if (keyA < keyB) return 1;
				if (keyA > keyB) return -1;
				return 0;
		});
	  	 $('#tbody_'+table_id).html(tbody);

	  }
	});
});	

$(document).on('click', '.edit-developer', function(e){
	e.preventDefault();
	$("#change_edit").attr("src","/assets/images/save_16.png");
	$(this).removeClass('edit-developer');
	$(this).addClass('save-developer');
	var full_name = $("#edit_name").text();
	var email = $("#edit_email").text();
	var skype = $("#edit_skype").text();
	var home_number = $("#edit_home_number").text();
	$("#edit_name").html("");
	$("#edit_email").html("");
	$("#edit_skype").html("");
	$("#edit_home_number").html("");
	$('<input>').attr({ type: 'text',id: 'full_name',name: 'full_name', value: full_name }).appendTo('span#edit_name');
	$('<input>').attr({ type: 'text',id: 'person_email',name: 'person_email', value: email }).appendTo('span#edit_email');
	$('<input>').attr({ type: 'text',id: 'person_skype',name: 'person_skype', value: skype }).appendTo('span#edit_skype');
	$('<input>').attr({ type: 'text',id: 'person_home_number',name: 'person_home_number', value: home_number }).appendTo('span#edit_home_number');
});

$(document).on('click', '.save-developer', function(e){
e.preventDefault();
	
	var full_name  = $( "#full_name").val().split(" ");
	var email = $( "#person_email").val();
	var skype = $( "#person_skype").val();
	var home_number = $( "#person_home_number").val();
	var developer_id = $( "#developer_id" ).val();
	var self = this;
	var params = {person:{name:full_name[0],last_name: full_name[1], email: email, home_number: home_number, skype: skype }};
	$.ajax({
	  type: "PUT",
	  url: "/developer/"+developer_id,
	  data:params,
	  async: true,
	  dataType: "json",
	  error: function(request, textStatus, errorThrown) {
	   var error = $.parseJSON(request.responseText);
	   if (!_.isUndefined(error.email)){
	   	$("#person_email").tooltip({trigger: 'focus',placement: "top", title: error.email[0], delay: { show: 500, hide: 100 }});
	    $("#person_email").focus();
	   }
	   if (!_.isUndefined(error.home_number)){
	   	$("#person_home_number").tooltip({trigger: 'focus',placement: "top", title: error.home_number[0], delay: { show: 500, hide: 100 }});
	    $("#person_home_number").focus();
	   }

	   if (!_.isUndefined(error.name) || !_.isUndefined(error.last_name)){
	   	$("#full_name").tooltip({trigger: 'focus',placement: "top", title: error.name[0], delay: { show: 500, hide: 100 }});
	    $("#full_name").focus();
	   }
	   
	  },
	  success: function(data, textStatus, jqXHR) {
	   $("#change_edit").attr("src","/assets/images/edit_16.png");
	   $(self).removeClass('save-developer');
	   $(self).addClass('edit-developer');
	   $("#edit_name").html(data.name + " " + data.last_name);
	   $("#edit_email").html(data.email);
	   $("#edit_skype").html(data.skype);
	   $("#edit_home_number").html(data.home_number)
	  }
	});


});


