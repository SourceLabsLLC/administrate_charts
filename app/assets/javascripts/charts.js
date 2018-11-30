var replaceOptions = function(selectElement, newOptions) {
  selectElement.empty();

  $.each(newOptions, function(index, value) {
    selectElement.append($("<option></option>")
     .attr("value", value).text(value));
  });
}

$(function(){
  $('select[name=resource]').change(function() {
    var resource = $(this).val();

    $.ajax({
      method: "GET",
      url: '/admin/charts/resource_attributes.json',
      data: { resource: resource }
    }).done(function( result ) {
      replaceOptions($('select[name=attribute_to_apply_function].axis'), result)
      replaceOptions($('select[name=group_attribute].axis'), result)
    })
  })
})
