<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/pages/taglibs.jsp"%>
<!DOCTYPE html>
<!-- saved from url=(0098)http://www.17sucai.com/preview/60944/2017-04-05/%E7%A4%BE%E5%8C%BA%E7%BD%91%E7%AB%99/Property.html -->
<html lang="en" class="hb-loaded"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
    <meta content="telephone=no" name="format-detection">
    <title>${app_name}</title>
    <link href="${ctx}/styles/my_wallet/css/main.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/styles/my_wallet/css/style.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/styles/my_wallet/css/shake.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/styles/my_wallet/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/styles/my_wallet/css/animate.min.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/styles/my_wallet/css/idangerous.swiper.css" rel="stylesheet" type="text/css">
</head>
<body huaban_collector_injected="true" youdao="bind">
<div class="warpe">
    <div class="head">
    <c:url var="url" value="/m/MMyHome.do" />
        <a onclick="goUrl('${url}')" class="return">
<!--         <i class="icon-chevron-left"></i>  -->返回</a>货款</div>
<fmt:formatNumber var="bi" value="${userInfo.bi_huokuan}" pattern="0.##"/>
<fmt:formatNumber var="bi1" value="${userInfo.bi_huokuan}" pattern="0"/>
<c:if test="${bi1 gt 10000}">
  <fmt:formatNumber var="bi" value="${bi/10000}" pattern="#.##万"/>
</c:if>
    <c:url var="url1" value="/m/MTiXianDianZiBi.do?method=add&mod_id=1100400100" />
	<c:url var="url2" value="/m/MTiXianDianZiBi.do?method=list&mod_id=1100400100" />
	<c:url var="url3" value="/m/MChongZhiEntpFxMoney.do?par_id=1300510000&mod_id=1300510130" />
	<c:url var="url5" value="/m/MTiXianHuoKuanBi.do?method=add&&par_id=1300100000&mod_id=1300300400" />
    <div class="pro_t">
        <p>货款余额</p>
        <p><span>${bi}</span></p>
      <div class="pro_b">
        <a onclick="goUrl('${url5}')" style="width: 25%;margin-left: 7rem;">提现</a>
        <c:if test="${((!pay_type_is_audit_success) and (userInfo.is_entp eq 1 or userInfo.is_fuwu eq 1)) or (pay_type_is_audit_success)}">
        <a onclick="goUrl('${url3}')">充值</a>
        </c:if>
      </div>
    </div>
    <div class="tabs my_tab pro_tab">
        <a href="" hidefocus="true" class="active">收入</a>
        <a href="" hidefocus="true" class="">支出</a>
    </div>
    <div class="swiper-container swiper-container-horizontal">
        <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
			<!-- 收入 -->
            <div class="swiper-slide swiper-slide-active" style="width: 375px;">
                <div class="content-slide">
                    <div class="I_list">
                        <ul>
                        <c:forEach var="cur" items="${entityList}" varStatus="vs">
                        <c:set var="class" value="animated fadeInRight"></c:set>
                        <c:if test="${vs.count mod 2 eq 0}">
                        <c:set var="class" value="animated fadeInLeft"></c:set>
                        </c:if>
                            <li class="${class}">
                                <a>
                                    <p style="width: 55%;float: left;height: 4rem;"> 
	                                    <c:forEach items="${biGetTypes}" var="keys">
				                             <c:if test="${cur.bi_get_type eq keys.index}">${keys.name}</c:if>
			      						</c:forEach>
		      						</p>
		      						<p style="color: green;">+<em><fmt:formatNumber var="bi" pattern="0.00" value="${cur.bi_no}"/>${bi}</em></p>
                                    <p style="width: 55%;"><font>操作前 &nbsp;&nbsp;&nbsp;&nbsp;<b class="color_y"><em><fmt:formatNumber var="bi_before" pattern="0.00" value="${cur.bi_no_before}"/>${bi_before}</em> </b></font></p>
                                    <p style="width: 55%;float: left;"><font>操作后&nbsp;&nbsp;&nbsp;&nbsp;<b class="color_y"><em><fmt:formatNumber var="bi_after" pattern="0.00" value="${cur.bi_no_after}"/>${bi_after}</em> </b></font></p><p style="font-size: 1.2rem;"><fmt:formatDate value="${cur.add_date}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                </a>
                            </li>
                       </c:forEach>  
                        </ul>
                    </div>
                </div>
            </div>
			<!--支出 -->
            <div class="swiper-slide swiper-slide-next" style="width: 375px;">
                <div class="content-slide">
<!--                     <div class="car_t">2016年</div> -->
                    <div class="I_list">
                        <ul>
                        <c:forEach var="cur" items="${uRecordList}" varStatus="vs">
                        <c:set var="class" value="animated fadeInRight"></c:set>
                        <c:if test="${vs.count mod 2 eq 0}">
                        <c:set var="class" value="animated fadeInLeft"></c:set>
                        </c:if>
                            <li class="${class}">
                                <a>
                                    <p style="width: 55%;float: left;height: 4rem;"> 
	                                    <c:forEach items="${biGetTypes}" var="keys">
				                             <c:if test="${cur.bi_get_type eq keys.index}">${keys.name}</c:if>
			      						</c:forEach>
		      						</p>
		      						<p style="color: red;">-<em><fmt:formatNumber var="bi" pattern="0.00" value="${cur.bi_no}"/>${bi}</em></p>
                                    <p style="width: 55%;"><font>操作前 &nbsp;&nbsp;&nbsp;&nbsp;<b class="color_y"><em><fmt:formatNumber var="bi_before" pattern="0.00" value="${cur.bi_no_before}"/>${bi_before}</em> </b>元</font></p>
                                    <p style="width: 55%;float: left;"><font>操作后&nbsp;&nbsp;&nbsp;&nbsp;<b class="color_y"><em><fmt:formatNumber var="bi_after" pattern="0.00" value="${cur.bi_no_after}"/>${bi_after}</em> </b>元</font></p><p style="font-size: 1.2rem;"><fmt:formatDate value="${cur.add_date}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                </a>
                            </li>
                       </c:forEach>  
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</div>
<script type="text/javascript" src="${ctx}/styles/my_wallet/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/styles/my_wallet/js/wo.js"></script>
<script type="text/javascript" src="${ctx}/styles/my_wallet/js/idangerous.swiper.min.js"></script>
<script type="text/javascript" src="${ctx}/m/scripts/mobiledialog/mobiledialog.js?v20161220"></script> 
<script type="text/javascript" src="${ctx}/m/scripts/common.js?v=20170212"></script>
<script type="text/javascript">

// 	$("#ti_xian").click(function(){
// 		$("#ti_xian").hide();
// 		$("#chong_zhi").hide();
// 		$("#zhuan_zhang").hide();
// 		$("#yue").show();
// 		$("#huo_kuan").show();
//  });

    var tabsSwiper = new Swiper('.swiper-container',{
        speed:500,
        onSlideChangeStart: function(){
            $(".tabs .active").removeClass('active');
            $(".tabs a").eq(tabsSwiper.activeIndex).addClass('active');
        }
    });
    $(".tabs a").on('touchstart mousedown',function(e){
        e.preventDefault()
        $(".tabs .active").removeClass('active')
        $(this).addClass('active')
        tabsSwiper.slideTo( $(this).index() )
    })
    $(".tabs a").click(function(e){
        e.preventDefault()
    })
</script>

</body></html>