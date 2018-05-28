package com.newminiproject.model;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.validator.constraints.Email;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity
@Table(name="M_EMPLOYEE")
public class Employee {
	@Id
	@SequenceGenerator(name="seqEmployee",sequenceName="seqEmployee")        
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seqEmployee")
	private int id;
	
	@Column(name="employee_number", length=50, unique=true)
	private String code;
	
	@Column(name="first_name", length=50)
	private String firstName;
	
	@Column(name="last_name", length=50)
	private String lastName;
	
	@Column(length=150)
	private String email;
	
	@Column(name="is_delete", length=50)
	private boolean isDelete;
	
	@Column(name="created_by", length=50)
	private String createdBy;
	
	
	@Temporal(TemporalType.DATE)
	@Column(name="created_date")
	private Date createdDate;
	
	@Column(name="updated_by", length=50)
	private String updated_by;
	
	@Temporal(TemporalType.DATE)
	@Column(name="updated_date")
	private Date updatedDate;
	
	@ManyToOne
	private Company company;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="employee")
	@JsonIgnore
	private List<Event> event;
	
	public List<Event> getEvent() {
		return event;
	}

	public void setEvent(List<Event> event) {
		this.event = event;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isDelete() {
		return isDelete;
	}

	public void setDelete(boolean isDelete) {
		this.isDelete = isDelete;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public String getUpdated_by() {
		return updated_by;
	}

	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}
}