/**
 * 分页带ajax动态加载页面 需要引入jquery.js
 * 
 * @author ethanwoobolg@gmail.com
 * @version 1.0
 * @bulidDate 2012-02-13
 * @howUse 
 *  $.fn.pagination.addHiddenInputs("method", "list");
    $.fn.pagination.addHiddenInputs("mod_id", "${af.map.mod_id}");
	$("#Pagination").pagination({
		//isAllowAjax : true,
		//callback : genTable,
		pageForm : document.bottomPageForm,
		recordCount : parseFloat("${af.map.pager.recordCount}"),
		pageSize : parseFloat("${af.map.pager.pageSize}"),
		currentPage : parseFloat("${af.map.pager.currentPage - 1}")
	});
	function genTable (page_index, opts) {
		alert("page_index:" + page_index + " opts:" + $(opts.pageForm).serialize());
	}
 */
jQuery.fn.pagination=function(opts){opts=jQuery.extend($.fn.pagination.defaults,opts||{});return this.each(function(){function numPages(){return Math.ceil(opts.recordCount/opts.pageSize)}function getInterval(){var ne_half=Math.ceil(opts.displayCount/2);var np=numPages();var upper_limit=np-opts.displayCount;var start=currentPage>ne_half?Math.max(Math.min(currentPage-ne_half,upper_limit),0):0;var end=currentPage>ne_half?Math.min(currentPage+ne_half,np):Math.min(opts.displayCount,np);return[start,end]}function pageSelected(page_id,evt){currentPage=page_id;drawLinks();var continuePropagation=opts.callback(page_id,panel);if(!continuePropagation){if(evt.stopPropagation){evt.stopPropagation()}else{evt.cancelBubble=true}}return continuePropagation}function pageSelectedAndSubmitForm(page_id,pageForm){currentPage=page_id;drawLinks();var hrp='<input name="pager.requestPage" type="hidden" value="'+(page_id+1)+'" >';panel.after(hrp);pageForm.submit();return}function drawLinks(){panel.empty();var interval=getInterval();var np=numPages();var getClickHandler=function(page_id){if(opts.isAllowAjax){return function(evt){return pageSelected(page_id,evt)}}else{return function(evt){return pageSelectedAndSubmitForm(page_id,opts.pageForm)}}};var appendItem=function(page_id,appendopts){page_id=page_id<0?0:(page_id<np?page_id:np-1);appendopts=jQuery.extend({text:page_id+1,classes:""},appendopts||{});if(page_id==currentPage){var lnk=jQuery("<li class='active'><a href='javascript:;'>"+(appendopts.text)+"</a></li>")}else{var lnk=jQuery("<li><a href='javascript:;'>"+(appendopts.text)+"</a></li>").bind("click",getClickHandler(page_id)).attr("href",opts.link_to.replace(/__id__/,page_id))}if((currentPage==0)&&(appendopts.text==opts.prev_text)&&appendopts.classes){lnk.unbind().addClass(appendopts.classes)}if((currentPage==np-1)&&(appendopts.text==opts.next_text)&&appendopts.classes){lnk.unbind().addClass(appendopts.classes)}panel.append(lnk)};if(opts.prev_text&&(currentPage>0||opts.prev_show_always)){appendItem(currentPage-1,{text:opts.prev_text,classes:"disabled"})}if(interval[0]>0&&opts.num_edge_entries>0){var end=Math.min(opts.num_edge_entries,interval[0]);for(var i=0;i<end;i++){appendItem(i)}if(opts.num_edge_entries<interval[0]&&opts.ellipse_text){jQuery("<li class='active'><a href='javascript:;'>"+opts.ellipse_text+"</a></li>").appendTo(panel)}}for(var i=interval[0];i<interval[1];i++){appendItem(i)}if(interval[1]<np&&opts.num_edge_entries>0){if(np-opts.num_edge_entries>interval[1]&&opts.ellipse_text){jQuery("<li class='active'><a href='javascript:;'>"+opts.ellipse_text+"</a></li>").appendTo(panel)}var begin=Math.max(np-opts.num_edge_entries,interval[1]);for(var i=begin;i<np;i++){appendItem(i)}}if(opts.next_text&&(currentPage<np-1||opts.next_show_always)){appendItem(currentPage+1,{text:opts.next_text,classes:"disabled"})}}var currentPage=opts.currentPage;opts.recordCount=(!opts.recordCount||opts.recordCount<0)?1:opts.recordCount;opts.pageSize=(!opts.pageSize||opts.pageSize<0)?1:opts.pageSize;var panel=jQuery(this);this.selectPage=function(page_id){pageSelected(page_id)};this.prevPage=function(){if(currentPage>0){pageSelected(currentPage-1);return true}else{return false}};this.nextPage=function(){if(currentPage<numPages()-1){pageSelected(currentPage+1);return true}else{return false}};var stylepath=_getBasePath()+"themes/"+opts.themeType+"/"+opts.themeType+".css";drawLinks();var _hiddenInputStrings=[];for(var i=0;i<opts._hiddenInputNameAndValues.length;i++){_hiddenInputStrings[_hiddenInputStrings.length]='<input name="'+opts._hiddenInputNameAndValues[i][0]+'" type="hidden" id="'+opts._hiddenInputNameAndValues[i][0]+'" value="'+opts._hiddenInputNameAndValues[i][1]+'" />'}var hiddenElements=_hiddenInputStrings.join("").toString();panel.after("<span id='spanHiddenElements'>"+hiddenElements+"</span>");opts.callback(currentPage,opts);function _getBasePath(){var els=document.getElementsByTagName("script"),src;for(var i=0,len=els.length;i<len;i++){src=els[i].src||"";if(/pagination[\w\-\.]*\.js/.test(src)){return src.substring(0,src.lastIndexOf("/")+1)}}return""}function _loadStyle(url){var head=document.getElementsByTagName("head")[0]||(_QUIRKS?document.body:document.documentElement),link=document.createElement("link");head.appendChild(link);link.href=url;link.rel="stylesheet"}})};$.fn.pagination.defaults={pageForm:{},recordCount:0,pageSize:10,displayCount:5,currentPage:0,num_edge_entries:1,link_to:"javascript:void(0);",prev_text:"&laquo;",next_text:"&raquo;",ellipse_text:"...",prev_show_always:true,next_show_always:true,isAllowAjax:false,_hiddenInputNameAndValues:[],themeType:"default",basePath:[],callback:function(){return false}};$.fn.pagination.addHiddenInputs=function(name,value){$o=$.fn.pagination.defaults;$o._hiddenInputNameAndValues[$o._hiddenInputNameAndValues.length]=new Array(name,value)};