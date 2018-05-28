package com.newminiproject.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.miniproject.xsis.codegenerator.CodeGenerator;
import com.miniproject.xsis.model.Event;
import com.miniproject.xsis.model.Souvenir;
import com.miniproject.xsis.model.TransactionSouvenir;
import com.miniproject.xsis.model.TransactionSouvenirItem;
import com.miniproject.xsis.model.Unit;
import com.miniproject.xsis.service.SouvenirRequestService;
import com.miniproject.xsis.service.SouvenirService;
import com.miniproject.xsis.service.TransactionSouvenirItemService;

@Controller
@RequestMapping("/souvenirrequest")
public class SouvenirRequestController {

	@Autowired
	SouvenirRequestService souvenirRequestService;
	
	@Autowired
	CodeGenerator codeGenerator;
	
	@Autowired
	SouvenirService souvenirService;
	
	@Autowired
	TransactionSouvenirItemService transactionSouvenirItemService;
	
	@RequestMapping
	//@ResponseBody
	public String index(Model model){
		List<Event> listEvent = souvenirRequestService.getAllEvent();
		List<Souvenir> listSouvenirItem = souvenirService.getAllSouvenir();
		List<TransactionSouvenir> listTransactionSouvenir = souvenirRequestService.getAllTransaction();
		List<TransactionSouvenirItem> listTransactionSouvenirItem = souvenirRequestService.getAllItem();
		String hasil = codeGenerator.sequenceTransaction();
		model.addAttribute("hasil", hasil);
		model.addAttribute("listEvent", listEvent);
		model.addAttribute("listSouvenirItem", listSouvenirItem);
		model.addAttribute("listTransactionSouvenir", listTransactionSouvenir);
		model.addAttribute("listTransactionSouvenirItem", listTransactionSouvenirItem);

		return "list-request";
	}
	
	@RequestMapping(value="/admin")
	public String indexAdmin(Model model){
		List<Event> listEvent = souvenirRequestService.getAllEvent();
		List<Souvenir> listSouvenirItem = souvenirService.getAllSouvenir();
		List<TransactionSouvenir> listTransactionSouvenir = souvenirRequestService.getAllTransaction();
		model.addAttribute("listTransactionSouvenir", listTransactionSouvenir);
		model.addAttribute("listEvent", listEvent);
		model.addAttribute("listSouvenirItem", listSouvenirItem);
		return "list-request";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	//@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	public TransactionSouvenir save(@RequestBody TransactionSouvenir transactionSouvenir){ //valid, buat aktifik validator nya
		souvenirRequestService.save(transactionSouvenir);
		return transactionSouvenir;
	}
	
	@RequestMapping(value="/update", method=RequestMethod.PUT)
	//@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public TransactionSouvenir update(@RequestBody TransactionSouvenir transactionSouvenir){
		souvenirRequestService.update(transactionSouvenir);
		return transactionSouvenir;
	}
	
	@ResponseBody
	@RequestMapping(value="/gettransactionsouvenir", method=RequestMethod.GET)
	public TransactionSouvenir getSouvenir(@RequestParam(value="id", required=false) int id, Model model){ //required=false -> gak harus
		TransactionSouvenir transactionSouvenir = souvenirRequestService.getTransactionSouvenirById(id);
		
		//model.addAttribute("lastTsi", lastTsi);
		//model.addAttribute("listTransactionSouvenirItem", listTransactionSouvenirItem);
		return transactionSouvenir;
	}
	
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String search(Model model, @RequestParam(value="transactioncode", defaultValue="")String transactionCode, @RequestParam(value="requestby", defaultValue="")String requestBy, @RequestParam(value="requestdate", defaultValue="")String requestDate, @RequestParam(value="duedate", defaultValue="")String dueDate, @RequestParam(value="status", defaultValue="")String status, @RequestParam(value="createddate", defaultValue="")String createdDate, @RequestParam(value="createby", defaultValue="")String createBy) throws ParseException{
		
		
		Date requestDateDual = null;
		Date dueDateDual = null;
		Date createdDateDual = null;
		
		if (!requestDate.equals("")) {
			requestDateDual = new SimpleDateFormat("yyyy-MM-dd").parse(requestDate);
		}
		
		if (!dueDate.equals("")) {
			dueDateDual = new SimpleDateFormat("yyyy-MM-dd").parse(dueDate);
		}
		
		if (!createdDate.equals("")) {
			createdDateDual = new SimpleDateFormat("yyyy-MM-dd").parse(createdDate);
		}
		
		TransactionSouvenir transactionSouvenir = new TransactionSouvenir();
		transactionSouvenir.setCode(transactionCode);
		//transactionSouvenir.setRequestBy(requestBy);
		transactionSouvenir.setRequestDate(requestDateDual);
		transactionSouvenir.setRequestDueDate(dueDateDual);
		//transactionSouvenir.setStatus(status);
		transactionSouvenir.setCreatedDate(createdDateDual);
		//transactionSouvenir.setCreatedBy(createdBy);
		
		List<TransactionSouvenir> listTransactionSouvenir = souvenirRequestService.getAllTransaction();
		List<TransactionSouvenir> listTransactionSouvenirFilter = souvenirRequestService.search(transactionSouvenir);
	
		model.addAttribute("listTransactionSouvenir", listTransactionSouvenirFilter);
		model.addAttribute("listTransactionSouvenirFilter", listTransactionSouvenir);
		
		String result = codeGenerator.sequenceTransaction();
		model.addAttribute("result", result);
		
		return "list-request";
	}
	
}