<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/commons/pages/taglibs.jsp" %><!DOCTYPE html>
<html>
   <head lang="en">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="telephone=no" name="format-detection">
    <meta name="wap-font-scale" content="no">
    <title>${app_name}</title>
    <jsp:include page="../_public_in_head.jsp" flush="true" />
    <link href="${ctx}/scripts/lightbox/css/lightbox.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
      .mui-bar {
		    background-color: #ffffff !important;
		}
    </style>
  </head>
<body>
<div id="app" v-cloak>
		<header class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title">{{entity.servicecenter_name}}村情</h1>
		</header>
		<div class="mui-content">
			<div class="mui-card" style="margin-top: 0px;margin:0px;padding: 10px;">
<!-- 				<div class="mui-card-header mui-card-media"> -->
<!-- 					<div class="mui-media-body" style="margin-left:auto;text-align: center;"> -->
						
<!-- 					</div> -->
<!-- 				</div> -->
				<div class="mui-card-content" id="content" v-html="entity.condition_info">
				</div>
			</div>
		</div>
		</div>
<script type="text/javascript" src="${ctx}/scripts/lightbox/js/lightbox.js"></script>
<script type="text/javascript">
	var vm = new Vue({
		el: '#app',
		data: {
			datas: "",
			ctx: Common.api,
			entity:'',
		},
		mounted: function() {
			this.$nextTick(function() {
				this.getAjaxData();
			});
		},
		updated: function() {
			lightbox.option({
				'showImageNumberLabel': false,
				'alwaysShowNavOnTouchDevices': true
			});
		},
		methods: {
			getAjaxData: function() {
				Common.getData({
					route: '/m/MServiceCenterInfo.do?method=getAjaxDataXianQing',
					data: {
						id: '${af.map.id}',
					},
					success: function(data) {
						if(data.code == -1) {
							mui.toast(data.msg);
							return false;
						} else{
							vm.datas = data.datas;
							vm.entity = data.datas.entity;
						}
					},
					error: function() {
						mui.toast('好像出错了哦~');
					}
				});
			},
			openUrl: function(item) {
				var link_url = vm.ctx + "m/MUserCenter.do?method=index&user_id=" + item.user_id;
				goUrl(link_url);
			},
		}
	});
</script>

	</body>
</html>