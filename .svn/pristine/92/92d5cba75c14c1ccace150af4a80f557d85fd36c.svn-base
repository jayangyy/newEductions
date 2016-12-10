var mm = {
    bw:0,
    bh:0,
    login:[ "10.192.111.79", "hhs", "hhs" ],
    url:"/PDMS/GeneralProServlet",
    objInfoJh:"",//机会数据
    objInfoXm:"",//项目数据
    objInfoZs:"",//招商数据
    gzUrl:"GZImg/",//单位章路径
    pidJh:"6996a898-660a-4642-adfe-22b1141f52a6",//机会ID
    pidXm:"be8f7ef4-9fe1-4751-bad3-b175ae5e6b32",//项目ID
    pidZs:"",//招商ID
    pidZy:"",//在营ID
    step:"",//当前步骤
    Punit:"重庆车辆段",//开发单位名称
    UserEncode:"2141215932",//登录人员编码
	Oname:"信息技术所"//登录人员所属机构
};
$(function(){
	try{
		var pp = getUrlParam();
		mm.pidJh = pp.pidJh;
		mm.pidXm = pp.pidXm;
		mm.pidZs = pp.pidZs;
		mm.pidZy = pp.pidZy;//'allFlowView.html?pidJh=&pidXm=&pidZs=&pidZy='+在营ID+'&Punit='+项目开发单位+'&Oname='+登录人单位+'&UserEncode='+登录人编码+'&step=';
		mm.Punit = pp.Punit;
		mm.Oname = pp.Oname;
		mm.UserEncode = pp.UserEncode;
		mm.step = pp.step;
	}catch(e){}
    $(window).resize(function(){
        setLayout();//布局
    });
    initPage();
});
/***
 * 程序入口
 */
function initPage(){
	bindFns();//绑定事件
	setLayout();//布局
	setDefaults();//设置页面默认值
	getDatas();//取数据
}
//页面布局
function setLayout(){
	mm.bh = $(window).height();
	mm.bw = $(window).width();
	var singleW = Math.floor((mm.bw-40)/4);//一个单元格宽度
//	$("#tab_sp_jh,#view_blyj_jh,#view_lczz_jh,#tab_sp_xm,#view_blyj_xm,#view_lczz_xm,#tab_zs,#view_blyj_zs,#view_lczz_zs").width(mm.bw-40);//表格宽度
	$(".tab2[id^='view']").width(mm.bw-60);//意见、流程	表格宽度
//	$("#tab_sp_jh td,#tab_sp_jh th,#tab_sp_xm td,#tab_sp_xm td,#tab_zs td,#tab_zs td").css({width:singleW});
	$(".tab th,.tab td").css({width:singleW});
}
//设置页面默认值
function setDefaults(){
	
}
//取数据
function getDatas(){
	getDic_source();//获取资源列表
	if(mm.pidZy!=""){//在营
		$("#pJh").panel("collapse");//收起机会
		$("#pXm").panel("collapse");//收起项目
		$("#pZs").panel("collapse");//收起招商
		$("#pZy").panel("expand");//展开在营
		getObjDataZy();//取在营数据
		return;
	}else{
		$("#myaa").accordion("remove","在营项目详情表");
	}
	if(mm.pidJh!=""){//机会
		getObjDataJh();//取机会数据
	}else{
		$("#myaa").accordion("remove","机会研究审批表");
	}
	if(mm.pidXm!=""){//项目
		$("#pJh").panel("collapse");//收起机会
		$("#pXm").panel("expand");//展开项目
		getObjDataXm();//取项目数据
	}else{
		$("#myaa").accordion("remove","项目开发审批表");
	}
	if(mm.pidZs!="" && mm.step=="3"){//招商 且已转招商
		$("#pJh").panel("collapse");//收起机会
		$("#pXm").panel("collapse");//收起项目
		$("#pZs").panel("expand");//展开招商
		getObjDataZs();//取招商数据
	}else{
		$("#myaa").accordion("remove","对外招商审批表");
	}
	
}
//绑定事件
function bindFns(){
}
/**>>>>>>>>>>>>业务逻辑********************************************************************************************/
//查看办理意见
function bc_blyj(obj,ty){
	if($("#view_blyj_"+ty).is(":visible")){
		$("#view_blyj_"+ty).hide();
	}else{
		if($("#view_blyj_"+ty).html()==""){
			if(ty=="jh"){
				getObjYjJh();//取机会意见
			}else if(ty=="xm"){
				getObjYjXm();//取项目意见
			}else if((ty=="zs")){
				getObjYjZs();//取招商意见
			}
		}
		$("#view_blyj_"+ty).show();
	}
}
//查看审批流程
function bc_lczz(obj,ty){
	if($("#view_lczz_"+ty).is(":visible")){
		$("#view_lczz_"+ty).hide();
	}else{
		if($("#view_lczz_"+ty).html()==""){
			if(ty=="jh"){
				getObjLcJh();//取机会流程
			}else if(ty=="xm"){
				getObjLcXm();//取项目流程
			}else if(ty=="zs"){
				getObjLcZs();//取招商流程
			}
		}
		$("#view_lczz_"+ty).show();
	}
}
/**>>>>>>>>>>>>数据处理********************************************************************************************/
//将机会项目数据放入DIV----机会
function setDataToDivJh(d){
	$("#xmbh_jh").html(d.PBH);//项目编号
	var zc = d.KFZCS;//开发资源列表
	var dom = '';
	if(zc!=""){
		dom += '<tr><th>固资编号</th><th>名称</th><th>单位</th></tr>';
		$.each(mm.source, function(i,v) {
			if(zc.indexOf(v.ZC_ID)>-1){
				dom += '<tr code="'+v.ZC_ID+'"><td>'+v.DEVICENO+'</td><td>'+v.DEVICENAME+'</td><td>'+v.ZCLZDW+'</td></tr>';
			}
		});
	}
	$("#kfzylb_jh").html(dom);//开发资源列表
	var sqrq = (new Date(d.REQUIR_DATE)).Format("yyyy-MM-dd");//申请日期
	$("#kflx_v_jh").html(d.DEV_TYPE);//发开类型
	$("#xmmc_v_jh").html(d.PNAME);//项目名称
	$("#kfdw_v_jh").html(d.DEPARTMENT);//开发单位
	$("#kfqx_v_jh").html(d.PQX);//开发期限（单位：月）
	$("#zrr_v_jh").html(d.ZRR);//责任人
	$("#zrrdh_v_jh").html(d.ZRRDH);//责任人电话
	$("#zrrsj_v_jh").html(d.ZRRSJ);//责任人手机
	$("#kfsl_v_jh").html(d.DEV_NUM);//开发数量
	$("#kfsldw_v_jh").html(d.DEV_UNIT);//开发数量单位
	$("#kfdj_v_jh").html(d.PRICE_UNIT);//开发单价
	$("#yjzsr_v_jh").html(d.YQZSR);//预期总收入
	$("#ndsy_v_jh").html(d.NDSY);//年度收益
	$("#ngrdh_v_jh").html(d.NGRDH);//拟缟人电话
	$("#ngrsj_v_jh").html(d.NGRSJ);//拟缟人手机
	$("#memo_v_jh").html(d.MEMO);//备注
	$("#xmdz_v_jh").html(d.PADDRESS);//项目地址
	$("#sqrq_v_jh").html(sqrq);//申请日期
	$("#xmgk_v_jh").html(d.XMGK);//项目概况
	$("#yjnlr_v_jh").html(d.YQNLR);//预计年利润
	$("#xjtr_v_jh").html((d.TRXJBZ=="0"?"否":"是"));//是否现金投入
	$("#trje_v_jh").html(d.TRXJJE);//投入金额
	$("#trly_v_jh").html(d.TRXJLY);//投入理由
	var wj = d.TZFJS.split(",");//投资收益分析
	var wjStr = '';
	$.each(wj, function(i,v) {
		var t = v.split("|");
		wjStr += '<li><a href="../PDMSFILE/'+t[1]+'">'+t[0]+'</a></li>';
	});
	$("#yjsyfx_v_jh").html(wjStr);//预计收益分析
	wj = d.SPFJS.split(",");
	wjStr = '';
	$.each(wj, function(i,v) {
		var t = v.split("|");
		wjStr += '<li><a href="../PDMSFILE/'+t[1]+'">'+t[0]+'</a></li>';
	});
	$("#qsspwj_v_jh").html(wjStr);//请示审批文件
	$("#ngr_v_jh").html(d.NGR);//拟稿人
}

//将项目数据放入DIV---项目
function setDataToDivXm(d){
	$("#xmbh_xm").html(d.PBH);//项目编号
	var zc = d.KFZCS;//开发资源列表
	var dom = '';
	if(zc!=""){
		dom += '<tr><th>固资编号</th><th>名称</th><th>单位</th></tr>';
		$.each(mm.source, function(i,v) {
			if(zc.indexOf(v.ZC_ID)>-1){
				dom += '<tr code="'+v.ZC_ID+'"><td>'+v.DEVICENO+'</td><td>'+v.DEVICENAME+'</td><td>'+v.ZCLZDW+'</td></tr>';
			}
		});
	}
	$("#kfzylb_xm").html(dom);//开发资源列表
	var sqrq = (new Date(d.REQUIR_DATE)).Format("yyyy-MM-dd");//申请日期
	$("#kflx_v_xm").html(d.DEV_TYPE);//发开类型
	$("#xmmc_v_xm").html(d.PNAME);//项目名称
	$("#kfdw_v_xm").html(d.DEPARTMENT);//开发单位
	$("#kfqx_v_xm").html(d.PQX);//开发期限（单位：月）
	$("#zrr_v_xm").html(d.ZRR);//责任人
	$("#zrrdh_v_xm").html(d.ZRRDH);//责任人电话
	$("#zrrsj_v_xm").html(d.ZRRSJ);//责任人手机
	$("#kfsl_v_xm").html(d.DEV_NUM);//开发数量dev_num
	$("#kfsldw_v_xm").html(d.DEV_UNIT);//开发数量单位
	$("#kfdj_v_xm").html(d.PRICE_UNIT);//开发单价
	$("#yjzsr_v_xm").html(d.YQZSR);//预期总收入
	$("#ndsy_v_xm").html(d.NDSY);//年度收益
	$("#ngrdh_v_xm").html(d.NGRDH);//拟缟人电话
	$("#ngrsj_v_xm").html(d.NGRSJ);//拟缟人手机
	$("#memo_v_xm").html(d.MEMO);//备注
	$("#xmdz_v_xm").html(d.PADDRESS);//项目地址
	$("#bxzzs_v_xm").html((d.ZSBZ=="0"?"否":"是"));//是否必需转招商
	$("#sqrq_v_xm").html(sqrq);//申请日期
	$("#xmgk_v_xm").html(d.XMGK);//项目概况
	$("#yjnlr_v_xm").html(d.YQNLR);//预计年利润
	$("#xjtr_v_xm").html((d.TRXJBZ=="0"?"否":"是"));//是否现金投入
	$("#trje_v_xm").html(d.TRXJJE);//投入金额
	$("#trly_v_xm").html(d.TRXJLY);//投入理由
	var wj = d.TZFJS.split(",");//投资收益分析
	var wjStr = '';
	$.each(wj, function(i,v) {
		var t = v.split("|");
		wjStr += '<li><a href="../PDMSFILE/'+t[1]+'">'+t[0]+'</a></li>';
	});
	$("#yjsyfx_v_xm").html(wjStr);//预计收益分析
	wj = d.SPFJS.split(",");
	wjStr = '';
	$.each(wj, function(i,v) {
		var t = v.split("|");
		wjStr += '<li><a href="../PDMSFILE/'+t[1]+'">'+t[0]+'</a></li>';
	});
	$("#qsspwj_v_xm").html(wjStr);//请示审批文件
	var zStr = "";//章
	if(d.BDWQZ!=""){//开发单位章不为空
		var bdwZ = d.BDWQZ.split("|");//本单位章（项目申请单位签章）
		if(bdwZ.length>0){
			var _time = bdwZ[1].split(" ")[0];
			var _code = 'getGZ';
			var _login = JSON.stringify(mm.login);
			var _sql = JSON.stringify([encodeURI(encodeURI(bdwZ[3])),_time]);
			var _src = "/PDMS/ImageServlet?login="+_login+"&code="+_code+"&sql="+_sql
			zStr = $("#model_dzz").html();
			zStr = zStr.replace("$txt$",bdwZ[0]).replace("$time$",_time).replace("$man$",bdwZ[2]).replace("$z$",_src);
		}
	}
	$("#xmsqdwqz_v_xm").html(zStr);//本单位章
	zStr = "";//章
	if(d.QTQZS!=""){//其它单位章不为空
		var qtdwZ = d.QTQZS.split(",");//其它单位章(联签单位签章)
		$.each(qtdwZ, function(i,v) {
			var bdwZ = v.split("|");//一个单位章数据
			var _time = bdwZ[1].split(" ")[0];
			var _code = 'getGZ';
			var _login = JSON.stringify(mm.login);
			var _sql = JSON.stringify([encodeURI(encodeURI(bdwZ[3])),_time]);
			var _src = "/PDMS/ImageServlet?login="+_login+"&code="+_code+"&sql="+_sql
			var m = $("#model_dzz").html();
			m = m.replace("$txt$",bdwZ[0]).replace("$time$",_time).replace("$man$",bdwZ[2]).replace("$z$",_src);
			zStr += m;
		});
		$("#lqdwqz_v_xm").html(zStr);//其它单位章(联签单位签章)
	}
	$("#ngr_v_xm").html(d.NGR);//拟稿人
}

//放置数据到页面---招商
function setDataToDivZs(d){
	$("#zsmc_zs").html(d.TITLE);//招商名称
	$("#zslb_zs").html(d.TYPE);//招商类型
	$("#ngr_zs").html(d.USERNAME);//拟稿人
	var zbrq = (new Date(d.BXSJ)).Format("yyyy-MM-dd hh:mm");
	var bmks = (new Date(d.BMKSSJ)).Format("yyyy-MM-dd hh:mm");
	var bmjs = (new Date(d.BMJZSJ)).Format("yyyy-MM-dd hh:mm");
	//展示控件
	$("#zbrq_v_zs").html(zbrq);//招标日期
	$("#bmks_v_zs").html(bmks);//报名开始时间
	$("#bmjs_v_zs").html(bmjs);//报名截止日期
	$("#lxr_v_zs").html(d.LXR);//联系人
	$("#lxrdh_v_zs").html(d.LXDH);//联系人电话
	$("#yjckfqzs_v_zs").html((d.JKCZS=="0"?"否":"是"));//是否由经开处发起招商
	$("#zsnr_v_zs").html(d.CONTEXT);//招商内容
	var wjStrV = '';
	if(d.JHWJ!=""){
		var t = d.JHWJ.split(",");//"file_name,file_realname"
		wjStrV += '<li><a href="../PDMSFILE/'+t[1]+'">'+t[0]+'</a></li>';
	}
	$("#zsfj_v_zs").html(wjStrV);//招商附件--展示
	var zStr = "";//章
	if(typeof(d.BDWQZ)!="undefined" && d.BDWQZ!=""){//开发单位章不为空
		var bdwZ = d.BDWQZ.split("|");//本单位章（项目申请单位签章）
		if(bdwZ.length>0){
			var _time = bdwZ[1].split(" ")[0];
			var _code = 'getGZ';
			var _login = JSON.stringify(mm.login);
			var _sql = JSON.stringify([encodeURI(encodeURI(mm.Oname)),_time]);
			var _src = "/PDMS/ImageServlet?login="+_login+"&code="+_code+"&sql="+_sql
			zStr = $("#model_dzz").html();
			zStr = zStr.replace("$txt$",bdwZ[0]).replace("$time$",_time).replace("$man$",bdwZ[2]).replace("$z$",_src);
		}
	}
	//专家组
	if(d.ZJS!=""){
		var zjs = d.ZJS.split(",");
		var dom = '';
		$.each(zjs,function(i,v){
			var one = v.split(":");//一个专家//[z_name,z_bgdh,z_lxdh,z_system,z_dw,z_bm,z_zw,z_rybm]
			var t = $("#model_zj").html();
			t = t.replace(/{seq}/g,i);//序号
			t = t.replace(/{photo}/g,one[0]);//照片
			t = t.replace(/{name}/g,one[0]);//姓名
			t = t.replace(/{tel}/g,one[1]);//电话--坐机
			t = t.replace(/{phone}/g,one[2]);//手机
			t = t.replace(/{lx}/g,one[3]);//类型
			t = t.replace(/{dw}/g,one[4]);//单位
			t = t.replace(/{bm}/g,one[5]);//部门
			t = t.replace(/{zw}/g,one[6]);//职务
			t = t.replace(/{code}/g,one[7]);//照片
			dom += t;
		});
		$("#myZJZList").html(dom);
	}
	$("#xmsqdwqz_v_zs").html(zStr);//本单位章
}

//放置数据到页面---在营
function setDataToDivZy(d){
	$("#htxyh_zy").html(d.XMHTH);//项目合同/协议号
	$("#yyskzje_zy").html(d.YSKZJE);//预计收款总金额（元）
	var wj = d.HTFJS.split(",");//合同附件
	var wjStr = '';
	$.each(wj, function(i,v) {
		var t = v.split("|");
		wjStr += '<li><a href="../PDMSFILE/'+t[1]+'">'+t[0]+'</a></li>';
	});
	$("#htfj_zy").html(wjStr);//合同附件
	$("#xmqssj_zy").html(d.XMQSSJ);//项目起始时间
	$("#xmzzsj_zy").html(d.XMZZSJ);//项目终止时间
	getSkjl();//取收款记录
//	$("#skjl_zy").html(d.USERNAME);//收款记录
}

//创建项目意见DOM
function creatDom_xmyj(d,ty){
	var rs = '<tr><th class="seq">序号</th><th class="sj">开始时间</th><th class="sj">结束时间</th><th>单位</th><th>部门</th><th>职务</th><th>办理人</th><th>内容</th><th>附件</th></tr>';
	$.each(d, function(i,v) {
		var fj = "";//批复文档.txt|spfj_20150901-1451.txt
		if(v.FLOWFJS!=""){
			var fjArr = v.FLOWFJS.split(",");
			$.each(fjArr, function(i,v) {
				var t = v.split("|");//一个附件
				fj += '<a href="../PDMSFILE/'+t[1]+'">'+t[0]+'</a>&nbsp;&nbsp;';
			});
		}
		rs += '<tr><td>'+(i+1)+'</td><td>'+v.CREATE_TIME+'</td><td>'+v.DONE_TIME+'</td><td>'+v.FLOW_UNIT+'</td><td>'+v.FLOW_DEPARTMENT+'</td><td>'+v.FLOW_PER_ZW+'</td><td>'+v.FLOW_PER+'</td><td>'+v.FLOW_TEXT+'</td><td>'+fj+'</td></tr>';
	});
	var objInfo = ty=="jh"?mm.objInfoJh:mm.objInfoXm;
	rs += '<tr><td class="c-red"><span>'+(d.length+1)+'</span></td><td colspan="9" class="c-red"><span>'+objInfo.SPPERS+'</span></td><tr>';
	$("#view_blyj_"+ty).html(rs);
}
//创建流程追踪DOM
function creatDom_lczz(d,ty){
	var rs = '<tr><th class="seq">序号</th><th class="sj">操作时间</th><th>单位</th><th>部门</th><th>职务</th><th>操作人</th><th>内容</th></tr>';
	$.each(d, function(i,v) {
		rs += '<tr><td>'+(i+1)+'</td><td>'+v.CZSJ+'</td><td>'+v.DW+'</td><td>'+v.BM+'</td><td>'+v.ZW+'</td><td>'+v.RYXM+'</td><td>'+v.CZNR+'</td></tr>';
	});
	var objInfo = ty=="jh"?mm.objInfoJh:mm.objInfoXm;
	rs += '<tr><td class="c-red"><span>'+(d.length+1)+'</span></td><td colspan="6" class="c-red"><span>'+objInfo.SPPERS+'</span></td><tr>';
	$("#view_lczz_"+ty).html(rs);
}
/**>>>>>>>>>>>>数据交互********************************************************************************************/
//取项目详情数据----机会
function getObjDataJh(){
	var _data = {};
	_data.code = '1116';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidJh,mm.Punit,mm.UserEncode,mm.Oname]);// param1:项目id,开发单位名称,人员编码,人员所属机构
	_data.where = JSON.stringify([mm.pidJh,mm.Punit,mm.UserEncode,mm.Oname]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="" && r!="[]") {
				//数据处理
				var d = JSON.parse(r);
				mm.objInfoJh = d[0];//项目详情
				setDataToDivJh(d[0]);//将数据放入容器
			}else{
				alert("提示-取项目数据-机会：返回数据格式错误！");
			}
		},async:false,
		error : function() {
			alert("提示-取项目数据-机会：取数据出错！");
		}
	});
}
//取项目意见--机会
function getObjYjJh(){
	var _data = {};
	_data.code = '1126';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidJh,mm.Oname]);// param1:项目id,登录人单位
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="") {
				//数据处理
				var d = JSON.parse(r);
				creatDom_xmyj(d,"jh");//创建项目意见DOM
			}else{
				alert("提示-取项目意见-机会：返回数据格式错误！");
			}
		},
		error : function() {
			alert("提示-取项目意见-机会：取数据出错！");
		}
	});
}
//取流程追踪--机会
function getObjLcJh(){
	var _data = {};
	_data.code = '1127';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidJh]);// param1:项目id,开发单位名称
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="") {
				//数据处理
				var d = JSON.parse(r);
				creatDom_lczz(d,"jh");//创建项目意见DOM
			}else{
				alert("提示-取流程追踪-机会：返回数据格式错误！");
			}
		},
		error : function() {
			alert("提示-取流程追踪-机会：取数据出错！");
		}
	});
}
//取项目详情数据--项目
function getObjDataXm(){
	var _data = {};
	_data.code = '1116';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidXm,mm.Punit,mm.UserEncode,mm.Oname]);// param1:项目id,开发单位名称,人员编码,人员所属机构
	_data.where = JSON.stringify([mm.pidXm,mm.Punit,mm.UserEncode,mm.Oname]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="" && r!="[]") {
				//数据处理
				var d = JSON.parse(r);
				mm.objInfoXm = d[0];//项目详情
				setDataToDivXm(d[0]);//将数据放入容器
			}else{
				alert("提示-取项目数据-项目：返回数据格式错误！");
			}
		},async:false,
		error : function() {
			alert("提示-取项目数据-项目：取数据出错！");
		}
	});
}
//取项目意见---项目
function getObjYjXm(){
	var _data = {};
	_data.code = '1126';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidXm,mm.Oname]);// param1:项目id,登录人单位
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="") {
				//数据处理
				var d = JSON.parse(r);
				creatDom_xmyj(d,'xm');//创建项目意见DOM
			}else{
				alert("提示-取项目意见-项目：返回数据格式错误！");
			}
		},
		error : function() {
			alert("提示-取项目意见-项目：取数据出错！");
		}
	});
}
//取流程追踪---项目
function getObjLcXm(){
	var _data = {};
	_data.code = '1127';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidXm]);// param1:项目id,开发单位名称
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="") {
				//数据处理
				var d = JSON.parse(r);
				creatDom_lczz(d,"xm");//创建项目意见DOM
			}else{
				alert("提示-取流程追踪-项目：返回数据格式错误！");
			}
		},
		error : function() {
			alert("提示-取流程追踪-项目：取数据出错！");
		}
	});
}

//取项目详情数据--招商
function getObjDataZs(){
	getBmdwList();//取招报名单位
	var _data = {};
	_data.code = '1175';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidZs,mm.Punit,mm.UserEncode,mm.Oname]);// param1[zsid,开发单位,rybm,本单位]
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="" && r!="[]") {
				var d = JSON.parse(r)[0];
				mm.objInfoZs = d;
				setDataToDivZs(d);//放置数据到页面
			}else{
				alert("提示-取项目数据-招商：返回数据格式错误！");
			}
		},async:false,
		error : function() {
			alert("提示-取项目数据-招商：取数据出错！");
		}
	});
}
//获取报名单位列表--招商
function getBmdwList(){
	var _data = {};
	_data.code = '1153';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidZs]);// param1[zsid]
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="") {//数据处理
				var d = JSON.parse(r);
				var h = '';
				$.each(d, function(i,v) {
					if(i==0){
						h += '<tr><th>资格审查</th><th>招商结果</th><th>单位名称</th><th>联系人</th><th>联系电话</th><th>报价(万元)</th></tr>';
					}
					var shzt = "未审";//审核状态  0-未资格审查	1-通过	2-未通过
					var shCls = "";//审核class
					if(v.SHZT=="1"){
						shzt = "通过";
						shCls = "pass";
					}else if(v.SHZT=="2"){
						shzt = "未通过";
						shCls = "unpass";
					}
					var zbbz = "";//最终中商标志  1-中商	
					var zbCls = "";//中商class
					if(v.ZZZBBZ=="1"){
						zbbz = "已中商";
						zbCls = "active";
					}
					h += '<tr class="row"><td class="td-rz '+shCls+'">'+shzt+'</td><td class="td-bx '+zbCls+'">'+zbbz+'</td><td class="dwmc">'+v.ZHM+'</td><td>'+v.LXR+'</td><td>'+v.LXDH+'</td><td class="td-bj">'+v.BMJG+'</td></tr>';
				});
				$("#bmdwList_zs").html(h);
			}else{
				alert("提示-获取报名单位列表：返回数据格式错误！");
			}
		},
		error : function() {
			alert("提示-获取报名单位列表：取数据出错！");
		}
	});
}
//取项目意见--招商
function getObjYjZs(){
	var _data = {};
	_data.code = '1126';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidZs,mm.Oname]);// param1:项目id,登录人单位
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="") {
				//数据处理
				var d = JSON.parse(r);
				creatDom_xmyj(d,'zs');//创建项目意见DOM
			}else{
				alert("提示-取项目意见-招商：返回数据格式错误！");
			}
		},
		error : function() {
			alert("提示-取项目意见-招商：取数据出错！");
		}
	});
}
//取流程追踪--招商
function getObjLcZs(){
	var _data = {};
	_data.code = '1127';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidZs]);// param1:项目id,开发单位名称
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="") {
				//数据处理
				var d = JSON.parse(r);
				creatDom_lczz(d,'zs');//创建项目意见DOM
			}else{
				alert("提示-取流程追踪-招商：返回数据格式错误！");
			}
		},
		error : function() {
			alert("提示-取流程追踪-招商：取数据出错！");
		}
	});
}
//取在营数据
function getObjDataZy(){
	var _data = {};
	_data.code = '1245';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([mm.pidZy]);// param1
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="" && r!="[]") {
				//数据处理
				var d = JSON.parse(r)[0];
				setDataToDivZy(d);//放置数据到页面
				if(d.JHID!=""){
					mm.pidJh = d.JHID;
					getObjDataJh();//取机会数据
				}else{
					$("#myaa").accordion("remove","机会研究审批表");
				}
				if(d.SPID!=""){
					mm.pidXm = d.SPID;
					getObjDataXm();//取项目数据
				}else{
					$("#myaa").accordion("remove","项目开发审批表");
				}
				if(d.ZSID!=""){
					mm.pidZs = d.ZSID;
					getObjDataZs();//取招商数据
				}else{
					$("#myaa").accordion("remove","对外招商审批表");
				}
			}else{
				alert("提示-取在营数据：返回数据格式错误！");
			}
		},
		error : function() {
			alert("提示-取在营数据：取数据出错！");
		}
	});
}
//取在营数据---收款记录
function getSkjl(){
	var _data = {};
	_data.code = '1036';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([]);// param1
	_data.where = JSON.stringify([mm.pidZy]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="" && r!="[]") {
				//数据处理
				var d = JSON.parse(r);
				var dom = '';
				dom += '<tr><th>应收款时间</th><th>应收款金额</th><th>实收款时间</th><th>实收款金额</th><th>收款录入人</th></tr>';
				$.each(d, function(i,v) {
					dom += '<tr><td>'+v.YSKSJ+'</td><td>'+v.YSKJE+'</td><td>'+v.YJSKSJ+'</td><td>'+(v.YJSKJE=="0"?"":v.YJSKJE)+'</td><td>'+(v.YJSKSJ==""?"":v.SKLRR)+'</td></tr>';
				});
				$("#skjl_zy").html(dom);//收款记录
			}
		},
		error : function() {
			alert("提示-取在营数据：取数据出错！");
		}
	});
}
//获取字典------开发资源列表
function getDic_source(){
	var unitName = mm.Oname;
	if(typeof(mm.Punit)!="undefined" && mm.Punit!=""){//有项目申请单位
		unitName = mm.Punit;
	}
	var _data = {};
	_data.code = '1064';
	_data.login = JSON.stringify(mm.login);
	_data.sql = JSON.stringify([unitName]);//([mm.Oname]);// param1[unit_name]//绵阳工务段
	_data.where = JSON.stringify([]);// param2
	_data.order = JSON.stringify([]);// param3
	$.ajax({
		type : "post",
		url : mm.url,
		data : _data,
		success : function(r) {
			if (r!="") {
				//数据处理
				var d = JSON.parse(r);
				mm.source = [];
				var dgD = [];
				$.each(d, function(i,v) {
					var one = JSON.parse(v.ZC_JSON);
					one.ZC_TYPE = v.ZC_TYPE;
					one.ZC_ID = v.ZC_ID;
					if(v.ZC_GXBM=="AssOfficialVehi"){//小汽车
						one.assno = one.gzbh;//固资编号
						one.assname = one.qcmc;//名称
						one.manadept = one.gzdw;//单位
					}
					mm.source.push(one);
				});
				$("#dgSource").datagrid("loadData",dgD);
			}else{
				alert("提示-开发资源列表：返回数据格式错误！");
			}
		},async:false,
		error : function() {
			alert("提示-开发资源列表：取数据出错！");
		}
	});
}