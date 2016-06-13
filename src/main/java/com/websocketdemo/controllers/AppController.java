package com.websocketdemo.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppController {
	
	
	public AppController(){
		
	}
	
	@RequestMapping("/")
	public String resolveRoot(){
		return "index";
	}

}
