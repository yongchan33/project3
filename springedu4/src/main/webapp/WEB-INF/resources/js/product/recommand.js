/**
 * 
 */
var gendercategory ='';
var order='1';
	var newlist = document.getElementById("1");
	var basketlist = document.getElementById("2");
	var recommnadlist = document.getElementById("3");
	var lowlist = document.getElementById("4");
	var highlist = document.getElementById("5");
	recommnadlist.addEventListener("click",recommnadlist_f);
	basketlist.addEventListener("click",basketlist_f);
	newlist.addEventListener("click",newlist_f);
	lowlist.addEventListener("click",lowlist_f);
	highlist.addEventListener("click",highlist_f);

 	
	function recommnadlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("추천정렬 선택함.");
		 var url=``;
		 var nurl = document.location.href;
		 var strArray=nurl.split('/');
  	 	 console.log(nurl);
 	
 	
 		for(var i=0; i<strArray.length; i++){
 		 console.log("strArray["+i+"]="+strArray[i]);
 		}
 

 			 gendercategory= strArray[6];

	if( gendercategory=='1'){
			url = `/portfolio/product/recommandlist/1`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/recommandlist/2`;
		}
		
		window.location.href =url;
	}
		//관심상품
		function basketlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("관심상품 선택함.");
			 var url=``;
		 var nurl = document.location.href;
		 var strArray=nurl.split('/');
 		 gendercategory= strArray[6];
 		 
 		 if( gendercategory=='1'){
			url = `/portfolio/product/basketlist/1/1`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/basketlist/1/2`;
		}
 		 
		
		window.location.href = url; 
	}
	
	
	//최신정렬
	function newlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		const listvalue=event.target;
		var url=``;
		console.log("최신정렬 선택함."+listvalue.id);
	
		 var nurl = document.location.href;
		 var strArray=nurl.split('/');
  	 	 console.log(nurl);
 	
 	
 		for(var i=0; i<strArray.length; i++){
 		 console.log("strArray["+i+"]="+strArray[i]);
 		}
 

 		gendercategory= String(strArray[6]);
		 console.log(gendercategory);
		
		
		if( gendercategory=='1'){
			url = `/portfolio/product/womanlist/1/1///`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/manlist/1/1///`;
		}
		
		window.location.href =url;
		}
	
	//낮은가격순
	function lowlist_f(event){
	event.preventDefault(); //기본이벤트 막기
	const listvalue=event.target;
	console.log("낮은가격정렬 선택함."+listvalue.id);
	var url=``;
	 var nurl = document.location.href;
	 var strArray=nurl.split('/');
 	console.log(nurl);
 	
 	
 		for(var i=0; i<strArray.length; i++){
 		 console.log("strArray["+i+"]="+strArray[i]);
 		}
 

 			 gendercategory= strArray[6];

		if( gendercategory=='1'){
			url = `/portfolio/product/womanlist/1/4///`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/manlist/1/4///`;
		}
		
		window.location.href =url;
	}
	
	//높은가격순
	function highlist_f(event){
	event.preventDefault(); //기본이벤트 막기
	const listvalue=event.target;
	console.log("높은가격정렬 선택함."+listvalue.id);
	var url=``;
	 var nurl = document.location.href;
	 var strArray=nurl.split('/');
 	console.log(nurl);
 	
 	
 		for(var i=0; i<strArray.length; i++){
 		 console.log("strArray["+i+"]="+strArray[i]);
 		}
 

 			 gendercategory= strArray[6];

		if( gendercategory=='1'){
			url = `/portfolio/product/womanlist/1/5///`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/manlist/1/5///`;
		}
		
		window.location.href =url;
	}
	
	
	
	

function get_query(){
    var url = document.location.href;
    var qs = url.substring(url.indexOf('?') + 1).split('&');
    for(var i = 0, result = {}; i < qs.length; i++){
        qs[i] = qs[i].split('=');
        result[qs[i][0]] = decodeURIComponent(qs[i][1]);
    }
    return result;
}

function basketlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("관심상품 선택함.");
		const url = `/portfolio/product/basketlist/1`;
		window.location.href = url; 
	}

