$ ->
	$(".delete").click ->
		entry_id = $(this).data("id")
		$("#deleteModal .btn-danger").attr("href", "/delete/" + entry_id)
		$("#deleteModal").modal('show')
