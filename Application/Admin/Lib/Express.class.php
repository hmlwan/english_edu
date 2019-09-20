<?php

/**
 * Description  :  ���������Ϣ��ѯ�ӿ�SDK
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
     * ����õĿ�����ӿڲ�ѯKEY��
     * @param string $key
     */
    public function KuaidiAPi($key){
        $this->_APPKEY = $key;
    }

    /**
     * �������ݷ������͡�0: ���� json �ַ���; 1:���� xml ����
     * @param int|number $show
     */
    public function setShow($show = 0){
        $this->_show = $show;
    }

    /**���÷���������Ϣ��Ŀ��, 0:���ض�����������Ϣ; 1:ֻ����һ����Ϣ
     * @param int $muti
     */
    public function setMuti($muti = 0){
        $this->_muti = $muti;
    }

    /**
     * ���÷���������Ϣ����desc:��ʱ�����µ�������; asc:��ʱ���ɾɵ�������
     * @param string $order
     */
    public function setOrder($order = 'desc'){
        $this->_order = $order;
    }

    /**
     * ��ѯ������Ϣ�����뵥�ţ�
     * @param �������� $nu
     * @param string|��˾���� $com Ҫ��ѯ�Ŀ�ݹ�˾����,��֧������,������ο���ݹ�˾�����ĵ��� ����Ĭ�ϸ��ݵ����Զ�ƥ�乫˾��ע:����ƥ��ɹ��ʸ��� 95%��
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
     * curl ��ѯ
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
     * ��ȡ������˾����
     */
    private function getCompanyNo(){
        $res = array(
            array('company_no'=>'aae','company_name'=>'AAE���'),
            array('company_no'=>'aramex','company_name'=>'Aramex���'),
            array('company_no'=>'bht','company_name'=>'BHT���'),
            array('company_no'=>'youzhengguonei','company_name'=>'����/ƽ��/�Һ���'),
            array('company_no'=>'baifudongfang','company_name'=>'�ٸ���������'),
            array('company_no'=>'huitongkuaidi','company_name'=>'������ͨ���'),
            array('company_no'=>'coe','company_name'=>'COE��������ݣ�'),
            array('company_no'=>'city100','company_name'=>'����100'),
            array('company_no'=>'disifang','company_name'=>'���ķ�'),
            array('company_no'=>'shunfeng','company_name'=>'˳������'),
            array('company_no'=>'shentong','company_name'=>'��ͨ���'),
            array('company_no'=>'rufengda','company_name'=>'������'),
            array('company_no'=>'yuantong','company_name'=>'Բͨ�ٵ�'),
            array('company_no'=>'yunda','company_name'=>'�ϴ����'),
            array('company_no'=>'zhongtong','company_name'=>'��ͨ���'),
            array('company_no'=>'zhaijisong','company_name'=>'լ����'),
        );
        return $res;
    }

}