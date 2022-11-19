var express = require('express');
var router = express.Router();
const tableName = 'shop_order'
const { Success, MError } = require("../utils/Result");
const Db = require("../utils/Db");
moment = require('moment')//引入处理时间模块


// 引入支付模块
const AlipaySdk = require('alipay-sdk').default
const AlipayFormData = require('alipay-sdk/lib/form').default


//支付宝支付返回form表单
router.post("/alipay", async (req, res) => {
	// 获取支付基本参数  子订单交易号 总支付金额
	let {outTradeNo,totalAmount,type} = req['body'];
	
	// 验证基本参数
	if (!outTradeNo || totalAmount < 0 || (type !=1 && type !=2 )) {
	    res.send(MError("缺少支付参数"));return;
	}
	// 初始化插件
	const alipaySdk = new AlipaySdk({
	  appId: '2021000116695752',//此处使用的是沙箱环境
	  gateway: 'https://openapi.alipaydev.com/gateway.do',
	  signType: 'RSA2', // 注意这里默认是RSA2， 正常不要配置
	  privateKey:'MIIEpAIBAAKCAQEAz7wEU7CrliipSM3MQ4JsSknVXsLxdzqMoEY7XgD0gvWDgmvk23X1/XQs8I9pHflCsyIkyBhow4qTeP6VM4ONqZJHOsJShFfCfWrz/lY4YuvF1Zkg7br2Nj6Y/LUebJFJYoqS/a+XnOnlKr3wQY3pyuJI3V3iTZqUo3swV8K57iVPZomGRa8EI0OHE+ApBXCgJ7O+JAo54WbXjrhpAMHqnPvjDV/NAYAxcav2lULaUMXES1lA4ErD/qfpIlNXCNmLKOz3gWXW/aUcDVWepi5SseZlt3JPUPwVzwrlVadV6tKue8/6EkUqBKHPH28BtmY8TaOvK1YjW+n1pdL+plgvKQIDAQABAoIBAAvonmLh1ORVzmaTDautFWIo22eES21nWNpzTEH2Ug4T3wciAkumdoSiHVVpE0CZon48bdletNrI3e1owsriNsPK0/SFYU+e7FJeSECDVtYs5/l3vtCCEE1Jx2FtTKIyrf9NLGIIp+th6TZLDzPi2806rayrDicevnikvj+5tQj21gSlwb5UnRVndT6awxty7B4Z7yOigYNNnE6Jq8MtdIABVceRAQ6OY/ajN0Sz43cq+ItMWMMSLx5Erqo93kfAryxfOfMuR7YMNHLU9g+QhPbnaD09LkOVvVqYgTtr/wGa1++LjD8ivchsf9G6XNFRLeh8coCbGN8Vp0lviiNFm3UCgYEA/vBRhF1/hqlk4f8h14/xLzb/XC3LRCta2yMpVIbMKlXlwrUYP3uvbCYmVKl8iirsdgfFl5Rw70xmOt5RlFXHNmc7JQpolSd9qlw9XVCcAFKNquNUAyS3/T+0qL6NDJnROOR7RUXFrhx/E9gsU3+vHRmGs1KrdCj7bcHw4wwhTdMCgYEA0Jlk4n0dM1bPIgtoafmM03fjypXaTshMvr5rA4UeuZGS+PeJQ9NlWPOKrmVklvDf71PNKruacr/DA5TaIs1Oxp0lBieoxYceNiKnw6Y1jEMcjYo5/vyi4dIw+eL+l7Q6HVL0PCU3ZeLwFl2Hmbm/a2gC4xus1RJ2K9Ph3USDJZMCgYEA9/2/3jmxXsYS+4BaZD2CSQJ/3yQw0aw24mpOvwmtOxV5vjC5WK+xUku+B6cjHahpgttGi4/7V9yCqYsv4lKaycIbl4mLeGQE6x51Fvvd9LZZVr1yMOicDb7Vtzw9Kt/J1UT04MrhY+AWgbBMViEjr/PvwyqM3B8tjXQWJlbbYr8CgYB6hs+CVdk0EbaDGc5QCTwV7qMHmPPtOKwTkkfLfoLon0CEKuoew+oQ0KTSAU6PdpcivceSZTW4VzkWPnXO4Wd3NFDOB7eTpuUxCTQfsN5dMAJyhRHB2+VU3aDU9udydnN4TASX24hpuV4q1O9UdY2haivf+J6RXVG6Nq/Bx399LwKBgQC2jiuscjLDLH2lEqO+DG+8CwQzbyCGM+EQtQ8OcmeLr4xLq8ukHe18iPjrQvcmNT71G+x57CxPRBOO/NVfRtdILhoslErk/7Idf2N8aU6DTJP1T0JDvbMwA7J1OO0vDr8oO+VLUqFoYzoCs4TaSqL/pWjoWTGS3055+Uyos7uOkg==',
	  alipayPublicKey:'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmPy8DuqRP4MGazqoukOkCOzHk7brAS3AdRIrnHibkbflGDNVY9zyKFmE4wApDOazLpa+VffH8ys+1Jep5LiHHGEIxSBUzC8ZE/G96L7A1BAK7O1+hRzgN+hdgUuzMiVqowXW0zLPpoc8vu00G9H34BkKit73S8XXifvUKVafQnoHusnEzzPAZ3U8IBYCyJhSoGnLcWjETs4mGp7PkDdnWe8b2Sa+P38WkZklvVBJUflaueRQtp+rFhvJ8/q9TKe9Aig0lU2Z5X6a5Z8yGCBSabnT0RSuHfLnm2C3rjG249Q0X4Bd86x1ChgQMhchKLVcR0RCUpb1KK90vGEyztt5+wIDAQAB'
	});
	const formData = new AlipayFormData()
	  // 调用 setMethod 并传入 get，会返回可以跳转到支付页面的 url
	  // formData.setMethod('get')
	  // 配置回调接口
	  formData.addField('notifyUrl', 'http://aslegou.vaiwan.com/api/notifyUrl')//异步通知地址，需要配置内网穿透(钉钉)
	  formData.addField('returnUrl', 'http://localhost:8080/#/pages/orderlist/orderlist')//同步通知地址
	  // 设置参数
	  formData.addField('bizContent', {
	    outTradeNo,
	    productCode: 'FAST_INSTANT_TRADE_PAY',
	    totalAmount,
	    subject: '商品',
	    body: '商品详情',
	  });
	  
	  // 根据请求type类型获取请求支付form表单 1是返回手机网站支付 2是返回pc端网站支付
	  let payUrl = type == 1 ? 'alipay.trade.wap.pay' : 'alipay.trade.page.pay'
	  console.log(type)
	  // 请求接口
	  const result = await alipaySdk.exec(
	    payUrl,
	    {},
	    { formData: formData },
	  );
	
	  // result 为可以跳转到支付链接的 url
	  console.log(result);
	  res.send(Success(result));
	
});



module.exports = router;