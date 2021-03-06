package com.newminiproject.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newminiproject.model.Menu;
import com.newminiproject.model.MenuAccess;
import com.newminiproject.model.Role;

@Repository
public class MenuAccessDaoImpl implements MenuAccessDao{

	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void save(MenuAccess menuAccess) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession();
		session.save(menuAccess);
		session.flush();
	}

	@Override
	public List<MenuAccess> getAllMenuAccess() {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession();
		String hql = "from MenuAccess ma where ma.isDelete = 0";
		List<MenuAccess> listMA= session.createQuery(hql).list();
		if(listMA.isEmpty()) {
			return new ArrayList<>();
		}
		
		return listMA;
	}

	@Override
	public void delete(MenuAccess menuAccess) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession();
		String hql = "update MenuAccess ma set ma.isDelete=1 where ma.id =:id";
		Query query = session.createQuery(hql);
		query.setParameter("id", menuAccess.getId());
		query.executeUpdate();
	}

	@Override
	public MenuAccess getMenuAccessById(int id) {
		// TODO Auto-generated method stub
		Session session= sessionFactory.getCurrentSession();
		return session.get(MenuAccess.class, id); //get berdasarkan model
	}

	@Override
	public void update(MenuAccess menuAccess) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		String hql = "update MenuAccess ma set ma.mRoleId=?, ma.mMenuId=?, ma.updatedBy=? where ma.id=?";
		Query query = session.createQuery(hql);
		query.setParameter(0, menuAccess.getmRoleId());
		query.setParameter(1, menuAccess.getmMenuId());
		query.setParameter(2, menuAccess.getUpdatedBy());
		query.setParameter(3, menuAccess.getId());
		query.executeUpdate();
		session.flush();
	}

	@Override
	public List<MenuAccess> search(MenuAccess menuAccess) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.getCurrentSession();
		String hql = "from MenuAccess ma where ma.mRoleId=:rcSearch or ma.mRoleId=:rnSearch or ma.createdBy=:maCreatedBy or ma.createdDate=:maCreatedDate";
		Query query = session.createQuery(hql);
		query.setParameter("rcSearch", menuAccess.getmRoleId());
		query.setParameter("rnSearch", menuAccess.getmRoleId());
		query.setParameter("maCreatedBy", menuAccess.getCreatedBy());
		query.setParameter("maCreatedDate", menuAccess.getCreatedDate());
		List<MenuAccess> listMenuAccess = query.list();
		if(listMenuAccess.isEmpty()) {
			return new ArrayList<>();
		}
		return listMenuAccess;
	}

}
