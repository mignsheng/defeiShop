package com.ebiz.webapp.dao.ibatis;

import org.springframework.stereotype.Service;

import com.ebiz.webapp.dao.ServiceBaseLinkDao;
import com.ebiz.webapp.domain.ServiceBaseLink;
import com.ebiz.ssi.dao.ibatis.EntityDaoSqlMapImpl;

/**
 * @author Wu,Yang
 * @version 2018-04-17 15:24
 */
@Service
public class ServiceBaseLinkDaoSqlMapImpl extends EntityDaoSqlMapImpl<ServiceBaseLink> implements ServiceBaseLinkDao {

}
