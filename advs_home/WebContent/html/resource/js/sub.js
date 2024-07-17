'use strice'; //'use strict'

($(function(){
	$('html').pageInit();
	lnbFn();
	datepickerFn();
	
	$('header, footer').addClass('sub');
	$('.ui-form').parents('tr').addClass('has-form');
}))

var $win = $(window);
var $doc = $(document);

/* add : 2022.11.30 datepicker event */
function uiDatePicker($root) {
    if (!$root) {
        $root = $doc;
    }
    $root.find('.js-datepicker-range').each(function () {
        var $this = $(this);
        var $min = $this.find('.js-datepicker-range__min');
        var $max = $this.find('.js-datepicker-range__max');
        $min.datetimepicker({
            locale: 'ko',
            format: 'YYYY-MM-DD',
            dayViewHeaderFormat: 'YYYY년 MMMM',
        });
        $max.datetimepicker({
            locale: 'ko',
            format: 'YYYY-MM-DD',
            dayViewHeaderFormat: 'YYYY년 MMMM',
            useCurrent: false,
        });
        $min.off('dp.change.uiJSDatepickerRange').on('dp.change.uiJSDatepickerRange', function (e) {
            $max.data('DateTimePicker').minDate(e.date);
        });
        $max.off('dp.change.uiJSDatepickerRange').on('dp.change.uiJSDatepickerRange', function (e) {
            $min.data('DateTimePicker').maxDate(e.date);
        });
    });
    $root.find('.js-datepicker').datetimepicker({
        locale: 'ko',
        format: 'YYYY-MM-DD',
        dayViewHeaderFormat: 'YYYY년 MMMM'
    });
    $root.find('.js-monthpicker').datetimepicker({
        locale: 'ko',
        viewMode: 'years',
        format: 'YYYY년 M월'
    });
}
function setTimeSelectRange($min, $max, min, max) {
    $min
        .find('option')
        .prop('selected', false)
        .removeAttr('selected')
        .filter('[data-option="' + min + '"]')
        .prop('selected', true)
        .attr('selected', '');
    $max
        .find('option')
        .prop('selected', false)
        .removeAttr('selected')
        .filter('[data-option="' + max + '"]')
        .prop('selected', true)
        .attr('selected', '');
}
$doc.on('click.uiDatepicker', '[data-datepicker-range]', function () {
    var $this = $(this);
    var $wrap = $this.closest('.js-datepicker-range');
    var $min = $wrap.find('.js-datepicker-range__min');
    var $max = $wrap.find('.js-datepicker-range__max');
    var $hourMin = $wrap.find('.js-datepicker-range__hour-select-min');
    var $hourMax = $wrap.find('.js-datepicker-range__hour-select-max');
    var $minuteMin = $wrap.find('.js-datepicker-range__minute-select-min');
    var $minuteMax = $wrap.find('.js-datepicker-range__minute-select-max');
    var range = $this.attr('data-datepicker-range');
    var val = Number(range.replace(/(-*[0-9]+) *((year|month|day)(s*))/g, '$1'));
    var unit = range.replace(/(-*[0-9]+) *((year|month|day)(s*))/g, '$2');
    var minDateTimePicker = $min.length ? $min.data('DateTimePicker') : null;
    var maxDateTimePicker = $max.length ? $max.data('DateTimePicker') : null;
    var now = moment();
    var to = moment().add(val, unit);
    var nowHour = now.hour();
    var nowMinute = now.minute();
    var isHour = $hourMin.length && $hourMax.length;

    if (minDateTimePicker && maxDateTimePicker) {
        if (val < 0) {
            if (!isHour) {
                to.add(1, 'day');
            }
            minDateTimePicker.date(to.format());
            maxDateTimePicker.date(now.format());
        } else if (0 < val) {
            if (!isHour) {
                to.add(-1, 'day');
            }
            minDateTimePicker.date(now.format());
            maxDateTimePicker.date(to.format());
        }
    }
    if (isHour) {
        setTimeSelectRange($hourMin, $hourMax, nowHour, nowHour);
    }
    if ($minuteMin.length && $minuteMax.length) {
        setTimeSelectRange($minuteMin, $minuteMax, nowMinute, nowMinute);
    }
});
function datepickerFn($root){
    if (!$root) {
        $root = $doc;
    }

    uiDatePicker($root);
}
window.datepickerFn = datepickerFn;
/* //add : 2022.11.30 datepicker event */

/* add : 2022.11.30 lnb event */
function lnbFn(){
    const aDepth1 = $('.lnb-item.is-active > a');
    const newEl = document.createElement('span');
    
	$('.lnb-depth--02').prev('a').attr('href', 'javascript:void(0)').parents('.lnb-item').addClass('hasChild');

    aDepth1.prepend(newEl);
}
$.fn.setSnbMenu = function () {
	$('> a', this).click(function () {
		const lnbItem = $(this).parent();
		const sibling = lnbItem.siblings();
		const lnbItemDepth2 = $('>ul', lnbItem);

		sibling.removeClass('is-open');
		$('ul', sibling).slideUp("fast");
		lnbItem.toggleClass('is-open');

		if (lnbItemDepth2.length > 0) {
			lnbItemDepth2.slideToggle("fast", function () {
			});
			return false;
		} else if ($(this).attr('target') != '_blank') {
		}
	});
};
$.fn.pageInit = function () {
	$('.lnb-item').setSnbMenu();
};
/* //add : 2022.11.30 lnb event */

/* add : 2022.11.30 fileUpload event */
$('.file__input--file').on('change',function(event){
    var $this = $(this);
    var thisParent = $this.parent();
    var files = event.target.files;
    var fileValue = $(this).val();
    var filename = $(this).next();

    filename.val(fileValue);
    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        $("<div class='file__value'><div class='file__value--text'>" + file.name + "<button type='button' class='file__value--remove' title='첨부파일 닫기'></button></div>" + "</div></div>").insertAfter(thisParent);
    }

});
$('.file__input--find').on('change',function(event){
    var fileValue = $(this).val();
    var filename = $(this).next();

    filename.val(fileValue);
});
//Click to remove item
$('body').on('click', '.file__value--remove', function() {
    $(this).parents('.file__value').remove();
});
/* //add : 2022.11.30 fileUpload event */

/* add : 2022.11.30 search detail event */
$('.btn--schDetail').click(function(){
    const schArea = $(this).parents('.sch-area');
    const schDetail = schArea.next();

    schDetail.slideToggle(200).toggleClass('is-open');
})
/* //add : 2022.11.30 search detail event */

/* add : 2022.12.15 clone method */
/* //add : 2022.12.15 clone method */