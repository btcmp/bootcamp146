
package com.newminiproject.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newminiproject.model.Promotion;
import com.newminiproject.model.PromotionItemFile;



@Repository
public class PromotionItemFileDaoImpl implements PromotionItemFileDao {

	@Autowired
	SessionFactory sessionFactory;

	public void save(PromotionItemFile promotionItemFile) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		session.save(promotionItemFile);
	}

	public List<PromotionItemFile> getPromotionItemFileByPromotion(Promotion promotion) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		String hql = "from PromotionItemFile pifl where pifl.promotion = :promotion";
		
		Query query = session.createQuery(hql);
		query.setParameter("promotion", promotion);
		List<PromotionItemFile> listPromotionItemFile = query.list();
		
		if(listPromotionItemFile.isEmpty()) {
			return new ArrayList<PromotionItemFile>();
		}
		
		return listPromotionItemFile;
	}

	@Override
	public void update(PromotionItemFile pif1) {
		// TODO Auto-generated method stub
		
		Session session = sessionFactory.getCurrentSession();
		String hql = "update PromotionItemFile pif set pif.qty=?, pif.requestDueDate=?, pif.todo=?, pif.note=? where pif.id=?";
		
		Query query = session.createQuery(hql);
		query.setParameter(0, pif1.getQty());
		query.setParameter(1, pif1.getRequestDueDate());
		query.setParameter(2, pif1.getTodo());
		query.setParameter(3, pif1.getNote());
		query.setParameter(4, pif1.getId());
		
		query.executeUpdate();
	}
	
	
}
