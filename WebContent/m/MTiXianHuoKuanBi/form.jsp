<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/pages/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${app_name}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<jsp:include page="../_public_in_head.jsp" flush="true" />
</head>
<body>
<jsp:include page="../_header.jsp" flush="true" />
<div class="content">
  <html-el:form action="/MTiXianHuoKuanBi.do" enctype="multipart/form-data" styleClass="ajaxForm0">
    <html-el:hidden property="id" />
    <html-el:hidden property="mod_id" />
    <html-el:hidden property="queryString" />
    <html-el:hidden property="method" value="save"/>
    <div class="set-site">
      <ul class="formUl">
        <li><span class="grey-name">货款总额：</span>
        <fmt:formatNumber pattern="#0.00" value="${af.map.bi_huokuan}" var="bi_huokuan" />
        <html-el:hidden property="bi_huokuan" value="${af.map.bi_huokuan}" styleId="bi_huokuan" />
        <html-el:hidden property="bi_huokuan_real" value="${af.map.bi_huokuan}" styleId="bi_huokuan_real" />
          <span class="price grey-content">${bi_huokuan}元</span>
        </li>
        <li  style="border-bottom: none;padding-bottom: 0"> <span class="grey-name">可提现金额：</span>
        <fmt:formatNumber pattern="#0.########" value="${huokuan_2_rmb}" var="bi" />
          <html-el:hidden property="huokuan_2_rmb" value="${huokuan_2_rmb}" styleId="huokuan_2_rmb" />
          <span class="price grey-content">${bi}元</span>  
        </li>
        <li style="padding-top: 0">
          <span class="label label-info">货款提现手续费${pre_number}%</span>
        </li>
        <li style="border-bottom: none;padding-bottom: 0"><span class="grey-name">提现金额：</span>
        <input type="number" name="cash_count" maxlength="10" id="cash_count" placeholder="请输入提现金额,单位:元" /></li>
        <li style="padding-top: 0"><span id="tip" class="label label-danger"></span></li>  
        <li> <span class="grey-name">支付密码：</span>
        <input type="password" name="password_pay" placeholder="请输入支付密码" id="password_pay" maxlength="20" />
        </li>
        <li><span class="grey-name">申请说明：</span>
         <input type="text" name="add_memo" maxlength="100" id="add_memo" placeholder="请输入申请说明" />
        </li>
      </ul>
    </div>
    <div class="box submit-btn"> <input type="button" class="com-btn" id="btn_submit" value="保存" /></div>
  </html-el:form>
</div>
<jsp:include page="../_footer.jsp" flush="true" />

<c:set var="tip_msg" value=""/>
<c:url var="tip_url" value="/m/MMySecurityCenter.do?mod_id=1100620100"/>
<c:if test="${not empty af.map.password_pay_is_empty}">
<c:set var="tip_msg" value="尊敬的用户，为了您的资金支付安全，请前往安全中心维护支付密码"/>
</c:if>
<c:if test="${not empty af.map.bank_account_is_empty}">
<c:set var="tip_msg" value="请先前往安全中心维护银行账号"/>
</c:if>
<c:if test="${not empty af.map.all_is_empty}">
<c:set var="tip_msg" value="请先前往安全中心维护支付密码和银行账号"/>
</c:if>
<c:if test="${not empty af.map.renzheng_is_empty}">
<c:set var="tip_msg" value="请先前往进行实名认证"/>
</c:if>
<script type="text/javascript" src="/commons/scripts/validator.m.js"></script>
<script type="text/javascript">//<![CDATA[
$(document).ready(function() {
	
	 var topBtnUrl = "${ctx}/m/MTiXianHuoKuanBi.do?method=list&mod_id=${af.map.mod_id}";
	 setTopBtnUrl(topBtnUrl);
	 
	$("#cash_count").attr("datatype","Require").attr("msg","请正确填写提现金额！");
	$("#password_pay").attr("datatype","Require").attr("msg","请填写支付密码！");
	$("#add_memo").attr("datatype","LimitB").attr("max","200").attr("msg","申请说明不能超过200个字！");
	setTimeout(function(){
		$("#cash_count").val("");
		$("#password_pay").val("");
	},100);
	
	<c:if test="${not empty tip_msg}">
	    setTimeout(function(){
		  $("#btn_submit").val("${tip_msg}").attr("disabled", "true").addClass("disabled");	
	    },100);
		Common.confirm("${tip_msg}",["确定","取消"],function(){
			location.href="${tip_url}";
		},function(){
			$("#btn_submit").attr("disabled","disabled").addClass("disabled");
		});	
	</c:if>
	
	
	$("#cash_count").change(function(){
		var tv = parseFloat($(this).val());
		var bi_huokuan = parseFloat($("#bi_huokuan_real").val());
		if (tv > (bi_huokuan)){
			$("#tip").html("超过提现金额限制，请重新选择提现金额");
			$("#btn_submit").attr("disabled","disabled").addClass("disabled");
		} else {
			$("#tip").empty();
			$("#btn_submit").removeAttr("disabled").removeClass("disabled");
		}
	});
	
	
	var f0 = $(".ajaxForm0").get(0);
	$("#btn_submit").click(function(){
		if(Validator.Validate(f0, 1)){
			 var cash_count = $("#cash_count").val();
			 if(cash_count <= 0) {
				 mui.toast("提现金额不能小于等于0");
				 return false;
			 }
			 Common.loading();
			 f0.submit();
			return true;
		}
	});
});
//]]></script>
</body>
</html>
