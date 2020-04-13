package com.ebiz.webapp.dao.ibatis;

import org.springframework.stereotype.Service;

import com.ebiz.ssi.dao.ibatis.EntityDaoSqlMapImpl;
import com.ebiz.webapp.dao.FreightDetailDao;
import com.ebiz.webapp.domain.FreightDetail;

/**
 * @author Wu,Yang
 * @version 2014-05-22 19:37
 */
@Service
public class FreightDetailDaoSqlMapImpl extends EntityDaoSqlMapImpl<FreightDetail> implements FreightDetailDao {

}
