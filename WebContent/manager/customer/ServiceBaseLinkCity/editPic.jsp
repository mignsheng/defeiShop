<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/pages/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${naviString}</title>
<jsp:include page="../_public_head_back.jsp" flush="true" />
<link href="${ctx}/styles/index/css/btns.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${ctx}/styles/admin/css/admin.css"  />
<link href="${ctx}/scripts/jquery-ui/themes/base/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<style type="">
.selectImg{margin-right:10px;border: 1px #e3dcdc solid;}
.selectImgCur{border: 1px #b12424 solid!important;}
</style>
</head>
<body>
<script type="text/javascript" src="${ctx}/commons/scripts/calendar/WdatePicker.js"></script> 
<div class="divContent">
  <div class="subtitle">
    <h3>${naviString}</h3>
  </div>
  <html-el:form action="/customer/ServiceBaseLinkCity" enctype="multipart/form-data">
    <html-el:hidden property="queryString" styleId="queryString" />
    <html-el:hidden property="method" styleId="method" value="save" />
    <html-el:hidden property="mod_id" styleId="mod_id" />
    <html-el:hidden property="link_id" styleId="link_id" />
    <html-el:hidden property="link_type" styleId="link_type" />
    <html-el:hidden property="type" styleId="type" />
    <html-el:hidden property="par_id" styleId="par_id" />
    <html-el:hidden property="par_son_type" styleId="par_son_type" />
    <html-el:hidden property="id" styleId="id" />
    <html-el:hidden property="main_type" styleId="main_type" />
    <html-el:hidden property="pre_number" styleId="pre_number"/>
    <html-el:hidden property="isNotStyle" styleId="isNotStyle"/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableClass">
      <tr>
        <th colspan="3">基本信息</th>
      </tr>
      <tr>
        <td width="15%" class="title_item" nowrap="nowrap"><span style="color: #F00;">*</span>标题：</td>
        <td colspan="2" width="85%"><html-el:text property="title" styleId="title" maxlength="125" style="width:480px" styleClass="webinput"/>
        </td>
      </tr>
      <tr>
        <td width="15%" class="title_item" nowrap="nowrap"><span style="color: #F00;">*</span>图片：</td>
        <td colspan="2" width="85%">
         <c:set var="img" value="${ctx}/images/no_img.gif" />
        <c:if test="${not empty af.map.image_path}">
          <c:set var="img" value="${ctx}/${af.map.image_path}@s400x400" />
        </c:if>
        <img src="${img}" height="100" id="image_path_img" />
          <html-el:hidden property="image_path" styleId="image_path" value="${af.map.image_path}"/>
        <div class="files-warp" id="image_path_warp">
          <div class="btn-files"> <span>添加附件</span>
            <input id="image_path_file" type="file" name="image_path_file" />
          </div>
          <div class="progress"> <span class="bar"></span><span class="percent">0%</span > </div>
        </div>
          <div style="color:rgb(241, 42, 34); padding: 5px;"> 
               <c:if test="${af.map.link_type eq 10}"> [图片尺寸] 建议：[1920px * 449px] </c:if>
               <c:if test="${af.map.link_type eq 20}"> [图片尺寸] 建议：[1066px * 122px] </c:if>
              <c:if test="${(af.map.pre_number eq 1) and (af.map.par_son_type eq 1)}">[图片尺寸] 建议：[1200px * 458px] </c:if>
              <c:if test="${(af.map.pre_number eq 2) and (af.map.par_son_type eq 1)}">[图片尺寸] 建议：[588px  * 706px] </c:if>
              <c:if test="${(af.map.pre_number eq 2) and (af.map.par_son_type eq 2)}">[图片尺寸] 建议：[588px  * 340px] </c:if>
              <c:if test="${(af.map.pre_number eq 2) and (af.map.par_son_type eq 3)}">[图片尺寸] 建议：[1200px * 430px] </c:if>
              <c:if test="${(af.map.pre_number eq 3) and (af.map.par_son_type eq 1)}">[图片尺寸] 建议：[384px  * 495px] </c:if>
              <c:if test="${(af.map.pre_number eq 4) and (af.map.par_son_type eq 1)}">[图片尺寸] 建议：[588px  * 502px] </c:if>
              <c:if test="${(af.map.pre_number eq 5) and (af.map.par_son_type eq 1)}">[图片尺寸] 建议：[282px  * 361px] </c:if>
         </div>
         </td>
      </tr>
     <c:if test="${af.map.link_type eq 20}">
        <tr>
      	<td width="15%" class="title_item" >请选择样式</td>
      	<td colspan="2" width="4px" id="selectImgId">
      	<img src="${ctx}/styles/serviceIndex/img/floor1.jpg" height="150" class="selectImg" data-flag="1"/>
      	<img src="${ctx}/styles/serviceIndex/img/floor2.jpg" height="150" class="selectImg" data-flag="2"/>
      	<img src="${ctx}/styles/serviceIndex/img/floor3.jpg" height="150" class="selectImg" data-flag="3"/>
      	<img src="${ctx}/styles/serviceIndex/img/floor4.jpg" height="150" class="selectImg" data-flag="4"/>
      	<img src="${ctx}/styles/serviceIndex/img/floor5.jpg" height="150" class="selectImg" data-flag="5"/>
      	</td>
      </tr> </c:if>
      <tr>
        <td width="15%" class="title_item"><span style="color: #F00;">*</span>链接URL：</td>
        <td colspan="2" width="85%"><html-el:text property="link_url" styleId="link_url" maxlength="200" style="width:50%" styleClass="webinput" />&nbsp;请用"http://"或者"https://"开头</td>
      </tr>
      <tr>
        <td width="15%" class="title_item" nowrap="nowrap">排序值：</td>
        <td colspan="2" width="85%"><html-el:text property="order_value" styleId="order_value" maxlength="4" size="4" styleClass="webinput"/>
          值越大，显示越靠前，范围：0-9999</td>
      </tr>
      <tr>
        <td colspan="3" align="center"><html-el:button property="" value="保 存" styleClass="bgButton" styleId="btn_submit" />
          &nbsp;
          <html-el:button property="" value="重 填" styleClass="bgButton" styleId="btn_reset" onclick="this.form.reset();" />
          &nbsp;
          <html-el:button property="" value="返 回" styleClass="bgButton" styleId="btn_back" onclick="history.back();" /></td>
      </tr>
    </table>
  </html-el:form>
</div>
 
<script type="text/javascript" src="${ctx}/commons/scripts/validator.js"></script> 
<script type="text/javascript" src="${ctx}/commons/scripts/jquery.form.min.js"></script>
<script type="text/javascript" src="${ctx}/scripts/lhgdialog/lhgdialog.min.js?skin=discuz"></script> 
<script type="text/javascript"><!--//<![CDATA[

$(document).ready(function(){
	
	var f = document.forms[0];
	 $("#selectImgId img").each(function (i) {
   		 if($(this).attr("data-flag") == $("#pre_number").val()){
    	  $(this).addClass("selectImgCur");
   		 }
     });
	
	$("#title").attr("dataType", "Require").attr("msg", "标题必须填写");
	 <c:if test="${af.map.link_type eq 60}">
		$("#pre_varchar").attr("dataType", "Require").attr("msg", "副标题必须填写");     
   </c:if>
  	$("#image_path").attr("dataType", "Filter" ).attr("msg", "请上传格式为（bmp, gif, jpeg, jpg, png）的图片！").attr("require", "true").attr("accept", "bmp, gif, jpeg, jpg, png");
	$("#link_url").attr("dataType", "Url2").attr("msg", "直接链接地址格式不合法,例如：http://baidu.com").attr("require", "true");
	$("#order_value").attr("dataType", "Number").attr("msg", "排序值必须为正整数");
	
	if($("#link_type").val() == 20){
			$("#pre_number").attr("dataType", "Require").attr("msg", "样式必须填写");
			}
	var btn_name = "上传图片";
	if ("" != "${af.map.image_path}") {
		btn_name = "重新上传图片";
	}
	upload("image_path", "image&dirName=index", btn_name, "${ctx}");
	
	$("#btn_submit").click(function(){
		if(Validator.Validate(f, 1)){
            $("#btn_submit").attr("value", "正在提交...").attr("disabled", "true");
            $("#btn_reset").attr("disabled", "true");
            $("#btn_back").attr("disabled", "true");
			f.submit();
		}
	})
	if(!$("#isNotStyle").val()){
	$("#selectImgId img").click(function() {
        $(this).addClass('selectImgCur').siblings().removeClass('selectImgCur');
        $("#pre_number").attr("value", $(this).attr("data-flag"));
    });
	}
});

//]]></script>
</body>
</html>