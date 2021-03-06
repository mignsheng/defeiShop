<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commons/pages/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx}/styles/entps/css/admin.css" rel="stylesheet" type="text/css" />
<title>选择产品</title>
<style type="text/css">
.inputText {
	border:1px solid #ccc;
	height:16px;
	line-height:16px;
	text-align:center;
}
table.TabTitle {
	border:1px solid #ccc;
	border-bottom:none;
	border-left:none;
}
table.TabTitle td {
	border-bottom:1px solid #ccc;
	border-left:1px solid #ccc;
	border-collapse:collapse;
	background:#F1F7FC;
	padding:6px 6px;
}
table.Tab {
	border:none;
}
table.Tab td {
	border-collapse:collapse;
	padding:5px 6px;
}
table.Tab td.next {
	background:#DBE9F7;
}
table.Tab td.page {
	text-align:right;
	background:#fff;
	padding-right:20px;
}
tr.alteven td {
	background: #ecf6fc;
}
tr.altodd td {
	background: #DBE9F7;
}
tr.over td {
	background: #BDD3E8;
}
table {
	table-layout: fixed;
}
</style>
</head>
<body>
<div align="center">
  <html-el:form action="BaseCsAjax.do">
    <html-el:hidden property="method" value="chooseCommInfo" />
    <html-el:hidden property="dir" styleId="dir"/>
    <html-el:hidden property="num" styleId="num"/>
    <html-el:hidden property="ajax"/>
    <html-el:hidden property="p_indexs"/>
    <html-el:hidden property="comm_type"/>
    <html-el:hidden property="own_entp_id"/>
    <html-el:hidden property="noNeedState"/>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableClassSearch">
      <tr>
        <th align="left" nowrap="nowrap">
          	商品名称：
          <html-el:text property="comm_name_like" styleClass="webinput" maxlength="50"/>
          &nbsp;
          <input name="submit" type="submit" style="cursor:pointer;" class="bgButton" value="查 询" /></th>
      </tr>
    </table>
  </html-el:form>
  
  <div>
  <table width="100%" border="0" cellpadding="1" cellspacing="1" class="backTable">
          <tr class="tite2">
            <th align="center" nowrap="nowrap">商品名称</th>
            <th width="20%" align="center" nowrap="nowrap">操作</th>
          </tr>
          <c:forEach var="cur" items="${entityList}" varStatus="vs">
            <tr>
              <td align="left">${fn:escapeXml(cur.comm_name)} </td>
              <td align="center">
              <span class="bgButtonFontAwesome" onclick="returnCommInfo('${cur.id}','${cur.comm_name}','${cur.up_date}','${cur.down_date}','${cur.comm_barcode}');">
                <a><i class="fa fa-check-square"></i>选择</a>
              </span>
              </td>
            </tr>
          </c:forEach>
        </table>
  </div>
  <form id="bottomPageForm" name="bottomPageForm" method="post" action="BaseCsAjax.do">
    <table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="40" align="center"><script type="text/javascript" src="${ctx}/commons/scripts/pager.js">;</script> 
          <script type="text/javascript">
            var pager = new Pager(document.bottomPageForm, 
            		${af.map.pager.recordCount}, 
            		${af.map.pager.pageSize}, 
            		${af.map.pager.currentPage});
            pager.addHiddenInputs("method", "chooseCommInfo");
            pager.addHiddenInputs("dir", "${fn:escapeXml(af.map.dir)}");
            pager.addHiddenInputs("comm_name_like", "${fn:escapeXml(af.map.comm_name_like)}");
            pager.addHiddenInputs("num", "${fn:escapeXml(af.map.num)}");
            pager.addHiddenInputs("ajax", "${fn:escapeXml(af.map.ajax)}");
            pager.addHiddenInputs("p_indexs", "${fn:escapeXml(af.map.p_indexs)}");
            pager.addHiddenInputs("noNeedState", "${fn:escapeXml(af.map.noNeedState)}");
            pager.addHiddenInputs("own_entp_id", "${fn:escapeXml(af.map.own_entp_id)}");
            document.write(pager.toString());
            </script></td>
      </tr>
    </table>
  </form>
</div>
<script type="text/javascript" src="${ctx}/commons/scripts/jquery.js"></script>
<script type="text/javascript" src="${ctx}/scripts/lhgdialog/lhgdialog.min.js?skin=discuz"></script> 
<script type="text/javascript">//<![CDATA[
$(document).ready(function(){
	$(".Tab tr").mouseover(function(){  
		$(this).addClass("over");
	}).mouseout(function(){
		$(this).removeClass("over");
	})
	$(".Tab tr:even").addClass("alteven");
	$(".Tab tr:odd").addClass("altodd");
});

function formatDate(date, format) {   
    if (!date) return;   
    if (!format) format = "yyyy-MM-dd";   
    switch(typeof date) {   
        case "string":   
            date = new Date(date.replace(/-/, "/"));   
            break;   
        case "number":   
            date = new Date(date);   
            break;   
    }    
    if (!date instanceof Date) return;   
    var dict = {   
        "yyyy": date.getFullYear(),   
        "M": date.getMonth() + 1,   
        "d": date.getDate(),   
        "H": date.getHours(),   
        "m": date.getMinutes(),   
        "s": date.getSeconds(),   
        "MM": ("" + (date.getMonth() + 101)).substr(1),   
        "dd": ("" + (date.getDate() + 100)).substr(1),   
        "HH": ("" + (date.getHours() + 100)).substr(1),   
        "mm": ("" + (date.getMinutes() + 100)).substr(1),   
        "ss": ("" + (date.getSeconds() + 100)).substr(1)   
    };       
    return format.replace(/(yyyy|MM?|dd?|HH?|ss?|mm?)/g, function() {   
        return dict[arguments[0]];   
    });                   
}   
function returnCommInfo(val0,val1,val2,val3,val4){
	var api = frameElement.api, W = api.opener;
	var ajax = "${af.map.ajax}";
	if(null != ajax && "" != ajax){
		console.info("ajax:"+ajax)
		if(ajax == "selectForBaseLink"){
			W.document.getElementById("comm_ids${af.map.num}").value = val0;
			W.document.getElementById("comm_names${af.map.num}").value = val1;
			W.getCommLinkInfo(val0,"${af.map.num}");
		} 
		if(ajax == "selectCommType4"){
			W.setCommInfoToForm(val0);
		}
		if(ajax == "fromGroup"){
			W.document.getElementById("comm_id").value = val0;
			W.document.getElementById("comm_name").value = val1;
			if(null != val2){
				if(W.document.getElementById("start_time")){
					W.document.getElementById("start_time").value = formatDate(val2,null);
				}
				
			}
			if(null != val3){
				if(W.document.getElementById("end_time")){
					W.document.getElementById("end_time").value = formatDate(val3,null);
				}
			}
		
			W.getCommLinkInfo(val0);
		}
		if(ajax == "selectCommType3"){
			W.document.getElementById("comm_id").value = val0;
			W.document.getElementById("comm_name").value = val1;
			W.document.getElementById("comm_code").value = val4;
			W.setDefaultCommAttr(val4);
		}
		if(ajax == "getCommInfo"){
			W.getCommLinkInfo(val0);
		}
	}else{
		W.document.getElementById("comm_id").value = val0;
		W.document.getElementById("comm_name").value = val1;
	}
	api.close();
}
//]]></script>

</body>
</html>