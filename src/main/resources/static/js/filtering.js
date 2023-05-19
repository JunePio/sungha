	// DB에 있는 데이터를 다시 태그로 변환
	function onGetUnescapeXSS(inputText) {
		if(inputText == null) {
			return null;
		}
	    var plainText = inputText;
	    if (plainText != '') {
	        var source = ["&amp;","&lt;","&gt;","&quot;","&#39;","&#47;","&#40;","&#41;","&#37;","&#45;"];
	        var target = ["&", "<", ">", "\"", "'", "/", "(", ")", "%", "-"];
	
	        for(var  i = 0; i < source.length; i++) {
	            if(plainText.indexOf(source[i]) > -1) {
	                plainText = plainText.replaceAll(source[i], target[i]);
	            }
	        }
	    }
	    return plainText;
	};
	
	// 기관명 입력시 특수문자 입력 제한
	function fnPressOrgNm(event, obj) {
		var inspect = /[\{\}\[\]\/?,;:|\*~`!^\-_+┼<>@\#$%'\"\\\\=]/g;
		if(inspect.test(obj.value)) {
			obj.value = obj.value.replaceAll(/[\{\}\[\]\/?,;:|\*~`!^\-_+┼<>@\#$%'\"\\\\=]/g, '');
			alert("한글, 영문, 숫자만 입력 가능합니다.");
			return false;
		}
	};
	
	// 한글 및 특수문자 입력 제한
	function fnPressHanSpecial(event, obj) {
		var inspect = /[\ㄱ-하-ㅣ가-힣|\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/g;
		if(inspect.test(obj.value)) {
			obj.value = obj.value.replaceAll(/[\ㄱ-하-ㅣ가-힣|\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/g, '');
			alert("영문, 숫자만 입력 가능합니다.");
			return false;
		}
	};
	
	// 특수문자 입력 제한
	function fnPressSpecial(event, obj) {
		var inspect = /[\{\}\[\]\/?.,;:|\*~`!^\-_+┼<>@\#$%&\'\"\\\\=]/g;
		if(inspect.test(obj.value)) {
			obj.value = obj.value.replaceAll(/[\{\}\[\]\/?.,;:|\*~`!^\-_+┼<>@\#$%&\'\"\\\\=]/g, '');
			alert("한글, 영문, 숫자만 입력 가능합니다.");
			return false;
		}
	};
	
	// textarea 특수문자 입력 제한
	function fnTextAreaPressSpecial(event, obj) {
		var inspect = /[\{\}\[\]\/?,;:|\*~`!^\-_+┼<>@\#$%&\'\"\\\\=]/g;
		if(inspect.test(obj.value)) {
			obj.value = obj.value.replaceAll(/[\{\}\[\]\/?,;:|\*~`!^\-_+┼<>@\#$%&\'\"\\\\=]/g, '');
			alert("한글, 영문, 숫자만 입력 가능합니다.");
			return false;
		}
		
	};
	
	// 숫자만 입력받기
	function fnPress(event, obj) {
		if((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105) && (event.keyCode != 8 && event.keyCode != 37 && event.keyCode != 39 && event.keyCode != 46)) {
			obj.value = obj.value.replaceAll(/[\ㄱ-하-ㅣ가-힣|a-z|A-Z|\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/g, '');
			alert("숫자만 입력가능합니다.");
			return false;
		}
	};
	
	// 주소입력시 특수 문자 제한 - 허용
	function fnPressAddress(event, obj) {
		var inspect = /[\{\}\[\]\/?.,;:|\*~`!^\_+┼<>@\#$%&\'\"\\\\=]/g;
		if(inspect.test(obj.value)) {
			obj.value = obj.value.replaceAll(/[\{\}\[\]\/?.,;:|\*~`!^\_+┼<>@\#$%&\'\"\\\\=]/g, '');
			alert("한글, 영문, 숫자만 입력 가능합니다.");
			return false;
		}
	};
	
	// 이메일 입력 제한 .는 허용
	function fnPressEmail(event, obj) {
		var inspect = /[\ㄱ-하-ㅣ가-힣|\{\}\[\]\/?,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/g;
		if(inspect.test(obj.value)) {
			obj.value = obj.value.replaceAll(/[\ㄱ-하-ㅣ가-힣|\{\}\[\]\/?,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/g, '');
			alert("영문, 숫자만 입력 가능합니다.");
			return false;
		}
		
	};