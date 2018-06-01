<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Unit</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.css">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
	  <!-- Tell the browser to be responsive to screen width -->
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <!-- Font Awesome -->
	  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/font-awesome/css/font-awesome.min.css">
	  <!-- Ionicons -->
	  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	  <!-- Theme style -->
	  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/dist/css/adminlte.min.css">
	  <!-- iCheck -->
	  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/iCheck/flat/blue.css">
	  <!-- Morris chart -->
	  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/morris/morris.css">
	  <!-- jvectormap -->
	  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
	  <!-- Date Picker -->
	  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/datepicker/datepicker3.css">
	  <!-- Daterange picker -->
	  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/daterangepicker/daterangepicker-bs3.css">
	  <!-- bootstrap wysihtml5 - text editor -->
	  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
	  <!-- Google Font: Source Sans Pro -->
	  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

<!-- 	ini di copy buat validasi -->
  	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/parsley.min.js"></script>
<!-- 	ini di copy buat validasi -->
  	
  	
  	
  	
  	<script src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
	<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>

<style type="text/css">
input.parsley-error {
	color: #B94A48 !important;
	background-color: #F2DEDE !important;
	border: 1px solid #EED3D7 !important;
}
</style>

<script type="text/javascript">

	$(function () {
    //datatabel
  	 var t = $('#data-unit').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false
  	 });
      t.on( 'order.dt search.dt', function () {
	        t.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
	            cell.innerHTML = i+1;
	        } );
	    } ).draw();
    });
	
	$(document).ready(function(){
		
		//add data event listener
		$(document).on('click', '.btn-add', function(event){
			$('#btnAddModal').modal();
		});
		
		//button save when click button add
		$(document).on('click', '#btnSave', function(event){
			event.preventDefault();
			var unit = {
					code: $("#codeAdd").val(),
					name: $("#nameAdd").val(),
					description: $("#descriptionAdd").val()
				}
			//console.log(unit);
			
			//validasi field pada saat save
			var nameValidate = $("#nameAdd").parsley({
				required : true,
				requiredMessage : 'Name must be filled!'
			});
			
			//function validate
			function getValid(validate){
				validate.validate();	
				return validate.isValid();
			}
			
			var valid = getValid(nameValidate);
			if(valid){
				$.ajax({
					url: '${pageContext.request.contextPath}/unit/save',
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify(unit),
					success:function(data){
						window.location = '${pageContext.request.contextPath}/unit'
					},
					error:function(){
						alert('error');
					}
				});
			}
			else{
				alert('Fill all data first!')
			}
		});
		
		//delete icon
		var delCode;
		$(document).on('click', '.iconDelete', function(){
			delCode = $(this).attr('del-id');
			$('#modalDelete').modal();
		});
		
		//button delete function
		$('#btnDel').on('click', function(){
			//alert('tes');
			window.location="${pageContext.request.contextPath}/unit/delete/" +delCode;
		});
		
		//view icon
		$(document).on('click', '.iconView', function(){
			var viewCode = $(this).attr('view-id');
			$.ajax({
				url: '${pageContext.request.contextPath}/unit/getunit/' + viewCode,
				type: 'GET',
				success:function(data){
					
					$('#codeView').val(data.code);
					$('#nameView').val(data.name);
					$('#descriptionView').val(data.description);
					//console.log(data);
				},
				error:function(){
					alert('Data not found');
				},
				dataType: 'JSON'
			});
			$('#btnViewModal').modal();
		});
		
		//edit icon
		$(document).on('click', '.iconEdit', function(){
			var editCode = $(this).attr('edit-id');
			console.log(editCode);
			$.ajax({
				url: '${pageContext.request.contextPath}/unit/getunit/' + editCode,
				type: 'GET',
				success:function(data){
					$('#id').val(data.id);
					$('#codeEdit').val(data.code);
					$('#nameEdit').val(data.name);
					$('#descriptionEdit').val(data.description);
					
				},
				error:function(){
					alert('Data not found');
				},
				dataType: 'JSON'
			});
			$('.btnEditModal').modal();
		});
		
		//button update function
		$('#btnEdit').on('click', function(){
			var unit = {
				id: $('#id').val(),
				name: $('#nameEdit').val(),
				description: $('#descriptionEdit').val()
			}
			
			//validasi field pada saat update
			var nameValidate = $("#nameEdit").parsley({
				required : true,
				requiredMessage : 'Name must be filled!'
			});
			
			//function validate
			function getValid(validate){
				validate.validate();	
				return validate.isValid();
			}
			
			var valid = getValid(nameValidate);
			
			if(valid){
				$.ajax({
					url:'${pageContext.request.contextPath}/unit/update',
					type:'POST',
					data:JSON.stringify(unit),
					contentType:'application/json',
					success:function(data){
						alert('update success');
						console.log(data);
						window.location = '${pageContext.request.contextPath}/unit'
					},error:function(){
						alert('update failed');
					}
				});
			}
			else{
				alert('Fill all data first!')
			}
		});
		
		//search button with data tables
		$('#btnSearch').on('click', function(){
			var form = $("#formunit");
			var data = form.serialize(); //untuk mengambil semua data yang ada di table
			console.log(data);
			if(data == "unitcode=&unitname=&unitcreateddate=&unitcreatedby="){
				window.location = '${pageContext.request.contextPath}/unit';
			}
			else{
				window.location = '${pageContext.request.contextPath}/unit/search?'+data;	
			} 	
		});
		
	});
	
</script>

</head>
<body>
	<body class="hold-transition sidebar-mini">
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand bg-white navbar-light border-bottom">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#"><i class="fa fa-bars"></i></a>
      </li>
      	
    </ul>


    

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
     <a href="javascript:formSubmit()"> Logout</a>
          
     
      
      
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="${pageContext.request.contextPath }/assets/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">Marcom Apps</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
     <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
        
         
           <%--  <a href="#" class="nav-link">
              <p>
                <h2><a href="#" class="d-block">${pageContext.request.userPrincipal.name}</a></h2>
              </p>
            </a> --%>
          
          <li class="nav-header">Menu</li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath }/company" class="nav-link">
              <i class="nav-icon fa fa-circle-o text-info"></i>
              <p>Company</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath }/event" class="nav-link">
              <i class="nav-icon fa fa-circle-o text-info"></i>
              <p>Event</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath }/menu" class="nav-link">
              <i class="nav-icon fa fa-circle-o text-info"></i>
              <p>Menu</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath }/role" class="nav-link">
              <i class="nav-icon fa fa-circle-o text-info"></i>
              <p>Role</p>
            </a>
          </li>
          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
   

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
       
     	<c:url value="/j_spring_security_logout" var="logoutUrl" />
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
		<script>
			function formSubmit() { 
				document.getElementById("logoutForm").submit();
			}
		</script>
	
		<c:if test="${pageContext.request.userPrincipal.name != null}">
			<h2>
				Welcome : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h2>
		</c:if>
	
	<div style="height:40px;background-color:#0069D9;margin-bottom:10px">
		<h5 style="font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;padding-top:8px;padding-left:8px;color:white;">List Unit</h5>
	</div>
	
	<div style="width:98%;margin:auto;">
		<ol class="breadcrumb">
  			<li><a href="#">Home </a>/</li>
  			<li><a href="#"> Master </a>/</li>
 		 	<li class="active">Unit</li>
		</ol>
    

    	<a href="#" class="btn btn-primary btn-add" style="width:70px;float:right;">Add</a><br/><br/>

		<form id="formunit">
	    	<div class="form-row">
	    		<div class="col ">
	    			<select id="data-unit-code" class="form-control" name="unitcode">
	    				<option value="" selected>- Select Unit Code -</option>
	    				<c:forEach items="${listUnitComponent}" var="unit">
	    					<option value="${unit.code }">${unit.code}</option>
	    				</c:forEach>
	    			</select>
	    		</div>
	    		<div class="col">
	    			<select id="data-unit-code" class="form-control" name="unitname">
	    				<option value="" selected>- Select Unit Name -</option>
	    				<c:forEach items="${listUnitComponent}" var="unit">
	    					<option value="${unit.name }">${unit.name}</option>
	    				</c:forEach>
	    			</select>
	    		</div>
	    		<div class="col-auto">
	    			<input placeholder="Created" class="form-control" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" id="create-date" name="unitcreateddate">	
	    		</div>
	    		<div class="col-auto">
	    			<input placeholder="Created By" class="form-control" type="text" id="create-by" name="unitcreatedby">	
	    		</div>
	    		<div class="col-auto">
	    			<a href="#" id="btnSearch" class="btn btn-warning" style="width:70px;color:white;">Search</a>
	    		</div>
	    	</div>
    	</form>
    	<table class="table" id=data-unit>
			<thead>
		    	<tr>
		      		<th scope="col">No</th>
					<th scope="col">Unit Code</th>
					<th scope="col">Unit Name</th>
					<th scope="col">Created Date</th>
					<th scope="col">Created By</th>
					<th scope="col">Action</th>
		    	</tr>
		  	</thead>
		  	<tbody>
		    	<c:forEach items="${listUnit}" var="unit">
					<tr unit-id='${unit.id }'>
						<td class="counterCell"></td>
						<td>${unit.code }</td>
						<td>${unit.name }</td>
						<td><fmt:formatDate value="${unit.createdDate }" pattern="dd/MM/yyyy" /></td>
						<td>${unit.createdBy }</td>
						<td>
							<a href="#" style="color:inherit" class="iconView" view-id="${unit.id}"><i class="fas fa-search"></i></a>
							<a href="#" style="color:inherit" class="iconEdit" edit-id="${unit.id}"><i class="fas fa-pencil-alt"></i></a>
							<a href="#" style="color:inherit" class="iconDelete" del-id="${unit.id}"><i class="fas fa-trash"></i></a>
						</td>
					</tr>
				</c:forEach>
		  	</tbody>
		</table>
	</div>	
	
	<!-- Modal Add -->
	<div class="modal fade bd-example-modal-sm" id="btnAddModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header" style="background-color:#0069D9;color:white;">
	        <h5 class="modal-title" id="exampleModalLongTitle">Add Unit</h5>
	      </div>
	      <div class="modal-body">
	      
	      	<form>
			  <div class="modal-body">
			    <div class="col">
			      * Unit Code <input type="text" id="codeAdd" class="form-control" placeholder="${result}" value="${result}" disabled>
			    </div>
			    <div class="col">
			      * Unit Name <input type="text" id="nameAdd" class="form-control" placeholder="Type Unit Name">
			    </div>
			    <div class="col">
			      * Description <input type="text" id="descriptionAdd" class="form-control" placeholder="Type Description">
			    </div>
			  </div>
			</form>
			
	      </div>
	      <div class="modal-footer">
	        <button id="btnSave" type="button" class="btn btn-primary">Save</button>
	        <button type="button" class="btn btn-warning" style="color:white;" data-dismiss="modal">Cancel</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal Delete -->
	<div id="modalDelete" class="modal" tabindex="-1" role="dialog">
	  	<div class="modal-dialog modal-dialog-centered modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Delete Data</h5>
	        <button type="button" class="close btn-danger" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-footer">
	        <button id="btnDel" type="button" class="btn btn-primary">Delete</button>
	        <button  type="button" class="btn btn-warning" data-dismiss="modal">Cancel</button>
	      </div>
	    </div>
	  	</div>
	</div>
	
	<!-- Modal View -->
	<div id="btnViewModal" class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header" style="background-color:#0069D9;color:white;">
	        <h5 class="modal-title" id="exampleModalLongTitle">View Unit</h5>
	      </div>
	      <div class="modal-body">
	      
	      	<form>
			  <div class="modal-body">
			    <div class="col">
			      * Unit Code <input type="text" id="codeView" class="form-control" placeholder="${result}" disabled>
			    </div>
			    <div class="col">
			      * Unit Name <input type="text" id="nameView" class="form-control" disabled>
			    </div>
			    <div class="col">
			      * Description <input type="text" id="descriptionView" class="form-control" disabled>
			    </div>
			  </div>
			</form>
			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-warning" style="color:white;" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal Edit -->
	<div class="modal fade bd-example-modal-sm btnEditModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header" style="background-color:#0069D9;color:white;">
	        <h5 class="modal-title" id="exampleModalLongTitle">Edit Unit</h5>
	      </div>
	      <div class="modal-body">
	      
	      	<form>
			  <div class="modal-body">
			    <div class="col">
			    	<input type="hidden" id="id"/>
			      * Unit Code <input type="text" id="codeEdit" class="form-control" placeholder="${result}" value="${ result}" disabled>
			    </div>
			    <div class="col">
			      * Unit Name <input type="text" id="nameEdit" class="form-control">
			    </div>
			    <div class="col">
			      * Description <input type="text" id="descriptionEdit" class="form-control">
			    </div>
			  </div>
			</form>
			
	      </div>
	      <div class="modal-footer">
	      	<button id="btnEdit" type="button" class="btn btn-primary">Update</button>
	        <button type="button" class="btn btn-warning" style="color:white;" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	</div>
       
       
       
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Copyright &copy; 2014-2018 <a href="http://adminlte.io">AdminLTE.io</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 3.0.0-alpha
    </div>
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath }/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath }/assets/dist/js/adminlte.min.js"></script>
<%-- </c:if> --%>
</body>
</html>