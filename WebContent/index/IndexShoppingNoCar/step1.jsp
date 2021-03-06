<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../../commons/pages/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="MSThemeCompatible" content="no" />
<meta name="MSSmartTagsPreventParsing" content="true" />
<meta name="Description" content="${app_name}" />
<meta name="Keywords" content="${app_name}" />
<title>查看购物车 - ${app_name}</title>
<jsp:include page="../../_public_header.jsp" flush="true" />
<link rel="stylesheet" type="text/css" href="${ctx}/styles/index/css/buy.css"  />
<style type="">
#bd{
    width: 1200px;
    top:0px;
}
</style>
</head>
<body class="pg-buy pg-buy-process pg-buy pg-cart pg-buy-process" id="deal-buy">
<jsp:include page="../../_header_order.jsp" flush="true" />
<div class="component-system-message mt-component--booted" style="display:none;" id="msg_error">
  <div class="sysmsgw common-tip">
    <div class="sysmsg"> <span class="J-msg-content"><span class="J-tip-status tip-status tip-status--error"></span> </span> <span id="msg_error-tip">抱歉，数量有限，您最多只能购买 1件</span> <span class="close common-close" onclick="closedErrorMsg();">关闭</span> </div>
  </div>
</div>
<div class="bdw">
  <div id="bd" class="cf cart_not_empty">
    <c:url var="url" value="IndexShoppingNoCar.do" />
    <html-el:form action="${url}" styleClass="common-form form J-wwwtracker-form mt-component--booted formOrder" method="post" >
    <html-el:hidden property="method" value="step2"/>
    <html-el:hidden property="shipping_address_id" styleId="shipping_address_id" value="${shipping_address_id}"/>
    <html-el:hidden property="showAddress" styleId="showAddress" value="${showAddress}"/>
    <html-el:hidden property="comm_id" />
    <html-el:hidden property="comm_tczh_id" />
    <div class="cart-head cf">
      <div class="cart-status"> <i class="cart-status-icon status-1"></i><span class="cart-title">我的购物车</span> </div>
    </div>
    <c:if test="${not empty showAddress}">
    <div class="component-dealbuy-delivery mt-component--booted">
      <div  class="blk-item delivery J-deal-buy-delivery dealbuy-delivery">
        <h3>收货地址<span style="float:right;"><a onclick="addAddr();" href="javascript:void(0);" style="color: #ec5051!important;">新增收货地址</a></span></h3>
      <c:if test="${not empty shippingAddressList}">
        <div class="step-cont">
          <div id="consignee-addr" class="consignee-content">
            <div class="consignee-scrollbar">
              <div class="ui-scrollbar-main">
                <div class="consignee-scroll">
                  <div class="consignee-cont" id="consignee1" style="height:auto;">
                    <ul id="consignee-list">
                     <c:forEach items="${shippingAddressList}" var="cur" varStatus="vs">
                     <c:set var="shippingSelect" value="" />
                      <c:if test="${cur.id eq shipping_address_id}">
            			<c:set var="shippingSelect" value="item-selected" />
          			  </c:if>
                      <li class="ui-switchable-panel ui-switchable-panel-selected" style="display:list-item;" id="addrli${cur.id}">
                        <div class="consignee-item ${shippingSelect}" id="addrliSelect${cur.id}" onclick="showShippingAddress(${cur.id});"> 
                        <span title="收货人：${fn:escapeXml(cur.rel_name)}">${fn:escapeXml(cur.rel_name)}</span><b></b></div>
                        <div class="addr-detail">
<%--                           <span class="addr-name" title="${fn:escapeXml(cur.rel_name)}">${fn:escapeXml(cur.rel_name)}</span>  --%>
                          <span class="addr-info" title="${fn:escapeXml(cur.map.full_addr)}">${fn:escapeXml(cur.map.full_addr)}</span> 
                          <span class="addr-tel">${fn:escapeXml(cur.rel_phone)}</span> 
                         </div>
                        <div class="op-btns"> 
	                        <a href="javascript:void(0);" class="ftx-05 del-consignee" onclick="delAddr('${cur.id}',this)">删除</a> 
                        </div>
                      </li>
                    </c:forEach>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <c:if test="${fn:length(shippingAddressList)> 4}">
	          <div class="addr-switch switch-on" id="showAllShippingAddr"> <span>更多地址</span><b></b> </div>
	          <div class="addr-switch switch-off" style="display:none;" id="onlyShowFourShippingAddr"> <span>收起地址</span><b></b> </div>
          </c:if>
        </div>
       </c:if> 
       <c:if test="${empty shippingAddressList}">
         	<div>暂无收货地址</div>
       </c:if>
      </div>
    </div>
    </c:if>
    <div class="table-section summary-table">
    <table class="buy-table">
      <tr class="order-table-head-row">
        <th width="60"> 
        <input type="checkbox" id="cart-selectall" class="ui-checkbox" checked="checked" onclick="chkSelectAll(this);" />
          <label for="cart-selectall" class="cart-select-all">全选</label>
        </th>
        <th class="desc">项目</th>
        <th class="unit-price">单价</th>
        <th class="amount">数量</th>
        <th class="col-total" style="border-right: 1px solid #E5E5E5;">小计</th>
      </tr>
      <tbody id="cartContentTbody">
        <tr>
          <td width="60" rowspan="1" class="select-cartItem">
          <input type="checkbox" class="ui-checkbox" name="cart_ids" checked="checked" id="cart-select${af.map.id}" onclick="chkSelect(this,'${af.map.id}');" value="${af.map.id}"/>
            <label for="cart-select${af.map.id}">&nbsp;</label>
          </td>
          <td class="desc"><c:url var="url" value="/entp/IndexEntpInfo.do?method=getCommInfo&id=${af.map.comm_id}" />
            <a href="javascript:void(0)" target="_blank"><c:if test="${not empty entpInfo.entp_name}">${fn:escapeXml(entpInfo.entp_name)}:</c:if>${fn:escapeXml(af.map.comm_name)}</a><c:if test="${not empty commTczhAttribute.attr_name}">[${commTczhAttribute.attr_name}]</c:if></td>
          <td class="money J-deal-buy-price">¥<span id="deal-buy-price">
            <fmt:formatNumber value="${af.map.pd_price}" pattern="0.##" />
            </span></td>
          <td class="deal-component-quantity">
          <div class="component-dealbuy-quantity mt-component--booted">
              <div class="dealbuy-quantity">
                <button class="minus" type="button" onclick="calcCartMoney($('#${af.map.id}pd_count'),${af.map.pd_price},${af.map.id}, -1);">-</button><input type="text" class="f-text J-quantity J-cart-quantity" maxlength="4" id="${af.map.id}pd_count" name="pd_count" value="${af.map.pd_count}" onkeyup="calcCartMoney($('#${af.map.id}pd_count'),${af.map.pd_price},${af.map.id},null);" onblur="calcCartMoney($('#${af.map.id}pd_count'),${af.map.pd_price},${af.map.id},null,true);" /><button class="item plus" type="button"  onclick="calcCartMoney($('#${af.map.id}pd_count'),${af.map.pd_price},${af.map.id},1);">+</button>
                <c:set var="color" value="" />
                <c:if test="${af.map.pd_count > af.map.map.pd_max_count}"><c:set var="color" value="color:red" /></c:if>
                <div id="msg${af.map.id}" style="${color}">${af.map.map.inventoryTip}</div>
              <input type="hidden" name="pd_max_count" value="${af.map.map.pd_max_count}" id="max${af.map.id}"/>
            </div>
      </div>
      </td>
      <td class="money total rightpadding col-total"  style="border-right: 1px solid #E5E5E5;">¥<span id="J-deal-buy-total${af.map.id}" class="thisTrCheck">${(af.map.pd_count * af.map.pd_price)}</span> </td>
      </tr>
      </tbody>
      <tr>
        <td></td>
        <td></td>
        <td colspan="4" class="extra-fee total-fee"><strong>应付总额</strong>： <span class="inline-block money">¥<strong id="J-cart-total">
          <fmt:formatNumber value="${totalMoney}" pattern="0.##"/>
          </strong> </span> </td>
      </tr>
    </table>
  </div>
    <div style="font-size:13px;padding-left:16px;">买家留言：
    <input type="text" name="remark" maxlength="100" style="width:260px;" placeholder="选填，可填写您和卖家达成一致的要求" />
    </div>
  <div class="form-submit">
    <c:if test="${lack_inventorty}">
      <input type="button" class="btn btn-large btn-buy" id="form_sbt" name="buy" value="提交订单" onclick="sbt();" />
    </c:if>
    <c:if test="${!lack_inventorty}">
      <input type="button" class="btn btn-large btn-disabled" id="form_sbt" name="buy" value="提交订单" />
    </c:if>
  </div>
  </html-el:form>
  <div>
 </div>
</div>
</div>
<c:url var="url_my_order" value="/manager/customer/MyOrder.do?par_id=1100500000&mod_id=1100500100"></c:url>
<script type="text/javascript" src="${ctx}/scripts/jBox/jbox.min.js"></script> 
<script type="text/javascript" src="${ctx}/scripts/lhgdialog/lhgdialog.min.js?skin=discuz"></script>
<script type="text/javascript">//<![CDATA[
                                          
 $(document).ready(function(){
	 $("#showAllShippingAddr").click(function(){
		 $("#consignee-addr").css("max-height","none");
		 $("#showAllShippingAddr").hide();
		 $("#onlyShowFourShippingAddr").show();
	 });
	 $("#onlyShowFourShippingAddr").click(function(){
		 $("#consignee-addr").css("max-height","168px");
		 $("#onlyShowFourShippingAddr").hide();
		 $("#showAllShippingAddr").show();
	 });
	 
 });
 
 function calcCartMoney(JqObj, pd_price, cart_id, addNum, isBlur) {
		
	   
	 
		if (null == addNum || undefined == addNum) {addNum = 0;}
		if (null == isBlur || undefined == isBlur) {isBlur = false;}
		var ajax = true;
		var _regInt = /^[1-9]\d{0,2}$/g;;
		var _regCurr = /^[\+]?\d*?\.?\d*?$/;
		var $this = JqObj;
		var count = parseFloat($this.val());
		
		if (!_regInt.test(count)) {
			ErrorMsgAndClosed("输入的数量有误,应为[1-999]");
			$this.val(1);
			count = 1;
			ajax = true;
		}
		count += parseFloat(addNum); 
		
		var pd_max_count = $("#max" + cart_id).val();
		if(isNaN(pd_max_count)) pd_max_count = 0;
		if ((count > pd_max_count)) {
			ErrorMsgAndClosed("很抱歉，该产品库存不足，货到后我们将第一时间通知您！");	
			$("#msg"+ cart_id).html("库存不足");
			$("#msg"+ cart_id).css("color","red");
			$("#form_sbt").removeClass("btn-buy").addClass("btn-disabled");
			$("#form_sbt").removeAttr("onclick");
			ajax = false;
		} else{
			$("#msg"+ cart_id).empty();
		}
		
		if(count<=0){count=1;ajax = true;}
		$this.val(count);
		var price = parseFloat(pd_price);
		if(isNaN(price)){ ajax = false;return false;}
		
		$("#J-deal-buy-total" + cart_id).text((count * price).toFixed(2));
		jugdeButton();
		calTotalMoney();
		
		 var flag = true;
		 $("#cartContentTbody").find("input[name*='cart_ids']").map(function(){
		 	if($(this).is(':checked')){
		 		flag=false;
		 	}
		 });
		 if(flag){
			 $("#cart-selectall").removeAttr("checked");
			 $("#form_sbt").removeClass("btn-buy").addClass("btn-disabled");
			 $("#form_sbt").removeAttr("onclick");
		 }
	}
 
 function jugdeButton(){
	 
	 var flag = true;
	 $("#cartContentTbody").find("div[class='dealbuy-quantity']").map(function(){
	 	var pd_max_count = $(this).find("input[id*='max']").val();
	 	var input_count = $(this).find("input[id*='pd_count']").val();
	 	//alert("input_count:"+input_count+"  pd_max_count:"+pd_max_count)
	 	if(parseInt(input_count) > parseFloat(pd_max_count)){
	 		flag = false;
	 		return false;
	 	}
	 });
	 if(flag){
		 $("#form_sbt").removeClass("btn-disabled").addClass("btn-buy");
		 $("#form_sbt").attr("onclick","sbt()");
	 }else{
		 $("#form_sbt").removeClass("btn-buy").addClass("btn-disabled");
		 $("#form_sbt").removeAttr("onclick");
	 }
	 
 }
 
 function calTotalMoney(){
	 var total_money = 0;
	 $("#cartContentTbody").find("span[class='thisTrCheck']").map(function(){
			total_money += parseFloat($(this).text());
	});
	$("#J-cart-total").text(total_money.toFixed(2));
 }
 
 function ErrorMsgAndClosed(msg){
		$("#msg_error-tip").text(msg);
		$("#msg_error").show();
		setTimeout(closedErrorMsg, 2000);
 }
 
 function addAddr(){
	 var url = "?method=addAddr";
		$.dialog({
			title:  "新增收货地址",
			width:  770,
			height:277,
			padding: 50,
	        lock:true,
	        max: false,
	        min: false,
	        drag: false,
			content:"url:"+url
		});
 }
 
 function showShippingAddress(id) {
	$("#shipping_address_id").val(id); 
	$(".formOrder").get(0).action="?method=step1";
	$(".formOrder").get(0).submit();
}
 function closedErrorMsg(){
	 $("#msg_error").hide();
 }
 
 function sbt(){
	$(".formOrder").get(0).action="?method=step2"; 
	$(".formOrder").get(0).submit();
 }
 
function chkSelectAll(obj){
	if(obj.checked){
		$("input[name*='cart_ids']").attr("checked",true); 
		 $("#cartContentTbody").find("span[id*='J-deal-buy-total']").map(function(){
			 $(this).addClass("thisTrCheck");
		 });
		 $("#form_sbt").removeClass("btn-disabled").addClass("btn-buy");
		 $("#form_sbt").attr("onclick","sbt()");
	}else{
		$("input[name*='cart_ids']").removeAttr("checked"); 
		 $("#cartContentTbody").find("span[id*='J-deal-buy-total']").map(function(){
			 $(this).removeClass("thisTrCheck");
		 });
		 $("#form_sbt").removeClass("btn-buy").addClass("btn-disabled");
		 $("#form_sbt").removeAttr("onclick");
	}
	calTotalMoney();
} 

function delAddr(id,obj){
	 if(null != id && '' != id){
		 var submit = function (v, h, f) {
			    if (v == true) {
			     $.post("${ctx}/CsAjax.do?method=delShippingAddress",{id:id},function(data){
			     	if (data.result) {
						if($("#addrliSelect" + id).hasClass("item-selected")){
							$("#addrli" + id).next().find("div[id*='addrliSelect']").addClass("item-selected");
							$("#shipping_address_id").val(id);
						}
						$("#addrli" + id).remove();
			     	}	
			     });
			    } 
			    return true;
			};
		confirmDelShippAddr("您确定要删除该收货地址吗？",submit);
	 } 
}

function confirmDelShippAddr(tip, submit){ 
	$.jBox.confirm(tip, "${app_name}", submit, { buttons: { '确定': true, '取消': false} });
}
function chkSelect(obj,cart_id){
	if(obj.checked){
		$(obj).attr("checked",true); 
		 $("#cart-selectall").attr("checked",true);
		 $("#form_sbt").removeClass("btn-disabled").addClass("btn-buy");
		 $("#form_sbt").attr("onclick","sbt()");
		 $("#J-deal-buy-total" + cart_id).addClass("thisTrCheck");
	}else{
		$(obj).removeAttr("checked"); 
		 var flag = true;
		 $("#cartContentTbody").find("input[name*='cart_ids']").map(function(){
		 	if($(this).is(':checked')){
		 		flag=false;
		 	}
		 });
		 if(flag){
			 $("#cart-selectall").removeAttr("checked");
			 $("#form_sbt").removeClass("btn-buy").addClass("btn-disabled");
			 $("#form_sbt").removeAttr("onclick");
		 }
		 $("#J-deal-buy-total" + cart_id).removeClass("thisTrCheck");
	}
	calTotalMoney();
} 
//]]></script>
<jsp:include page="../../_footer.jsp" flush="true" />
</body>
</html>
