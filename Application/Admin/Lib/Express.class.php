<?php

/**
 * Description  :  快递物流信息查询接口SDK
 * Author       : aluo <aluo108@163.com>
 * Date         : 2016/8/3
 * Time         : 16:11
 */
class Express
{
    private $_APPKEY = '';

    /**
     * @var string
     */
    private $_APIURL = "http://highapi.kuaidi.com/openapi-querycountordernumber.html?";

    private $_show = 0;

    private $_muti = 0;

    /**
     * @var string
     */
    private $_order = 'desc';

    /**
     * 您获得的快递网接口查询KEY。
     * @param string $key
     */
    public function KuaidiAPi($key){
        $this->_APPKEY = $key;
    }

    /**
     * 设置数据返回类型。0: 返回 json 字符串; 1:返回 xml 对象
     * @param int|number $show
     */
    public function setShow($show = 0){
        $this->_show = $show;
    }

    /**设置返回物流信息条目数, 0:返回多行完整的信息; 1:只返回一行信息
     * @param int $muti
     */
    public function setMuti($muti = 0){
        $this->_muti = $muti;
    }

    /**
     * 设置返回物流信息排序。desc:按时间由新到旧排列; asc:按时间由旧到新排列
     * @param string $order
     */
    public function setOrder($order = 'desc'){
        $this->_order = $order;
    }

    /**
     * 查询物流信息，传入单号，
     * @param 物流单号 $nu
     * @param string|公司简码 $com 要查询的快递公司代码,不支持中文,具体请参考快递公司代码文档。 不填默认根据单号自动匹配公司。注:单号匹配成功率高于 95%。
     * @return array
     * @throws Exception
     */
    public function query($nu, $com=''){

        if (function_exists('curl_init') == 1) {

            $url = $this->_APIURL;
            $dataArr = array(
                'id' => $this->_APPKEY,
                'com' => $com,
                'nu' => $nu,
                'show' => $this->_show,
                'muti' => $this->_muti,
                'order' => $this->_order
            );

            foreach ($dataArr as $key => $value) {
                $url .= $key . '=' . $value . "&";
            }

            // echo $url;
            $express_result = $this->curl($url);

            if($this->_show == 0){
                $result = json_decode($express_result, true);
            }else{
                $result = $express_result;
            }

            return $result;

        }else{
            throw new Exception("Please install curl plugin", 1);
        }
    }
    /**
     * curl 查询
     */
    private function curl($url){

        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_TIMEOUT, 10);
        $result = curl_exec($curl);
        curl_close($curl);

        return $result;
    }
    /**
     * 获取物流公司简码
     */
    private function getCompanyNo(){
        $res = array(
            array('company_no'=>'aae','company_name'=>'AAE快递'),
            array('company_no'=>'aramex','company_name'=>'Aramex快递'),
            array('company_no'=>'bht','company_name'=>'BHT快递'),
            array('company_no'=>'youzhengguonei','company_name'=>'包裹/平邮/挂号信'),
            array('company_no'=>'baifudongfang','company_name'=>'百福东方物流'),
            array('company_no'=>'huitongkuaidi','company_name'=>'百世汇通快递'),
            array('company_no'=>'coe','company_name'=>'COE（东方快递）'),
            array('company_no'=>'city100','company_name'=>'城市100'),
            array('company_no'=>'disifang','company_name'=>'递四方'),
            array('company_no'=>'shunfeng','company_name'=>'顺丰速运'),
            array('company_no'=>'shentong','company_name'=>'申通快递'),
            array('company_no'=>'rufengda','company_name'=>'如风达快递'),
            array('company_no'=>'yuantong','company_name'=>'圆通速递'),
            array('company_no'=>'yunda','company_name'=>'韵达快运'),
            array('company_no'=>'zhongtong','company_name'=>'中通快递'),
            array('company_no'=>'zhaijisong','company_name'=>'宅急送'),
        );
        return $res;
    }

}