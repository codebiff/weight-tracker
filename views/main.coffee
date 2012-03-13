$ ->
	$(".delete").click ->
		entry_id = $(this).data("id")
		$("#deleteModal .btn-danger").attr("href", "/delete/" + entry_id)
		$("#deleteModal").modal('show')
		$("#deleteModal .btn-close").click ->
			$("#deleteModal").modal('hide')

	$(".edit").click ->
		entry_id = $(this).data("id")
		$("#editModal input#edit_kg").keyup ->
 			$("#editModal .btn-primary").attr( "href", "/edit/" + entry_id + "/" + $(this).val() )
		$("#editModal").modal('show')
		$("#editModal .btn-close").click ->
			$("#editModal").modal('hide')
