var replaceOptions = function(selectElement, newOptions) {
  selectElement.empty();

  $.each(newOptions, function(index, element) {
    if(typeof(element) === 'string') {
      selectElement.append($("<option></option>")
        .attr("value", element).text(element));
    } else if(typeof(element) === 'object') {
      selectElement
        .append($("<option></option>")
        .attr("data-attribute-type", element.attribute_type)
        .attr("value", element.value)
        .text(element.value));
    }
  });
}

var cleanFunctionOptions = function() {
  var attributeType = $('select[name=attribute_to_apply_function] option:selected').data('attribute-type')
  var functionNumberTypeOption = $('select[name=function] option[data-attribute-type=number]')

  if(attributeType != 'number') {
    functionNumberTypeOption.addClass('hidden')
  } else {
    functionNumberTypeOption.removeClass('hidden')
  }
}

$(function(){
  $('select[name=resource]').change(function() {
    var resource = $(this).val();

    $.ajax({
      method: "GET",
      url: '/admin/charts/resource_attributes.json',
      data: { resource: resource }
    }).done(function( result ) {
      replaceOptions($('select[name=attribute_to_apply_function].axis'), result['attributes_to_apply_function'])
      replaceOptions($('select[name=group_attribute].axis'), result['group_attributes'])
      cleanFunctionOptions();
    })
  })

  $('select[name=attribute_to_apply_function]').change(function() {
    cleanFunctionOptions();
  })
})
