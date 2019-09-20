<?php
/**
 * @param $code
 * @param string $id
 * @return bool
 *
 */
function fn_array_column(array $array, $columnKey, $indexKey = null){
    if (!function_exists('array_column'))
    {
        $result = array();
        foreach ($array as $subArray) {
            if (!is_array($subArray)) {
                continue;
            } elseif (is_null($indexKey) && array_key_exists($columnKey, $subArray)) {
                $result[] = $subArray[$columnKey];
            } elseif (array_key_exists($indexKey, $subArray)) {
                if (is_null($columnKey)) {
                    $result[$subArray[$indexKey]] = $subArray;
                } elseif (array_key_exists($columnKey, $subArray)) {
                    $result[$subArray[$indexKey]] = $subArray[$columnKey];
                }
            }
        }

    }else{
        $result = array_column($array, $columnKey, $indexKey = null);
    }

    return $result;

}
function check_verify($code, $id = ''){
	$verify = new \Think\Verify();
	return $verify->check($code, $id);
}
/**
 * 
 * @param unknown $val
 * @param unknown $filed_str
 * @return boolean|string
 */
function fn_getCheckbox($val,$filed_str){
    

    if(!$filed_str){
        return false;
    }
    
    $filed_arr = explode(',', $filed_str);

    $val_res = unserialize($val);
    
    $res_str='';
    if($val_res){
        
        foreach ($val_res as $val_val){
            return $filed_arr[0];
            $res_str.=$filed_arr[$val_val];
        }
//         return 
    }
    return $res_str;
    
}
/**
 * 获取当前地址
 */
function fn_getUrl($vars=array()){
    $url = $_SERVER['PHP_SELF'].'?'.$_SERVER['QUERY_STRING'];
    if($vars){
        $str = '';
        foreach ($vars as $key=>$val){
            $str.=$key."=".$val.'&';
        }
        $str = rtrim($str,'&');
        
        if(strstr($url, "?")){
            $url = rtrim($url,'&').'&'.$str;
        }else{
            $url = $url.'?'.$str;
        }
    }
    
    return $url;
}
/**
 * 截取字符串，支持中文
 *
 * @param        $str
 * @param        $max_length
 * @param string $suffix
 *
 * @return string
 */
function fn_msubstr($str, $start=0, $length=10, $charset="utf-8", $suffix='...')
{
    if(function_exists("mb_substr"))
        return mb_substr($str, $start, $length, $charset).$suffix;
    elseif(function_exists('iconv_substr')) {
        return iconv_substr($str,$start,$length,$charset).$suffix;
    }
    $re['utf-8']   = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xff][\x80-\xbf]{3}/";
    $re['gb2312'] = "/[\x01-\x7f]|[\xb0-\xf7][\xa0-\xfe]/";
    $re['gbk']    = "/[\x01-\x7f]|[\x81-\xfe][\x40-\xfe]/";
    $re['big5']   = "/[\x01-\x7f]|[\x81-\xfe]([\x40-\x7e]|\xa1-\xfe])/";
    preg_match_all($re[$charset], $str, $match);
    $slice = join("",array_slice($match[0], $start, $length));
   	return $slice.$suffix;die;
    return $slice;
}
/**
 * 取验证码hash值
 *
 * @param
 * @return string 字符串类型的返回结果
 */
function getHash(){
    return substr(md5(__SELF__),0,8);
}

/*生成哈希链接*/
function U_hash($link){
	return U($link,array('nchash'=>getHash()));
}

function random($length, $numeric = 0) {
	$seed = base_convert(md5(microtime().$_SERVER['DOCUMENT_ROOT']), 16, $numeric ? 10 : 35);
	$seed = $numeric ? (str_replace('0', '', $seed).'012340567890') : ($seed.'zZ'.strtoupper($seed));
	$hash = '';
	$max = strlen($seed) - 1;
	for($i = 0; $i < $length; $i++) {
		$hash .= $seed{mt_rand(0, $max)};
	}
	return $hash;
}

function makeSeccode($nchash){
	$seccode = random(6, 1);
	$seccodeunits = '';

	$s = sprintf('%04s', base_convert($seccode, 10, 23));
	$seccodeunits = 'ABCEFGHJKMPRTVXY2346789';
	if($seccodeunits) {
		$seccode = '';
		for($i = 0; $i < 4; $i++) {
			$unit = ord($s{$i});
			$seccode .= ($unit >= 0x30 && $unit <= 0x39) ? $seccodeunits[$unit - 0x30] : $seccodeunits[$unit - 0x57];
		}
	}
	session('seccode',$nchash);
	//cookie('seccode'.$nchash, encrypt(strtoupper($seccode)."\t".(time())."\t".$nchash,MD5_KEY),3600);
	return $seccode;
}

/**
 * 加密函数
 *
 * @param string $txt 需要加密的字符串
 * @param string $key 密钥
 * @return string 返回加密结果
 */
function encrypt($txt, $key = ''){
	if (empty($txt)) return $txt;
	if (empty($key)) $key = md5(MD5_KEY);
	$chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.";
	$ikey ="-x6g6ZWm2G9g_vr0Bo.pOq3kRIxsZ6rm";
	$nh1 = rand(0,64);
	$nh2 = rand(0,64);
	$nh3 = rand(0,64);
	$ch1 = $chars{$nh1};
	$ch2 = $chars{$nh2};
	$ch3 = $chars{$nh3};
	$nhnum = $nh1 + $nh2 + $nh3;
	$knum = 0;$i = 0;
	while(isset($key{$i})) $knum +=ord($key{$i++});
	$mdKey = substr(md5(md5(md5($key.$ch1).$ch2.$ikey).$ch3),$nhnum%8,$knum%8 + 16);
	$txt = base64_encode(time().'_'.$txt);
	$txt = str_replace(array('+','/','='),array('-','_','.'),$txt);
	$tmp = '';
	$j=0;$k = 0;
	$tlen = strlen($txt);
	$klen = strlen($mdKey);
	for ($i=0; $i<$tlen; $i++) {
		$k = $k == $klen ? 0 : $k;
		$j = ($nhnum+strpos($chars,$txt{$i})+ord($mdKey{$k++}))%64;
		$tmp .= $chars{$j};
	}
	$tmplen = strlen($tmp);
	$tmp = substr_replace($tmp,$ch3,$nh2 % ++$tmplen,0);
	$tmp = substr_replace($tmp,$ch2,$nh1 % ++$tmplen,0);
	$tmp = substr_replace($tmp,$ch1,$knum % ++$tmplen,0);
	return $tmp;
}

/**
 * 解密函数
 *
 * @param string $txt 需要解密的字符串
 * @param string $key 密匙
 * @return string 字符串类型的返回结果
 */
function decrypt($txt, $key = '', $ttl = 0){
	if (empty($txt)) return $txt;
	if (empty($key)) $key = md5(MD5_KEY);

	$chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.";
	$ikey ="-x6g6ZWm2G9g_vr0Bo.pOq3kRIxsZ6rm";
	$knum = 0;$i = 0;
	$tlen = @strlen($txt);
	while(isset($key{$i})) $knum +=ord($key{$i++});
	$ch1 = @$txt{$knum % $tlen};
	$nh1 = strpos($chars,$ch1);
	$txt = @substr_replace($txt,'',$knum % $tlen--,1);
	$ch2 = @$txt{$nh1 % $tlen};
	$nh2 = @strpos($chars,$ch2);
	$txt = @substr_replace($txt,'',$nh1 % $tlen--,1);
	$ch3 = @$txt{$nh2 % $tlen};
	$nh3 = @strpos($chars,$ch3);
	$txt = @substr_replace($txt,'',$nh2 % $tlen--,1);
	$nhnum = $nh1 + $nh2 + $nh3;
	$mdKey = substr(md5(md5(md5($key.$ch1).$ch2.$ikey).$ch3),$nhnum % 8,$knum % 8 + 16);
	$tmp = '';
	$j=0; $k = 0;
	$tlen = @strlen($txt);
	$klen = @strlen($mdKey);
	for ($i=0; $i<$tlen; $i++) {
		$k = $k == $klen ? 0 : $k;
		$j = strpos($chars,$txt{$i})-$nhnum - ord($mdKey{$k++});
		while ($j<0) $j+=64;
		$tmp .= $chars{$j};
	}
	$tmp = str_replace(array('-','_','.'),array('+','/','='),$tmp);
	$tmp = trim(base64_decode($tmp));

	if (preg_match("/\d{10}_/s",substr($tmp,0,11))){
		if ($ttl > 0 && (time() - substr($tmp,0,11) > $ttl)){
			$tmp = null;
		}else{
			$tmp = substr($tmp,11);
		}
	}
	return $tmp;
}

//文章列表xml
function news_xml_encode($data, $root='rows', $item='item', $attr='', $id='id', $encoding='utf-8'){
    if(is_array($attr)){
        $_attr = array();
        foreach ($attr as $key => $value) {
            $_attr[] = "{$key}=\"{$value}\"";
        }
        $attr = implode(' ', $_attr);
    }
    $attr   = trim($attr);
    $attr   = empty($attr) ? '' : " {$attr}";
    $xml    = "<?xml version=\"1.0\" encoding=\"{$encoding}\"?>";
    $xml   .= "<{$root}{$attr}>";
    $xml   .= "<page>".$data['page']."</page>";
	$xml   .= "<total>".$data['total']."</total>";
	foreach($data['data'] as $v){
		$xml.= "<row id='".$v['id']."'>"; 
		$xml.= "<cell><![CDATA[<a class='btn blue' href='".U('news/edit',array('id'=>$v['id']))."'><i class='fa fa-pencil-square-o'></i>编辑</a><a class='btn red' href='javascript:void(0);' onclick='fg_del(".$v['id'].");'><i class='fa fa-trash-o'></i>删除</a>]]></cell>";
		$xml.= "<cell>".$v['sort']."</cell>";
		$xml.= "<cell>".$v['title']."</cell>";
		$xml.= "<cell><![CDATA[<a href='javascript:void(0);' class='pic-thumb-tip' onMouseOut='toolTip()' onMouseOver='toolTip(\"<img src=".$v['pic'].">\")'><i class='fa fa-picture-o'></i></a>]]></cell>";
		$xml.= "<cell>".count($v['attachment'])."</cell>";
		$xml.= "<cell>".$v['category']['cat_name']."</cell>";	
		$xml.= "<cell>".$v['view_times']."</cell>";
		if($v['status']){
			$xml.= "<cell><![CDATA[<span class='yes'><i class='fa fa-check-circle'></i>显示</span>]]></cell>";
		}else{
			$xml.= "<cell><![CDATA[<span class='no'><i class='fa fa-ban'></i>隐藏</span>]]></cell>";
		}
		$xml.= "<cell>".$v['source']."</cell>";
		$xml.= "<cell>".date('Y-m-d H:i:s',$v['update_time'])."</cell>";
		$xml.= "</row>";
	}
    $xml   .= "</{$root}>";
    return $xml;
}
//xml
function list_xml_encode($data, $root='rows', $item='item', $attr='', $id='id', $encoding='utf-8'){
    if(is_array($attr)){
        $_attr = array();
        foreach ($attr as $key => $value) {
            $_attr[] = "{$key}=\"{$value}\"";
        }
        $attr = implode(' ', $_attr);
    }
    $attr   = trim($attr);
    $attr   = empty($attr) ? '' : " {$attr}";
    $xml    = "<?xml version=\"1.0\" encoding=\"{$encoding}\"?>";
    $xml   .= "<{$root}{$attr}>";
    $xml   .= "<page>".$data['page']."</page>";
    $xml   .= "<total>".$data['total']."</total>";
    foreach($data['data'] as $key=>$v){
        
        $xml.= "<row id='".$v['id']."'>";     
        $xml.= "<cell><![CDATA[<a class='btn blue' href='".U(CONTROLLER_NAME.'/edit',array('id'=>$v['id']))."'><i class='fa fa-pencil-square-o'></i>编辑</a><a class='btn red' href='javascript:void(0);' onclick='fg_del(".$v['id'].");'><i class='fa fa-trash-o'></i>删除</a>]]></cell>";
        foreach ($data['fields'] as $field){
            $f = explode('|', $field);
            if(count($f)>1){
                $show_fun = $f;
                array_shift($show_fun);
                $fun_xml = show_fun($show_fun,$v[$f[0]]);
                $xml.= $fun_xml;
            }else{
                $xml.= "<cell>".$v[$f[0]]."</cell>";
            }
               
        }
   
        $xml.= "</row>";
    }
    $xml   .= "</{$root}>";
    return $xml;
}
//递归获取数据
function show_fun($fun,$val){
    if($fun && isset($fun[0])&&$fun[0]){
        $res = array();
        $v = $fun[0]($val);
        array_shift($fun);
        $res = $v;
        if(show_fun($fun,$v)){
            $res = show_fun($fun,$v);
        }
        return $res;
    }
}
function show_test($val){
    $v = $val[0];
    $v+=10;
    
    return $v;
}
function show_status($status,$id){
    $s_status = $status>0?0:1;
    $xml = '';
    if($status){
        $xml.= "<cell><![CDATA[<span class='yes' onclick='fg_status(this)'><i class='fa fa-check-circle'></i>显示</span>]]></cell>";
    }else{
        $xml.= "<cell><![CDATA[<span class='no' onclick='fg_status(this)'><i class='fa fa-ban'></i>隐藏</span>]]></cell>";
    }
    return $xml;
}
function show_img($img){
    $xml = '';
    $xml.= "<cell><![CDATA[<a href='javascript:void(0);' class='pic-thumb-tip' onMouseOut='toolTip()' onMouseOver='toolTip(\"<img src=".$img.">\")'><i class='fa fa-picture-o'></i></a>]]></cell>";
    return $xml;
}
/**
 * 获取排序后的分类
 * @param  [type]  $data  [description]
 * @param  integer $pid   [description]
 * @param  string  $html  [description]
 * @param  integer $level [description]
 * @return [type]         [description]
 */
function getSortedCategory($data,$pid=0,$html="|---",$level=0)
{
    if (!$data){
        return false;
    }
    $temp = array();
    foreach ($data as $k => $v) {
        if($v['pid'] == $pid){

            $str = str_repeat($html, $level);
            $v['html'] = $str;
            $temp[] = $v;

            $temp = array_merge($temp,getSortedCategory($data,$v['id'],'|---',$level+1));
        }

    }
    return $temp;
}
/**
 * 调试输出数据
 */
function dd($data=''){
    echo '<pre>';
    print_r($data);
    echo "</pre>";
    die;
}
//上传文件
function upload_file($savepath,$field){
	$upload = new \Think\Upload(C('UPLOAD_CONFIG'));

	$upload->savePath = $savepath;

	$upload_info = $upload->upload();

	if(!$upload_info) { 
		return $upload->getError();
	}else{

		$file_path = './Uploads'.ltrim($upload_info[$field]['savepath'],'.').$upload_info[$field]['savename'];

		$upload_info[$field]['file_path'] = $file_path;
		return $upload_info[$field];
	}
}

/**
 * 显示图片
 */
function showImg($path){
    $res = C('IMG_HTTP').$path;
    return $res;
}

/**
 * 生成二维码
 *  使用方法 $img_src = qr_code(); echo "<img src='".$img_src."'/>";
 * @param $data
 * @param string $url
 * @return string
 */
function qr_code($data=array(), $url='room.wearmaker.cn?a=2&b=c')
{
    $config_data = array(
        'bg'    => 'fff',//背景颜色
        'fg'    => '87CEFA',//前景颜色
        'gc'    => 'cc00000',//渐变颜色
        'el'    => 'h',//纠错等级	el可用值：h\q\m\l，例如：el=h
        'w'     => '300',//尺寸大小	w=数值（像素），例如：w=300
        'm'     => '30',//静区（外边距）	m=数值（像素），例如：m=30
        'pt'    => '00ff00',//定位点颜色（外框）	pt=颜色代码，例如：pt=00ff00
        'inpt'  => '000000',//定位点颜色（内点）	inpt=颜色代码，例如：inpt=000000
        'logo'  => 'http://wearmaker.cn/img/logo.png',//logo图片	logo=图片地址
    );

    $data = array_merge($data,$config_data);
    $query = 'http://'.urlencode($url).'&'.http_build_query($data);

    $result = "http://qr.liantu.com/api.php?text=".$query;
    return $result;
}

/**
 * 当前地址
 */

function funcurl(){
    return 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
}
/**
 *  id 用名称显示
 */
function funcusername($model,$ids,$field){
    $data = $model->where(array('id'=>array('in',implode(',',array_unique($ids)))))->field('id,'.$field)->select();

    $data_str = array();
    foreach($data as $data_key=>$data_item){
        $data_str[$data_item['id']] = $data_item[$field];

    }
    return $data_str;
}

/**
 * 提取id为数值
 */
function funcIdArr($arr,$field){
    $idArr = [];
    foreach ($arr as $key=>$item){
        $idArr[] = $item[$field];
    }
    return $idArr;
}
/**
 * 订单状态
 */
function funcOrderState($state){
    switch($state){
        case 1:   //待付款
            $condition = array(
                'pay_status'=>0,
                'order_status'=>0,
                'handle_status'=>0
            );
            break;
        case 2: //待发货
            $condition = array(
                'pay_status'=>1,
                'order_status'=>0,
                'handle_status'=>0
            );
            break;
        case 3:  //待收货
            $condition = array(
                'pay_status'=>1,
                'order_status'=>0,
                'handle_status'=>1
            );
            break;
        case 4:  //待评价
            $condition = array(
                'pay_status'=>1,
                'order_status'=>0,
                'handle_status'=>2
            );
            break;
        case 5 : //已评价
            $condition = array(
                'pay_status'=>1,
                'order_status'=>1,
                'handle_status'=>3

            );
            break;
    }
       return  $condition;
}

/**
 * @param $data
 * @return mixed  订单状态编号
 */
function funcOrderStatsNum($data){
    foreach($data as $data_key=>$data_item) {
        if ($data_item['pay_status'] == 0 && $data_item['order_status'] == 0 && $data_item['handle_status'] == 0) {
            $data[$data_key]['status'] = 1; //待付款
        } elseif ($data_item['pay_status'] == 1 && $data_item['order_status'] == 0 && $data_item['handle_status'] == 0) {
            $data[$data_key]['status'] = 2; //已付款，待发货

        } elseif ($data_item['pay_status'] == 1 && $data_item['order_status'] == 0 && $data_item['handle_status'] == 1) {
            $data[$data_key]['status'] = 5; //已发货，待收货

        } elseif ($data_item['pay_status'] == 1 && $data_item['order_status'] == 0 && $data_item['handle_status'] == 2) {
            $data[$data_key]['status'] = 6; //已收货，待评价

        } elseif ($data_item['pay_status'] == 1 && $data_item['order_status'] == 1 && $data_item['handle_status'] == 3) {
            $data[$data_key]['status'] = 7; //已评价,完成
        }else{
            $data[$data_key]['status'] = 0; //订单失效/删除
        }
    }
    return $data;
}
/**
 * 切割以'|'分割的数值
 */
function funcStr($arr){
    $str = array();
    foreach ($arr as $key=>$item){
        $data = explode('|',$item);
        $str[$key]['attr_id'] = $data[0] ;
        $str[$key]['attr_name'] =  $data[1];
    }
    return $str;
}

/**
 * 根据生日计算年龄
 */
function funcAge($birth){

    list($y1,$m1,$d1) = explode('-',date('Y-m-d',$birth));
    list($y2,$m2,$d2) = explode('-',date('Y-m-d',time()));
    $age = $y2-$y1;
    if(intval($m1.$d1)>intval($m2.$d2)){
        $age -= 1;
    }
    return $age;
}

/**
 * 数据导出excel
 */
function funcOutgetExcel($res){
    Vendor('PHPExcel.PHPExcel');
    $objPHPExcel = new \PHPExcel();
    $objWriter = new \PHPExcel_Writer_Excel5($objPHPExcel);
    $letter = array('A','B','C','D','E','F','G','H','I','J');
    $header = array('编号','奖项名称','获奖日期','获奖人姓名','奖项级别','获奖形式','所属部门','颁奖单位','负责教师');
//    $order_arr = array(0=>'订单失效/删除',1=>'待付款',2=>'已付款',5=>'已发货',6=>'待评价',7=>'已完成');

    $objPHPExcel->getProperties()->setCreator('hmlwan');
    $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
    $objPHPExcel->getActiveSheet()->setTitle('AwardData');
    foreach ($header as $header_key=>$header_item){
        $objPHPExcel->getActiveSheet()->setCellValue($letter[$header_key].'1',$header[$header_key]);
//                $objPHPExcel->getActiveSheet()->getColumnDimension($letter[$header_key])->setAutoSize(true);
        $objPHPExcel->getActiveSheet()->getColumnDimension($letter[$header_key+1])->setWidth(20);
    }
    foreach($res as $key => $value){
        $i = $key + 2;
        $objPHPExcel->getActiveSheet()->setCellValue('A'.$i,  $value['id']);//这里是设置A1单元格的内容
        $objPHPExcel->getActiveSheet()->setCellValue('B'.$i,  $value['award_name']);////这里是设置B2单元格的内容
        $objPHPExcel->getActiveSheet()->setCellValue('C'.$i,  $value['_award_time']);////这里是设置C2单元格的内容
        $objPHPExcel->getActiveSheet()->setCellValue('D'.$i,  $value['username']);////这里是设置D2单元格的内容
        $objPHPExcel->getActiveSheet()->setCellValue('E'.$i,  $value['_award_rank']);////这里是设置E2单元格的内容
        $objPHPExcel->getActiveSheet()->setCellValue('F'.$i,  $value['_award_form']);////这里是设置F2单元格的内容
        $objPHPExcel->getActiveSheet()->setCellValue('G'.$i,  $value['_department']);////这里是设置G2单元格的内容
        $objPHPExcel->getActiveSheet()->setCellValue('H'.$i,  $value['unit']);////这里是设置H2单元格的内容
        $objPHPExcel->getActiveSheet()->setCellValue('I'.$i,  $value['teacher_charge']);////这里是设置I2单元格的内容

    }
    header("Pragma: public");
    header("Expires: 0");
    header("Cache-Control:must-revalidate, post-check=0, pre-check=0");
    header("Content-Type:application/force-download");
    header("Content-Type:application/vnd.ms-execl");
    header("Content-Type:application/octet-stream");
    header("Content-Type:application/download");;
    header('Content-Disposition:attachment;filename=获奖数据.xls');
    header("Content-Transfer-Encoding:binary");
    $objWriter->save('文件名称.xls');
    $objWriter->save('php://output');
    return ;
}






























