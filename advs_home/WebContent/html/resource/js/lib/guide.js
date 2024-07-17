'use strict';

$(function () {
    $('html').fnInit();
    buttonFn();
    folderTreeFn('.directory-tree-wrap');
});

$.fn.tabFn = function () {
    const linkWrap = $('.el-tab__link'),
    linkItem = linkWrap.find('li'),
    linkBtn = linkItem.find('button'),
    linkClose = linkItem.find('> span');

    $('.el-tab-wrap').parent().addClass('tabs-on');

    linkBtn.click(function(){
        const thisId = $(this).parent().data('id'),
        thisConId = $('#' + thisId);

        linkItem.removeClass('is-open');
        $(this).parent().addClass('is-open');
        $('.el-tab__cont').removeClass('is-open');
        thisConId.addClass('is-open');
    })
    linkClose.click(function(){
        const thisId = $(this).parent().data('id'),
        thisConId = $('#' + thisId);

        thisConId.remove();
        $(this).parent('li').remove();
    })
}
$.fn.setFormFn = function () {
    const $this = $(this),
        selBtn = $('> button', this),
        selCont = $('> ul', this),
        selValue = selCont.find('> li');

    selCont.hide();
    selBtn.click(function () {
        $(this).parent().toggleClass('is-open').find('ul').slideToggle('fast', 'swing');
    });
    selValue.click(function () {
        $(this).parent().prev('button').find('span').text($(this).text());
        selCont.slideUp('fast', 'swing');
        $this.removeClass('is-open');
    });
    selValue.hover(function () {
        $(this).toggleClass('is-hover');
    })
};

function buttonFn(){
    $('.boxItem__reset').click(function(){
        $(this).addClass("fn-reset");
        setTimeout(function(){ 
            $(".boxItem__reset").removeClass("fn-reset"); 
        }, 400)
    })
};

function folderTreeFn(obj){
    const depth01 = $('>ul>li>a', obj),
    siblingFolder = depth01.siblings('ul');

    const treeFolderLink = $('.directory-tree__folder > li > a');
    const treeFileLink = $('.directory-tree__file > li > a');

    treeFolderLink.attr('href', 'javascript:void(0)');
    $('a', this).click(function(){
        siblingFolder.slideToggle();
    })
}

$.fn.fnInit = function () {
    $('.custom-sel').setFormFn();
    $('.el-tab-wrap').tabFn();
};