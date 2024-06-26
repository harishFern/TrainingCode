public class httpconcepts {
    public static HttpResponse httpsetdata(){
        Http ht=new Http();
        HttpRequest hr=new HttpRequest();
        hr.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        hr.setMethod('POST');
        hr.setHeader('Content-type','application/json;charset=UTF-8');
        hr.setBody('{"name":"harish"}');
        HttpResponse hr1=ht.send(hr);
        if(hr1.getStatusCode()==201){
            system.debug(hr1.getBody());
        }
        else{
            system.debug('unexpected: '+hr1.getStatusCode()+' '+hr1.getStatus());
        }
        return hr1;
    }
}