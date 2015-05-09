$(document).on('click', '#pdf_export', function(e){
   e.preventDefault();
   $("#pdf-profile").modal('show');
});   

$(document).on('click', '#export-developer-profile', function(e){
	e.preventDefault();
	$( "#exportsubmit" ).submit();
	 $("#pdf-profile").modal('hide');
});	
