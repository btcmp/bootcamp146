package com.newminiproject.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newminiproject.model.Design;
import com.newminiproject.model.DesignItem;

@Repository
public class DesignItemDaoImpl implements DesignItemDao {
	
	@Autowired
	SessionFactory sessionFactory;

	public void save(DesignItem di2) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.save(di2);
		session.flush();
	}

	public List<DesignItem> getDesignItemByDesign(Design design) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		String hql = "from DesignItem di where di.tDesignId = :design";
		Query query = session.createQuery(hql);
		query.setParameter("design", design);
		List<DesignItem> listDesignItem = query.list();
		if(listDesignItem.isEmpty()) {
			return new ArrayList<DesignItem>();
		}
		return listDesignItem;
	}

	public void update(DesignItem di2) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		String hql = "update DesignItem di set di.mProductId=?, di.titleItem=?, di.requestPic=?, di.requestDueDate=?, di.note=?, di.updatedDate=? where di.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, di2.getmProductId());
		query.setParameter(1, di2.getTitleItem());
		query.setParameter(2, di2.getRequestPic());
		query.setParameter(3, di2.getRequestDueDate());
		query.setParameter(4, di2.getNote());
		query.setParameter(5, di2.getUpdatedDate());
		query.setParameter(6, di2.getId());
		System.out.println("list Product = "+di2.getmProductId());
		System.out.println("title header = "+di2.getTitleItem());
		System.out.println("request pic = "+di2.getRequestPic());
		System.out.println("due date = "+di2.getRequestDueDate());
		System.out.println("note = "+di2.getNote());
		System.out.println("updated date = "+di2.getUpdatedDate());
		System.out.println("id = "+di2.getId());
		query.executeUpdate(); 
	}

	@Override
	public void closerequest(DesignItem di2) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		String hql = "update DesignItem di set di.startDate=?, di.endDate=? where di.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, di2.getStartDate());
		query.setParameter(1, di2.getEndDate());
		query.setParameter(2, di2.getId());
		System.out.println("start date = "+di2.getStartDate());
		System.out.println("end date = "+di2.getEndDate());
		System.out.println("id = "+di2.getId()); 
		query.executeUpdate(); 
	}

}
