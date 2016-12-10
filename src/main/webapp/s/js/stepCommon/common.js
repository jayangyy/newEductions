// ==========================================//
// 取地址栏参数 返回：对象数组[{key:"",value:""},{key:"",value:""}],编码：encodeURI/decodeURI
// ==========================================//
function getUrlParam(isCode) {
	var rs = {};
	var txt = window.location.search.replace("?", "");// 参数
	//base64 解码  add by 阿Q 2015-08-07
//	txt = base64decode(txt);
	if(typeof(isCode)=="undefined" || isCode==true){//需要解码
		txt = base64decode(txt);
	}
	if (txt != "") {
		var sarr = txt.split("&");
		$.each(sarr, function(i, v) {// decodeURIComponent()[谷歌]
			// unescape()[IE]
			var t = v.split("=");
			var _k = t[0];
			var _v = t[1];
			_k = decodeURI(_k);
			_v = decodeURI(_v);
			rs[_k] = _v;
		});
		return rs;
	} else {
		return false;
	}
}
//地址栏参数加密的方法（base64）
function encodeUrlParam($url){
	var tmp = $url.split('?');
	if(tmp.length>1){
		return tmp[0]+'?'+base64encode(encodeURI(tmp[1]));
		//return tmp[0]+'?'+encodeURI(tmp[1]);
	}else{
		return tmp[0];
	}
}
//地址栏参数解密的方法
function decodeUrlParam($url){
	var tmp = $url.split('?');
	if(tmp.length>1){
		return tmp[0]+'?'+decodeURI(base64decode(tmp[1]));
	}else{
		return tmp[0];
	}
}
//==========================================//
//将后台取到的数据转换为datagrid可用的数据格式（适用于数据第一行为表头）
//参数：data：数据源
//参数：isAll：是否为全部数据
//参数：autoKey：是否自动生成键
//==========================================//
function convertData(data,isAll,autoKey){
	var rsdata = {total:0,rows:[]};
	if(data.length>1){
		$.each(data,function(i,v){
			if(i>0){//第一行为表头，第二行开始为数据
				var json = {};
				$.each(data[0],function(j,k){
					k = k.replace("(","").replace(")","");
					if(isAll){//全部数据
						if(autoKey){
							json["key"+j] = v[j];
						}else{
							json[k] = v[j];
						}
					}else{//分页数据
						if(j>0){//第一位是数据总条数，从第二位开始，才是数据
							if(autoKey){
								json["key"+j] = v[j];
							}else{
								json[k] = v[j];
							}
						}
					}
				});
				rsdata.rows.push(json);
			}
		});
		if(isAll){//全部数据
			rsdata.total = data.length-1;
		}else{//分页数据
			rsdata.total = data[1][0];
		}
	}
	return rsdata;
}

//==========================================//
//将后台取到的数据转换为datagrid可用的数据格式（适用于数据 [[KEY,VALUE]]）
//参数：data：数据源
//==========================================//
function convertData1(data,autoKey){
	var rsdata = {total:0,rows:[]};
	if(data!=null&&data.length>0){
		$.each(data,function(i,v){
			var json = {};
			$.each(v,function(j,k){
				if(autoKey){
					json["key"+k[0]] = k[1];
				}else{
					json[k[0]] = k[1];
				}
				
			});
			rsdata.rows.push(json);
		});
		rsdata.total = data.length;
	}
	return rsdata;
}

//==========================================//
//将后台取到的数据转换为datagrid可用的数据格式（适用于数据 [KEY,VALUE]）
//参数：data：数据源
//返回：OBJECT obj.key = value;
//==========================================//
function convertData2(data){
	var rsdata = {};
	if(data!=null&&data.length>0){
		$.each(data,function(i,v){
			$.each(v,function(j,k){
				rsdata[k[0]] = k[1];
			});
		});
	}
	return rsdata;
}

//==========================================//
//将后台取到的数据转换为datagrid可用的数据格式（适用于数据 [obj]）
//参数：data：数据源  idx:作为KEY的列
//返回：OBJECT rows[obj[idx]] = obj;
//==========================================//
function convertData3(data,idx){
	var rsdata = [];
	if(data!=null&&data.length>0){
		$.each(data,function(i,v){
			rsdata[v[idx]]=v;
		});
	}
	return rsdata;
}

//==========================================//
//将后台取到的数据转换为datagrid可用的数据格式（适用于数据 [obj]）
//参数：data：数据源  idx:作为KEY的列
//返回：OBJECT rows[obj[idx]] = obj[value]";
//==========================================//
function convertData4(data,key,value){
	var rsdata = [];
	if(data!=null&&data.length>0){
		$.each(data,function(i,v){
			rsdata[v[key]]=v[value];
		});
	}
	return rsdata;
}
//将二维数组（id,pid格式）转为树形数据（id,text,children)
function convertTreeData(d) {
    var rs = [];
    for(var i= 0;i< d.length;i++){
        var mark = false;
        for(var j =0;j< d.length;j++){
            if(d[i].pid!=null&&d[i].pid==d[j].id){
                mark = true;
                if (typeof(d[j].children) == "undefined")
                    d[j].children = [d[i]];
                else d[j].children.push(d[i]);
                break;
            }
        }
        if(!mark){
            rs.push(d[i]);
        }
    }
    return rs;
}
//==========================================//
//向表格数据中增添底部统计数据
//参数：data：数据源
//参数：footerJson：待统计字段	例：{"QQCS":0,"QQDS":0,"PZCS":0,"PZDS":0}
//参数：titleKey：统计显示文字标题	例：{key:"ZCRQ",text:"统计"}
//参数：showZero：是否显示统计数0
//==========================================//
function addFooterToData(data,footerJson,titleKey,showZero){
	var footer = jQuery.extend({}, footerJson);
	$.each(data,function(i,v){
		$.each(footer,function(key,val){
			if(v[key]!=""){//
				footer[key] += parseInt(v[key],10);
			}
		});
	});
	if(!showZero){
		$.each(footer,function(key,val){
			if(val==0){
				footer[key] = "";
			}
		});
	}
	footer[titleKey.key] = titleKey.text;
	var rsData = {"total":data.length,"rows":data,"footer":[footer]};
	return rsData;
}
//==========================================//
//提示框
//==========================================//
function showMsg(msg,t){
	var _msg = msg?'<div class="big-msg-text">'+msg+'</div>':'<div class="big-msg-text">操作成功</div>';
	$.messager.show({
		title:'操作提示',
		msg:_msg,
		timeout:t?t:1500,
		showType:'fade',
		style:{right:'',bottom:'',top:document.body.scrollTop+document.documentElement.scrollTop}
	});
}
//重写日期格式化函数
Date.prototype.Format = function (fmt) { //
    var o = {
        "M+": this.getMonth() + 1, // 月份
        "d+": this.getDate(), // 日
        "h+": this.getHours(), // 小时
        "m+": this.getMinutes(), // 分
        "s+": this.getSeconds(), // 秒
        "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
        "S": this.getMilliseconds() // 毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};
function toValue(_value){
	return $.trim(typeof(_value)=='undefined'||_value==null?'':_value);
}

function toValue(_value){
	return $.trim(typeof(_value)=='undefined'||_value==null||_value==''?0:_value);
}
//在一个日期上加时间
function getDateTimeSub(curDate,formatStr,hours){
	curDate.setHours(curDate.getHours()+hours)  ;
	formatStr=formatStr.replace("yyyy",curDate.getFullYear());
	formatStr=formatStr.replace('MM',(curDate.getMonth()+1)>9?(curDate.getMonth()+1):'0'+(curDate.getMonth()+1));
	formatStr=formatStr.replace('dd',curDate.getDate()>9?curDate.getDate():'0'+curDate.getDate());
	formatStr=formatStr.replace('hh',curDate.getHours()>9?curDate.getHours():'0'+curDate.getHours()) ;
	formatStr=formatStr.replace("mm",curDate.getMinutes()>9?curDate.getMinutes():'0'+curDate.getMinutes());
	formatStr=formatStr.replace("ss",curDate.getSeconds()>9?curDate.getSeconds():'0'+curDate.getSeconds());
	formatStr=formatStr.replace("SSS",curDate.getMilliseconds());
	return formatStr;
}

function startLoading(){
	$("#div_cover").show();
}
function endLoading(){
	$("#div_cover").hide();
}
function loadNulData(dgs){
	$.each(dgs,function(i,v){
		$("#"+v).datagrid("loadData",{total:0,rows:[]});
	});
}

//生成随机数： N位数字+时间     n:N位数字 fm:日期格式
var randomChars=['0','1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
function creatRandomDig(n,fm){
	var rStr = '';
	var _len = randomChars.length;
	for(var i=0;i<n;i++){  //N位随机数字
		rStr += randomChars[Math.ceil(Math.random()*_len)];
	}
	rStr += getDateTimeSub(new Date(),fm,0);
	return rStr;
}

/****************************************************************************/
/*                        base64加密                                                                                                                             */
/****************************************************************************/
var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"; 
var base64DecodeChars = new Array( 
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, 
    -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, 
    -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1); 

function base64encode(str) { 
    var out, i, len; 
    var c1, c2, c3; 

    len = str.length; 
    i = 0; 
    out = ""; 
    while(i < len) { 
    c1 = str.charCodeAt(i++) & 0xff; 
    if(i == len) 
    { 
        out += base64EncodeChars.charAt(c1 >> 2); 
        out += base64EncodeChars.charAt((c1 & 0x3) << 4); 
        out += "=="; 
        break; 
    } 
    c2 = str.charCodeAt(i++); 
    if(i == len) 
    { 
        out += base64EncodeChars.charAt(c1 >> 2); 
        out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4)); 
        out += base64EncodeChars.charAt((c2 & 0xF) << 2); 
        out += "="; 
        break; 
    } 
    c3 = str.charCodeAt(i++); 
    out += base64EncodeChars.charAt(c1 >> 2); 
    out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4)); 
    out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >>6)); 
    out += base64EncodeChars.charAt(c3 & 0x3F); 
    } 
    return out; 
} 

function base64decode(str) { 
    var c1, c2, c3, c4; 
    var i, len, out; 

    len = str.length; 
    i = 0; 
    out = ""; 
    while(i < len) { 
    /* c1 */ 
    do { 
        c1 = base64DecodeChars[str.charCodeAt(i++) & 0xff]; 
    } while(i < len && c1 == -1); 
    if(c1 == -1) 
        break; 

    /* c2 */ 
    do { 
        c2 = base64DecodeChars[str.charCodeAt(i++) & 0xff]; 
    } while(i < len && c2 == -1); 
    if(c2 == -1) 
        break; 

    out += String.fromCharCode((c1 << 2) | ((c2 & 0x30) >> 4)); 

    /* c3 */ 
    do { 
        c3 = str.charCodeAt(i++) & 0xff; 
        if(c3 == 61) 
        return out; 
        c3 = base64DecodeChars[c3]; 
    } while(i < len && c3 == -1); 
    if(c3 == -1) 
        break; 

    out += String.fromCharCode(((c2 & 0XF) << 4) | ((c3 & 0x3C) >> 2)); 

    /* c4 */ 
    do { 
        c4 = str.charCodeAt(i++) & 0xff; 
        if(c4 == 61) 
        return out; 
        c4 = base64DecodeChars[c4]; 
    } while(i < len && c4 == -1); 
    if(c4 == -1) 
        break; 
    out += String.fromCharCode(((c3 & 0x03) << 6) | c4); 
    } 
    return out; 
} 

function utf16to8(str) { 
    var out, i, len, c; 

    out = ""; 
    len = str.length; 
    for(i = 0; i < len; i++) { 
    c = str.charCodeAt(i); 
    if ((c >= 0x0001) && (c <= 0x007F)) { 
        out += str.charAt(i); 
    } else if (c > 0x07FF) { 
        out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F)); 
        out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F)); 
        out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F)); 
    } else { 
        out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F)); 
        out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F)); 
    } 
    } 
    return out; 
} 

function utf8to16(str) { 
    var out, i, len, c; 
    var char2, char3; 

    out = ""; 
    len = str.length; 
    i = 0; 
    while(i < len) { 
    c = str.charCodeAt(i++); 
    switch(c >> 4) 
    { 
      case 0: case 1: case 2: case 3: case 4: case 5: case 6: case 7: 
        // 0xxxxxxx 
        out += str.charAt(i-1); 
        break; 
      case 12: case 13: 
        // 110x xxxx 10xx xxxx 
        char2 = str.charCodeAt(i++); 
        out += String.fromCharCode(((c & 0x1F) << 6) | (char2 & 0x3F)); 
        break; 
      case 14: 
        // 1110 xxxx 10xx xxxx 10xx xxxx 
        char2 = str.charCodeAt(i++); 
        char3 = str.charCodeAt(i++); 
        out += String.fromCharCode(((c & 0x0F) << 12) | 
                       ((char2 & 0x3F) << 6) | 
                       ((char3 & 0x3F) << 0)); 
        break; 
    } 
    } 

    return out; 
} 
