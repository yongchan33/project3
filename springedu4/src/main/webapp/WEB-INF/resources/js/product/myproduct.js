/**
 * 
 */
	var allmyproduct = document.getElementById("allmyproduct");
	var product = document.getElementById("product");
	var trsproduct = document.getElementById("trsproduct");
	var finiproduct = document.getElementById("finiproduct");
	
	var modifyproduct = document.getElementsByName("modifyproduct");
	var deleteproduct = document.getElementsByName("deleteproduct");
	
		
		
	allmyproduct.addEventListener("click",allmyproduct_f);
	product.addEventListener("click",product_f);	
	trsproduct.addEventListener("click",trsproduct_f);	
	finiproduct.addEventListener("click",finiproduct_f);


	for (var i = 0; i < modifyproduct.length; i++) {
	
	modifyproduct[i].addEventListener('click', modifyproduct_f);
	}
	
	for (var i = 0; i < deleteproduct.length; i++) {
	
	deleteproduct[i].addEventListener('click', deleteproduct_f);
	}
	
	//상품수정
	function modifyproduct_f(event){
		event.preventDefault(); //기본이벤트 막기
		const productnumber= event.target.parentNode.parentNode.childNodes[1].childNodes[1].id;

		
		const url = `/portfolio/product/modifyproductPage/${productnumber}`;
		console.log(url);
		window.location.href = url; 
	}
	//상품삭제
	function deleteproduct_f(event){
	
		event.preventDefault(); //기본이벤트 막기
		let deleteform = document.getElementById('deleteform');
		
		const productnumber= event.target.parentNode.parentNode.parentNode.childNodes[1].childNodes[1].id;
		console.log('상품삭제클릭'+productnumber);
		const url = `/portfolio/product/deleteproductPage/${productnumber}`;
		var deletecon = confirm('등록된 상품을 삭제하시겠습니까?');
		if(deletecon ==true){
		//서버에 전송
		deleteform.method = 'post';
		deleteform.action = url;
		deleteform.submit();
		}
	}
	
	//전체보기
	function allmyproduct_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("전체보기 선택함.");
		const url = `/portfolio/product/myproduct/1/1`;
		window.location.href = url; 
	}
	
	//판매 중 상품
	function product_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("전체보기 선택함.");
		const url = `/portfolio/product/myproduct/1/2`;
		window.location.href = url; 
	}
	
	//거래 중 상품
	function trsproduct_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("전체보기 선택함.");
		const url = `/portfolio/product/myproduct/1/3`;
		window.location.href = url; 
	}
	
	//판매완료상품
	function finiproduct_f(event){
		event.preventDefault(); //기본이벤트 막기
		console.log("전체보기 선택함.");
		const url = `/portfolio/product/myproduct/1/4`;
		window.location.href = url; 
	}
	



