<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/pages/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="../_public_head_back.jsp" flush="true" />
<link href="${ctx}/styles/entps/css/admin.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="mainbox mine">
<html-el:form action="/customer/TuiHuoAudit.do" styleClass="ajaxForm">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="backTable">
       <tr>
         <td width="14%" nowrap="nowrap" class="title_item">商品名称：</td>
         <td >${af.map.comm_name }</td>
       </tr>
       <tr>
         <td width="14%" nowrap="nowrap" class="title_item">退换货原因：</td>
         <td >${returnTypeName}</td>
       </tr>
       <tr>
         <td width="14%" nowrap="nowrap" class="title_item">申请时间：</td>
         <td ><fmt:formatDate value="${af.map.add_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
       </tr>
        <tr>
         <td width="14%" nowrap="nowrap" class="title_item">审核时间：</td>
         <td ><fmt:formatDate value="${af.map.audit_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
       </tr>
        <tr>
         <td width="14%" nowrap="nowrap" class="title_item">申请说明：</td>
         <td >${af.map.return_desc }</td>
       </tr>
       <tr>
         <td width="14%" nowrap="nowrap" class="title_item"><span style="color: #F00;">*</span>反馈内容：</td>
         <td ><html-el:textarea property="content" styleId="content" style="width:400px"/> </td>
       </tr>
       <tr>
        <td style="text-align:center" colspan="2">
          <html-el:submit property="" value="保 存" styleClass="bgButton" styleId="btn_submit" />
       </td>
      </tr>
    </table>
</html-el:form>
</div>
<script type="text/javascript" src="${ctx}/scripts/jBox/jbox.min.manager.js"></script>
<script type="text/javascript" src="${ctx}/commons/scripts/validator.js"></script> 
<script type="text/javascript">//<![CDATA[
$(document).ready(function(){
	$("#content").attr("dataType", "Require").attr("msg", "请输入反馈内容");
	
	var f0 = $(".ajaxForm").get(0);
	f0.onsubmit = function(){
		if (Validator.Validate(f0, 3)) {
			$.jBox.tip("数据提交中...", 'loading');
			$("#btn_submit").attr("value", "正在提交...").attr("disabled", "true");
				$.ajax({
					type: "POST",
					url: "?method=insertOrderReturnMsg&id=${af.map.id}",
					data: $(f0).serialize(),
					dataType: "json",
					error: function(request, settings) {},
					success: function(data) {
						if(data.ret == "1"){
							$.jBox.tip(data.msg, "success",{timeout:1000});
							window.setTimeout(function () {
								returnTo();
							}, 1500);
						} else {
							$.jBox.tip(data.msg, "info");
							$("#btn_submit").attr("value", "保 存").removeAttr("disabled");
						}
					}
				});	
			return false;
		}
		return false;
	}
});

function returnTo(){
	var api = frameElement.api, W = api.opener;
	W.refreshPage();
	api.close();
	
}
//]]></script>
</body>
</html>
