package com.newminiproject.dao;

import java.util.List;

import com.newminiproject.model.Employee;
import com.newminiproject.model.Event;
import com.newminiproject.model.Role;
import com.newminiproject.model.User;

public interface EventDao {

	void save(Event event);

	List<Event> getAll();

	void delete(Event event);

	Event getEventById(int id);

	void update(Event event);

	void updatecls(Event event);

	List<Employee> getAllEmployee();

	void aprove(Event event);

	void rejected(Event event);

	List<Event> search(Event event);

	User getUserEmp(String name);

	List<User> getAllByRole();

	//List<User> getEmployeByRole();

	

	

}
