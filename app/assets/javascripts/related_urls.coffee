# methods for dealing with Related URLs in the drafts forms
$(document).ready ->

  # Handle RelatedURL URLContentType select
  $('.related-url-content-type-select').change ->
    handleContentTypeSelect($(this))

  # Handle RelatedURL Type select
  $('.related-url-type-select').change ->
    handleTypeSelect($(this))

  getRelatedUrlContentTypeSelect = (selector) ->
    $(selector).closest('.eui-accordion__body').find('.related-url-content-type-select')

  getRelatedUrlTypeSelect = (selector) ->
    $(selector).closest('.eui-accordion__body').find('.related-url-type-select')

  getRelatedUrlSubtypeSelect = (selector) ->
    $(selector).closest('.eui-accordion__body').find('.related-url-subtype-select')

  handleContentTypeSelect = (selector) ->
    contentTypeValue = $(selector).val()

    $typeSelect = getRelatedUrlTypeSelect(selector)
    $subtypeSelect = getRelatedUrlSubtypeSelect(selector)

    disableField($typeSelect)
    disableField($subtypeSelect)

    typeValue = $typeSelect.val()
    subtypeValue = $subtypeSelect.val()

    $typeSelect.find('option').remove()
    $typeSelect.append($("<option />").val('').text('Select Type'))

    if contentTypeValue?.length > 0
      types = urlContentTypeMap[contentTypeValue]?.types

      for k, v of types
        $typeSelect.append($("<option />").val(k).text(v.text))
        $typeSelect.val(typeValue) if typeValue == k

      # if only one Type option exists, select that option
      if $typeSelect.find('option').length == 2
        $typeSelect.find('option').first().remove()
        $typeSelect.find('option').first().prop 'selected', true
      enableField($typeSelect)
    $typeSelect.trigger('change')

  handleTypeSelect = (selector) ->
    typeValue = $(selector).val()

    $parent = $(selector).closest('.eui-accordion__body')
    $parent.find('.get-data-fields, .get-service-fields').hide()

    if typeValue?.length > 0
      switch typeValue
        when 'GET DATA'
          $parent.find('.get-data-fields').show()
          $parent.find('.get-service-fields').find('input, select').val ''
        when 'GET SERVICE'
          $parent.find('.get-service-fields').show()
          $parent.find('.get-data-fields').find('input, select').val ''

      $subtypeSelect = getRelatedUrlSubtypeSelect(selector)
      contentTypeValue = getRelatedUrlContentTypeSelect(selector).val()
      subtypeValue = $subtypeSelect.val()

      disableField($subtypeSelect)

      subtypes = urlContentTypeMap[contentTypeValue].types[typeValue].subtypes

      $subtypeSelect.find('option').remove()
      $subtypeSelect.append($("<option />").val('').text('Select Subtype'))
      for subtype in subtypes
        $subtypeSelect.append($("<option />").val(subtype[1]).text(subtype[0]))
        $subtypeSelect.val(subtypeValue) if subtypeValue == subtype[1]

      # if only one Subtype option exists, select that option
      if $subtypeSelect.find('option').length == 2
        $subtypeSelect.find('option').first().remove()
        $subtypeSelect.find('option').first().prop 'selected', true

      # Enable the field if any options exist
      else if $subtypeSelect.find('option').length > 1
        enableField($subtypeSelect)
      else
        # if no options exist
        $subtypeSelect.find('option').text 'No available subtype'
        $subtypeSelect.find('option').first().prop 'selected', true

  # Update all the url content type select fields on page load
  $('.related-url-content-type-select').each ->
    handleContentTypeSelect($(this))
