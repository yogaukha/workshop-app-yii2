$(document).ready(function () {
  $('.field-generals-value').hide();
  $('.field-generals-image').hide();
  var selected = $("input[name='Generals[type]']:checked").val()
  if (selected == 'Teks') {
    $(".field-generals-image").hide();
    $("#image-wrapper-general").hide();
    $(".field-generals-value").show();
  } else if (selected == 'Gambar') {
    $(".field-generals-value").hide();
    $(".field-generals-image").show();
    $("#image-wrapper-general").show();
  } else {
    $(".field-generals-value").hide();
    $(".field-generals-image").hide();
    $("#image-wrapper-general").hide();
  }
  $("input[name='Generals[type]']").prop('disabled', true);
  $("#workorders-completion_date").addClass('form-control');

  $('#dynamic-form').on('click', '.select2', function(event) {
    var targetId = event.target.id.replace('select2-', '').replace('-container', '');
    if (!targetId.includes('service_id')) return false;
    $('#' + targetId).change(function() {
      $.ajax({
        method: "GET",
        url: "/work-orders/get-price",
        data: { service_id: $(this).val(), category_id: $('#customers-category_id').val() }
      }).done(function( data ) {
        var priceId = targetId.replace('service_id', 'manual_price');
        var subtotalId = targetId.replace('service_id', 'subtotal');
        $('#' + priceId + '.service-manual-price').val(data);
        $('#' + subtotalId + '.service-subtotal').val(data).trigger('change');
      });
    });
  });

  $('#dynamic-form').on('keyup', '.service-manual-price', function (event) {
    var targetId = event.target.id;
    var discountId = targetId.replace('manual_price', 'discount');
    var subtotalId = targetId.replace('manual_price', 'subtotal');
    var price = $('#' + targetId + '.service-manual-price').val();
    var discount = $('#' + discountId + '.service-manual-price').val();
    discount = typeof discount == 'undefined' ? 0 : discount;
    var subtotal = price - (price * (discount / 100));
    $('#' + subtotalId + '.service-subtotal').val(subtotal).trigger('change');
  });

  $('#dynamic-form').on('keyup', '.service-manual-discount', function (event) {
    var targetId = event.target.id;
    var priceId = targetId.replace('manual_discount', 'manual_price');
    var subtotalId = targetId.replace('manual_discount', 'subtotal');
    var price = $('#' + priceId).val();
    var discount = $('#' + targetId).val();
    discount = typeof discount == 'undefined' ? 0 : discount;
    var subtotal = price - (price * (discount / 100));
    $('#' + subtotalId + '.service-subtotal').val(subtotal).trigger('change');
  });

  $('#dynamic-form').on('keyup', '.sparepart-manual-price', function (event) {
    var targetId = event.target.id;
    var discountId = targetId.replace('manual_price', 'discount');
    var subtotalId = targetId.replace('manual_price', 'subtotal');
    var price = $('#' + targetId + '.sparepart-manual-price').val();
    var discount = $('#' + discountId + '.sparepart-manual-discount').val();
    discount = typeof discount == 'undefined' ? 0 : discount;
    var subtotal = price - (price * (discount / 100));
    $('#' + subtotalId + '.sparepart-subtotal').val(subtotal).trigger('change');
  });

  $('#dynamic-form').on('keyup', '.sparepart-manual-discount', function (event) {
    var targetId = event.target.id;
    var priceId = targetId.replace('manual_discount', 'manual_price');
    var subtotalId = targetId.replace('manual_discount', 'subtotal');
    var discount = $('#' + targetId + '.sparepart-manual-discount').val();
    var price = $('#' + priceId + '.sparepart-manual-price').val();
    discount = typeof discount == 'undefined' ? 0 : discount;
    var subtotal = price - (price * (discount / 100));
    $('#' + subtotalId + '.sparepart-subtotal').val(subtotal).trigger('change');
  });

  $('#dynamic-form').on('change', '.service-subtotal', function () {
    var totalService = 0;
    $('.service-subtotal').each(function(i, obj) {
      let subtotal = parseInt($(this).val());
      totalService += subtotal;
    });
    $('#workorders-total_service').val(totalService);
    var totalSparepart = $('#workorders-total_sparepart').val();
    totalSparepart = typeof totalSparepart == 'undefined' ? 0 : parseInt(totalSparepart);
    $('#workorders-grand_total').val(parseInt(totalService) + totalSparepart);
  });

  $('#dynamic-form').on('change', '.sparepart-subtotal', function () {
    var totalSparepart = 0;
    $('.sparepart-subtotal').each(function(i, obj) {
      let subtotal = parseInt($(this).val());
      totalSparepart += subtotal;
    });
    $('#workorders-total_sparepart').val(totalSparepart);
    var totalService = $('#workorders-total_service').val();
    totalService = typeof totalService == 'undefined' ? 0 : parseInt(totalService);
    $('#workorders-grand_total').val(totalService + parseInt(totalSparepart));
  });

  $('#dynamic-form').on('click', '.remove-item', function () {
    setTimeout(function() { 
      var totalService = 0;
      $('.service-subtotal').each(function(i, obj) {
        let subtotal = $(this).val() == '' ? 0 : parseInt($(this).val());
        totalService += subtotal;
      });
      $('#workorders-total_service').val(totalService);
      var totalSparepart = $('#workorders-total_sparepart').val() == '' ? 0 : parseInt($('#workorders-total_sparepart').val());
      totalSparepart = typeof totalSparepart == 'undefined' ? 0 : parseInt(totalSparepart);
      $('#workorders-grand_total').val(parseInt(totalService) + totalSparepart);
    }, 200);
  });

  $('#dynamic-form').on('click', '.remove-item-sparepart', function () {
    setTimeout(function() { 
      var totalSparepart = 0;
      $('.sparepart-subtotal').each(function(i, obj) {
        let subtotal = $(this).val() == '' ? 0 : parseInt($(this).val());
        totalSparepart += subtotal;
      });
      $('#workorders-total_sparepart').val(totalSparepart);
      var totalService = $('#workorders-total_service').val() == '' ? 0 : parseInt($('#workorders-total_service').val());
      totalService = typeof totalService == 'undefined' ? 0 : parseInt(totalService);
      $('#workorders-grand_total').val(parseInt(totalSparepart) + totalService);
    }, 200);
  });

  $('#customers-license_plate').change(function (e) {
    $.ajax({
      method: "GET",
      url: "/work-orders/get-customer",
      data: { license_plate: $(this).val() },
      dataType: 'json',
    }).done(function( data ) {
      if (data != '') {
        $('#customers-name').val(data.name);
        $('#customers-address').val(data.address);
        $('#customers-email').val(data.email);
        $('#customers-phone_number').val(data.phone_number);
        $('#customers-year').val(data.year);
        $('#customers-kilometre').val(data.kilometre);
        $('#customers-brand').val(data.brand);
        $('#customers-type').val(data.type);
        $('#customers-vehicle_identification_number').val(data.vehicle_identification_number);
        $('#customers-engine_number').val(data.engine_number);
        $('#customers-color').val(data.color);
        $('#customers-category_id').val(data.category_id);
      } else {
        $('#customers-name').val('');
        $('#customers-address').val('');
        $('#customers-email').val('');
        $('#customers-phone_number').val('');
        $('#customers-year').val('');
        $('#customers-kilometre').val('');
        $('#customers-brand').val('');
        $('#customers-type').val('');
        $('#customers-vehicle_identification_number').val('');
        $('#customers-engine_number').val('');
        $('#customers-color').val('');
        $('#customers-category_id').val('');
      }
    });
  })

  // $("input[name='Generals[type]']").click(function() {
  //   var selected = $(this).val();
  //   if (selected == 'Teks') {
  //     $(".field-generals-image").hide();
  //     $("#image-wrapper-general").hide();
  //     $(".field-generals-value").show();
  //   } else if (selected == 'Gambar') {
  //     $(".field-generals-value").hide();
  //     $(".field-generals-image").show();
  //     $("#image-wrapper-general").show();
  //   } else {
  //     $(".field-generals-value").hide();
  //     $(".field-generals-image").hide();
  //     $("#image-wrapper-general").hide();
  //   }
  // });
})
