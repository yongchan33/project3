/**
 * 
 */
const findBtn = document.getElementById("findBtn");
var lcategory ='';
var order='1';
	var newlist = document.getElementById("1");
	var basketlist = document.getElementById("2");
	var recommnadlist = document.getElementById("3");
	var lowlist = document.getElementById("4");
	var highlist = document.getElementById("5");
	
	newlist.addEventListener("click",newlist_f);
	basketlist.addEventListener("click",basketlist_f);
	lowlist.addEventListener("click",lowlist_f);
	highlist.addEventListener("click",highlist_f);
	recommnadlist.addEventListener("click",recommnadlist_f);
	





	//추천정렬
		function recommnadlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("추천정렬 선택함.");
			 var nurl = document.location.href;
		 var strArray=nurl.split('/');
 		 gendercategory= strArray[7];
	if( gendercategory=='1'){
			url = `/portfolio/product/recommandlist/1`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/recommandlist/2`;
		}
		window.location.href = url; 
	}
	//관심상품
		function basketlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("관심상품 선택함.");
				 var url=``;
		 var nurl = document.location.href;
		 var strArray=nurl.split('/');
 		 gendercategory= strArray[7];
		 if( gendercategory=='1'){
			url = `/portfolio/product/basketlist/1/1`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/basketlist/2/1`;
		}
		window.location.href = url; 
	}
	
		//최신정렬
	function newlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		 var url=``;
		 var nurl = document.location.href;
		 var strArray=nurl.split('/');
 		 gendercategory= strArray[7];
		 if( gendercategory=='1'){
			url = `/portfolio/product/womanlist/1/1`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/manlist/1/1`;
		}
		
		window.location.href = url; 	
		}
	
	//낮은가격순
	function lowlist_f(event){
	event.preventDefault(); //기본이벤트 막기
	console.log("낮은가격정렬 선택함.");
 var url=``;
		 var nurl = document.location.href;
		 var strArray=nurl.split('/');
 		 gendercategory= strArray[7];
		 if( gendercategory=='1'){
			url = `/portfolio/product/womanlist/1/4`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/manlist/1/4`;
		}
	window.location.href = url; 	
	}
	
	//높은가격순
	function highlist_f(event){
	event.preventDefault(); //기본이벤트 막기
	console.log("높은가격정렬 선택함.");
	var url=``;
		 var nurl = document.location.href;
		 var strArray=nurl.split('/');
 		 gendercategory= strArray[7];
		 if( gendercategory=='1'){
			url = `/portfolio/product/womanlist/1/5`;
		}
		if( gendercategory=='2'){
			url = `/portfolio/product/manlist/1/5`;
		}
	window.location.href = url; 	
	}



