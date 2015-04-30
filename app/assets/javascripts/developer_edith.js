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
	  	 
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#edit_'+skill_id ).index()+')').remove()
	  	 //$("#"+table_id+" > tbody:last tr:eq("+$( 'tr#show_'+skill_id ).index()+')').remove()
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#show_'+skill_id ).index()+')').after(data);
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

	var table_id = $('tr#project_edit'+person_has_project ).parent().parent().attr('id');


	$.ajax({
	  type: "POST",
	  url: "/developer/"+developer_id+"/edit_project",
	  data:{id:developer_id, start_date:start_date, finish_date: finish_date, person_has_project_id: person_has_project},
	  async: true,
	  dataType: "html",
	  error: function(jqXHR, textStatus, errorThrown) {
	   
	  },
	  success: function(data, textStatus, jqXHR) {
	  	 console.log($('tr#project_show'+person_has_project).index());
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#project_edit'+person_has_project ).index()+')').remove()
	  	 //$("#"+table_id+" > tbody:last tr:eq("+$( 'tr#project_show'+person_has_project ).index()+')').remove()
	  	 $("#"+table_id+" > tbody:last tr:eq("+$( 'tr#project_show'+person_has_project ).index()+')').after(data);
	  }
	});
});	