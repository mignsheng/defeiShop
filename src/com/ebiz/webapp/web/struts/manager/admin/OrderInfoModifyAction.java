package com.ebiz.webapp.web.struts.manager.admin;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.GenericValidator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ebiz.ssi.web.struts.bean.Pager;
import com.ebiz.webapp.domain.OrderInfo;
import com.ebiz.webapp.domain.OrderInfoDetails;
import com.ebiz.webapp.domain.UserInfo;
import com.ebiz.webapp.web.Keys;

public class OrderInfoModifyAction extends BaseAdminAction {
	public ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return this.list(mapping, form, request, response);
	}

	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		setNaviStringToRequestScope(request);

		DynaBean dynaBean = (DynaBean) form;
		Pager pager = (Pager) dynaBean.get("pager");
		String st_modify_date = (String) dynaBean.get("st_add_date");
		String en_modify_date = (String) dynaBean.get("en_add_date");
		OrderInfo entity = new OrderInfo();
		super.copyProperties(entity, form);

		HttpSession session = request.getSession(false);
		UserInfo ui = (UserInfo) session.getAttribute(Keys.SESSION_USERINFO_KEY);
		// entity.setPrice_modify_user_id(ui.getId());//暂时系统管理员可以看到所有修改过的订单

		entity.setIs_price_modify(1);
		entity.getMap().put("st_modify_date", st_modify_date);
		entity.getMap().put("en_modify_date", en_modify_date);
		Integer recordCount = getFacade().getOrderInfoService().getOrderInfoCount(entity);
		pager.init(recordCount.longValue(), 10, pager.getRequestPage());
		entity.getRow().setFirst(pager.getFirstRow());
		entity.getRow().setCount(pager.getRowCount());

		List<OrderInfo> entityList = getFacade().getOrderInfoService().getOrderInfoPaginatedList(entity);
		if (entityList != null && entityList.size() > 0) {
			for (OrderInfo oi : entityList) {
				OrderInfoDetails orderInfoDetails = new OrderInfoDetails();
				orderInfoDetails.setOrder_id(oi.getId());
				List<OrderInfoDetails> orderInfoDetailsList = super.getFacade().getOrderInfoDetailsService()
						.getOrderInfoDetailsList(orderInfoDetails);
				oi.getMap().put("orderInfoDetailsList", orderInfoDetailsList);
				// 标识是否为系统管理员修改
				if (ui.getId().equals(oi.getPrice_modify_user_id())) {
					oi.getMap().put("is_admin", "1");
				}
			}
		}
		request.setAttribute("entityList", entityList);
		return mapping.findForward("list");
	}

	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		setNaviStringToRequestScope(request);
		super.saveToken(request);
		return new ActionForward("/../manager/admin/OrderInfoModify/add.jsp");
	}

	public ActionForward check(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		setNaviStringToRequestScope(request);
		DynaBean dynaBean = (DynaBean) form;
		String trade_index = (String) dynaBean.get("trade_index");
		if (StringUtils.isBlank(trade_index)) {
			String msg = "参数不能为空";
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');history.back();}");
			return null;
		}
		OrderInfo entity = new OrderInfo();
		entity.setTrade_index(trade_index);
		entity = getFacade().getOrderInfoService().getOrderInfo(entity);
		if (entity == null) {
			String msg = "系统内无此订单号,请确认订单号是否正确";
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');history.back();}");
			return null;
		}
		if (entity.getOrder_state().intValue() != Keys.OrderState.ORDER_STATE_0.getIndex()) {
			String msg = "该订单不是预定状态,无法修改价格";
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');history.back();}");
			return null;
		}
		if (StringUtils.isNotBlank(entity.getYhq_tip_desc())) {
			String msg = "该订单有挑夫会员立减优惠,无法修改价格";
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');history.back();}");
			return null;
		}
		HttpSession session = request.getSession(false);
		UserInfo ui = (UserInfo) session.getAttribute(Keys.SESSION_USERINFO_KEY);

		OrderInfoDetails orderInfoDetails = new OrderInfoDetails();
		orderInfoDetails.setOrder_id(entity.getId());
		List<OrderInfoDetails> orderInfoDetailsList = super.getFacade().getOrderInfoDetailsService()
				.getOrderInfoDetailsList(orderInfoDetails);
		entity.getMap().put("orderInfoDetailsList", orderInfoDetailsList);
		// 标识是否为系统管理员修改
		if (!ui.getId().equals(entity.getPrice_modify_user_id())) {
			entity.getMap().put("is_admin", "1");
		}

		request.setAttribute("entity", entity);
		return mapping.findForward("input");
	}

	public ActionForward view(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		setNaviStringToRequestScope(request);
		DynaBean dynaBean = (DynaBean) form;
		String id = (String) dynaBean.get("id");

		if (GenericValidator.isLong(id)) {
			OrderInfo entity = new OrderInfo();
			entity.setId(Integer.valueOf(id));
			entity = getFacade().getOrderInfoService().getOrderInfo(entity);
			if (null != entity) {
				// 订单明细
				OrderInfoDetails ods = new OrderInfoDetails();
				ods.setOrder_id(Integer.valueOf(id));
				List<OrderInfoDetails> oidsList = super.getFacade().getOrderInfoDetailsService()
						.getOrderInfoDetailsList(ods);
				entity.getMap().put("oidsList", oidsList);
				// 收货人信息
				super.showShippingAddressForOrderInfo(entity);
			}

			super.copyProperties(form, entity);
			return mapping.findForward("view");
		} else {
			saveError(request, "errors.Integer", id);
			return mapping.findForward("list");
		}
	}

	public ActionForward save(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		setNaviStringToRequestScope(request);
		if (!super.isTokenValid(request, true)) {
			super.saveMessage(request, "errors.token");
			return mapping.findForward("list");
		}
		resetToken(request);
		HttpSession session = request.getSession(false);
		UserInfo ui = (UserInfo) session.getAttribute(Keys.SESSION_USERINFO_KEY);

		DynaBean dynaBean = (DynaBean) form;
		String order_id = (String) dynaBean.get("order_id");
		String mod_id = (String) dynaBean.get("mod_id");

		String[] details_ids = request.getParameterValues("details_id");
		String[] good_sum_prices = request.getParameterValues("good_sum_price");
		String[] price_modify_olds = request.getParameterValues("price_modify_old");
		String[] price_modify_remarks = request.getParameterValues("price_modify_remark");
		String[] details_matflow_price = request.getParameterValues("details_matflow_price");
		String[] details_matflow_price_old = request.getParameterValues("details_matflow_price_old");

		String matflow_price_modify_old = request.getParameter("matflow_price_modify_old");
		String matflow_price = request.getParameter("matflow_price");
		String order_price_modify_old = request.getParameter("order_price_modify_old");
		String order_price_modify_remark = request.getParameter("order_price_modify_remark");

		OrderInfo entity = new OrderInfo();
		super.copyProperties(entity, form);

		int orderMoney_matflowPrice_modify = 0;
		List<OrderInfo> orderInfoList = new ArrayList<OrderInfo>();
		List<OrderInfoDetails> orderInfoDetailsList = new ArrayList<OrderInfoDetails>();
		boolean updateFlag = true;

		if (null != details_ids) {
			for (int i = 0; i < details_ids.length; i++) {
				OrderInfoDetails oid = new OrderInfoDetails();
				oid.setGood_sum_price(new BigDecimal(good_sum_prices[i]));
				oid.setPrice_modify_old(new BigDecimal(price_modify_olds[i]));
				oid.setMatflow_price(new BigDecimal(details_matflow_price[i]));
				oid.setMatflow_price_old(new BigDecimal(details_matflow_price_old[i]));

				// Order_Info_Details
				OrderInfoDetails orderInfoDetails = new OrderInfoDetails();
				orderInfoDetails.setId(new Integer(details_ids[i]));
				if (StringUtils.isNotBlank(price_modify_remarks[i])) {
					orderInfoDetails.setPrice_modify_remark(price_modify_remarks[i]);
				} else {
					orderInfoDetails.setPrice_modify_remark("");
				}

				if (oid.getGood_sum_price().compareTo(oid.getPrice_modify_old()) == 0
						&& oid.getMatflow_price().compareTo(oid.getMatflow_price_old()) == 0) { // 此商品未修改价格

				} else { // 修改了价格
					// Order_Info_Details

					orderInfoDetails.setPrice_modify_date(new Date());
					orderInfoDetails.setIs_price_modify(1);
					orderInfoDetails.setGood_sum_price(new BigDecimal(good_sum_prices[i]));
					orderInfoDetails.setActual_money(orderInfoDetails.getGood_sum_price());
					orderInfoDetails.setPrice_modify_old(new BigDecimal(price_modify_olds[i]));

					if (StringUtils.isNotBlank(details_matflow_price[i])) {
						orderInfoDetails.setMatflow_price(new BigDecimal(details_matflow_price[i]));
					}
					if (StringUtils.isNotBlank(details_matflow_price_old[i])) {
						orderInfoDetails.setMatflow_price_old(new BigDecimal(details_matflow_price_old[i]));
					}

					orderMoney_matflowPrice_modify = 1;
				}

				// Order_Info_Details
				orderInfoDetailsList.add(orderInfoDetails);
			}

			OrderInfo oi = new OrderInfo();
			oi.setMatflow_price(new BigDecimal(matflow_price));
			oi.setMatflow_price_modify_old(new BigDecimal(matflow_price_modify_old));
			oi.setId(new Integer(order_id));

			OrderInfo orderInfoQuery = new OrderInfo();
			orderInfoQuery.setId(new Integer(order_id));
			orderInfoQuery = super.getFacade().getOrderInfoService().getOrderInfo(orderInfoQuery);
			if (StringUtils.isNotBlank(order_price_modify_remark)) {
				oi.setPrice_modify_remark(order_price_modify_remark);
			} else {
				oi.setPrice_modify_remark("");
			}
			if (oi.getMatflow_price().compareTo(oi.getMatflow_price_modify_old()) != 0) {
				oi.setPrice_modify_date(new Date());
				orderMoney_matflowPrice_modify = 1;
			}
			oi.setIs_price_modify(orderMoney_matflowPrice_modify);
			if (orderMoney_matflowPrice_modify == 1) {
				// 修改前的订单金额，包括 order_money + money_bi
				oi.setPrice_modify_old(new BigDecimal(order_price_modify_old).add(orderInfoQuery.getMoney_bi()));
				oi.setIs_reload_pay(0);
				oi.setPrice_modify_date(new Date());
			}
			oi.setPrice_modify_user_id(ui.getId());
			orderInfoList.add(oi);

			/*
			 * for (OrderInfoDetails oid : orderInfoDetailsList) {
			 * super.getFacade().getOrderInfoDetailsService().modifyOrderInfoDetails(oid); } for (OrderInfo oi2 :
			 * orderInfoList) { OrderInfoDetails orderInfoDetails_ = new OrderInfoDetails();
			 * orderInfoDetails_.setOrder_id(oi2.getId()); List<OrderInfoDetails> orderInfoDetailsList2 =
			 * super.getFacade().getOrderInfoDetailsService() .getOrderInfoDetailsList(orderInfoDetails_); // 重新计算订单价格
			 * BigDecimal order_money = new BigDecimal("0"); for (OrderInfoDetails orderInfoDetails :
			 * orderInfoDetailsList2) { order_money = order_money.add(orderInfoDetails.getGood_sum_price().add(
			 * orderInfoDetails.getMatflow_price())); } oi2.setOrder_money(order_money);
			 * oi2.setReal_pay_money(oi2.getOrder_money()); oi2.setNo_dis_money(oi2.getOrder_money());
			 * oi2.setMoney_bi(new BigDecimal(0)); super.getFacade().getOrderInfoService().modifyOrderInfo(oi2); }
			 */
			updateFlag = super.getFacade().getOrderInfoService().modifyOrderInfoAndDetails(orderInfoDetailsList,
					orderInfoList);

			OrderInfo _entity = new OrderInfo();
			_entity.setId(Integer.valueOf(order_id));
			_entity = super.getFacade().getOrderInfoService().getOrderInfo(_entity);
			if (_entity != null) {
				super.createSysOperLog(request, 67,
						"订单ID：".concat(_entity.getId().toString()).concat("，订单号：").concat(
								_entity.getTrade_index().concat("，操作时间：").concat(sdFormat_ymdhms.format(new Date()))),
						entity.toString());
			}
		}
		if (!updateFlag) {
			// 未修改成功
			String msg = "该订单不是预定状态,无法修改价格";
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');history.back();}");
			return null;
		}

		StringBuffer pathBuffer = new StringBuffer();
		pathBuffer.append(mapping.findForward("success").getPath());
		pathBuffer.append("&");
		pathBuffer.append("&mod_id=" + mod_id);
		ActionForward forward = new ActionForward(pathBuffer.toString(), true);
		return forward;
	}

}
