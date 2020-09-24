/**
 * 
 */
const findBtn = document.getElementById("findBtn");
var lcategory ='';
var order='1';
	findBtn.addEventListener("click", findBtn_f);
	var listCategorys = document.getElementsByName("listCategory");
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
	




 	for (var i = 0; i < listCategorys.length; i++) {
		
	  //  listCategorys[i].addEventListener('click', listCategorys_f);
	} 
	//검색 enter event
 function pressEnter(){
        if(event.keyCode == 13){
event.preventDefault(); //기본이벤트 막기
 var nurl = document.location.href;
 var strArray=nurl.split('/');
 console.log(nurl);
 
 for(var i=0; i<strArray.length; i++){
  console.log("strArray["+i+"]="+strArray[i]);
 }
 
 if(strArray.length>7){
 order=strArray[7];
 	 lcategory= strArray[8];
 }
	const searchTypeTag = document.getElementById("searchType");
	const keywordTag = document.getElementById("keyword");
	
	if(keywordTag.value.trim().length == 0){
		alert('검색어를 입력하세요');
		keywordTag.value = "";
		keywordTag.focus();
		return false;
	}
	console.log(searchTypeTag.value, keywordTag.value);
	const url = `/portfolio/product/manlist/1/${order}/${lcategory}/${searchTypeTag.value}/${keywordTag.value}`;
	console.log(url);
	window.location.href = url; 	
        }
    }





	//추천정렬
		function recommnadlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("추천정렬 선택함.");
		const url = `/portfolio/product/recommandlist/2`;
		window.location.href = url; 
	}
	//관심상품
		function basketlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("관심상품 선택함.");
		const url = `/portfolio/product/basketlist/1/2`;
		console.log(url);
		window.location.href = url; 
	}
	
		//최신정렬
	function newlist_f(event){
		event.preventDefault(); //기본이벤트 막기
		const listvalue=event.target;
		console.log("최신정렬 선택함."+listvalue.id);
	
		 var nurl = document.location.href;
		 var strArray=nurl.split('/');
  	 	 console.log(nurl);
 	
 	
 		for(var i=0; i<strArray.length; i++){
 		 console.log("strArray["+i+"]="+strArray[i]);
 		}
 
 		if(strArray.length>8){
 			 lcategory= strArray[8];
		 }
		const searchTypeTag = document.getElementById("searchType");
		const keywordTag = document.getElementById("keyword");
		var searchTypevalue=searchTypeTag.value;
		var keywordTagvalue=keywordTag.value;
		if(keywordTagvalue==''){
			searchTypevalue='';
		}
		

		const url = `/portfolio/product/manlist/1/1/${lcategory}/${searchTypevalue}/${keywordTagvalue}`;
		console.log(searchTypevalue);
		window.location.href = url; 	
		}
	
	//낮은가격순
	function lowlist_f(event){
	event.preventDefault(); //기본이벤트 막기
	const listvalue=event.target;
	console.log("낮은가격정렬 선택함."+listvalue.id);
	
	 var nurl = document.location.href;
	 var strArray=nurl.split('/');
 	console.log(nurl);
 	
 	
 for(var i=0; i<strArray.length; i++){
  console.log("strArray["+i+"]="+strArray[i]);
 }
 
 if(strArray.length>8){
 	 lcategory= strArray[8];
 }
		const searchTypeTag = document.getElementById("searchType");
		const keywordTag = document.getElementById("keyword");
		var searchTypevalue=searchTypeTag.value;
		var keywordTagvalue=keywordTag.value;
		if(keywordTagvalue==''){
			searchTypevalue='';
		}

	const url = `/portfolio/product/manlist/1/4/${lcategory}/${searchTypevalue}/${keywordTagvalue}`;
	console.log(url);
	window.location.href = url; 	
	}
	
	//높은가격순
	function highlist_f(event){
	event.preventDefault(); //기본이벤트 막기
	const listvalue=event.target;
	console.log("높은가격정렬 선택함."+listvalue.id);
	
	 var nurl = document.location.href;
	 var strArray=nurl.split('/');
 	console.log(nurl);
 	
 	
 for(var i=0; i<strArray.length; i++){
  console.log("strArray["+i+"]="+strArray[i]);
 }
 
 if(strArray.length>8){
 	 lcategory= strArray[8];
 }
		const searchTypeTag = document.getElementById("searchType");
		const keywordTag = document.getElementById("keyword");
		var searchTypevalue=searchTypeTag.value;
		var keywordTagvalue=keywordTag.value;
		if(keywordTagvalue==''){
			searchTypevalue='';
		}

	const url = `/portfolio/product/manlist/1/5/${lcategory}/${searchTypevalue}/${keywordTagvalue}`;
	console.log(url);
	window.location.href = url; 	
	}
	
	
	
	//카테고리 선택시
 function listCategorys_f(event) {
  console.log("카테고리 선택함.");
	const searchTypeTag = document.getElementById("searchType");
	const keywordTag = document.getElementById("keyword");
	const category = event.target;

	console.log(searchTypeTag.value, keywordTag.value,category);
	const url = `/portfolio/product/manlist/1/${category.value}/`;
	console.log(url);
	//window.location.href = url; 	
} 
//

//검색 클릭시
function findBtn_f(e) {
 e.preventDefault(); //기본이벤트 막기
 var nurl = document.location.href;
 var strArray=nurl.split('/');
 console.log(nurl);
 
 for(var i=0; i<strArray.length; i++){
  console.log("strArray["+i+"]="+strArray[i]);
 }
 
 if(strArray.length>7){
 order=strArray[7];
 	 lcategory= strArray[8];
 }
	const searchTypeTag = document.getElementById("searchType");
	const keywordTag = document.getElementById("keyword");
	
	if(keywordTag.value.trim().length == 0){
		alert('검색어를 입력하세요');
		keywordTag.value = "";
		keywordTag.focus();
		return false;
	}
	console.log(searchTypeTag.value, keywordTag.value);
	const url = `/portfolio/product/manlist/1/${order}/${lcategory}/${searchTypeTag.value}/${keywordTag.value}`;
	console.log(url);
	window.location.href = url; 	
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


