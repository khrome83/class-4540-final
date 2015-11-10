$(function() {

    $(".filter").on("click", function() {
		var year = $(this).attr("href").replace("#", "");
		
		if(year !== "all") {
			$(".entry").hide();
			$(".y" + year).show();			
		} else {
			$(".entry").show();
		}
	});
	
	$(".close").on("click", function() {
		$(this).parent().hide();
	});
	
	$(".togglesource").on("click", function() {
		$(".sources").toggle();
	});
});

