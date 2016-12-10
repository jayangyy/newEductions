//字符串检查
jQuery.validator.addMethod("stringCheck", function(value, element) {       
     return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);       
 }, "只能包括中文字、英文字母、数字和下划线");   
 //数字检查
jQuery.validator.addMethod("IsNumber", function(value, element) {       
     return this.optional(element) || /^[1-9]\d*$/.test(value);       
 }, "只能包括数字"); 
 // 中文字两个字节       
 jQuery.validator.addMethod("byteRangeLength", function(value, element, param) {       
     var length = value.length;       
     for(var i = 0; i < value.length; i++){       
         if(value.charCodeAt(i) > 127){       
         length++;       
         }       
     }       
     return this.optional(element) || ( length >= param[0] && length <= param[1] );       
 }, "请确保输入的值在3-15个字节之间(一个中文字算2个字节)");   
   
 // 身份证号码验证       
 jQuery.validator.addMethod("isIdCardNo", function(value, element) {       
     return this.optional(element) || checkidcard(value);       
 }, "请正确输入您的身份证号码");    
      
 // 手机号码验证       
 jQuery.validator.addMethod("isMobile", function(value, element) {       
     var length = value.length;   
     var mobile = /^0?[1][358][0-9]{9}$/;   
     return this.optional(element) || (length == 11 && mobile.test(value));       
 }, "请正确填写您的手机号码,格式应为13*********");       
      
 // 固定电话号码验证       
 jQuery.validator.addMethod("isTel", function(value, element) {       
     //var tel = /^\d{3,4}-?\d{7,9}$/;    //电话号码格式010-12345678   
	 var tel = /^(0[0-9]{2,3}\-)([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/     
     return this.optional(element) || (tel.test(value));       
 }, "请正确填写您的电话号码,格式应为区号-电话(-分机号)");   
   
 // 联系电话(手机/电话皆可)验证   
 jQuery.validator.addMethod("isPhone", function(value,element) {   
     var length = value.length;   
     var mobile = /^0?[1][358][0-9]{9}$/;   
     var tel = /^(0[0-9]{2,3}\-)([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/;   
     return this.optional(element) || (tel.test(value) || mobile.test(value));   
   
 }, "请正确填写您的联系电话");  
 //营业站受理服务电话  支持座机、手机和服务热线
 jQuery.validator.addMethod("isPhoneRX", function(value,element) {   
     var length = value.length;   
     var mobile = /^0?[1][3458][0-9]{9}$/;   
     var tel = /^(0[0-9]{2,3}\-)([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/; 
     var rxno = /^(0[0-9]{2,3}\-?[0-9]{5}$)|(^[0-9]{5})$/;  //如12306  023-12306  0839-12306
     var fwdh = /^400\d{7}$/;  //400服务电话
     return this.optional(element) || (tel.test(value) || mobile.test(value) || rxno.test(value) || fwdh.test(value));   
   
 }, "请正确填写您的联系电话"); 
      
 // 邮政编码验证       
 jQuery.validator.addMethod("isZipCode", function(value, element) {       
     var tel = /^[0-9]{6}$/;       
     return this.optional(element) || (tel.test(value));       
 }, "请正确填写您的邮政编码"); 
//电子邮箱验证
 jQuery.validator.addMethod("isEmail", function(value, element) {       
     var tel = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;   
     return this.optional(element) || (tel.test(value));       
 }, "请正确填写您的电子邮箱"); 
 
//正整数验证，区别于digits，digits包括0
 jQuery.validator.addMethod("positiveInteger", function(value, element) { 
	 return this.optional(element) || /^[0-9]*[1-9][0-9]*$/.test(value);     
 }, "只能输入正整数"); 
 
//中文姓名验证
 jQuery.validator.addMethod("chineseName", function(value, element) { 
	 return this.optional(element) || /[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*/.test(value);     
 }, "请输入中文姓名"); 
 
//英文姓名验证
 jQuery.validator.addMethod("englishName", function(value, element) { 
	 return this.optional(element) || /^[a-zA-Z]{2,5}(?:·[a-zA-Z]{2,5})*/.test(value);     
 }, "请输入英文名"); 
 
//姓名验证，包括中英文
 jQuery.validator.addMethod("allName", function(value, element) { 
	 return this.optional(element) || /[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*/.test(value)||/^[a-zA-Z]{2,5}(?:·[a-zA-Z]{2,5})*/.test(value);     
 }, "请输入姓名");
 
//字符检查，适用于装载方案，重点合同号*******不包括下划线该怎么写
 jQuery.validator.addMethod("stringCheck1", function(value, element) {       
	 return this.optional(element) || /^[\u0391-\uFFE5\w\-]+$/.test(value);  
  }, "只能输入中英文、数字、中划线及下划线!");  
 
//非负数
 jQuery.validator.addMethod("nonNegativeNumber", function(value, element) {
	 return this.optional(element) || /^((0{1})|([1-9]{1}[0-9]*)|([1-9]+[0-9]*\.[0-9]+)|([0]{1}\.[0-9]+))$/.test(value);  
	 //return this.optional(element) || /^\d+(\.\d+)?$/.test(value);  
	 ///^\0{1}$/ || /^\[1-9]\d?$/ ||/^\d+\.\d+$/
  }, "只能输入非负数!");  
 
 
//正数
jQuery.validator.addMethod("positiveNumber", function(value, element) {       
	// return this.optional(element) || /^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/.test(value);  
	return this.optional(element) || /^([1-9]{1}[0-9]*)|([1-9]+[0-9]*\.[0-9]+)|([0]{1}\.[0-9]+)$/.test(value);
 }, "只能输入正数!");  
//非汉字
jQuery.validator.addMethod("nonChinese", function(value, element) {
	return this.optional(element) || /^[\w!@#$%^&*()<>{},.?-_]+$/.test(value);
}, "不能输入中文!");
//组织机构代码验证
jQuery.validator.addMethod("orgCode", function(value, element) {
	return this.optional(element) || /^[0-9a-zA-Z|-]+$/.test(value);
}, "无效的组织机构代码!");
/**
* 表单不提交的验证方法
* @param:
* 	end: 为开始时间 yyyy-MM-dd
* 	start:为包含结束时间的控件 yyyy-MM-dd
* @return if end > start ,then return true , otherwise return false.
* @version <2> 2011/11/11 Hayden : modify logic.
* @version <1> 2011/10/27 Hayden : create. 
*/
//不允许跨月订单
jQuery.validator.addMethod("everyMonth", function(end,element,start) {
	var a = $(start).val();
	var endDate = String.parseToDate(end.replaceAll("-",""));
	var startDate = String.parseToDate(a.replaceAll("-",""));
	var endMonth = endDate.getMonth()+1;
	var startMonth = startDate.getMonth()+1;
	//alert(startMonth);
	//alert(endMonth);
	//alert(endMonth == startMonth);
	return (endMonth == startMonth);
}, "不允许提报跨月订单");
	
 function checkidcard(num){  
	    var len = num.length, re;  
	    if (len == 15)  
	        re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{3})$/);  
	    else if (len == 18)  
	        re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\d)$/);  
	    else{  
	        //alert("请输入15或18位身份证号,您输入的是 "+len+ "位");   
	        return false;  
	    }  
	    var a = num.match(re);  
	    if (a != null){  
	        if (len==15){  
	            var D = new Date("19"+a[3]+"/"+a[4]+"/"+a[5]);  
	            var B = D.getYear()==a[3]&&(D.getMonth()+1)==a[4]&&D.getDate()==a[5];  
	        }else{  
	            var D = new Date(a[3]+"/"+a[4]+"/"+a[5]);  
	            var B = D.getFullYear()==a[3]&&(D.getMonth()+1)==a[4]&&D.getDate()==a[5];  
	        }  
	        if (!B){  
	            //alert("输入的身份证号 "+ a[0] +" 里出生日期不对！");   
	            return false;  
	        }  
	    }  
	  
	    return true;  
	}   